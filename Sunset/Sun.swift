//
//  Sun.swift
//  Sunset
//
//  Created by Kevin Lima on 27-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import Foundation
class Sun{
	
	private var sunset: String = "99:99"
	private var sunrise: String = "11:11"
	
	private var location: Location = Location()
	
	private var apiURL = "http://api.sunrise-sunset.org/json?lat=51.850775&lng=4.368332"
	private var results = [String:AnyObject]()
	
	init() {
		self.apiURL = "http://api.sunrise-sunset.org/json?lat=\(location.getLatitude())&lng=\(location.getLongitude())"
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
	
	func getLongitude()->String{
		return location.getLongitude()
	}
	
	func getLatitude()->String{
		return location.getLatitude()
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
							self.setData()
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
	
	func setData(){
		self.sunset = self.results["sunset"] as! String
		self.sunrise = self.results["sunrise"] as! String
		NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
		
	}
}
