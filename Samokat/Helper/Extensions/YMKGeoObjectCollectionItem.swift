//
//  YMKGeoObjectCollectionItem.swift
//  Samokat
//
//  Created by Daniyar on 7/22/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import YandexMapKit
import YandexMapKitSearch

extension YMKGeoObjectCollectionItem {
    func isAddress() -> Bool {
        if let metadata = self.obj?.metadataContainer.getItemOf(YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata, metadata.address.components.contains(where: {$0.kinds.contains(8)}) {
            return true
        }
        return false
    }
    
    func getAddress() -> (String?, String?, String?) {
        if self.isAddress(), let metadata = self.obj?.metadataContainer.getItemOf(YMKSearchToponymObjectMetadata.self) as? YMKSearchToponymObjectMetadata, metadata.address.components.contains(where: {$0.kinds.contains(8)}) {
            let city = metadata.address.components.first(where: {
                $0.kinds.contains(5)
                })?.name
            let street = metadata.address.components.first(where: {
                $0.kinds.contains(7)
                })?.name
            let house = metadata.address.components.first(where: {
                $0.kinds.contains(8)
                })?.name
            return (city, street, house)
        }
        return (nil, nil, nil)
    }
}
