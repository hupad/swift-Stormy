//
//  ForecastService.swift
//  Stormy
//
//  Created by Harish Upadhyayula on 1/6/16.
//  Copyright © 2016 Harish Upadhyayula. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let apiKey: String
    let forecastBaseUrl: NSURL?
    
    init(apiKey: String){
        self.apiKey = apiKey
        self.forecastBaseUrl = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")
    }
    
    func getForcastData(lat: Double, long: Double, completion: (CurrentWeather? -> Void)){
        if let forecastUrl = NSURL(string: "\(lat),\(long)", relativeToURL: self.forecastBaseUrl){
            
            let networkOperation = NetworkOperation(url: forecastUrl)
            networkOperation.downloadJsonFromUrl{
                (let jsonDoctionaryCompletion) in
                
               let currentWeather = self.currentWeatherFromDictionary(jsonDoctionaryCompletion)
                completion(currentWeather)
            }
        }else{
            print("Could not construct a valid URL")
        }
    }
    
    func currentWeatherFromDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeather = jsonDictionary?["currently"] as? [String: AnyObject]{
            return CurrentWeather.init(weatherDictionary: currentWeather)
        }else{
            print("Json dictionary returned nil")
            return nil
        }
    }
}