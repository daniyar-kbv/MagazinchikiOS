//
//  YMKMap.swift
//  Samokat
//
//  Created by Daniyar on 7/22/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import YandexMapKit

extension YMKMap {
    func setCameraToPoints(allPoints: [YMKPoint]){
        if var greatestLat = allPoints.first?.latitude, var smallestLat = allPoints.first?.latitude, var greatestLon = allPoints.first?.longitude, var smallestLon = allPoints.first?.longitude {
            for point in allPoints{
                if point.latitude > greatestLat {
                    greatestLat = point.latitude
                } else if point.longitude > greatestLon {
                    greatestLon = point.longitude
                } else if point.latitude < smallestLat {
                    smallestLat = point.latitude
                } else if point.longitude < smallestLon {
                    smallestLon = point.longitude
                }
            }
            let southWest = YMKPoint(latitude: smallestLat, longitude: smallestLon)
            let northEast = YMKPoint(latitude: greatestLat, longitude: greatestLon)
            let boundingBox = YMKBoundingBox(southWest: southWest, northEast: northEast)
            var cameraPosition = self.cameraPosition(with: boundingBox)
            print(cameraPosition.target.latitude)
            print(cameraPosition.target.longitude)
            print(cameraPosition.zoom)
            cameraPosition = YMKCameraPosition(target: cameraPosition.target, zoom: cameraPosition.zoom - 0.8, azimuth: cameraPosition.azimuth, tilt: cameraPosition.tilt)
            self.move(with: cameraPosition)
        }
    }
    
    func drawDistricts(districts: [District], removeObjects: [YMKPolygonMapObject]) -> [YMKPolygonMapObject] {
        var districtMapObjects: [YMKPolygonMapObject] = []
        for obj in removeObjects {
            self.mapObjects.remove(with: obj)
        }
        for district in districts{
            if let districtPoints = district.points {
                var points: [YMKPoint] = []
                for point in districtPoints{
                    if let lat = point.latitude, let lon = point.longitude{
                        let p = YMKPoint(latitude: lat, longitude: lon)
                        points.append(p)
                    }
                }
                let polygon = YMKPolygon(outerRing: YMKLinearRing(points: points), innerRings: [])
                let polygonMapObject = self.mapObjects.addPolygon(with: polygon)
                districtMapObjects.append(polygonMapObject)
                polygonMapObject.fillColor = UIColor(hex: "#F9E900").withAlphaComponent(0.10)
                polygonMapObject.strokeWidth = 0
            }
        }
        return districtMapObjects
    }
}
