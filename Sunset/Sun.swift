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
	
	private var apiURL = "http://api.sunrise-sunset.org/json?lat=51.850775&lng=-4.368332"
	private var results = [String:AnyObject]()
	
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
		let requestURL: NSURL = NSURL(string: apiURL)!
		let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
		let session = URLSession.shared
		let task = session.dataTask(with: urlRequest as URLRequest){
			(data, response, error) -> Void in
			
			let httpResponse = response as! HTTPURLResponse
			let statusCode = httpResponse.statusCode
			
			if statusCode == 200{
				do{
					let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
					if let items = parsedData["results"] as? [String:AnyObject]{
						if parsedData["status"] as? String == "OK"{
							self.results = items
							print(self.results)
						}
					}else{
						print("Error while retrieving the json")
						let statError = parsedData["status"] as? String
						print("API error: \(statError!)")
					}
					
				}catch{
					print("error: \(error)")
				}
				
			}
		}
		task.resume()
		
	}
	
}
