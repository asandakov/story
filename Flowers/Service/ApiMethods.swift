//
//  ApiMethods.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation


enum ApiMethods: String {
    
    
    
    
    case logout = "/v1/auth.exitLogin"

    case addDevice = "/v1/device.addDevice"
    case userAuth = "/v1/auth.setLogin"
    case userRegister = "/v1/auth.setRegister"
    case passwordAccount = "/v1/user.setPasswordAccount"
    case updateUser = "/v1/user.edit"
    case getUser = "/v1/user.getInfo"
    case getContact = "/v1/contact.getlist"
   
    case useCoderRegister = "/v1/auth.addAccountRegister"
    case product = "/v1/producttype.getList"
    case productInfo = "/v1/producttype.getInfo"
    case offices = "/v1/store.getList"
    case refreshToken = "/v1/token.getRefreshToken"
    case updatePassword = "/v1/user.setUpdPasswordAccount"

    case delivery = "/v1/delivery.getList"
    case payment = "/v1/payment.getList"
    case interval = "/v1/interval.getList"
    
    case addOrder = "/v1/order.add"
    case getBonus = "/v1/order.getBonus"
    case orderList = "/v1/order.getList"
    case orderGetInfo = "/v1/order.getInfo"
    
    case setPayOrder = "/v1/order.setPayOrder"
}
