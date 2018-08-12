//
//  Location.swift
//  Sunset
//
//  Created by Kevin Lima on 27-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


class Location: NSObject, CLLocationManagerDelegate{
	private var longitude: String = "Loading..."
	private var latitude: String = "Loading..."
	private var city: String = ""
	private var country: String = ""
	private let locationManager = CLLocationManager()
	private var notificationWasSend:Bool = false
	
	override init() {
		super.init()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		DispatchQueue.main.async {
			let userLocation:CLLocation = locations.first!
			if !self.notificationWasSend{
				self.notificationWasSend = true
				self.longitude = String(format:"%f", userLocation.coordinate.longitude)
				self.latitude = String(format:"%f", userLocation.coordinate.latitude)
				
				self.locationManager.stopUpdatingLocation()
				
				CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error)-> Void in
					if placemarks != nil{
						if placemarks!.count > 0{
							let placemark = placemarks![0]
							self.city = placemark.locality!
							self.country = placemark.country!
                            
                            let locationDict: [String:[String]] = ["location": [self.city, self.country]]
                            
                            // VC to display new lcoation
							NotificationCenter.default.post(name: Notification.Name("receiveLocation"), object: nil)
                            
                            // VC to display new sun profile 
							NotificationCenter.default.post(name: Notification.Name("retrieveSunProfile"), object: nil)
						}
					}else{
						print("Error while obtaining city")
					}
					if error != nil{
						print(error!)
					}
				
				})
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to find user's location: \(error.localizedDescription)")
	}
	
	
	func getLongitude()->String{
		return longitude
	}
	
	func getLatitude()->String{
		return latitude
	}
	
	func getCity()->String{
		return city
	}
	
	func getCountry()->String{
		return country
	}
}
