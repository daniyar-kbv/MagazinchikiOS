//
//  SearchViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    var searchView: SearchView
    var products: [Product]? {
        didSet {
            searchView.collectionView.reloadData()
        }
    }
    
    required init(searchY: CGFloat) {
        searchView = SearchView(searchY: searchY)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.cancelButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        searchView.searchField.field.addTarget(self, action: #selector(onFieldChange(_:)), for: .editingChanged)
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        hideKeyboardWhenTappedAround()
    }
    
    func open(){
        searchView.cancelButton.snp.updateConstraints({
            $0.bottom.equalTo(view.snp.top).offset(Global.safeAreaTop() + StaticSize.s20)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.searchView.backView.backgroundColor = .white
        }, completion: { finished in
            self.searchView.collectionView.isHidden = false
            self.searchView.searchField.field.becomeFirstResponder()
        })
    }
    
    @objc func close(){
        searchView.cancelButton.snp.updateConstraints({
            $0.bottom.equalTo(view.snp.top).offset(searchView.top)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
            self.searchView.cancelButton.isHidden = true
            self.searchView.backView.backgroundColor = .clear
            self.searchView.collectionView.isHidden = true
        }, completion: { finished in
            self.remove()
        })
    }
    
    @objc func onFieldChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        products = AppShared.sharedInstance.searchProducts(text: text)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.customReuseIdentifier, for: indexPath) as! ProductsCollectionViewCell
        cell.product = products?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2), height: StaticSize.s295)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = products?[indexPath.row]{
            let toVc = ProductDetailViewController()
            toVc.product = product
            present(toVc, animated: true, completion: nil)
        }
    }
}
