//
//  ViewController.swift
//  city-views
//
//  Created by Michael Nienaber on 4/15/19.
//  Copyright © 2019 Michael Nienaber. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UIApplicationDelegate, CLLocationManagerDelegate {

  var appDelegate: AppDelegate!
  let locationManager = CLLocationManager()
  let regionRadius: CLLocationDistance = 2000
  var annotations: [MKAnnotation] = []


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

