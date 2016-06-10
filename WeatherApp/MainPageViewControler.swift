//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Brendan Stang on 6/1/16.
//  Copyright © 2016 Brendan Stang. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var temperatureLable:UILabel!
    @IBOutlet weak var temperatureUnitLable:UILabel!
    @IBOutlet weak var forecastLabel:UILabel!
    
    
    var weatherReportJson:JSON?
    
    var weatherUpdateTimer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(weatherUpdateTimer == nil){
            updateWeatherInformation()
            weatherUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: Selector("updateWeatherInformation"), userInfo: nil, repeats: true)
        }
        updateWeatherDisplay()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateWeatherDisplay()
    }
    
    func updateWeatherInformation(){
        let manager = AFHTTPSessionManager()
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        manager.GET(UrlGenerator.generateUrl("philadelphia"),
            parameters: nil,
            progress:nil,
            success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                if let responseObject = responseObject{
                    self.weatherReportJson = JSON(responseObject)
                    self.updateWeatherDisplay()
                    activityIndicatorView.removeFromSuperview()
                }
            },
            failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                print("Error:" + error.localizedDescription)
        })
        print("weatherUpdated")
    }
    
    func updateWeatherDisplay(){
        if let weatherReportJson = self.weatherReportJson{
            if let forecast = weatherReportJson["weather"][0]["description"].string {
                self.forecastLabel.text = forecast
                print("forecast:" + forecast)
            }
            if let temperature = weatherReportJson["main"]["temp"].number{
                var temperatureNumber:Double = temperature.doubleValue
                self.view.backgroundColor = UIColor(hue: CGFloat(((temperatureNumber*(-6))+110.5)/357), saturation: 100, brightness: 100, alpha: 1)
                let hue = (temperatureNumber*(-4)+200.0)
                print("hue:")
                print(hue)
                switch(Settings.tempUnit){
                case .kelvin:
                    temperatureNumber = temperatureNumber + 273.15
                    temperatureUnitLable.text = "K"
                case .fahrenheit:
                    temperatureNumber = temperatureNumber * (9/5) + 32
                    temperatureUnitLable.text = "°F"
                default:
                    temperatureNumber = temperatureNumber * 1
                    temperatureUnitLable.text = "°C"
                }
                self.temperatureLable.text = String(Int(temperatureNumber))
                print(temperature)
            }else{
                print("unable to get temperture")
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

