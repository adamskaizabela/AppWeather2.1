//
//  WeatherData.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 21/10/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//
import Foundation


class WeatherData: NSObject {
    var title: String = ""
    var woeid: Int = 0
    var days: [DayDetails] = []
    
    init(title: String, woeid: Int, days: [DayDetails]) {
        self.title = title
        self.woeid = woeid
        self.days = days
    }
    
}

class DayDetails: NSObject {
    var date: String = ""
    var type: String = ""
    var tempMax: Double = 0.0
    var tempMin: Double = 0.0
    var theTemp: Double = 0.0
    var windDirection: String = ""
    var windSpeed: Double = 0.0
    var airPressure: Double = 0.0
    //var precipitation: String = "" //opady
    var abbr: String = ""
    
    init(date: String, type: String, tempMax: Double, tempMin: Double, theTemp: Double, windDirection: String,
         windSpeed: Double, airPressure: Double, abbr: String){
        self.date = date
        self.type = type
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.theTemp = theTemp
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.airPressure = airPressure
        //self.precipitation = precipitation
        self.abbr = abbr
    }
}
