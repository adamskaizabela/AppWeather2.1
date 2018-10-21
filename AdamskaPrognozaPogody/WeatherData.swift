//
//  WeatherData.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 21/10/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import Foundation


class WeatherData: NSObject {
    var date: String = ""
    var type: String = ""
    var tempMax: Double = 0.0
    var tempMin: Double = 0.0
    var windDirection: String = ""
    var windSpeed: Double = 0.0
    var airPressure: Double = 0.0

    
    init(date: String, type: String, tempMax: Double, tempMin: Double, windDirection: String,
         windSpeed: Double, airPressure: Double){
        self.date = date
        self.type = type
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.airPressure = airPressure
    }
}
