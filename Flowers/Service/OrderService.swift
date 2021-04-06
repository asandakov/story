//
//  OrderService.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import Foundation

protocol OrderServiceControllerProtocol:class {
    func sussesServiceOrder()
    func errorServiceOrder(error:String)
}

protocol OrderServiceProtocol:class {
    
    func showAddOrder(view:OrderServiceControllerProtocol&ProgressProtocol&BuyAlertProtocol, product:Product)
    
    func addOrder(view:OrderServiceControllerProtocol&ProgressProtocol, user:UserOrder, product:Product) -> ()
}

class OrderService: OrderServiceProtocol{
    
    func showAddOrder(view:OrderServiceControllerProtocol&ProgressProtocol&BuyAlertProtocol, product:Product) {
        
        view.showBuyAlert(product: product, userInfo: UserOrder()){ (user) in
            self.addOrder(view: view, user: user, product: product)
        }
    }
 
    func addOrder(view:OrderServiceControllerProtocol&ProgressProtocol, user:UserOrder, product:Product) {
         
               
        view.showProgressHUD()
       
        let orderNetworkService: OrderNetworkServiceProtocol = OrderNetworkService()
      
        let ParamsRequest:[String:String] = [
            "id" : product.id,
            "name" : product.name,
            "price" : product.price.stingWithCurrency,
            "img" : product.url,
            "nameUser" : user.name,
            "phoneUser" : user.phone
        ]
        
        
        orderNetworkService.addOrder(params: ParamsRequest) { [weak view] result in
        
        guard let view = view else { return }
    
        view.hideProgressHUD()
     

        switch result {
                       
            case  .success(let data):
                
                let decoder: JSONDecoder = JSONDecoder()
                    guard
                        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []),
                        let OrderResponce = try? decoder.decode(OrderResponce.self, from: jsonData)
                        else {
                            view.errorServiceOrder(error: Localization.Alert.Network.message)
                            return
                         }
                
                
                if OrderResponce.id > 0 {
                    
                    let orderCoreDataService: OrderCoreDataServiceProtocol = OrderCoreDataService()
                    let falgAdd = orderCoreDataService.add(name: user.name, phone: user.phone, idOrder: OrderResponce.id, product: product)
                    
                   if (falgAdd) {
                        view.sussesServiceOrder()
                    }else{
                        
                        view.errorServiceOrder(error: Localization.Alert.OrderBuy.noSaveOrder)
                    }
                }else{
                    view.errorServiceOrder(error: Localization.Alert.OrderBuy.noCreateOrder)
                }
               
           
            case  .failure(let error):
                if let errorMsg = error.errorDescription{
                    view.errorServiceOrder(error: errorMsg)
                }
                
        }


        }
    }
}
        

