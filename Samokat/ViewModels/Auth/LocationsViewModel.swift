//
//  LocationsViewModel.swift
//  Samokat
//
//  Created by Daniyar on 7/21/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import RxSwift
import YandexMapKit

class LocationsViewModel {
    let disposeBag  = DisposeBag()
    
    lazy var findDistrictData = PublishSubject<FindDistrctData>()
    lazy var districtsData = PublishSubject<DistrictsData>()
    lazy var errorSubject = PublishSubject<String>()
    
    var findDistrictResponse: FindDistrictResponse? {
        didSet {
            if let data = findDistrictResponse?.data {
                DispatchQueue.global(qos: .background).async {
                    self.findDistrictData.onNext(data)
                }
            }
        }
    }
    var districtsResponse: DistrictsResponse? {
        didSet {
            if let districtsData = districtsResponse?.data {
                DispatchQueue.global(qos: .background).async {
                    self.districtsData.onNext(districtsData)
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
    
    func getDistricts(){
        SpinnerView.showSpinnerView()
        APIManager.shared.getDistricts(){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            self.districtsResponse = response
        }
    }
    
    func findDistrict(latitude: Double?, longitude: Double?, city: String?, street: String?, house: String?, flat: String?){
        guard let lat = latitude, let lon = longitude, let city = city, let street = street, let house = house, let flat = flat else { return }
        let address = "\(city), \(street) \(house), \(flat)"
        SpinnerView.showSpinnerView()
        APIManager.shared.findDistrict(latitude: lat, longitude: lon, address: address){ error, response in
            SpinnerView.removeSpinnerView()
            guard let response = response else {
                self.error = error
                return
            }
            self.findDistrictResponse = response
        }
    }
    
    init() {
        
    }
}

