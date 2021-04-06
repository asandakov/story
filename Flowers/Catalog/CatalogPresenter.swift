//
//  CatalogPresenter.swift
//  Flowers
//
//  Created by Алексей on 02.01.2021.
//

import Foundation

protocol CatalogControllerProtocol:class,ProgressProtocol {
  func sucessProduct()
  func errorProduct(error:String)
}

protocol CatalogPresenterProtocol:class {
    var catalog: CatalogResponce { get set }
    var products: [Product] { get set }
    var isRequestCatalog:Bool { get set }
    var orderService: OrderServiceProtocol { get set }
    func getCatalog(isPage:Bool)
    func showDeiailProduct(idProduct:String)
    
}



class CatalogPresenter:CatalogPresenterProtocol {
    
    var router: RouterProtocol
    weak var view: CatalogControllerProtocol?
    var catalog: CatalogResponce = CatalogResponce()
    var products:[Product] = []
    let productNetworkService: ProductNetworkServiceProtocol!
    var isRequestCatalog = true
    var pageCatalog = 1
    var isPageCatalog = false
    var orderService: OrderServiceProtocol
 
    required init (view:CatalogControllerProtocol, productNetworkService:ProductNetworkServiceProtocol, orderService:OrderServiceProtocol, router:RouterProtocol){
        self.productNetworkService = productNetworkService
        self.orderService = orderService
        self.view = view
        self.router = router
    }
    
    
    func getCatalog(isPage:Bool) -> () {
  
            self.isRequestCatalog = false
            self.isPageCatalog = isPage
        
            if (self.isPageCatalog){
                pageCatalog = pageCatalog + 1
            }else{
                pageCatalog = 1
                self.view?.showProgressHUD()
            }
         
            let params = [
                "page": String(pageCatalog)
            ]
         
            productNetworkService.getCatalog(params: params) { [weak self] result in
           
                                    
                    guard let self = self else { return }
             
                
                    self.isRequestCatalog = true
                    self.view?.hideProgressHUD()
           
                    if params["page"] != "1" && !self.isPageCatalog {
                        return
                    }
                        
                    switch result {
                                   
                        case  .success(let data):
                            
                            let decoder: JSONDecoder = JSONDecoder()
                                guard
                                    let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                                    let CatalogResponce = try? decoder.decode(CatalogResponce.self, from: jsonData)
                                    else {
                                    
                                        self.view?.errorProduct(error: Localization.Alert.Network.message)
                                        return
                                     }
                            
                         
                            if (CatalogResponce.curPage == 1){
                              
                                self.products = CatalogResponce.products
                            }else{
                                self.products = self.products + CatalogResponce.products
                            }
                            self.catalog = CatalogResponce
                            self.view?.sucessProduct()
                        case  .failure(let error):
                            if let errorMsg = error.errorDescription{
                                self.view?.errorProduct(error: errorMsg)
                            }
                            
                    }
                

            }
        
    }
      
    
    func showDeiailProduct(idProduct:String) {
        router.showDetailProduct(idProduct: idProduct, type: .CATALOG )
    }
    
    
}
