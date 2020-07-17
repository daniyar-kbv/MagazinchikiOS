//
//  MainPageViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainPageViewController: UIViewController {
    var viewModel: MainPageViewModel?
    let disposeBag = DisposeBag()
    lazy var mainView = MainPageView()
    lazy var footerHeight: CGFloat = StaticSize.s40
    var categories: [Category]? {
        didSet{
            mainView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        confogActions()
        
        viewModel = MainPageViewModel()
        bind()
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if mainView.tableView.subviews.count > 2{
            for i in 0..<mainView.tableView.numberOfSections{
                var imageName = "frameBread"
                if i == 1{
                    imageName = "frameBakaleya"
                }
                let image = UIImageView(image: UIImage(named: imageName)!)
                var sectionRect = mainView.tableView.rect(forSection: i)
                sectionRect.size.height -= (footerHeight - StaticSize.s20)
                let view = UIView(frame: sectionRect)
                view.addSubview(image)
                image.snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
                mainView.tableView.addSubview(view)
                mainView.tableView.sendSubviewToBack(view)
            }
        }
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.categories.subscribe(onNext: { categories in
            DispatchQueue.main.async {
                self.categories = categories
            }
        }).disposed(by: disposeBag)
    }
    
    func confogActions(){
        mainView.smallFigureView.addTarget(self, action: #selector(openMainPageModal), for: .touchUpInside)
        mainView.searchField.field.addTarget(self, action: #selector(onSearch), for: .editingDidBegin)
    }
    
    @objc func onSearch(){
        openSearch(y: mainView.searchField.frame.origin.y)
    }
}
    
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categories?[section].subCategories?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewHeader.customReuseIdentifier, for: indexPath) as! MainTableViewHeader
            let title = self.categories?[indexPath.section].title ?? ""
            cell.title.onTap = {
                let vc = ProductsViewController()
                vc.title = title
                vc.categoryId = self.categories?[indexPath.section].id
                AppShared.sharedInstance.selectedFilter = self.categories?[indexPath.section].subCategories?.first?.id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.setTitle(text: title)
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.customReuseIdentifier, for: indexPath) as! MainTableViewCell
            cell.setTitle(text: self.categories?[indexPath.section].subCategories?[indexPath.row - 1].title ?? "")
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.bringSubviewToFront(cell)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductsViewController()
        vc.title = self.categories?[indexPath.section].title ?? ""
        vc.categoryId = self.categories?[indexPath.section].id
        if indexPath.row != 0{
            AppShared.sharedInstance.selectedFilter = categories?[indexPath.section].subCategories?[indexPath.row - 1].id
        } else {
            AppShared.sharedInstance.selectedFilter = self.categories?[indexPath.section].subCategories?.first?.id
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
