//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Gopabandhu on 14/12/19.
//  Copyright © 2019 Gopabandhu. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=e9fa3069748df57f83036169d48b7379&units=metric"
    var weatherDelegate: WeatherDataDelegate?
    
    func fetchWeatherUrl(city: String){
        
        let url = weatherUrl + "&q=\(city)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            print(url)
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    print(error)
                    return
                }
                
                if let safeData = data{
                    
                    if let resultModel = self.parseJSON(data: safeData){
                        if let delegate = self.weatherDelegate{
                            delegate.didUpdateWeather(weather: resultModel)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel?{
        
        let jsonDecoder = JSONDecoder()
        do{
            let response = try jsonDecoder.decode(WeatherData.self, from: data)
            let weatherModel = WeatherModel(conditionId: response.weather[0].id, description: response.weather[0].description, tempreature: response.main.temp)
            print(weatherModel.conditionName)
            return weatherModel
            
        }catch{
            print(error)
            return nil
        }
    }
}
