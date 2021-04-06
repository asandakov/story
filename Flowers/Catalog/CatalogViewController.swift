//
//  CatalogTableController.swift
//  Flowers
//
//  Created by Алексей on 02.01.2021.
//

import UIKit

class CatalogViewController: UIViewController  {
    
    var presenter:CatalogPresenterProtocol!
    private let catalogTableView = ProductTableView()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization.Catalog.title    
        
        view.addSubview(catalogTableView)
        catalogTableView.dataTable = self
        catalogTableView.isScrollEnabled = true
        catalogTableView.showsVerticalScrollIndicator = true
      
        catalogTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        catalogTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        catalogTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        catalogTableView.bottomAnchor.constraint(equalTo:  view.bottomAnchor, constant: 0).isActive = true
        
   
       

        catalogTableView.refreshControl = UIRefreshControl()
        catalogTableView.refreshControl?.addTarget(self, action: #selector(refreshCatalog(sendrer:)), for: .valueChanged)

        presenter.getCatalog(isPage: false)

//        let orderCoreDataService: OrderCoreDataServiceProtocol = OrderCoreDataService()
//        let falgAdd = orderCoreDataService.removeAll()

    }
    
      
    
    @objc func refreshCatalog(sendrer:UIRefreshControl){
        presenter.getCatalog(isPage: false)
        self.catalogTableView.refreshControl?.endRefreshing()
    }
    
    
  

}



extension CatalogViewController:CatalogControllerProtocol {
  
    func sucessProduct() {        
        self.catalogTableView.reloadData()
    }
    
    func errorProduct (error:String){
        self.showAlert(message: error)
    }
    
    

}

extension CatalogViewController:ProductTableViewProtocol{
   
    func buyProduct(product: Product) {
        self.presenter.orderService.showAddOrder(view:self, product: product)    
    }
    
    func lastCellTable() {
        
        if (self.presenter.catalog.isPage){
                 
            if (self.presenter.isRequestCatalog){
                self.catalogTableView.tableFooterView = self.catalogTableView.createSpinerFooter()
                self.presenter.getCatalog(isPage:true)
            }
        }else{
            self.catalogTableView.tableFooterView = nil
        }
       
    }
    
  
  
    func showDeiailProduct(idProduct:String) {
        presenter.showDeiailProduct(idProduct:idProduct)
    }
    
    func getDataProduct() -> [Product]?{       
        return presenter?.products
    }
}

extension CatalogViewController: OrderServiceControllerProtocol {
   
    func sussesServiceOrder() {
        self.showAlert(message: Localization.Alert.OrderBuy.saveOrder)
    }
    
    func errorServiceOrder(error: String) {
        self.showAlert(tite: Localization.Alert.OrderBuy.title,message: error)
    }
    
}
