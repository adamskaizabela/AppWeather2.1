//
//  MapViewController.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 14/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//

import UIKit
import MapKit

//class CustomPin: NSObject, MKAnnotation {
//    var coordinate: CLLocationCoordinate2D
//    var title: String?
//    var subtitle: String?
//
//    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.subtitle = subtitle
//        self.coordinate = coordinate
//    }
//}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location: CLLocationCoordinate2D?
    var locationTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMarker()
    }
    
    func addMarker() {
        guard let location = location else {return}
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = locationTitle
        mapView.addAnnotation(annotation)
    }
    
}
