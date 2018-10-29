//
//  LocationSelectorViewController.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/26/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    var geocodingData: GeocodeData?
    var weatherData: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSearchBar.delegate = self
    }
    
    
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveData(address: searchAddress)
        
    }
    
    
    
    
    
    func retrieveData(address: String) {
        APIManager.sharedInstance.geocode(address: address) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                self.handleError()
                return
            } else {
                guard let data = data else {
                    self.handleError()
                    return
                }
                self.geocodingData = data
                self.retrieveWeatherData(latitude: data.latitude, longitude: data.longitude)
            }
        }
    }
    
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        var retrievableData: WeatherData? = nil
        APIManager.sharedInstance.getWeather(latitude: latitude, longitude: longitude) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                self.handleError()
                return
            } else {
                guard let data = data else {
                    self.handleError()
                    return
                }
                self.weatherData = data
                self.performSegue(withIdentifier: "unwindToMain", sender: self)
            }
        }
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is WeatherDisplayViewController
        {
            guard let weatherDisplayViewController = segue.destination as? WeatherDisplayViewController else {
                print("error")
                return
            }
                weatherDisplayViewController.weatherData = weatherData
                weatherDisplayViewController.geocodeData = geocodingData
        }
    }
    
    
    
    
}
