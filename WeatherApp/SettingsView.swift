//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Brendan Stang on 6/1/16.
//  Copyright © 2016 Brendan Stang. All rights reserved.
//

import UIKit

class SettingsView:UITableViewController{
    
    @IBOutlet var tempUnitSelector:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTempUnitSelector()
    }
    
    @IBAction func updateTempUnitSetting(sender:UISegmentedControl){
        switch(tempUnitSelector.selectedSegmentIndex){
            case 0:
                Settings.tempUnit = Settings.TempUnits.kelvin
            case 1:
                Settings.tempUnit = Settings.TempUnits.fahrenheit
            case 2:
                Settings.tempUnit = Settings.TempUnits.celsius
            default:
                Settings.tempUnit = Settings.TempUnits.celsius
            
        }
    }
    
    func initTempUnitSelector(){
        var index = 2
        switch(Settings.tempUnit){
            case .kelvin:
                index = 0
            case .fahrenheit:
                index = 1
            default:
                index = 2
        }
        tempUnitSelector.selectedSegmentIndex = index
    }
    
    
}
