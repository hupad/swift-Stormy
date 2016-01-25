//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Harish Upadhyayula on 1/6/16.
//  Copyright © 2016 Harish Upadhyayula. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    enum Icon: String {
        case ClearDay = "clear-day"
        case ClearNight = "clear-night"
        case Rain = "rain"
        case Snow = "snow"
        case Sleet = "sleet"
        case Wind = "wind"
        case Fog = "fog"
        case Cloudy = "cloudy"
        case PartlyCloudyDay = "partly-cloudy-day"
        case PartlyCloudyNight = "partly-cloudy-night"
    }
    
    let temperature: Int?
    let humidity: Int?
    let percipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    init(weatherDictionary: [String: AnyObject]){
        
        temperature = weatherDictionary["temperature"] as? Int
        
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        }else{
            humidity = nil
        }
        
        if let percipProbabilityFloat = weatherDictionary["percipProbability"] as? Double {
            percipProbability = Int(percipProbabilityFloat * 100)
        }else{
            percipProbability = nil
        }
        
        if let iconString = weatherDictionary["icon"] as? String {
            //icon = weatherImageForDictionary(iconString)
        }
        
        summary = weatherDictionary["summary"] as? String
    }
    
    func weatherImageForDictionary(iconString: String) -> UIImage? {
        
        var imageName: String = "default.png"
        
        if let iconValue = Icon(rawValue: iconString){
            switch iconValue {
            case Icon.ClearDay:
                imageName = "clear-day.png"
            case Icon.ClearNight:
                imageName = "clear-night.png"
            case Icon.Rain:
                imageName = "rain.png"
            case Icon.Snow:
                imageName = "snow.png"
            case Icon.Sleet:
                imageName = "sleet.png"
            case Icon.Wind:
                imageName = "wind.png"
            case Icon.Fog:
                imageName = "fog.png"
            case Icon.Cloudy:
                imageName = "cloudy.png"
            case Icon.PartlyCloudyDay:
                imageName = "partly-cloudy-day"
            case Icon.PartlyCloudyNight:
                imageName = "partly-cloudy-night"
            }
        }

        return UIImage(named: imageName)
    }
}