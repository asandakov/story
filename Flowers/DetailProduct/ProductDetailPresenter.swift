//
//  ProductDetailPresenter.swift
//  Flowers
//
//  Created by Алексей on 30.12.2020.
//

import Foundation


protocol ProductDetailControllerProtocol:class,ProgressProtocol {
  
  func sucessProduct()
  func errorProduct(error:String)
    
}

protocol ProductDetailPresenterProtocol:class {
    var products: ProductDetailResponce { get set }
    func getProduct(idProduct:String)
    func showDeiailProduct(idProduct:String)
    var orderService: OrderServiceProtocol { get set }
}




class ProductDetailPresenter: ProductDetailPresenterProtocol{
  
    
    var router: RouterProtocol
    weak var view: ProductDetailControllerProtocol?
    var products: ProductDetailResponce = ProductDetailResponce()
    let productNetworkService: ProductNetworkServiceProtocol!
    var orderService: OrderServiceProtocol
    var typeDetail:TypeDetail
    
    required init (view:ProductDetailControllerProtocol,type: TypeDetail, productNetworkService:ProductNetworkServiceProtocol, idProduct:String, orderService:OrderServiceProtocol, router:RouterProtocol){
        self.productNetworkService = productNetworkService
        self.orderService = orderService
        self.view = view
        self.router = router
        self.typeDetail = type
        getProduct(idProduct:idProduct)
    }
    
    func getProduct(idProduct:String) -> () {
    
        self.view?.showProgressHUD()
      
        let params = [
            "id" : idProduct,
            "popular": "1"
        ]
        
        productNetworkService.getProduct(params: params) { [weak self] result in
   
            guard let self = self else { return }
           
            self.view?.hideProgressHUD()
            
            switch result {
                           
                case  .success(let data):
                  
                    let decoder: JSONDecoder = JSONDecoder()
                        guard
                            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                            let productResponce = try? decoder.decode(ProductDetailResponce.self, from: jsonData)
                            else {
                            
                                self.view?.errorProduct(error: Localization.Alert.Network.message)
                                return
                             }

                    self.products = productResponce
                    self.view?.sucessProduct()
                case  .failure(let error):
                    if let errorMsg = error.errorDescription{
                        self.view?.errorProduct(error: errorMsg)
                    }
                    
            }
            
            
        }
    }
      
    
    func showDeiailProduct(idProduct:String) {
        router.showDetailProduct(idProduct:idProduct,type:typeDetail)
    }
    
}
