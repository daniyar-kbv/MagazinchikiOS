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
}
