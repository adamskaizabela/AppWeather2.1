//
//  SearchViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 08/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func didSelectCity(woeid: Int)
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: [WeatherData] = []
    
    weak var delegate: SearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func searchQuery() {
        guard let phrase = searchTextField.text else {return}
        
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
    
    func reloadResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchQuery()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
