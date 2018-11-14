//
//  SearchViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 08/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchDelegate: class {
    func didSelectCity(woeid: Int)
}

class SearchViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [WeatherData] = []
    
    weak var delegate: SearchDelegate?
    
    let locationManager: CLLocationManager = CLLocationManager()
    var currentLocation : CLLocation?
    let locationDescription = "Aktualnie znajdujesz się w:"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func searchQuery() {
        guard let phrase = searchTextField.text else {return}
        
        if(phrase.contains(locationDescription)) {
            let alert = UIAlertController(title: "Alert", message: "Niepoprawna fraza wyszukiwania.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(!phrase.isEmpty) {
            searchResults.removeAll()
            reloadResults()
            
            DownloadService.search(phrase: phrase) { (responseData) in
                guard let response = responseData else {return}
                for data in response {
                    self.searchResults.append(data)
                }
                
                self.reloadResults()
            }
        }
        
        searchTextField.resignFirstResponder()
    }
    
    func searchLocationQuery() {
        guard let location = currentLocation else {return}
        updateCityInfo(location: location)
        
        locationManager.stopUpdatingLocation()
        searchResults.removeAll()
        
        DownloadService.searchWithLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (responseData) in
            guard let response = responseData else {return}
            for data in response {
                self.searchResults.append(data)
            }
            
            self.reloadResults()
        }
        
        searchTextField.resignFirstResponder()
    }
    
    func updateCityInfo(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            }else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                self.searchTextField.text = "\(self.locationDescription) \(city), \(country)"
            }
        })
        
    }
    
    func reloadResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        searchLocationQuery()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchQuery()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //CoreLocation delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchResults[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let woeid = searchResults[indexPath.row].woeid
        delegate?.didSelectCity(woeid: woeid)
        navigationController?.popViewController(animated: true)
    }
    
    
}
