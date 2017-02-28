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
	private var longitude: String = "4.368332"
	private var latitude: String = "51.850775"
	private var city: String = "Hoogvliet"
	private var country: String = "The Netherlands"
	let locationManager = CLLocationManager()
	
	override init() {
		super.init()
		
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
		
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation:CLLocation = locations.first!
		self.longitude = String(format:"%f", userLocation.coordinate.longitude)
		self.latitude = String(format:"%f", userLocation.coordinate.latitude)
		locationManager.stopUpdatingLocation()
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
