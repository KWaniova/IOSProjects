//
//  ViewController.swift
//  GetLocation
//
//  Created by Henryk Telega on 08.05.2015.
//  Copyright (c) 2015 IIiMKUJ. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var locationNameTextField: UITextField!
    
    
    let locationManager = CLLocationManager()
    var locationError : Bool = false
    var locationFound : Bool = false
    var locationStatus : NSString = "Not Started"
    var location: CLLocation?
    var coordinates: CLLocationCoordinate2D?
    
    let regionRadius: CLLocationDistance = 1000
    
    var places = [Place]()
    var place: Place?
    
    var titleString: String?
    var categoryStrig: String?
    var locationNameString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleTextField.delegate = self
        categoryTextField.delegate = self
        locationNameTextField.delegate = self
        mapView.delegate = self
        longitudeLabel.text = "Unknown"
        latitudeLabel.text = "Unknown"
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        coordinates = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        place = Place(title: "", category: "", locationName: "", coordinate: coordinates!)
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.mapTapped(_:)))
        self.mapView.addGestureRecognizer(longGestureRecognizer)
        
        
    }

    @objc func mapTapped(_ sender:UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.ended {
            
            let point: CGPoint = sender.location(in: self.mapView);
            
            let locCoord : CLLocationCoordinate2D = self.mapView.convert(point, toCoordinateFrom:self.mapView)
            
            coordinates = locCoord
            
            longitudeLabel.text = String(format:"%f",coordinates!.longitude)
            latitudeLabel.text = String(format:"%f",coordinates!.latitude)

            titleString = titleTextField.text
            categoryStrig = categoryTextField.text
            locationNameString = locationNameTextField.text
            place = Place(title: titleString!, category: categoryStrig!, locationName: locationNameString!, coordinate: coordinates!)
            
            mapView.addAnnotation(place!)
            
        }
    }
    // MARK: MapKit
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
            latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - Location manager - autoryzacja

    @IBAction func getLocationPressed(_ sender: UIButton) {

        self.checkLocationAuthorizationStatus()
        locationManager.startUpdatingLocation()
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

    @IBAction func savePressed(_ sender: UIButton) {
        titleString = titleTextField.text
        categoryStrig = categoryTextField.text
        locationNameString = locationNameTextField.text
        place = Place(title: titleString!, category: categoryStrig!, locationName: locationNameString!, coordinate: coordinates!)
        
        mapView.addAnnotation(place!)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if (locationError == false) {
                locationError = true
                print(error, terminator: "")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        location = locationManager.location
        coordinates = location!.coordinate
        longitudeLabel.text = String(format:"%f",coordinates!.longitude)
        latitudeLabel.text = String(format:"%f",coordinates!.latitude)
        
        self.centerMapOnLocation(location!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            titleString = textField.text
        }
        if textField == categoryTextField {
            categoryStrig = textField.text
        }
        if textField == locationNameTextField {
            locationNameString = textField.text
        }
        
    }
    
    // MARK: Ukrywanie klawiatury przez kliknięcie w tło
    
    @IBAction func backgroundPressed(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "pin"
            var annotationPinView: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    annotationPinView = dequeuedView
            } else {
                annotationPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            annotationPinView.canShowCallout = true
            annotationPinView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationPinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            
            annotationPinView.pinTintColor = annotation.pinColor()
            
            return annotationPinView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            let location = view.annotation as! Place
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

