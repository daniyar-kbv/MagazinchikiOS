//
//  PhoneViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhoneViewController: UIViewController {
    lazy var phoneView = PhoneView()
    lazy var disposeBag = DisposeBag()
    var viewModel = PhoneViewModel()
    var codeButtonType: CodeButtonTypes = .check
    var transctionId: String?
    var error: String? {
        didSet {
            guard let error = error else { return }
            phoneView.errorLabel.text = error
            phoneView.errorLabel.isHidden = false
        }
    }
    var type: PhoneViewTypes? {
        didSet {
            guard let type = type else { return }
            phoneView.type = type
        }
    }
    var timer: Timer?
    var timerValue: Int! {
        didSet {
            phoneView.nextButton.setTitle(timerValue.toTime(), for: .normal)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = phoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        navigationController?.isNavigationBarHidden = false
        
        configActions()
        addBackButton()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        phoneView.field.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        phoneView.field.becomeFirstResponder()
        phoneView.nextButton.isHidden = false
        if type == .code{
            runTimer()
        }
    }
    
    private func bind() {
        viewModel.phoneData.subscribe(onNext: { data in
            DispatchQueue.main.async {
                let vc = PhoneViewController()
                vc.type = .code
                vc.transctionId = self.transctionId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.errorSubject.subscribe(onNext: { error in
            DispatchQueue.main.async {
                self.error = error
            }
        }).disposed(by: disposeBag)
        viewModel.smsResponseData.subscribe(onNext: { _ in
            DispatchQueue.main.async {
                ModuleUserDefaults.setIsLoggedIn(true)
                let vc = MainPageViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        viewModel.resendSuccess.subscribe(onNext: {success in
            DispatchQueue.main.async {
                self.runTimer()
                self.phoneView.nextButton.isActive = false
                self.codeButtonType = .check
            }
            }).disposed(by: disposeBag)
    }
    
    func configActions() {
        phoneView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }
    
    @objc func nextTapped(){
        switch type {
        case .phone:
            if let transactionId = transctionId{
                viewModel.checkPhoneNumber(phone: phoneView.field.text ?? "", transactionId: transactionId)
            }
        case .code:
            switch codeButtonType {
            case .resend:
                if let transactionId = transctionId{
                    viewModel.resendSms(transactionId: transactionId)
                }
            case .check:
                if let sms = phoneView.field.text, let transactionId = transctionId{
                    viewModel.checkSms(sms: sms, transactionId: transactionId)
                }
            }
        default:
            break
        }
    }
    
    func runTimer(){
        timerValue = 90
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timerValue == 0{
                timer.invalidate()
                self.phoneView.nextButton.setTitle("Отправить код повторно", for: .normal)
                self.phoneView.nextButton.isActive = true
                self.codeButtonType = .resend
                return
            }
            self.timerValue -= 1
        }
    }
}

extension PhoneViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if !(viewController is PhoneViewController){
            AppShared.sharedInstance.navigationController.isNavigationBarHidden = true
            AppShared.sharedInstance.navigationController.delegate = nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MainPageViewController{
            AppShared.sharedInstance.navigationController.isNavigationBarHidden = true
        }
    }
}

enum PhoneViewTypes{
    case phone
    case code
}

enum CodeButtonTypes {
    case resend
    case check
}

