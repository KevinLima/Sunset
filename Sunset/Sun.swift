//
//  Sun.swift
//  Sunset
//
//  Created by Kevin Lima on 27-02-17.
//  Copyright © 2017 Kevin Lima. All rights reserved.
//

import Foundation
class Sun:NSObject{
	
	private var sunset: String = "Loading..."
	private var sunrise: String = "Loading..."
	private var dayLength: String = "Loading..."
	
	private var location: Location = Location()
	
	private var apiURL = "http://api.sunrise-sunset.org/json?lat=51.850775&lng=4.368332"
	private var results = [String:AnyObject]()
	
	override init(){
		super.init()
		NotificationCenter.default.addObserver(self, selector: #selector(Sun.retrieveSunProfile(notification:)), name: Notification.Name("locationReady"), object: nil)
	}
	
	@objc func retrieveSunProfile(notification:Notification){
		if Reachability.isConnectedToNetwork() == true {
            self.apiURL = "http://api.sunrise-sunset.org/json?lat=\(location.getLatitude())&lng=\(location.getLongitude())"
            print(self.apiURL)
			getJSON()
		}else{
			print("Internet Connection not Available!")
		}
	}
	
	
	func getSunset()->String{
		return sunset
	}
	
	func getSunrise()->String{
		return sunrise
	}
	
	func getDayLength()->String{
		return dayLength
	}
	
	func getCity()->String{
		return location.getCity()
	}
    func getCountry()->String{
        return location.getCountry()
    }
	
	func getLongitude()->String{
		return location.getLongitude()
	}
	
	func getLatitude()->String{
		return location.getLatitude()
	}
    
    //array.append(self.results["day_length"] as! String)
    func getValues()->[Date]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        
        var array : [Date] = []
        array.append(dateFormatter.date(from: self.results["sunset"] as! String)!)
        array.append(dateFormatter.date(from: self.results["sunrise"] as! String)!)
        array.append(dateFormatter.date(from: self.results["solar_noon"] as! String)!)
        array.append(dateFormatter.date(from: self.results["civil_twilight_begin"] as! String)!)
        array.append(dateFormatter.date(from: self.results["civil_twilight_end"] as! String)!)
        array.append(dateFormatter.date(from: self.results["nautical_twilight_begin"] as! String)!)
        array.append(dateFormatter.date(from: self.results["nautical_twilight_end"] as! String)!)
        array.append(dateFormatter.date(from: self.results["astronomical_twilight_begin"] as! String)!)
        array.append(dateFormatter.date(from: self.results["astronomical_twilight_end"] as! String)!)
        
        var timeZoneArray :[Date] = []
        var secondsFromGMT: Int {return TimeZone.current.secondsFromGMT()}
        
        for result in array{
            timeZoneArray.append(result.addingTimeInterval(Double(secondsFromGMT)))
        }
        return timeZoneArray
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
        // day length is not in the getValues array because it's not a date
		self.dayLength = self.results["day_length"] as! String
        
        UserDefaults.standard.set(getValues(), forKey: "sunProfileDates")
        UserDefaults.standard.set(self.results["day_length"] as! String, forKey: "dayLength")
        NotificationCenter.default.post(name: NSNotification.Name("reloadData"), object: nil)
        
	}
    func getDataCount()->Int{
        return 9
    }
}
