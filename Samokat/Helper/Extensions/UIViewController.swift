//
//  UIViewCOntroller.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSpinnerView(){
        view.addSubview(SpinnerView.view)
        SpinnerView.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        SpinnerView.isLoading = true
    }
    
    func removeSpinnerView(){
        SpinnerView.view.removeFromSuperview()
        SpinnerView.isLoading = false
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func addBackButton(){
        let backImage = UIImage(named: "backButton")!.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView.init(image: backImage)
        let backView = UIView()
        backView.addSubview(imageView)
        imageView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(StaticSize.s10)
            $0.height.equalTo(StaticSize.s18)
        })
        let menuItem = UIBarButtonItem(customView: backView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pop))
        backView.addGestureRecognizer(tapGesture)
        let widthConstraintLeft = backView.widthAnchor.constraint(equalToConstant: 40)
        let heightConstraintLeft = backView.heightAnchor.constraint(equalToConstant: 40)
        heightConstraintLeft.isActive = true
        widthConstraintLeft.isActive = true
        menuItem.imageInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    @objc func pop(){
        navigationController?.popViewController(animated: true)
    }

//  MARK: - Modal opening

    @objc func openMainPageModal(){
        openModal(vc: MainPageModalViewController(modalHeight: ScreenSize.SCREEN_HEIGHT / 2))
    }
    
    @objc func openPaymentsModal(){
        openModal(vc: PaymentTypeModalViewController(modalHeight: ScreenSize.SCREEN_HEIGHT * 0.4))
    }
    
    @objc func openPromocodeModal(){
        openModal(vc: PromocodeModalViewController(modalHeight: ScreenSize.SCREEN_WIDTH * 0.8))
    }
    
    func openModal(vc: CustomModalViewController){
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.openContainer()
    }
    
    func openSearch(y: CGFloat){
        let vc = SearchViewController(searchY: y)
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.open()
    }
    
    func openTop(vc: UIViewController){
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(view.snp.right).priority(.low)
            $0.width.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.view.snp.makeConstraints({
            $0.left.equalToSuperview().priority(.medium)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func removeTop(){
        if let superview = view.superview{
            view.snp.makeConstraints({
                $0.top.bottom.equalToSuperview()
                $0.left.equalTo(superview.snp.right).priority(.high)
                $0.width.equalToSuperview()
            })
            
            UIView.animate(withDuration: 0.15, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                self.remove()
            })
        }
    }
    
//  MARK: - Keyboard opening
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardDisplay(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if window.frame.origin.y == 0
            {
                window.frame.origin.y -= (keyboardSize.height - StaticSize.s20)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            if window.frame.origin.y != 0
            {
                window.frame.origin.y += (keyboardSize.height - StaticSize.s20)
            }
        }
    }
    
    func disableKeyboardDisplay(_ vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
