//
//  WeatherData.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/26/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//
import SwiftyJSON
import Foundation

class WeatherData {
    
    //MARK:- Types
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌕"
            case .rain:
                return "🌧"
            case .snow:
                return "🌨"
            case .sleet:
                return "❄"
            case .wind:
                return "💨"
            case .fog:
                return "🌫"
            case .cloudy:
                return "☁️"
            case .partlyCloudyDay:
                return "⛅️"
            case .partlyCloudyNight:
                return "🌑"
            }
        }
    }
    
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    
    
    //MARK:- Properties
    var currentTemperature: Double
    var hotTemperature: Double
    var coldTemperature: Double
    let condition: Condition
    
    //MARK:- Methods
    init(currentTemperature: Double, hotTemperature: Double, coldTemperature: Double, condition: Condition) {
        self.currentTemperature = currentTemperature
        self.hotTemperature = hotTemperature
        self.coldTemperature = coldTemperature
        self.condition = condition
    }
    
    convenience init?(json: JSON) {
        
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else {
            return nil
        }
        guard let temperatureHigh = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
            return nil
        }
        guard let temperatureLow = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
            return nil
        }
        guard let conditionString = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else {
            return nil
        }
        guard let condition = Condition(rawValue: conditionString) else {
            return nil
        }
        self.init(currentTemperature: temperature, hotTemperature: temperatureHigh, coldTemperature: temperatureLow, condition: condition)
    }
}
