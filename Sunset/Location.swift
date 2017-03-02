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
	private var longitude: String = "8.888888"
	private var latitude: String = "22.222222"
	private var city: String = "Hoogvliet"
	private var country: String = "The Netherlands"
	let locationManager = CLLocationManager()
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
				print("Location obtained")
				NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
				self.locationManager.stopUpdatingLocation()
				NotificationCenter.default.post(name: Notification.Name("retrieveSunProfile"), object: nil)
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
