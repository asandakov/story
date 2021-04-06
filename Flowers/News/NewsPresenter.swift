//
//  NewsPresenter.swift
//  Flowers
//
//  Created by Алексей on 05.01.2021.
//

import Foundation

protocol NewsControllerProtocol:class {

}

protocol NewsPresenterProtocol:class {
    
}

class NewsPresenter: NewsPresenterProtocol {
    

    weak var view: NewsControllerProtocol?
       
    required init (view:NewsControllerProtocol){
        self.view = view
    }
}
