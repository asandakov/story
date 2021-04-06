//
//  AssemblyBuilder.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import UIKit

enum TypeDetail {
    case HOME
    case CATALOG
}

protocol AssemblyBuilderProtocol {
    func createHomeModule(router:RouterProtocol) -> UIViewController?
    func createDetailProductModule(idProduct:String,type: TypeDetail, router:RouterProtocol) -> UIViewController?
    func createCatalogModule(router:RouterProtocol) -> UIViewController?
    func createOrderModule() -> UIViewController?
    func createNewsModule() -> UIViewController?
}

class AssemblyBuilder:AssemblyBuilderProtocol{
   
    let orderService = OrderService()
    let productNetworkService = ProductNetworkService()
    
    func createHomeModule(router:RouterProtocol) -> UIViewController?{
        
        let view = HomeViewController()
        let present = HomePresenter(view: view, productNetworkService: productNetworkService, orderService:orderService, router:router)
        view.presenter = present
        return view
    }
    
    func createDetailProductModule(idProduct:String, type: TypeDetail,router:RouterProtocol) -> UIViewController?{
                
        let view = ProductDetailViewController()
        let productNetworkService = ProductNetworkService()
        let orderService = OrderService()
        let present = ProductDetailPresenter(view: view, type: type, productNetworkService: productNetworkService, idProduct:idProduct, orderService:orderService, router:router)
        view.presenter = present
        return view
        
    }
    
    
    func createCatalogModule(router:RouterProtocol) -> UIViewController?{
                
        let view = CatalogViewController()       
        let present = CatalogPresenter(view: view, productNetworkService: productNetworkService,  orderService:orderService, router:router)
        view.presenter = present
        return view
        
    }
    
    
    func createOrderModule() -> UIViewController?{
                
        let view = OrderViewController()       
        let orderService = OrderService()
        let orderCoreDataService = OrderCoreDataService()  
        let present = OrderPresenter(view: view, orderCoreDataService: orderCoreDataService,  orderService:orderService)
        view.presenter = present
        return view
        
    }
    
    
    func createNewsModule() -> UIViewController?{
                
        let view = NewsViewController()   
        let present = NewsPresenter(view: view)
        view.presenter = present
        return view
        
    }
    
}
