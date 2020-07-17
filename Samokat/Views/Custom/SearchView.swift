//
//  SearchView.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    var top: CGFloat
    
    lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Отменить", for: .normal)
        view.setTitleColor(.customTextBlack, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: StaticSize.s12, weight: .regular)
        return view
    }()
    
    lazy var searchField: CustomSearchField = {
        let view = CustomSearchField()
        view.field.placeholder = "Это поиск по магазину"
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    required init(searchY: CGFloat) {
        top = searchY
        
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubViews([backView, cancelButton, searchField, collectionView])
        
        backView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        cancelButton.snp.makeConstraints({
            $0.height.equalTo(StaticSize.s20)
            $0.bottom.equalTo(self.snp.top).offset(top)
            $0.right.equalToSuperview().offset(-StaticSize.s15)
        })
        
        searchField.snp.makeConstraints({
            $0.top.equalTo(cancelButton.snp.bottom)
            $0.height.equalTo(StaticSize.s40)
            $0.left.right.equalToSuperview().inset(StaticSize.s15)
        })
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(searchField.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
