//
//  BillVIewController.swift
//  Samokat
//
//  Created by Daniyar on 7/13/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import LinkPresentation

class BillViewController: UIViewController {
    lazy var billView = BillView()
    
    var order: Order? {
        didSet {
            billView.order = order
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = billView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configActions()
    }
    
    func configActions(){
        billView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        billView.shareButton.addTarget(self, action: #selector(shareBill), for: .touchUpInside)
    }
    
    @objc func backTapped(){
        removeTop()
    }
    
    @objc func shareBill(){
//        let image = billView.mainView.asImage()
//
//        // set up activity view controller
//        let imageToShare = [ image ]
//        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
////        // exclude some activity types from the list (optional)
////        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivityType.postToFacebook ]
//
//        // present the view controller
//        self.present(activityViewController, animated: true, completion: nil)
        
        let activityController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}

extension BillViewController: UIActivityItemSource {

    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return billView.mainView.asImage()
    }

    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return billView.mainView.asImage()
    }

    @available(iOS 13.0, *)
    public func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        if let resourcePath = Bundle.main.resourcePath {
            let imgName = "AppIcon"
            let path = resourcePath + "/" + imgName
            let urlOfImageToShare = URL(string: path)
            metadata.title = "Магазинчик"
            metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
            return metadata
        }
        return nil
    }
}
