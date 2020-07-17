//
//  OrderFormingViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/16/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class OrderFormingViewController: UIViewController {
    lazy var orderView = OrderFormingView()
    var timer: Timer?
    var initialTimerValue: Int = 60
    var timerValue: Int!
    var initialTime: Double?
    
    override func loadView() {
        super.loadView()
        
        view = orderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderView.animation.play()
        runTimer()
        initialTime = Date().timeIntervalSince1970
        print(initialTime)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reCountTimer), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func reCountTimer(){
        let currentTime = Date().timeIntervalSince1970
        print(currentTime)
        let diff = currentTime - (initialTime ?? 0)
        print(diff)
        if diff <= 1 {
            timerValue = 1
        } else {
            timerValue = initialTimerValue - Int(diff)
        }
    }
    
    func runTimer(){
        timerValue = initialTimerValue
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerValue == 0{
                timer.invalidate()
                let vc = OrderResultViewController()
                vc.type = .success
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            self.timerValue -= 1
        }
    }
}
