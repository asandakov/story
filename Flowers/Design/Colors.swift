//
//  Colors.swift
//  Flowers
//
//  Created by Алексей on 29.12.2020.
//

import UIKit

struct Colors {
   
    struct Common {
        static let readColor = #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.462745098, alpha: 1)
        static let whiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let grayColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
   }
    
    struct Product {
        static let name = #colorLiteral(red: 0.1512201428, green: 0.1610366702, blue: 0.1652122438, alpha: 1)
        static let price = #colorLiteral(red: 0.1512201428, green: 0.1610366702, blue: 0.1652122438, alpha: 1)
        static let text = #colorLiteral(red: 0.1512201428, green: 0.1610366702, blue: 0.1652122438, alpha: 1)
        static let textBuy = Common.whiteColor
        static let backgroundBuy = Common.readColor
  }
      

    
}
