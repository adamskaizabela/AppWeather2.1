
//  ViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by Student on 10.10.2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTypeTextField: UITextField!
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var precipitationTextField: UITextField!
    @IBOutlet weak var pressureTextField: UITextField!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var windDirectionTextField: UITextField!
    @IBOutlet weak var windSpeedTextField: UITextField!
    
    
    var weatherData: [WeatherData] = []
    var dayNumber = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
    
    
    func fetchWeather() {
        DownloadService.fetchWeather { (response) in
            guard let responseData = response else {return}
            self.weatherData = responseData
            
            DispatchQueue.main.async {
                if(!self.weatherData.isEmpty){
                    self.showWeather(weather: self.weatherData[self.dayNumber])
                }
            }
        }
    }
    
    
    func showWeather(weather: WeatherData) {
        dateLabel.text = "London \(weather.date)"
        weatherTypeTextField.text = weather.type
        minTempTextField.text = String(format: "%.3f", weather.tempMin)
        maxTempTextField.text = String(format: "%.3f", weather.tempMax)
        windDirectionTextField.text = weather.windDirection
        windSpeedTextField.text = String(format: "%.3f", weather.windSpeed)
        pressureTextField.text = String(format: "%.3f", weather.airPressure)
        
        if(weather.type=="Heavy Cloud" || weather.type == "Light Cloud" || weather.type == "Clear"){
            precipitationTextField.text = "No"
        }else{
            precipitationTextField.text = "Yes"
        }
        
        fetchImage()
    }
    
    
    
    func fetchImage() {
        let abbr = weatherData[dayNumber].abbr
        let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(abbr).png")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if let imageData = data {
                    self.weatherImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        if(dayNumber > 0){
            dayNumber = dayNumber - 1
        }
        
        showWeather(weather: weatherData[dayNumber])
        if(dayNumber == 0){
            previousButton.isEnabled = false
        }
        
        nextButton.isEnabled = true
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if(dayNumber < 4){
            dayNumber = dayNumber + 1
        }
        showWeather(weather: weatherData[dayNumber])
        
        if(dayNumber == 4){
            nextButton.isEnabled = false
        }
        
        previousButton.isEnabled = true
    }
    
    
}
