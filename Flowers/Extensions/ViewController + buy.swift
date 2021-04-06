//
//  ViewController + buy.swift
//  Flowers
//
//  Created by Алексей on 03.01.2021.
//

import UIKit

protocol BuyAlertProtocol:class {
    func showBuyAlert(product:Product, userInfo:UserOrder, handler: ((_ user:UserOrder)->())?) -> ()
}

extension UIViewController: BuyAlertProtocol {
    
    func showBuyAlert(product:Product, userInfo:UserOrder = UserOrder(), handler: ((_ user:UserOrder)->())? = nil){

        let alertController = UIAlertController(title: Localization.Alert.Buy.tite, message: product.name+",\n цена: "+product.price.stingWithCurrency, preferredStyle: .alert)
           
        let actionOkAlert = UIAlertAction(title: Localization.Alert.Buy.okButton, style: .default) { _ in
          
            guard  let name =  alertController.textFields?[0].text,  let phone = alertController.textFields?[1].text else{
                return
            }
            
            if (name == "" || phone == ""){
                self.showAlert(tite: "Заказ не создан", message: "Ошибка: не введен имя или телефон")
                return
            }
                       
            guard let handler = handler else { return }
            
            let user = UserOrder(name:name, phone:phone)
            
            handler(user)
            
        }
        alertController.addAction(actionOkAlert)
        
       let actionCanselAlert = UIAlertAction(title: Localization.Alert.canselButton, style: .cancel) { _ in
            
        }
        alertController.addAction(actionCanselAlert)
        
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = Localization.Alert.Buy.name
            textField.text = userInfo.name
        })
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = Localization.Alert.Buy.phone
            textField.text = userInfo.phone
        })
          
 
        self.present(alertController, animated: true, completion: nil)
       }
    
    
    
}
