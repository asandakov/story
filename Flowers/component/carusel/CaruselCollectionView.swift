//
//  SaleCollectionView.swift
//  Flowers
//
//  Created by Алексей on 25.12.2020.
//

import UIKit

protocol CaruselCollectionViewProtocol:class {
    func getDataProductCarusel() -> [Product]?
    func showDeiailProductCarusel(idProduct:String)
    func buyProductCarusel(product:Product)
}

class CaruselCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public weak var dataTable:CaruselCollectionViewProtocol?
    
    static let leftDictanceToView:CGFloat = 30
    static let rightDictanceToView:CGFloat = 30
    static let minimumLineSpacing:CGFloat = 15
    static let widthItem = (UIScreen.main.bounds.width - CaruselCollectionView.leftDictanceToView - CaruselCollectionView.rightDictanceToView - (CaruselCollectionView.minimumLineSpacing/2))/2
      
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(CaruselCollectionViewCell.self, forCellWithReuseIdentifier: CaruselCollectionViewCell.reuseId)
        
        layout.minimumLineSpacing = CaruselCollectionView.minimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: CaruselCollectionView.leftDictanceToView, bottom: 0, right: CaruselCollectionView.rightDictanceToView)
        
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CaruselCollectionView.widthItem, height: frame.height*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataTable?.getDataProductCarusel()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       
        guard let cell = dequeueReusableCell(withReuseIdentifier: CaruselCollectionViewCell.reuseId, for: indexPath) as? CaruselCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        let data = self.dataTable?.getDataProductCarusel() ?? []
        
        
        guard let url = URL(string:data[indexPath.item].url) else { return UICollectionViewCell()}
       
      
        cell.pictureImageView.sd_setImage(with: url, placeholderImage: Images.Photo.placeholder ) { (image, _, _, _) in
            if image == nil {
                cell.pictureImageView.image = Images.Photo.placeholder
            }
        }
        
        cell.nameLabel.text = data[indexPath.item].name
        cell.priceLabel.text = data[indexPath.item].price.stingWithCurrency
        cell.buyBottonAction = {  [weak self] in
            guard let self = self else { return }
            self.dataTable?.buyProductCarusel(product: data[indexPath.row])
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let data = self.dataTable?.getDataProductCarusel() ?? []
      
        self.dataTable?.showDeiailProductCarusel(idProduct: data[indexPath.row].id)
    }
    
}
