
//  DetailViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 10.10.2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    //MARK: Properties
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
    
    var weatherData: WeatherData?
    var dayNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
    }
    
    func loadWeather() {
        guard let data = weatherData else {return}
        self.title = data.title
        
        showWeather(day: data.days[dayNumber])
    }
    
    
    func showWeather(day: DayDetails) {
        dateLabel.text = "\(day.date)"
        weatherTypeTextField.text = day.type
        minTempTextField.text = String(format: "%.3f", day.tempMin)
        maxTempTextField.text = String(format: "%.3f", day.tempMax)
        windDirectionTextField.text = day.windDirection
        windSpeedTextField.text = String(format: "%.3f", day.windSpeed)
        pressureTextField.text = String(format: "%.3f", day.airPressure)
        
        if(day.type=="Heavy Cloud" || day.type == "Light Cloud" || day.type == "Clear"){
            precipitationTextField.text = "No"
        }else{
            precipitationTextField.text = "Yes"
        }
        
        fetchImage()
    }
    
    
    func fetchImage() {
        guard let data = weatherData else {return}
        let abbr = data.days[dayNumber].abbr
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
    
    
    @IBAction func mapButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "MapViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MapViewController") {
            let vc = segue.destination as! MapViewController
            guard let data = weatherData else {return}
            let latt_long = data.latt_long
            
            var coordinatesArray = latt_long.components(separatedBy: ",").map { (value) -> Double? in
                return Double(value)
            }
            
            if let latt = coordinatesArray[0], let long = coordinatesArray[1] {
                vc.location = CLLocationCoordinate2D(latitude: latt, longitude: long)
                vc.locationTitle = data.title
            }
        }
    }
    
    
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        guard let data = weatherData else {return}
        
        if(dayNumber > 0){
            dayNumber = dayNumber - 1
        }
        
        showWeather(day: data.days[dayNumber])
        if(dayNumber == 0){
            previousButton.isEnabled = false
        }
        
        nextButton.isEnabled = true
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let data = weatherData else {return}
        
        if(dayNumber < 4){
            dayNumber = dayNumber + 1
        }
        showWeather(day: data.days[dayNumber])
        
        if(dayNumber == 4){
            nextButton.isEnabled = false
        }
        
        previousButton.isEnabled = true
    }
    
    
}
