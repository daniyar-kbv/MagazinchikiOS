//
//  OrderFormingViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class OrderFormingViewController: UIViewController {
    lazy var orderView = OrderFormingView()
    var timer: Timer?
    var isPaused = false
    lazy var initialTimerValue: Int = 10
    lazy var timerValue: Int = initialTimerValue
    var initialTime: Double?
    lazy var disposeBag = DisposeBag()
    lazy var viewModel = OrderFormingViewModel()
    var orderId: Int?
    var error: String? {
        didSet {
            isPaused = false
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = orderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderView.animation.play()
        runTimer()
        initialTime = Date().timeIntervalSince1970
        bind()
        orderView.cancelButton.addTarget(self, action: #selector(cancelOrder), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(reCountTimer), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func bind() {
        viewModel.data.subscribe(onNext: { _ in
            DispatchQueue.main.async {
                AppShared.sharedInstance.navigationController.popToMain()
            }
        }).disposed(by: disposeBag)
        viewModel.errorSubject.subscribe(onNext: { error in
            DispatchQueue.main.async {
                self.error = error
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func cancelOrder(){
        if let orderId = orderId{
            viewModel.cancelOrder(orderId: orderId)
        }
    }
    
    @objc func reCountTimer(){
        orderView.animation.play()
        let currentTime = Date().timeIntervalSince1970
        let diff = initialTimerValue - Int(currentTime - (initialTime ?? 0))
        if diff <= 0 {
            toResult()
        } else {
            timerValue = diff
        }
        timer?.invalidate()
        runTimer()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerValue == 0{
                self.toResult()
                return
            }
            if !self.isPaused{
                self.timerValue -= 1
            }
        }
    }
    
    func toResult() {
        let vc = OrderResultViewController()
        vc.type = .success
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
