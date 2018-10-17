//
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
    @IBOutlet weak var windTextFIeld: UITextField!
    @IBOutlet weak var precipitationTextField: UITextField!
    @IBOutlet weak var pressureTextField: UITextField!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    let url: String = "https://www.metaweather.com/api/location/2487956/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }
    
    
    func loadJSON(){
        let urlObject: URL = URL.init(string: url)!
        
        
        
    }
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
    }
    
    
}

