//
//  Product.swift
//  Flowers
//
//  Created by Алексей on 25.12.2020.
//

import Foundation

class Product:Codable {
    var id = ""
    var name = ""
    var url = ""
    var price = ""
    var text = ""
    
    enum CodingKeys:String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case url = "URL"
        case price = "PRICE"
        case text = "TEXT"
    }
}


class ProductSaleHitResponce:Codable {
    var sale:[Product] = []
    var hit:[Product] = []
    
    enum CodingKeys:String, CodingKey {
        case sale = "SALE"
        case hit = "HIT"
    }
}


class ProductDetailResponce:Codable {
    var product:Product? = nil
    var popular:[Product] = []
    
    enum CodingKeys:String, CodingKey {
        case product = "PRODUCT"
        case popular = "POPULAR"
    }
}


class CatalogResponce:Codable {
    var products:[Product] = []
    var count:Int = 0
    var isPage:Bool = false
    var allPage:Int = 0
    var curPage:Int = 0
   
    
    enum CodingKeys:String, CodingKey {
        case products = "LIST"
        case count = "COUNT"
        case allPage = "ALL_PAGE"
        case isPage = "FLAG_NAV"
        case curPage = "CURRENT_PAGE"
    }
}
