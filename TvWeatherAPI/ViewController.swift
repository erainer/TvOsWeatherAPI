//
//  ViewController.swift
//  TvWeatherAPI
//
//  Created by Emily Rainer on 3/9/19.
//  Copyright © 2019 Emily Rainer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = NSURL(string: "https://api.darksky.net/forecast/f3ce92e52d7509098b59805b2e280a60/37.8267,-122.4233") else {
            return
        }
        
        if let data = NSData(contentsOf: url as URL){
            do {
                guard let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] else {
                    return
                }
                
                let newDict = parsed
                print(newDict)
                
    
                guard let summary = newDict["currently"]?["summary"] as? String,
                        let icon = newDict["currently"]?["icon"] as? String else {
                    print("Error obtaining information from dictionary")
                    return
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd, yyyy"
                let today = formatter.string(from: Date())

                dateLabel.text = today
                summaryLabel.text = summary
                temperatureLabel.text = "\(newDict["currently"]!["temperature"]!!)"
                windSpeedLabel.text = "\(newDict["currently"]!["windSpeed"]!!)"
                dewPointLabel.text = "\(newDict["currently"]!["dewPoint"]!!)"
            
                if icon.contains("cloudy") {
                     weatherIcon.image = UIImage(named: "partly-cloudy")
                }else if icon.contains("rain") {
                     weatherIcon.image = UIImage(named: "rainy")
                } else if icon.contains("snow") {
                    weatherIcon.image = UIImage(named: "snowflake")
                } else if icon.contains("sun") {
                    weatherIcon.image = UIImage(named: "sun")
                }
            }
            catch let error as NSError {
                print("Error parsing JSON: \(error)")
            }
        }
        
    }
}

