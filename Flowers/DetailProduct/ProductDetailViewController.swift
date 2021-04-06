//
//  ProductDetailViewController.swift
//  Flowers
//
//  Created by Алексей on 30.12.2020.
//

import UIKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    var presenter:ProductDetailPresenterProtocol!
  
    private let caruselSaleCollectionView = CaruselCollectionView()
    
    let viewScroll:UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false    
       return view
    }()
    
    
    let pictureImageView:UIImageView = {
       let img = UIImageView()
       img.translatesAutoresizingMaskIntoConstraints = false
       img.contentMode = .scaleAspectFit
       return img
    }()
         
    
    let nameLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.numberOfLines = 2
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let priceLabel:UILabel = {
       let price = UILabel()
        price.font = Fonts.Text.textSemiboldFont(size: 16.0)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.textColor = Colors.Product.price
        return price
    }()

    let buyBotton:UIButton = {
        let buy = UIButton()
        buy.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        buy.setTitleColor(Colors.Product.textBuy, for: .normal)
        buy.setTitle(Localization.Product.textBuyButton, for: .normal)
        buy.titleLabel?.font = Fonts.Text.textSemiboldFont(size: 16.0)
        buy.backgroundColor = Colors.Product.backgroundBuy
        buy.layer.cornerRadius = 5
        buy.translatesAutoresizingMaskIntoConstraints = false
        return buy
    }()
    
    
    let nameCaruselSaleLabel:UILabel = {
       let name = UILabel()
        name.font = Fonts.Text.textSemiboldFont(size: 16.0)
        name.text = "Вам может понравится"
        name.numberOfLines = 2
        name.textColor = Colors.Product.name
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Localization.ProductDetail.title
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        caruselSaleCollectionView.dataTable = self
      
        viewScroll.delegate = self
   
        viewScroll.addSubview(pictureImageView)
        viewScroll.addSubview(nameLabel)
        viewScroll.addSubview(priceLabel)
        viewScroll.addSubview(buyBotton)
        viewScroll.addSubview(nameCaruselSaleLabel)
        viewScroll.addSubview(caruselSaleCollectionView)
        
        view.addSubview(viewScroll)
        setConstraint()
    }
    

    func setConstraint() {
   
        viewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewScroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewScroll.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        viewScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewScroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: caruselSaleCollectionView.bottomAnchor, constant: 20).isActive = true
        
        pictureImageView.leadingAnchor.constraint(equalTo: viewScroll.frameLayoutGuide.leadingAnchor).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: viewScroll.frameLayoutGuide.trailingAnchor).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: viewScroll.topAnchor, constant: 0).isActive = true
        pictureImageView.heightAnchor.constraint(equalTo: viewScroll.widthAnchor, multiplier: 0.7).isActive = true

                                 
        nameLabel.leadingAnchor.constraint(equalTo: viewScroll.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: viewScroll.trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10).isActive = true


        priceLabel.leadingAnchor.constraint(equalTo: viewScroll.leadingAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: buyBotton.centerYAnchor).isActive = true


        buyBotton.trailingAnchor.constraint(equalTo: viewScroll.frameLayoutGuide.trailingAnchor, constant: -10).isActive = true
        buyBotton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50).isActive = true
        buyBotton.widthAnchor.constraint(equalToConstant: buyBotton.frame.size.width).isActive = true
        buyBotton.addTarget(self, action: #selector(clickBuyBottonn(_:)), for: .touchUpInside)
        
        
        nameCaruselSaleLabel.leadingAnchor.constraint(equalTo: viewScroll.leadingAnchor, constant: 10).isActive = true
        nameCaruselSaleLabel.trailingAnchor.constraint(equalTo: viewScroll.trailingAnchor, constant: -10).isActive = true
        nameCaruselSaleLabel.topAnchor.constraint(equalTo: buyBotton.bottomAnchor, constant: 50).isActive = true

        nameCaruselSaleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameCaruselSaleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        caruselSaleCollectionView.leadingAnchor.constraint(equalTo: viewScroll.frameLayoutGuide.leadingAnchor).isActive = true
        caruselSaleCollectionView.trailingAnchor.constraint(equalTo: viewScroll.frameLayoutGuide.trailingAnchor).isActive = true
        caruselSaleCollectionView.topAnchor.constraint(equalTo: nameCaruselSaleLabel.bottomAnchor, constant: 5).isActive = true
        caruselSaleCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true


    }
      
    @objc func clickBuyBottonn(_ sender:UIButton){
        if let product = presenter.products.product {
            self.presenter.orderService.showAddOrder(view: self, product:product)
        }
    }
    
    
    deinit {
        print("deinit ProductDetailViewController")
    }
   
}


extension ProductDetailViewController:ProductDetailControllerProtocol {
  
    func sucessProduct() {

        self.caruselSaleCollectionView.reloadData()
        
        if let product = presenter.products.product {
           
           
            if let url = URL(string:product.url){
                pictureImageView.sd_setImage(with: url, placeholderImage: Images.Photo.placeholder) { (image, _, _, _) in
                    if image == nil {
                        self.pictureImageView.image = Images.Photo.placeholder
                    }
                }
            }else{
                self.pictureImageView.image = Images.Photo.placeholder
            }

            nameLabel.text = product.name
            priceLabel.text = product.price.stingWithCurrency
        
        }else{
            self.showAlert(message: "Не нашелся букет")
        } 
 
    }
    
    func errorProduct (error:String){
        self.showAlert(message: error)
    }
    
    
}


extension ProductDetailViewController:CaruselCollectionViewProtocol{
   
    func buyProductCarusel(product: Product) {
        self.presenter.orderService.showAddOrder(view: self, product:product)
    }
    
   
    func showDeiailProductCarusel(idProduct:String) {
        presenter.showDeiailProduct(idProduct:idProduct)
    }
    
    func getDataProductCarusel() -> [Product]?{
        return presenter.products.popular
    }
}


extension ProductDetailViewController: OrderServiceControllerProtocol {
   
    func sussesServiceOrder() {
        self.showAlert(message: Localization.Alert.OrderBuy.saveOrder)
    }
    
    func errorServiceOrder(error: String) {
        self.showAlert(tite: Localization.Alert.OrderBuy.title,message: error)
    }
    
}
