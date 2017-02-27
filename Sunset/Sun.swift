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
	
	private var isDownloaded: Bool = false
	private var results = [String]()
	
	init() {
		getJSON()
	}
	
	
	func getSunset()->String{
		return sunset
	}
	
	func getSunrise()->String{
		return sunrise
	}
	
	func getLocation()->String{
		return location.getCity()
	}
	
	func getJSON(){
		let requestURL: NSURL = NSURL(string: "http://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400")!
		let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
		let session = URLSession.shared
		let task = session.dataTask(with: urlRequest as URLRequest){
			(data, response, error) -> Void in
			
			let httpResponse = response as! HTTPURLResponse
			let statusCode = httpResponse.statusCode
			
			if statusCode == 200{
				print(data)
			}
		}
		task.resume()
	}
	
}
