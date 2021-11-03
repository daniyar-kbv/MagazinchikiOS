//
//  TopFullFiltersView.swift
//  Samokat
//
//  Created by Daniyar on 7/10/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TopFullFiltersView: UIView {
    var size: CGSize!
    var filtersCell = ProductFiltersCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        addSubview(filtersCell)
        filtersCell.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0)
        })
        
        self.layoutIfNeeded()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        if location.y > size.height {
            close(animated: true)
        }
    }
    
    func open(){
        if filtersCell.superview == nil {
            setUp()
        }
        filtersCell.snp.updateConstraints({
            $0.height.equalTo(size.height)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        })
        
        filtersCell.frame.size = size
    }
    
    func close(animated: Bool){
        if animated{
            filtersCell.snp.updateConstraints({
                $0.height.equalTo(0)
            })
            
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
                self.backgroundColor = .clear
            }, completion: { finished in
                self.removeFromSuperview()
                AppShared.sharedInstance.onSelectFilter = nil
            })
        } else {
            self.backgroundColor = .clear
            self.removeFromSuperview()
            AppShared.sharedInstance.onSelectFilter = nil
        }
    }
}
