//
//  CustomModalViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/9/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class MainPageModalViewController: CustomModalViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var mainModalView = MainPageModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.setView(view: mainModalView)
        
        mainModalView.tableView.delegate = self
        mainModalView.tableView.dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        
        view = modalView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppShared.sharedInstance.categories?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.customReuseIdentifier, for: indexPath) as! CategoryCell
        cell.setTitle(text: AppShared.sharedInstance.categories?[indexPath.row].title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateDown()
        AppShared.sharedInstance.selectedCategory.onNext(indexPath.row)
    }
}
