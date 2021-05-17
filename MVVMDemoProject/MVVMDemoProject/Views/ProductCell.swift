//
//  ProductCell.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 16/05/21.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private let productImage:UIImageView = {
       let storeImage = UIImageView()
        storeImage.sizeToFit()
        storeImage.image = UIImage(named: "store-placeholder")
        storeImage.translatesAutoresizingMaskIntoConstraints = false
        return storeImage
    }()
    
    private let productNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDescriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPriceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addProductButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Agregar", for: .normal)
        button.backgroundColor = UIColor.BlueColor.blueButton
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var addProductCallback:(()->Void)?
    
    private var product:ProductModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        productNameLabel.text = ""
        productDescriptionLabel.text = ""
    }
    
    private func addViews() {
        
        self.contentView.backgroundColor = UIColor.GrayColor.backgroundGray
        self.contentView.layer.cornerRadius = 10
        
        self.contentView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 10, scale: true)
        
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(productNameLabel)
        self.contentView.addSubview(productDescriptionLabel)
        self.contentView.addSubview(productPriceLabel)
        self.contentView.addSubview(addProductButton)
        
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 17),
            productNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            productImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            productImage.widthAnchor.constraint(equalToConstant: 110),
            productImage.heightAnchor.constraint(equalToConstant: 70),
            
            addProductButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            addProductButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            addProductButton.widthAnchor.constraint(equalToConstant: 100),
            addProductButton.heightAnchor.constraint(equalToConstant: 40),
            
            productPriceLabel.centerYAnchor.constraint(equalTo: addProductButton.centerYAnchor, constant: 0),
            productPriceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
        ])
        
        addProductButton.addTarget(self, action: #selector(addProductHandler), for: .touchUpInside)
        
    }
    
    @objc private func addProductHandler() {
        addProductCallback?()
    }
    
    func bindData(vm:ProductsDetailVM?, position:Int) {
        
        //self.product = storeProduct
        
        /*
        if !((imageURL?.isEmpty) != nil) {
            //TODO: Load store image
        }
        */
        
        productNameLabel.text = vm?.getProductAtPosition(position: position).name ?? ""
        //productDescriptionLabel.text = storeProduct.description ?? ""
        productPriceLabel.text = "MX\(vm?.getProductAtPosition(position: position).price ?? 0.0)" 
        
    }
    
}
