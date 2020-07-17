//
//  FilterCollectionView.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FilterCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let disposeBag = DisposeBag()
    var subCategories: [SubCategory]? {
        didSet{
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .white
        register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.customReuseIdentifier)
        delegate = self
        dataSource = self
        collectionViewLayout = UICollectionViewFlowLayout()
        delaysContentTouches = false
        
        bind()
        if subCategories == nil{
            subCategories = AppShared.sharedInstance.subCategories
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        AppShared.sharedInstance.selectedFilterSubject.subscribe(onNext: {[weak self] selected in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.select(index: selected)
            }
        }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.customReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
        cell.setTitle(text: subCategories?[indexPath.row].title ?? "")
        if subCategories?[indexPath.row].id == AppShared.sharedInstance.selectedFilter{
            cell.isActive = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
        label.textColor = .customGreen
        label.text = subCategories?[indexPath.row].title ?? ""
        label.sizeToFit()
        return CGSize(width: label.frame.width + StaticSize.s20, height: StaticSize.s36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: StaticSize.s15, left: StaticSize.s15, bottom: 0, right: StaticSize.s15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppShared.sharedInstance.selectedFilter = subCategories?[indexPath.row].id
    }
    
    func select(index: Int) {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
            for i in 0..<self.numberOfItems(inSection: 0){
                if let cell = self.cellForItem(at: IndexPath(item: i, section: 0)) as? FilterCollectionViewCell{
                    cell.isActive = self.subCategories?[i].id == index
                }
            }
        }, completion: nil)
    }
}

class ProductFiltersCell: UICollectionViewCell{
    static var customReuseIdentifier = "ProductFiltersCell"
    
    lazy var filterCollection: FilterCollectionView = {
        let view = FilterCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(filterCollection)
        filterCollection.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
