//
//  WeatherDisplayViewController.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/24/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class WeatherDisplayViewController: UIViewController {
    
    
    // MARK:- Storyboard
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var coldTemperatureLabel: UILabel!
    
    //MARK:- Variables
    var geocodeData: GeocodeData?
    var weatherData: WeatherData?
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIFromData(weatherData: weatherData)
    }
    
    
    
    func setupDefaultUI() {
        locationLabel.text = ""
        conditionLabel.text = "⚙️"
        currentTemperatureLabel.text = "Enter a location"
        highTemperatureLabel.text = "-"
        coldTemperatureLabel.text = "-"
    }
    
    func setupUIFromData(weatherData: WeatherData?) {
        if let weatherData = weatherData {
            conditionLabel.text = weatherData.condition.icon
            currentTemperatureLabel.text = String(Int(weatherData.currentTemperature)) + "º"
            highTemperatureLabel.text = String(Int(weatherData.hotTemperature)) + "º"
            coldTemperatureLabel.text = String(Int(weatherData.coldTemperature)) + "º"
            guard let geocodeData = geocodeData else {
                return
            }
            locationLabel.text = geocodeData.formattedAddress
        } else {
            // we have no data to use
            setupDefaultUI()
        }
    }
    
    
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) { }
    
}


