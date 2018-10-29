//
//  GeocodeData.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/26/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeocodeData {
    
    //MARK:- Types
    
    enum GeocodingDataKeys : String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    //MARK:-Properties
    var longitude: Double
    var latitude: Double
    var formattedAddress: String
    
    
    //MARK:-Methods
    
    init(longitude: Double, latitude: Double, formattedAddress: String) {
        self.longitude = longitude
        self.latitude = latitude
        self.formattedAddress = formattedAddress
    }
    
    convenience init?(json: JSON) {
        print("Getting results")
        guard let results = json[GeocodingDataKeys.results.rawValue].array else {
            print("results are nil")
            return nil
        }
        print("found results")
        if results.count == 0 {
            print("results is empty")
            return nil
        }
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
            print("address is nil")
           return nil
        }
        print("found address")
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            print("couldn't find longitude")
            return nil
        }
        print("found longitude")
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            print("couldn't find latitude")
            return nil
        }
        
        self.init(longitude: longitude, latitude: latitude, formattedAddress: formattedAddress)
    }
    
    
    
    
    
    
}
