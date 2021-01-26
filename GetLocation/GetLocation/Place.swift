//
//  Place.swift
//  GetLocation
//
//  Created by Henryk Telega on 08.05.2015.
//  Copyright (c) 2015 IIiMKUJ. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Contacts


class Place: NSObject, MKAnnotation { // implementuje protokół MKAnnotation
    
    var locationName: String
    var category: String
    
    init(title: String, category:String,locationName:String, coordinate:CLLocationCoordinate2D){
        self.title = title
        self.category = category
        self.locationName=locationName
        self.coordinate = coordinate
        super.init()
    }
    
    // MARK: Protokół MKAnnotation
    var title: String?
    var subtitle:String?{
        return locationName
    }
    let coordinate: CLLocationCoordinate2D
    
    func pinColor() -> UIColor  {
        
        switch category {
        case "A", "B", "C":
            return .purple
        case "D", "E":
            return .red
        default:
            return .green
        }
    }
 
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [CNPostalAddressStreetKey: subtitle as AnyObject]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}
