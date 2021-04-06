//
//  HomeViewController.swift
//  Flowers
//
//  Created by Алексей on 25.12.2020.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    public  var presenter:HomePresenterProtocol!
    
    private let nameCaruselSaleLabel:UILabel = {
        let nameCaruselSale = UILabel()
        nameCaruselSale.font = Fonts.Text.textSemiboldFont(size: 20)
        nameCaruselSale.translatesAutoresizingMaskIntoConstraints = false
        nameCaruselSale.textColor = Colors.Common.grayColor
        nameCaruselSale.text = Localization.Home.BlockSale
        return nameCaruselSale
    }()
    
    private let nameBlockHitLabel:UILabel = {
        let nameBlockHit = UILabel()
        nameBlockHit.font = Fonts.Text.textSemiboldFont(size: 20.0)
        nameBlockHit.translatesAutoresizingMaskIntoConstraints = false
        nameBlockHit.textColor = Colors.Common.grayColor
        nameBlockHit.text = Localization.Home.BlockHit
        return nameBlockHit
    }()

    private let homeScroll = UIScrollView()
   
    private let caruselSaleCollectionView = CaruselCollectionView()
    private let productHitTableView = ProductTableView()
 

    private var heightTable:NSLayoutConstraint?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = Localization.Home.title
        //sleep(10)
       
      
        view.addSubview(homeScroll)
     
        homeScroll.delegate = self
        homeScroll.isScrollEnabled = true
        homeScroll.showsVerticalScrollIndicator = true
        homeScroll.showsHorizontalScrollIndicator = false
        homeScroll.refreshControl = UIRefreshControl()
        homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)
        homeScroll.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        homeScroll.addSubview(nameCaruselSaleLabel)
        homeScroll.addSubview(caruselSaleCollectionView)
        homeScroll.addSubview(nameBlockHitLabel)
        homeScroll.addSubview(productHitTableView)
     
        caruselSaleCollectionView.dataTable = self
        productHitTableView.dataTable = self
        

        self.setConstraint()
        self.presenter.getProductSaleHit()
    }

    
    func setConstraint() {
      
        homeScroll.translatesAutoresizingMaskIntoConstraints = false
        homeScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeScroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        homeScroll.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
            
        homeScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        homeScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: productHitTableView.bottomAnchor, constant: 0).isActive = true
        
        
        nameCaruselSaleLabel.leadingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.leadingAnchor, constant: 30).isActive = true
        nameCaruselSaleLabel.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 30).isActive = true

        caruselSaleCollectionView.leadingAnchor.constraint(equalTo: homeScroll.leadingAnchor).isActive = true
        caruselSaleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        caruselSaleCollectionView.topAnchor.constraint(equalTo: nameCaruselSaleLabel.bottomAnchor, constant: 10).isActive = true
        caruselSaleCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true


        nameBlockHitLabel.leadingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.leadingAnchor, constant: 30).isActive = true
        nameBlockHitLabel.topAnchor.constraint(equalTo: caruselSaleCollectionView.bottomAnchor, constant: 30).isActive = true

        productHitTableView.leadingAnchor.constraint(equalTo: homeScroll.frameLayoutGuide.leadingAnchor).isActive = true
        productHitTableView.topAnchor.constraint(equalTo: nameBlockHitLabel.bottomAnchor, constant: 10).isActive = true
        productHitTableView.widthAnchor.constraint(equalTo: homeScroll.widthAnchor).isActive = true
          
        
    }
    
    
 
    @objc func refreshHome(sendrer:UIRefreshControl){
      
        presenter.getProductSaleHit()
        self.homeScroll.refreshControl?.endRefreshing()
       
    }
    
  
    
    deinit {
        print("deinit HomeViewController")
    }

}


extension HomeViewController:HomeControllerProtocol {
  
    func sucessProduct() {
     
        self.caruselSaleCollectionView.reloadData()
        self.productHitTableView.reloadData()
        
        heightTable?.isActive = false
        heightTable = productHitTableView.heightAnchor.constraint(equalToConstant: CGFloat(presenter.products.hit.count*productHitTableView.heightCell))
        heightTable?.isActive = true
    }
    
    func errorProduct (error:String){
        self.showAlert(message: error) 
    }
      

}




extension HomeViewController:ProductTableViewProtocol{
    
    func buyProduct(product: Product) {
        self.presenter.orderService.showAddOrder(view: self, product:product)
    }
    
      
    func lastCellTable() {
        
    }
    
    func showDeiailProduct(idProduct:String) {
        presenter.showDeiailProduct(idProduct:idProduct)
    }
    
    func getDataProduct() -> [Product]?{
        return presenter.products.hit
    }
}


extension HomeViewController:CaruselCollectionViewProtocol{
   
    func buyProductCarusel(product: Product) {
        self.presenter.orderService.showAddOrder(view: self, product:product)
    }
    
    
    func showDeiailProductCarusel(idProduct:String) {
        presenter.showDeiailProduct(idProduct:idProduct)
    }
    
    func getDataProductCarusel() -> [Product]?{
        return presenter.products.sale
    }
}

extension HomeViewController: OrderServiceControllerProtocol {
   
    func sussesServiceOrder() {       
        self.showAlert(message: Localization.Alert.OrderBuy.saveOrder)
    }
    
    func errorServiceOrder(error: String) {
        self.showAlert(tite: Localization.Alert.OrderBuy.title,message: error)
    }
    
}
