//
//  GeoLocationManager.swift
//  ShopTest
//
//  Created by david cortes on 15/01/21.
//

import Foundation
import CoreLocation

enum LocationStatus: String {
    case denied
    case notDetermined
    case authorized
    case disable
}

protocol LocationServiceDelegate: class {
    func setCountryLocation(country: String)
    func tracingLocationDidFailWithError(error: NSError)
    func statusAuthorizationLocation(status: LocationStatus)
}

class GeoLocationManager: NSObject {
    static let sharedInstance: GeoLocationManager = GeoLocationManager()
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    weak var delegate: LocationServiceDelegate?
    var locationLoaded = false
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
    }
    
    func requestPermission() {
        locationLoaded = false
        
        if locationManager?.checkLocationPermission() ?? false{
            startUpdatingLocation()
        } else {
            locationManager?.requestWhenInUseAuthorization()
        }
        
        locationManager?.delegate = self
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
}

extension CLLocationManager {
    func checkLocationPermission()->Bool {
        if self.authorizationStatus != .authorizedWhenInUse && self.authorizationStatus != .authorizedAlways {
            return true
        }
        return false
    }
}

extension GeoLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as NSError? {
            if error.code == 1 {
                delegate?.statusAuthorizationLocation(status: .denied)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = manager.location else { return }
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        if locValue.longitude != 0 && !locationLoaded {
            
            locationLoaded = true
            fetchCityAndCountry(from: location) { city, country, codeCountry, error in
                guard let codeCountry = codeCountry ,error == nil else { return }
                self.delegate?.setCountryLocation(country: codeCountry)
            }
            locationManager?.stopUpdatingLocation()
        }
        
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ codeCountry: String?, _ error: Error?) -> ()) {
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            
            completion(placemarks?.first?.locality,
                       
                       placemarks?.first?.country,
                       
                       placemarks?.first?.isoCountryCode,
                       
                       error)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            switch status {
            case .notDetermined:
                requestPermission()
            case .authorizedWhenInUse:
                delegate?.statusAuthorizationLocation(status: .authorized)
                startUpdatingLocation()
            case .authorizedAlways:
                delegate?.statusAuthorizationLocation(status: .authorized)
            case .restricted:
                delegate?.statusAuthorizationLocation(status: .denied)
            case .denied:
                delegate?.statusAuthorizationLocation(status: .denied)
            @unknown default:
                delegate?.statusAuthorizationLocation(status: .denied)
            }
            
        } else {
            delegate?.statusAuthorizationLocation(status: .disable)
            self.locationLoaded = false
        }
    }
}

