//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Gopabandhu on 14/12/19.
//  Copyright © 2019 Gopabandhu. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITextFieldDelegate, WeatherDataDelegate {

    //MARK: Outlets
    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: Properties
    var objWeatherManager = WeatherManager()
    
    //TODO:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //TODO:- TextField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let city = txtCityName.text
        objWeatherManager.fetchWeatherUrl(city: city!)
        objWeatherManager.weatherDelegate = self
        lblCity.text = (txtCityName.text)?.uppercased()
        txtCityName.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtCityName { textField.resignFirstResponder() }
        return true
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        
        let temp = String(format: "%.1f", weather.tempreature)
        DispatchQueue.main.async {
            self.lblTemp.text = "\(temp)"
            self.imgWeather.image = UIImage(systemName: weather.conditionName)
            self.lblDescription.text = weather.description
        }
        
    }
}

