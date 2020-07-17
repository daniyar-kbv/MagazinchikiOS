//
//  LocationViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class LocationViewController: UIViewController {
    lazy var locationView = LocationView()
    var startHeight: CGFloat?
    lazy var initialHeight: CGFloat = 0
    var isUp: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configActions()
        configData()
        
        addBackButton()
    }
    
    override func loadView() {
        super.loadView()
        
        view = locationView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startHeight = locationView.bottomContainer.frame.height
        if let startHeight = startHeight{
            locationView.bottomContainer.snp.makeConstraints({
                $0.height.equalTo(startHeight)
            })
        }
    }
    
    func configData(){
    }
    
    func configActions() {
        locationView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanTray(sender:)))
        locationView.topSmallContainer.addGestureRecognizer(panGesture)
        
        locationView.addressField.textField.addTarget(self, action: #selector(fieldEditingDidBegin(textField:)), for: .editingDidBegin)
        
        locationView.houseField.textField.addTarget(self, action: #selector(fieldEditingDidBegin(textField:)), for: .editingDidBegin)
        
        locationView.addressField.onReturn = onReturn
        locationView.houseField.onReturn = onReturn
    }

    @objc func nextTapped(){
        let vc = PhoneViewController()
        vc.type = .phone
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == UIGestureRecognizer.State.began {
            initialHeight = locationView.bottomContainer.frame.height
        } else if sender.state == UIGestureRecognizer.State.changed {
            locationView.bottomContainer.snp.updateConstraints({
                $0.height.equalTo(initialHeight - translation.y)
            })
        } else if sender.state == UIGestureRecognizer.State.ended {
            let velocity = sender.velocity(in: view)
            isUp ? animateUp() : animateDown()
        }
    }
    
    func animateDown(){
        isUp = false
        if let startHeight = startHeight{
            locationView.bottomContainer.snp.updateConstraints({
                $0.height.equalTo(startHeight)
            })
        }
        locationView.fieldsStack.snp.updateConstraints({
            $0.height.equalTo(StaticSize.s100)
        })
        dismissKeyboard()
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.locationView.darkBackground.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { (finished) in
            self.addDarkBackground(add: false)
        }
    }
        
    func animateUp(){
        isUp = true
        locationView.bottomContainer.snp.updateConstraints({
            $0.height.equalTo(ScreenSize.SCREEN_HEIGHT - StaticSize.s70)
        })
        locationView.fieldsStack.snp.updateConstraints({
            $0.height.equalTo(StaticSize.s40)
        })
        DispatchQueue.main.async {
            self.addDarkBackground()
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.locationView.darkBackground.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    func addDarkBackground(add: Bool = true) {
        if add{
            locationView.mapView.addSubview(locationView.darkBackground)
            locationView.darkBackground.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
        } else {
            locationView.darkBackground.removeFromSuperview()
        }
    }
    
    @objc func fieldEditingDidBegin(textField: UITextField){
        showTextField(textField: textField.superview! as! AuthTextField)
        animateUp()
    }
    
    func showTextField(textField: AuthTextField){
        showAllFields(false)
        textField.isHidden = false
    }
    
    func showAllFields(_ show: Bool = true){
        locationView.addressField.isHidden = !show
        locationView.houseField.isHidden = !show
    }
    
    func onReturn() {
        showAllFields()
        animateDown()
    }
}
