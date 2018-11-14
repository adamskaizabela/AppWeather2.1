//
//  DownloadService.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 21/10/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//
import Foundation

class DownloadService {
    
    class func fetchWeather(woeid: Int, handler: @escaping (_ response: WeatherData?) -> Void) {
        let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)/")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>
                    
                    guard let responseData = jsonSerialized else {return}
                    var days : [DayDetails] = []
                    
                    let title = responseData["title"] as! String
                    let woeid = responseData["woeid"] as! Int
                    let latt_long = responseData["latt_long"] as! String
                    
                    if let weatherData = responseData["consolidated_weather"] as? [Dictionary<String, Any>] {
                        
                        for weather in weatherData {
                            
                            let date = weather["applicable_date"] as! String
                            let type = weather["weather_state_name"] as! String
                            let tempMax = weather["max_temp"] as! Double
                            let tempMin = weather["min_temp"] as! Double
                            let theTemp = weather["the_temp"] as! Double
                            let windDirection = weather["wind_direction_compass"] as! String
                            let windSpeed = weather["wind_speed"] as! Double
                            let airPressure = weather["air_pressure"] as! Double
                            let abbr = weather["weather_state_abbr"] as! String
                            
                            days.append(DayDetails(date: date, type: type, tempMax: tempMax, tempMin: tempMin, theTemp: theTemp, windDirection: windDirection, windSpeed: windSpeed, airPressure: airPressure, abbr: abbr))
                        }
                    }
                    
                    handler(WeatherData(title: title, woeid: woeid, latt_long: latt_long, days: days))
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    class func search(phrase: String, handler: @escaping (_ response: [WeatherData]?) -> Void) {
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=\(phrase)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>]
                    
                    guard let responseData = jsonSerialized else {return}
                    
                    var searchResult: [WeatherData] = []
                    
                    for dict in responseData {
                        let title = dict["title"] as! String
                        let woeid = dict["woeid"] as! Int
                        let latt_long = dict["latt_long"] as! String
                        
                        searchResult.append(WeatherData(title: title, woeid: woeid, latt_long: latt_long, days: [DayDetails]()))
                    }
                    
                    handler(searchResult)
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    class func searchWithLocation(latitude: Double, longitude: Double, handler: @escaping (_ response: [WeatherData]?) -> Void) {
        let url = URL(string: "https://www.metaweather.com/api/location/search/?lattlong=\(latitude),\(longitude)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>]
                    
                    guard let responseData = jsonSerialized else {return}
                    
                    var searchResult: [WeatherData] = []
                    
                    for dict in responseData {
                        let title = dict["title"] as! String
                        let woeid = dict["woeid"] as! Int
                        let latt_long = dict["latt_long"] as! String
                        
                        searchResult.append(WeatherData(title: title, woeid: woeid, latt_long: latt_long, days: [DayDetails]()))
                    }
                    
                    handler(searchResult)
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
}
