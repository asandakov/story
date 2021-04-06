//
//  SaleCaruselPresenter.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import Foundation

protocol HomeControllerProtocol:class,ProgressProtocol {
  
  func sucessProduct()
  func errorProduct(error:String)

    
}

protocol HomePresenterProtocol:class {
    var products: ProductSaleHitResponce { get set }
    func getProductSaleHit()
    func showDeiailProduct(idProduct:String)
    var orderService: OrderServiceProtocol { get set }
}


class HomePresenter:HomePresenterProtocol {

    
    var router: RouterProtocol
    weak var view: HomeControllerProtocol?
    var products: ProductSaleHitResponce = ProductSaleHitResponce()
    let productNetworkService: ProductNetworkServiceProtocol!
    var orderService: OrderServiceProtocol
    
    required init (view:HomeControllerProtocol, productNetworkService:ProductNetworkServiceProtocol, orderService:OrderServiceProtocol, router:RouterProtocol){
        self.productNetworkService = productNetworkService
        self.view = view
        self.orderService = orderService
        self.router = router
    }
    
    func getProductSaleHit() -> () {
    
        self.view?.showProgressHUD()
        
        productNetworkService.getProductSaleHit(params: [:]) { [weak self] result in
         
                guard let self = self else { return }
               
                self.view?.hideProgressHUD()
         
                switch result {
                               
                    case  .success(let data):
               
                        let decoder: JSONDecoder = JSONDecoder()
                            guard
                                let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                let productResponce = try? decoder.decode(ProductSaleHitResponce.self, from: jsonData)
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
        router.showDetailProduct(idProduct:idProduct,type:.HOME)
    }
}
