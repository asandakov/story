//
//  CoreDataService.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import Foundation
import CoreData

protocol OrderCoreDataServiceProtocol {
   func add(name:String, phone:String, idOrder:Int64, product:Product)->Bool
   func getList(page:Int) -> OrderDataResponce
   func removeAll() -> Bool
}


class OrderCoreDataService:OrderCoreDataServiceProtocol{
    
    func add(name:String, phone:String, idOrder:Int64, product:Product)->Bool {
        
        var flagAdd = false
  
        let order = Order(context: CoreDataStorage.default.persistentContainer.viewContext)
     
        order.number = idOrder
        order.fio = name
        order.phone = phone
        order.id = Int64(product.id) ?? 0
        order.name = product.name
        order.price = Int32(product.price) ?? 0
        order.img = product.url
        order.date = Date()
        
        let flag = CoreDataStorage.default.saveContext()
        if (flag){
            flagAdd = true
        }
        
       return flagAdd
    }
    
    
    func getList(page:Int) -> OrderDataResponce {
    
        var order:[Order] = []
        var errorFlag:Bool = false
        let limit = 10
        var count = 0
        var isPage = true
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Order")
        let sort:NSSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = limit*(page-1)
        do {
            let result = try CoreDataStorage.default.persistentContainer.viewContext.fetch(fetchRequest) as! [Order]
         
            for item in result {
                order.append(item)
            }
                        
        } catch {
            errorFlag = true
        }
        
        let allFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Order")
        if let countRow =  try? CoreDataStorage.default.persistentContainer.viewContext.count(for: allFetchRequest){
            count = countRow
        }
           
        
        let allPage = Int(ceil(Double(Double(count)/Double(limit))))
        if allPage == 0 {
           isPage = false
        }
        
        if allPage == page {
           isPage = false
        }
       // sleep(5)
        var orderData = OrderDataResponce()
        orderData.order = order
        orderData.count = count
        orderData.error = errorFlag
        orderData.curPage = page
        orderData.isPage = isPage
        
        return orderData
    }
    
    func removeAll() -> Bool{
    
        var errorFlag:Bool = false
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Order")
        let sort:NSSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
      
        do {
            let result = try CoreDataStorage.default.persistentContainer.viewContext.fetch(fetchRequest) as! [Order]
     
            for item in result {
                CoreDataStorage.default.persistentContainer.viewContext.delete(item)
            }
                        
        } catch {
            errorFlag = true
        }
        
        let flag = CoreDataStorage.default.saveContext()
       
        return errorFlag
    }
}
