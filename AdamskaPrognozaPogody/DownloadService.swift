
//
//  DownloadService.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 21/10/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import Foundation

class DownloadService {
    
    class func fetchWeather(handler: @escaping (_ response: [WeatherData]?) -> Void) {
        let url = URL(string: "https://www.metaweather.com/api/location/44418/")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>
                    
                    guard let responseData = jsonSerialized else {return}
                    var response : [WeatherData] = []
                    
                    //let title = responseData["title"] as! String
                    
                    if let weatherData = responseData["consolidated_weather"] as? [Dictionary<String, Any>] {
                        
                        for weather in weatherData {
                            
                            let date = weather["applicable_date"] as! String
                            let type = weather["weather_state_name"] as! String
                            let tempMax = weather["max_temp"] as! Double
                            let tempMin = weather["min_temp"] as! Double
                            let windDirection = weather["wind_direction_compass"] as! String
                            let windSpeed = weather["wind_speed"] as! Double
                            let airPressure = weather["air_pressure"] as! Double
                            let abbr = weather["weather_state_abbr"] as! String
                            
                            response.append(WeatherData(date: date, type: type, tempMax: tempMax, tempMin: tempMin, windDirection: windDirection, windSpeed: windSpeed, airPressure: airPressure, abbr: abbr))
                        }
                    }
                    
                    handler(response)
                    
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
