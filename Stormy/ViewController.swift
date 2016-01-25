//
//  ViewController.swift
//  Stormy
//
//  Created by Harish Upadhyayula on 1/6/16.
//  Copyright © 2016 Harish Upadhyayula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    private let forcastApiKey = "014f2ac44e6547d49b3639839eed7da5"
    let coordinates: (lat: Double, long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let forecastService = ForecastService.init(apiKey: forcastApiKey)
        
        forecastService.getForcastData(coordinates.lat, long: coordinates.long) {
            (let currentWeatherData) in
            
            if let currently = currentWeatherData {
                dispatch_async(dispatch_get_main_queue()){
                    
                    if let temperature = currently.temperature {
                        self.currentTemperatureLabel.text = "\(temperature)º"
                    }
                    
                    if let humidity = currently.humidity {
                        self.humidity.text = "\(humidity)"
                    }
                    
                    if let percipitation = currently.percipProbability{
                        self.precipitationLabel.text = "\(percipitation)"
                    }
                }
            }
            
        }
    }
}

