//
//  LocationViewController.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import YandexMapKit
import YandexMapKitSearch
import CoreLocation
import RxSwift

class LocationViewController: UIViewController{
    lazy var locationView = LocationView()
    lazy var disposeBag = DisposeBag()
    lazy var viewModel = LocationsViewModel()
    var startHeight: CGFloat?
    lazy var initialHeight: CGFloat = 0
    var isUp: Bool = false
    var locationManager: CLLocationManager!
    var mapView: YMKMapView!
    var keyboardHeight: CGFloat? {
        didSet {
            guard let keyboardHeight = keyboardHeight else { return }
            locationView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - StaticSize.s80, right: 0)
        }
    }
    var districtMapObjects: [YMKPolygonMapObject] = []
    var districtsData: DistrictsData? {
        didSet {
            guard let districts = districtsData?.districts else { return }
            districtMapObjects = mapView.mapWindow.map.drawDistricts(districts: districts, removeObjects: districtMapObjects)
            var allPoints = districtsData?.getAllPoints()
            if let userPoint = userLocationLayer?.cameraPosition()?.target{
                allPoints?.append(userPoint)
            }
            mapView.mapWindow.map.setCameraToPoints(allPoints: allPoints ?? [])
        }
    }
    var fromMain = false
    let mapKit = YMKMapKit.sharedInstance()
    lazy var userLocationLayer = mapKit?.createUserLocationLayer(with: locationView.mapView.mapWindow)
    
    var searchManager: YMKSearchManager?
    var searchSession: YMKSearchSession?
    var tapSearchSession: YMKSearchSession?
    var searchItems: [YMKGeoObjectCollectionItem] = [] {
        didSet {
            locationView.tableView.reloadData()
        }
    }
    var placemark: YMKPlacemarkMapObject?
    var selected: YMKGeoObject?
    
    var address: Address?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
        
        configActions()
        configData()
        
        addBackButton()
        
        configMap()
        
        bind()
        
        addBackButton()
    }
    
    override func loadView() {
        super.loadView()
        
        view = locationView
        mapView = locationView.mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startHeight = locationView.bottomContainer.frame.height
        if let startHeight = startHeight{
            locationView.bottomContainer.snp.makeConstraints({
                $0.height.equalTo(startHeight)
            })
            
            locationView.mapView.snp.updateConstraints({
                $0.height.equalTo(ScreenSize.SCREEN_HEIGHT - startHeight + StaticSize.s50)
            })
        }
        
        askLocationPermission()
        
        viewModel.getDistricts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func bind(){
        viewModel.districtsData.subscribe(onNext: { districtsData in
            DispatchQueue.main.async {
                self.districtsData = districtsData
            }
        }).disposed(by: disposeBag)
        viewModel.findDistrictData.subscribe(onNext: { data in
            DispatchQueue.main.async {
                guard let distrctId = data.districtId else { return }
                ModuleUserDefaults.setDistrctId(id: distrctId)
                if let address = self.address{
                    ModuleUserDefaults.setAddress(address:address)
                    AppShared.sharedInstance.address = address
                }
                if self.fromMain{
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let vc = PhoneViewController()
                    vc.type = .phone
                    vc.transctionId = data.transactionId
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }).disposed(by: disposeBag)
        viewModel.errorSubject.subscribe(onNext: { error in
            DispatchQueue.main.async {
                self.locationView.showError(show: true, text: error)
            }
        }).disposed(by: disposeBag)
    }
    
    func configData(){
        locationView.tableView.delegate = self
        locationView.tableView.dataSource = self
        
        if fromMain {
            locationView.addressField.textField.text = AppShared.sharedInstance.address?.getStreetHouse()
            locationView.houseField.textField.text = AppShared.sharedInstance.address?.flat
            locationView.nextButton.isActive = true
            if let lat = AppShared.sharedInstance.address?.point?.latitude, let lon = AppShared.sharedInstance.address?.point?.longitude{
                let point = YMKPoint(latitude: lat, longitude: lon)
                onMapTap(with: mapView.mapWindow.map, point: point)
            }
        }
    }
    
    func configActions() {
        locationView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanTray(sender:)))
        locationView.topSmallContainer.addGestureRecognizer(panGesture)
        
        locationView.addressField.textField.addTarget(self, action: #selector(fieldEditingDidBegin(textField:)), for: .editingDidBegin)
        locationView.houseField.textField.addTarget(self, action: #selector(fieldEditingDidBegin(textField:)), for: .editingDidBegin)
        locationView.addressField.textField.addTarget(self, action: #selector(bothFieldChange(_:)), for: .editingChanged)
        locationView.houseField.textField.addTarget(self, action: #selector(bothFieldChange(_:)), for: .editingChanged)
        
        locationView.addressField.onReturn = onReturn
        locationView.addressField.didChange = onFieldDidChange(_:)
        
        locationView.houseField.onReturn = onReturn
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        locationView.locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
        
        locationView.backButton.addTarget(self, action: #selector(onBack), for: .touchUpInside)
    }

    @objc func nextTapped(){
        address?.flat = locationView.houseField.textField.text
        viewModel.findDistrict(latitude: address?.point?.latitude, longitude: address?.point?.longitude, city: address?.city, street: address?.street, house: address?.house, flat: address?.flat)
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == UIGestureRecognizer.State.began {
            initialHeight = locationView.bottomContainer.frame.height
        } else if sender.state == UIGestureRecognizer.State.changed {
            let height = initialHeight - translation.y
            if height >= initialHeight - StaticSize.s50 {
                locationView.bottomContainer.snp.updateConstraints({
                    $0.height.equalTo(initialHeight - translation.y)
                })
            }
        } else if sender.state == UIGestureRecognizer.State.ended {
            _ = sender.velocity(in: view)
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
        locationView.tableView.isHidden = !(textField == locationView.addressField.textField)
        animateUp()
        locationView.showError(show: false)
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
    
    @objc func bothFieldChange(_ textField: UITextField) {
        locationView.nextButton.isActive = !locationView.addressField.textField.isEmpty() && !locationView.houseField.textField.isEmpty()
    }
    
    func onFieldDidChange(_ textField: UITextField){
        let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                self.onSearchResponse(response)
            } else {
                self.onSearchError(error!)
            }
        }
        
        let boundingBox = YMKBoundingBox(southWest: YMKPoint(latitude: 43.191197, longitude: 76.847461), northEast: YMKPoint(latitude: 43.296987, longitude: 76.998180))
        
        searchSession = searchManager!.submit(
            withText: textField.text ?? "",
            geometry: YMKGeometry(boundingBox: boundingBox),
            searchOptions: YMKSearchOptions(searchTypes: .geo, resultPageSize: 10, snippets: YMKSearchSnippet(), experimentalSnippets: [], userPosition: nil, origin: nil, directPageId: nil, appleCtx: nil, geometry: true, advertPageId: nil, suggestWords: true, disableSpellingCorrection: false),
            responseHandler: responseHandler)
    }
    
    @objc func locationTapped(){
        if let userCameraPosition = userLocationLayer?.cameraPosition(){
            userCameraPosition.setValue(15, forKey: "zoom")
            mapView.mapWindow.map.move(with: userCameraPosition, animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1), cameraCallback: nil)
        }
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
}

extension LocationViewController: YMKUserLocationObjectListener, YMKMapInputListener {
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                self.onTapSearchResponse(response)
            } else {
                self.onSearchError(error!)
            }
        }
        
        tapSearchSession = searchManager?.submit(with: point, zoom: 15, searchOptions: YMKSearchOptions(searchTypes: .geo, resultPageSize: nil, snippets: YMKSearchSnippet(), experimentalSnippets: [], userPosition: nil, origin: nil, directPageId: nil, appleCtx: nil, geometry: true, advertPageId: nil, suggestWords: true, disableSpellingCorrection: false), responseHandler: responseHandler)
    }
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
    }
    
    func onObjectAdded(with view: YMKUserLocationView) {
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
    }
    
    func configMap(){
        if let style = readRawJson(resourceName: "map_customization") {
            mapView.mapWindow.map.setMapStyleWithStyle(style)
        }
        
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = false
        
        mapView.mapWindow.map.addInputListener(with: self)
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.isTiltGesturesEnabled = false
        
        mapView.mapWindow.map.move(with: YMKCameraPosition(
            target: YMKPoint(latitude: 43.238293, longitude: 76.945465),
            zoom: 11,
            azimuth: 0,
            tilt: 0))
    }
    
    func onSearchResponse(_ response: YMKSearchResponse) {
        searchItems = response.collection.children
    }
    
    func onTapSearchResponse(_ response: YMKSearchResponse) {
        if let lat = response.collection.children.first?.obj?.geometry.first?.point?.latitude, let lon = response.collection.children.first?.obj?.geometry.first?.point?.longitude, response.collection.children.first?.isAddress() ?? false {
            
            let point = YMKPoint(latitude: lat, longitude: lon)
            
            addPin(point: point)
            
            locationView.addressField.textField.text = response.collection.children.first?.obj?.name
            let addressPoint = Point(latitude: response.collection.children.first?.obj?.geometry.first?.point?.latitude, longitude: response.collection.children.first?.obj?.geometry.first?.point?.longitude)
            if let (city, street, house) = response.collection.children.first?.getAddress() {
                address = Address(point: addressPoint, city: city, street: street, house: house, flat: nil)
            }
            locationView.showError(show: false)
        }
    }
    
    func onSearchError(_ error: Error) {
        let searchError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError
        var errorMessage = "Неизвестная ошибка"
        if searchError.isKind(of: YRTNetworkError.self) {
            errorMessage = "Ошибка соеденения"
        } else if searchError.isKind(of: YRTRemoteError.self) {
            errorMessage = "Ошибка сервера"
        }
        
        let alert = UIAlertController(title: "Ошибка", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func addPin(point: YMKPoint) {
        if let placemark = placemark {
            mapView.mapWindow.map.mapObjects.remove(with: placemark)
        }
        
        if let viewProvider = YRTViewProvider(uiView: locationView.pinView) {
            placemark = mapView.mapWindow.map.mapObjects.addPlacemark(
                with: point,
                view: viewProvider,
                style: YMKIconStyle(
                    anchor: CGPoint(x: 0.5, y: 0.8) as NSValue,
                    rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                    zIndex: 1,
                    flat: true,
                    visible: true,
                    scale: 1,
                    tappableArea: nil))
        }
    }
}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchItems[indexPath.row].obj?.name
        cell.textLabel?.font = .systemFont(ofSize: StaticSize.s14, weight: .regular)
        cell.textLabel?.textColor = .customTextBlack
        cell.separatorInset = .zero
        cell.layoutMargins = UIEdgeInsets(top: 0, left: StaticSize.s40/2.5, bottom: 0, right: 0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationView.addressField.textField.text = searchItems[indexPath.row].obj?.name
        onFieldDidChange(locationView.addressField.textField)
        if let point = searchItems[indexPath.row].obj?.geometry.first?.point{
            addPin(point: point)
        }
        if searchItems[indexPath.row].isAddress() {
            onReturn()
            let addressPoint = Point(latitude: searchItems[indexPath.row].obj?.geometry.first?.point?.latitude, longitude: searchItems[indexPath.row].obj?.geometry.first?.point?.longitude)
            let (city, street, house) = searchItems[indexPath.row].getAddress()
            address = Address(point: addressPoint, city: city, street: street, house: house, flat: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .customLightGray
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .clear
    }
}

extension LocationViewController {
    private func readRawJson(resourceName: String) -> String? {
        if let filepath: String = Bundle.main.path(forResource: resourceName, ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                NSLog("JsonError: Contents could not be loaded from json file: " + resourceName)
                return nil
            }
        } else {
            NSLog("JsonError: json file not found: " + resourceName)
            return nil
        }
    }
}
