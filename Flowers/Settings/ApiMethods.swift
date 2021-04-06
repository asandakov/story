//
//  ApiMethods.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation


enum ApiMethods: String {
             
    case productSaleHit = "/v1/product.getSaleHit/"
    case productDetail = "/v1/product.getProduct/"
    case productCatalog = "/v1/product.getList/"
    case addOrder = "/v1/orders.add/"
}
