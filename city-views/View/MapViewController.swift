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

  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()

    mapView.delegate = self
    mapView.showsUserLocation = true

//    appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

  }

  private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

    if status == .authorizedWhenInUse {
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    let location = locations.last
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.65, longitudeDelta: 0.65))

    mapView.setRegion(region, animated: true)
    locationManager.stopUpdatingLocation()
  }

  private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

    print("error:: \(error)")
  }

}

