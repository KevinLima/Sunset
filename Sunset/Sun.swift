//
//  Sun.swift
//  Sunset
//
//  Created by Kevin Lima on 27-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import Foundation
class Sun{
	
	private var sunset: String = "18:19"
	private var sunrise: String = "07:31"
	

	private var location: Location = Location()
	
	
	func getSunset()->String{
		return sunset
	}
	
	func getSunrise()->String{
		return sunrise
	}
	
	func getLocation()->String{
		return location.getCity()
	}
	
}
