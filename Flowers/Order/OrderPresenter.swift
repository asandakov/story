//
//  OrderPresenter.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import Foundation
import CoreData

protocol OrderControllerProtocol:class {
  func sucessOrder()
  func errorOrder(error:String)
}

protocol OrderPresenterProtocol:class {
    var order: [Order] { get set }
    var orderData: OrderDataResponce { get set }
    var orderService: OrderServiceProtocol! { get set }
    var isRequestOrder:Bool { get set }
    func getOrder(isPage:Bool)
    
}



class OrderPresenter:OrderPresenterProtocol {
    weak var view: OrderControllerProtocol?
    var order: [Order] = []
    var orderData: OrderDataResponce = OrderDataResponce()
    var orderService: OrderServiceProtocol!
    let orderCoreDataService: OrderCoreDataServiceProtocol!
    var queueOrder =  DispatchQueue.global(qos: .userInteractive)
    var isRequestOrder = true
    var pageOrder = 1
    var isPageOrder = false
    
    
    required init (view:OrderControllerProtocol, orderCoreDataService:OrderCoreDataServiceProtocol,orderService:OrderServiceProtocol){
        self.orderCoreDataService = orderCoreDataService
        self.view = view
        self.orderService = orderService
    }
    
    
    func getOrder(isPage:Bool) -> () {
          
            self.isRequestOrder = false
            self.isPageOrder = isPage
        
            if (self.isPageOrder){
                pageOrder = pageOrder + 1
            }else{
                pageOrder = 1
            }
     
            queueOrder.async{
                //sleep(1)
                self.orderData = self.orderCoreDataService.getList(page:self.pageOrder)
                DispatchQueue.main.async {
                    self.isRequestOrder = true
                    if (self.orderData.error){
                        self.view?.errorOrder(error: "Техническая ошибка")
                    }else{
                        if (self.pageOrder == 1){
                            self.order = self.orderData.order
                        }else {
                            self.order = self.order + self.orderData.order
                        }
                        self.view?.sucessOrder()
                    }
               }
            
        }
      
    }
    
    
}
