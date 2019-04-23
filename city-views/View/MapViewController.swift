//
//  ViewController.swift
//  city-views
//
//  Created by Michael Nienaber on 4/15/19.
//  Copyright © 2019 Michael Nienaber. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, UIApplicationDelegate, CLLocationManagerDelegate {

  var appDelegate: AppDelegate!
  let locationManager = CLLocationManager()
  let regionRadius: CLLocationDistance = 500
  var annotations: [MKAnnotation] = []

  let collectionView: UICollectionView = {
    let frame = CGRect(x: 0, y: 600, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 600)
    let col = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    col.layer.borderWidth = 1.0
    col.backgroundColor = UIColor.white
    col.isOpaque = false
    return col
  }()

  let switchView = UISwitch()

  @objc func switched(s: UISwitch){
    let origin: CGFloat = s.isOn ? view.frame.height : 30
    UIView.animate(withDuration: 0.35) {
      self.collectionView.frame.origin.y = origin
    }
  }

  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()

    mapView.delegate = self
    mapView.showsUserLocation = true

    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    getMapLocations()
//    callPanel()
  }

  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

    print("auth call")

    if status == .authorizedWhenInUse {
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    let location = locations.last
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))

    mapView.setRegion(region, animated: true)
    locationManager.stopUpdatingLocation()
  }

  private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

    print("error:: \(error)")
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

    let reuseId = "pin"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      pinView!.pinTintColor = .yellow
      pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    else {
      pinView!.annotation = annotation
    }
    print(pinView!)
    return pinView
  }

  func fun() -> Bool {
    return true
  }

  func getMapLocations() {

    let locations = ListingLocations.init()
    let lat = locations.chelsea_hotel_lat
    let long = locations.chelsea_hotel_long
    let listingName = locations.listingName

    let annotation = MKPointAnnotation()
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

    annotation.coordinate = coordinate
    annotation.title = listingName
    self.annotations.append(annotation)
    self.mapView.addAnnotations(self.annotations)
  }

  func callPanel() {
    
    switchView.frame = CGRect(x: 0, y: 20, width: 40, height: 20)
    switchView.addTarget(self, action: #selector(switched), for: .valueChanged)

    view.addSubview(switchView)
    view.addSubview(collectionView)
    print("change")
  }
  @IBAction func callPanelButton(_ sender: Any) {

    callPanel()
  }
}

