//
//  Localization.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import Foundation

struct Localization {
    
    struct Product {
        public static var textBuyButton : String = "product.buy.button".localized()
    }
    
    struct Home {
        public static var title : String = "home.title".localized()
        public static var BlockSale : String = "home.block.sale".localized()
        public static var BlockHit : String = "home.block.hit".localized()
    }
    
    struct Order {
        public static var title : String = "order.title".localized()
        public static var actionRepeat : String = "order.action.repeat".localized()
        public static var noOrder : String = "order.no_order".localized()
    }
    
    
    struct Catalog {
        public static var title : String = "catalog.title".localized()
    }
    
    struct News {
        public static var title : String = "news.title".localized()
    }
    
    struct ProductDetail {
        
        public static var title : String = "product.detatil.title".localized()
        
    }

    
    struct Alert {
        
        public static var okButton : String = "alert.ok.button".localized()
        public static var canselButton : String = "alert.cansel.button".localized()
        public static var tite : String = "alert.title".localized()
        
        struct Error {
            public static var tite : String = "alert.error.title".localized()
            public static var message : String = "alert.error.message".localized()
          
        }
        struct Network {
            public static var message : String = "alert.network.message".localized()
        }
        
        struct News {
            public static var messageNoPge : String = "alert.news.error.page.no".localized()
        }
          
        
        struct Buy {
            public static var okButton : String = "alert.buy.ok.button".localized()
            public static var canselButton : String = "alert.buy.cansel.button".localized()
            public static var tite : String = "alert.buy.title".localized()
            public static var titeRepeat : String = "alert.buy.repeat.title".localized()
            public static var message : String = "alert.buy.message".localized()
            public static var name : String = "alert.buy.name".localized()
            public static var phone : String = "alert.buy.phone".localized()
        }
        
        
     
        
        struct OrderBuy {
            public static var noCreateOrder : String = "alert.order.error.order.no".localized()
            public static var noSaveOrder : String = "alert.order.error.order.save".localized()
            public static var saveOrder : String = "alert.order.save".localized()
            public static var title : String = "alert.order.error.order.no.title".localized()
   
        }
        
    }
    
}


