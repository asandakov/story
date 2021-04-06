//
//  RouterApp.swift
//  Flowers
//
//  Created by Алексей on 26.12.2020.
//

import UIKit

protocol RouterProtocol {
    var assembly: AssemblyBuilderProtocol? {get set}
    func initialViewController() -> UITabBarController?
    func showDetailProduct(idProduct:String,type:TypeDetail)   
}

class RouterApp:RouterProtocol {
   
    var assembly: AssemblyBuilderProtocol?
    
    var HouseNavController: UINavigationController
    var CatalogNavController: UINavigationController
    
    
    init(assembly:AssemblyBuilderProtocol){
        self.assembly = assembly
        self.HouseNavController = UINavigationController()
        self.CatalogNavController = UINavigationController()
    }
    
    func initialViewController() -> UITabBarController? {
              

        let tabController = UITabBarController()
        tabController.tabBar.tintColor = Colors.Common.readColor
       
        guard let HouseController = self.assembly?.createHomeModule(router:self) else {
           return nil
        }
        HouseController.tabBarItem = UITabBarItem(title: Localization.Home.title, image: Images.TabBar.home, selectedImage: nil)
        
        guard let showCatalogController = self.assembly?.createCatalogModule(router:self) else {
           return nil
        }
        showCatalogController.tabBarItem = UITabBarItem(title: Localization.Catalog.title, image: Images.TabBar.catalog, selectedImage: nil)
        
        guard let showOrder = self.assembly?.createOrderModule() else {
           return nil
        }
        showOrder.tabBarItem = UITabBarItem(title: Localization.Order.title, image: Images.TabBar.order, selectedImage: nil)
        
        guard let showNews = self.assembly?.createNewsModule() else {
           return nil
        }
        showNews.tabBarItem = UITabBarItem(title: Localization.News.title, image: Images.TabBar.news, selectedImage: nil)
            
        let OrderNavController = UINavigationController(rootViewController: showOrder)
        let NewsNavController = UINavigationController(rootViewController: showNews)
       
       
        self.CatalogNavController.viewControllers = [showCatalogController]
        self.HouseNavController.viewControllers = [HouseController]
        tabController.setViewControllers([HouseNavController,CatalogNavController,OrderNavController,NewsNavController], animated: true)

        return tabController
    }
    
    
    func showDetailProduct(idProduct:String,type:TypeDetail) {
     
        guard let showDetailController = self.assembly?.createDetailProductModule(idProduct:idProduct,type: type,router:self) else {
           return
        }
        
        switch type {
            case .HOME:
                self.HouseNavController.pushViewController(showDetailController, animated: true);
            case .CATALOG:
               self.CatalogNavController.pushViewController(showDetailController, animated: true);
        }
      
    }
  
}
