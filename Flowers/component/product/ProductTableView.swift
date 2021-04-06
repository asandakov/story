//
//  ProductTableView.swift
//  Flowers
//
//  Created by Алексей on 27.12.2020.
//

import UIKit
import SDWebImage

protocol ProductTableViewProtocol:class {
    func getDataProduct() -> [Product]?
    func showDeiailProduct(idProduct:String)
    func lastCellTable()
    func buyProduct(product:Product)
}

class ProductTableView: UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  
    public weak var dataTable:ProductTableViewProtocol?
   
    public let heightCell = 400
    
    
    init(){
        super.init(frame: .zero, style: .plain)
        register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseId)
        
        delegate = self
        dataSource = self
                    
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = false        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
     
    }
    
    required init?(coder: NSCoder) {        
        fatalError("init(coder:) has not been implemented")
    }
      
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTable?.getDataProduct()?.count ?? 0
    }
      
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // SDImageCache.shared.clearDisk()
        
        
        guard let cell = dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let data = self.dataTable?.getDataProduct() ?? []
  
        
        guard let url = URL(string:data[indexPath.row].url) else { return UITableViewCell()}
       
      
        cell.pictureImageView.sd_setImage(with: url, placeholderImage: Images.Photo.placeholder) { (image, _, _, _) in
            if image == nil {
                cell.pictureImageView.image = Images.Photo.placeholder
            }
        }

        cell.nameLabel.text = data[indexPath.row].name
        cell.priceLabel.text = data[indexPath.row].price.stingWithCurrency
        cell.buyBottonAction = {  [weak self] in
            guard let self = self else { return }
            self.dataTable?.buyProduct(product: data[indexPath.row])
        }

        cell.selectionStyle = .none
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return CGFloat(self.heightCell)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let data = self.dataTable?.getDataProduct() ?? []

        self.dataTable?.showDeiailProduct(idProduct: data[indexPath.row].id)


    }
  
    func createSpinerFooter() -> UIView{ 
        let view = UIView(frame: CGRect(x: 0, y: 0, width:self.contentSize.width, height: 50))
        let spiner = UIActivityIndicatorView()
        spiner.startAnimating()
        spiner.center = view.center
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(spiner)
        return view
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
                 self.dataTable?.lastCellTable()
             }
     }
 
}
