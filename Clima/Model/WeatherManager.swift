//
//  WeatherManager.swift
//  Clima
//
//  Created by Jittanan Jackthreemongkol on 12/8/2565 BE.
//  Copyright © 2565 BE App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weather: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/weather?appid=542ffd081e67f4512b705f89d2a611b2"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with:urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let urlString =  "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with:urlString)
        
    }
    
    func performRequest(with urlString:String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJson(safeData){
                       let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            //4.Start the task
            task.resume()
            
        }
    }
    
    func parseJson(_ weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
         
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            print (error)
            return nil
        }
        
    }
    
    

}
