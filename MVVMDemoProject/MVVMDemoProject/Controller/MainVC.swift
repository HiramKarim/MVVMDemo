//
//  MainVC.swift
//  MVVMDemoProject
//
//  Created by Hiram Castro on 27/04/21.
//

import UIKit

class MainVC: UIViewController {
    
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let storeCollection:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: 60, height: 60)
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let headerView:UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var waterStores = [StoreModel]()
    
    private let screenBounds = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        getStores()
    }
    
    private func configUI() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(headerView)
        self.view.addSubview(storeCollection)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            storeCollection.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            storeCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            storeCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            storeCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        storeCollection.register(StoreCell.self, forCellWithReuseIdentifier: "cell")
        storeCollection.dataSource = self
        storeCollection.delegate = self
    }
    
    private func getStores() {
        APIService.shared.getStores { [weak self] (storesArray) in
            self?.waterStores = storesArray
            DispatchQueue.main.async {
                self?.storeCollection.reloadData()
            }
        }
    }
    
    private func getProductsByStore(store:StoreModel) {
        let productDetailVC = ProductsDetail()
        productDetailVC.storeObj = store
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getProductsByStore(store: waterStores[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenBounds.width * 0.90, height: 180)
    }
    
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return waterStores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let storeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StoreCell
        else { return UICollectionViewCell() }
        
        storeCell.prepareForReuse()
        
        let store = waterStores[indexPath.row]
        
        storeCell.bindData(imageURL: store.storeLogoURL, storeName: store.name, storeAddress: "\(store.storeRoute ?? "") \(store.storeAddress ?? "")")
        
        return storeCell
    }
    
}

/*
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let store = waterStores[indexPath.row]
        
        cell.textLabel?.text = store.name
        
        return cell
        
    }
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = waterStores[indexPath.row]
        getProductsByStore(storeid: store.id)
    }
    
}
*/
