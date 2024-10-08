//
//  PhoneViewModel.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift

class PhoneViewModel {
    let disposeBag  = DisposeBag()
    
    lazy var phoneData = PublishSubject<PhoneData>()
    lazy var errorSubject = PublishSubject<String>()
    lazy var smsResponseData = PublishSubject<CheckSmsData>()
    lazy var resendSuccess = PublishSubject<Bool>()
    
    var phoneResponse: PhoneResponse? {
        didSet {
            if let data = phoneResponse?.data {
                DispatchQueue.global(qos: .background).async {
                    self.phoneData.onNext(data)
                }
            }
        }
    }
    var smsResponse: CheckSmsResponse? {
        didSet{
            if let data = smsResponse?.data{
                DispatchQueue.global(qos: .background).async {
                    self.smsResponseData.onNext(data)
                }
            }
        }
    }
    var error: String? {
        didSet{
            if let error = error{
                DispatchQueue.global(qos: .background).async {
                    self.errorSubject.onNext(error)
                }
            }
        }
    }
    
    func checkPhoneNumber(phone: String, transactionId: String){
        var formattedPhone = phone.replacingOccurrences(of: " ", with: "")
        let range1 = formattedPhone.index(formattedPhone.startIndex, offsetBy: 1)..<formattedPhone.endIndex
        formattedPhone = String(formattedPhone[range1])
        SpinnerView.showSpinnerView()
        APIManager.shared.checkPhoneNumber(phone: formattedPhone, transactionId: transactionId){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            self.phoneResponse = response
        }
    }
    
    func checkSms(sms: String, transactionId: String){
        SpinnerView.showSpinnerView()
        APIManager.shared.checkSmsCode(sms: sms, transactionId: transactionId){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            self.smsResponse = response
        }
    }
    
    func resendSms(transactionId: String) {
        SpinnerView.showSpinnerView()
        APIManager.shared.resendSms(transactionId: transactionId){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            DispatchQueue.global(qos: .background).async {
                self.resendSuccess.onNext(response)
            }
        }
    }
    
    init() {
        
    }
}
