//
//  ProductsDetail.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 28/04/21.
//

import UIKit

class ProductsDetail: UIViewController {
    
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var storeObj:StoreModel? {
        didSet {
            guard let store = storeObj,
                  let storeID = storeObj?.storeID
            else { return }
            setStoreDataInfo(storeData: store)
            getProductsByStore(storeid: storeID)
        }
    }
    
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
    
    let backButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let productsCollection:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: 60, height: 60)
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var cartView:UIView!
    
    let cartImage:UIImageView = {
       let cartImage = UIImageView()
        cartImage.image = UIImage(systemName: "cart.circle")
        cartImage.translatesAutoresizingMaskIntoConstraints = false
        return cartImage
    }()
    
    let totalPriceLabel:UILabel = {
        let label = UILabel()
        label.text = "MX$0.0"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addProductButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Pagar", for: .normal)
        button.backgroundColor = UIColor.BlueColor.blueButton
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //var productsArray = [ProductModel]()
    
    private var productsDetailVM:ProductsDetailVM? = ProductsDetailVM(apiService: APIService())
    
    private let screenBounds = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //productsDetailVM = ProductsDetailVM(apiService: APIService())
        
        configUI()
    }
    
    deinit {
        productsDetailVM = nil
        print("removing objects from memory")
    }
    
    private func configUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(storeImage)
        self.view.addSubview(storeNameLabel)
        self.view.addSubview(storeAddressLabel)
        self.view.addSubview(productsCollection)
        self.view.addSubview(backButton)

        NSLayoutConstraint.activate([
            storeImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            storeImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            storeImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            storeImage.heightAnchor.constraint(equalToConstant: 150),
            
            storeNameLabel.topAnchor.constraint(equalTo: storeImage.bottomAnchor, constant: 10),
            storeNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            storeAddressLabel.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 10),
            storeAddressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            productsCollection.topAnchor.constraint(equalTo: storeAddressLabel.bottomAnchor, constant: 0),
            productsCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            productsCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            productsCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        productsCollection.register(ProductCell.self, forCellWithReuseIdentifier: "cell")
        productsCollection.dataSource = self
        productsCollection.delegate = self
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        configCartView()
        
        /*
        self.view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        */
        
        //tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //tableview.dataSource = self
        //tableview.delegate = self
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getProductsByStore(storeid:Int) {
        productsDetailVM?.getProductsByStore(storeid: storeid) { [weak self] in
            DispatchQueue.main.async {
                self?.productsCollection.reloadData()
            }
        }
    }
    
    private func setStoreDataInfo(storeData:StoreModel) {
        if !((storeData.storeLogoURL?.isEmpty) != nil) {
            //TODO: Load store image
        }
        
        storeNameLabel.text = storeData.name ?? ""
        storeAddressLabel.text = "\(storeData.storeRoute ?? "") \(storeData.storeAddress ?? "")"
    }
    
    private func configCartView() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        
        cartView = UIView(frame: CGRect(x: 0, y: screenBounds.height + 50, width: screenBounds.width, height: 100))
        cartView.backgroundColor = UIColor.GrayColor.backgroundGray
        cartView.addGestureRecognizer(swipeDown)
        
        cartView.addSubview(cartImage)
        cartView.addSubview(totalPriceLabel)
        cartView.addSubview(addProductButton)
        
        NSLayoutConstraint.activate([
            cartImage.topAnchor.constraint(equalTo: cartView.topAnchor, constant: 10),
            cartImage.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 10),
            cartImage.widthAnchor.constraint(equalToConstant: 60),
            cartImage.heightAnchor.constraint(equalToConstant: 60),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: cartImage.centerYAnchor, constant: 0),
            totalPriceLabel.leadingAnchor.constraint(equalTo: cartImage.trailingAnchor, constant: 20),
            
            addProductButton.centerYAnchor.constraint(equalTo: totalPriceLabel.centerYAnchor, constant: 0),
            addProductButton.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -20),
            addProductButton.widthAnchor.constraint(equalToConstant: 100),
            addProductButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(cartView)
    }
    
    private func showCartView() {
        
        UIView.animate(withDuration: 0.3) {
            self.cartView.layer.position.y = self.screenBounds.height - 50
        }
        
    }
    
    private func hideCartView() {
        
        UIView.animate(withDuration: 0.3) {
            self.cartView.layer.position.y = self.screenBounds.height + 50
        }
        
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                hideCartView()
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}

extension ProductsDetail: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //getProductsByStore(store: waterStores[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds.width * 0.90, height: 180)
    }
    
}

extension ProductsDetail: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsDetailVM?.getProductsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCell
        else { return UICollectionViewCell() }
        
        productCell.prepareForReuse()
        
        productCell.bindData(vm: productsDetailVM, position: indexPath.row)
        
        productCell.addProductCallback = { [weak self] in
            self?.productsDetailVM?.addProductToBuy(position: indexPath.row)
            self?.showCartView()
        }
        
        return productCell
    }
    
}

//extension ProductsDetail: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return productsArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        let product = productsArray[indexPath.row]
//
//        cell.textLabel?.text = product.name
//
//        return cell
//
//    }
//}
