//
//  ProductNetworkService.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import Foundation

protocol ProductNetworkServiceProtocol {
    func getProductSaleHit(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getProduct(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
    func getCatalog(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
}


class ProductNetworkService: ProductNetworkServiceProtocol {
    
    let queueOrder =  DispatchQueue.global(qos: .userInteractive)
   
    
    func getProductSaleHit(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.productSaleHit.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    
    
    }
    
    
    func getProduct(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.productDetail.rawValue
        request.method = .GET
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }
    
    
    func getCatalog(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.productCatalog.rawValue
        request.method = .GET
        request.queue = queueOrder
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            if (params["page"] != "1"){
                sleep(1)
            }
              
            DispatchQueue.main.async {
                completion(result)
            }
         }
     
    }
    
}
