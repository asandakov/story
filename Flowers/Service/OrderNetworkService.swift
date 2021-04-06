//
//  OrderNetworkService.swft.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import Foundation


import Foundation

protocol OrderNetworkServiceProtocol {
    func addOrder(params:[String:String], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> ()
 
}


class OrderNetworkService: OrderNetworkServiceProtocol {
    
    func addOrder(params:[String:String] = [:], completion: @escaping (Result<[String:Any],ErrorNetworkCore>) -> ()) -> (){
        
             
        let ParamsRequest:[String:String] = [
            "accessToken" : Settings.accessTokenApi
        ]
        
        let newParamsRequest = ParamsRequest.merging(params) { (curent, _) -> String in
            curent
        }
        
        var request = RequestNetworkCore.init()
        request.parameters = .dictionary(newParamsRequest)
        request.url = Settings.apiURL+ApiMethods.addOrder.rawValue
        request.method = .POST
    
        let objNetworkCore = FactoryNetworkCore.defaultFactory.createNetwork()
        let _ = objNetworkCore.request(request: request){ result in
            DispatchQueue.main.async {
                completion(result)
            }
         }
    }

}
