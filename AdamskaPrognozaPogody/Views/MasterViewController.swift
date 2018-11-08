//
//  MasterViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 02/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//
import UIKit

class MasterViewController: UITableViewController, SearchDelegate {
    
    var locationIDs = [44418, 13963, 14979]
    var weatherData = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Izabela Adamska"
        fetchWeatherOnStart()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func reloadResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchWeatherOnStart() {
        for location in locationIDs {
            DownloadService.fetchWeather(woeid: location) { (response) in
                guard let data = response else {return}
                self.weatherData.append(data)
                self.reloadResults()
            }
        }
    }
    
    //MARK: - SearchDelegate method
    func didSelectCity(woeid: Int) {
        DownloadService.fetchWeather(woeid: woeid) { (response) in
            guard let data = response else {return}
            self.weatherData.append(data)
            self.reloadResults()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        cell.titleLabel.text = weatherData[indexPath.row].title
        if let currentDay = weatherData[indexPath.row].days.first {
            let temp = String(format: "%.01f", currentDay.theTemp)
            cell.temperatureLabel.text = "\(temp) \u{00B0}C"
            
            let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(currentDay.abbr).png")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if let imageData = data {
                        cell.weatherImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailViewController", sender: nil)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailViewController") {
            let vc = segue.destination as! DetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let data = weatherData[indexPath.row]
            
            vc.weatherData = data
        }else {
            let vc = segue.destination as! SearchViewController
            vc.delegate = self
        }
    }
    
}
