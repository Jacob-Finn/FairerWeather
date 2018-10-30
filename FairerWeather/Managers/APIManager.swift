//
//  APIManager.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/29/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIManager {
    
    static let sharedInstance = APIManager()
    
    // MARK:- Variables
    
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    private let darkSkyBaseUrl = "https://api.darksky.net/forecast/"
    private let apiKeys = APIKeys()
    
    // MARK:- Types
    
    private enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    //MARK:- Methods
    
    private init () { }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> ()) {
        let url = darkSkyBaseUrl + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        let request = Alamofire.request(url)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                }else {
                    onCompletion(nil, APIErrors.invalidData)
                }
                
            case .failure(_):
                onCompletion(nil, APIErrors.noData)
            }
        }
    }
    
    //  Attempt to geocode the address that's passed in afterward, call the onCompletion closure by passing in geocoding data or an error.
    func geocode(address: String, onCompletion: @escaping (GeocodeData?, Error?) -> ()) {
        let googleRequestURL = googleBaseURL + address + "&key=" + apiKeys.googleKey
        let request = Alamofire.request(googleRequestURL)
        request.responseJSON { (response) in
            switch response.result
            {
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let geocodingData = GeocodeData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                print(error.localizedDescription)
                onCompletion(nil, APIErrors.noData)
            }
        }
        
    }
    
    
}
