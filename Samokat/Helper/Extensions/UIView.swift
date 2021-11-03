//
//  UIView.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func showSpinnerViewFull(){
        addSubview(SpinnerView.view)
        SpinnerView.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    func showSpinnerViewCenter(){
        addSubview(SpinnerView.circleView)
        SpinnerView.circleView.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
    
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
            return constraint
        }
        return nil
    }

    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
        let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
        return firstItemMatch || secondItemMatch
    }
    
    func addSubViews(_ views: [UIView]){
        for view in views{
            addSubview(view)
        }
    }
    
    func mask(path: UIBezierPath){
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        let scale = self.layer.bounds.width / path.bounds.width
        mask.transform = CATransform3DMakeScale(scale, scale, 1)
        layer.mask = mask
    }
    
    func viewContainingController() -> UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
