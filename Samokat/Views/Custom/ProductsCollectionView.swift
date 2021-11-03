//
//  ProductsCollectionView.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class ProductsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var topFullFiltersView = TopFullFiltersView()
    var didScroll = false
    var subCategory: SubCategory? {
        didSet {
            guard let subCategory = subCategory else { return }
            let id = AppShared.sharedInstance.selectedFilter
            if let id = id {
                AppShared.sharedInstance.topFilterView.setTitle(text: AppShared.sharedInstance.tags?[id].name ?? "")
            } else {
                AppShared.sharedInstance.topFilterView.show = false
            }
            filteredProducts = subCategory.filterByTag(tagId: id)
            topFullFiltersView.filtersCell.filterCollection.tags = subCategory.tags
        }
    }
    var filteredProducts: [Product]? {
        didSet {
            reloadData() { _ in
                self.filtersMove(up: true)
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .white
        register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.customReuseIdentifier)
        register(ProductFiltersCell.self, forCellWithReuseIdentifier: ProductFiltersCell.customReuseIdentifier)
        delegate = self
        dataSource = self
        collectionViewLayout = UICollectionViewFlowLayout()
        delaysContentTouches = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return filteredProducts?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductFiltersCell.customReuseIdentifier, for: indexPath) as! ProductFiltersCell
            cell.filterCollection.tags = subCategory?.tags
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.customReuseIdentifier, for: indexPath) as! ProductsCollectionViewCell
            cell.product = filteredProducts?[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return calculateFilterCellSize()
        case 1:
            return CGSize(width: (collectionView.bounds.width / 2), height: StaticSize.s295)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            print(AppShared.sharedInstance.topFilterView.isUp)
            print(didScroll)
            print("\n")
            if AppShared.sharedInstance.topFilterView.isUp && didScroll{
                filtersMove(up: false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if !AppShared.sharedInstance.topFilterView.isUp && didScroll{
                filtersMove(up: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.viewContainingController()
        if let vc = vc, let product = subCategory?.products?[indexPath.row]{
            let toVc = ProductDetailViewController()
            toVc.product = product
            vc.present(toVc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: section == 1 ? StaticSize.s100 : 0, right: 0)
    }
    
    @objc func openFilters(){
        if self.superview != nil{
            let size = calculateFilterCellSize()
            topFullFiltersView.size = size
            
            self.superview?.addSubview(topFullFiltersView)
            topFullFiltersView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })

            self.superview?.layoutIfNeeded()

            topFullFiltersView.open()

            AppShared.sharedInstance.onSelectFilter = closeFilters
        }
    }
    
    func closeFilters(){
        topFullFiltersView.close(animated: false)
        self.reloadData()
        self.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    func filtersMove(up: Bool){
        if !up {
            AppShared.sharedInstance.topFilterView = TopFilterView()
            AppShared.sharedInstance.topFilterView.addTarget(self, action: #selector(openFilters), for: .touchUpInside)
        }
        let view = AppShared.sharedInstance.topFilterView
        
        if !up, let superview = superview as? ProductsView {
            superview.addSubview(view)
            view.snp.makeConstraints({
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(-StaticSize.s50)
            })
            
            superview.layoutIfNeeded()
        }
        
        if let selected = AppShared.sharedInstance.selectedFilter, !up{
            view.setTitle(text: subCategory?.getTag(tagId: selected)?.name ?? "")
        }
        
        if let topSuperview = view.superview {
            view.snp.updateConstraints({
                $0.top.equalToSuperview().offset(up ? -StaticSize.s50 : StaticSize.s15)
            })
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { _ in
            if up{
                AppShared.sharedInstance.topFilterView.removeFromSuperview()
            }
        })
        
        AppShared.sharedInstance.topFilterView.isUp = up
    }
    
    func calculateFilterCellSize() -> CGSize {
        var totalWidth: CGFloat = 0
        for tag in subCategory?.tags ?? []{
            let label = UILabel()
            label.font = .systemFont(ofSize: StaticSize.s12, weight: .medium)
            label.textColor = .customGreen
            label.text = tag.name ?? ""
            label.sizeToFit()
            totalWidth += label.frame.size.width + StaticSize.s20
        }
        let count = ceil(totalWidth / (self.bounds.width - StaticSize.s30))
        let height = StaticSize.s15 + (count * StaticSize.s46)
        return CGSize(width: self.bounds.width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll = true
    }
}
