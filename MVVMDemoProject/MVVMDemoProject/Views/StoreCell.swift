//
//  StoreCell.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 15/05/21.
//

import UIKit

class StoreCell:UICollectionViewCell {
    
    let storeImage:UIImageView = {
       let storeImage = UIImageView()
        storeImage.sizeToFit()
        storeImage.image = UIImage(named: "store-placeholder")
        storeImage.translatesAutoresizingMaskIntoConstraints = false
        return storeImage
    }()
    
    let storeNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let storeAddressLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        storeNameLabel.text = ""
        storeAddressLabel.text = ""
    }
    
    private func addViews() {
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        
        self.contentView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 10, scale: true)
        
        self.contentView.addSubview(storeImage)
        self.contentView.addSubview(storeNameLabel)
        self.contentView.addSubview(storeAddressLabel)
        
        NSLayoutConstraint.activate([
            storeImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            storeImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            storeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            storeImage.heightAnchor.constraint(equalToConstant: 90),
            
            storeNameLabel.topAnchor.constraint(equalTo: storeImage.bottomAnchor, constant: 10),
            storeNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            
            storeAddressLabel.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 10),
            storeAddressLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
        ])
        
        
    }
    
    func bindData(imageURL:String?, storeName:String?, storeAddress:String?) {
        
        if !((imageURL?.isEmpty) != nil) {
            //TODO: Load store image
        }
        
        storeNameLabel.text = storeName ?? ""
        storeAddressLabel.text = storeAddress ?? ""
        
    }
    
    
    
}
