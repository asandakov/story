//
//  Order.swift
//  Flowers
//
//  Created by Алексей on 04.01.2021.
//

import Foundation


class OrderResponce:Codable {
    var id:Int64 = 0
  
    
    enum CodingKeys:String, CodingKey {
        case id = "ID"
    }
}


struct OrderDataResponce {
    
    var order:[Order] = []
    var count:Int = 0
    var isPage:Bool = false
    var curPage:Int = 0
    var error:Bool = false
    
}
