//
//  WeatherManager.swift
//  Clima
//
//  Created by Jittanan Jackthreemongkol on 12/8/2565 BE.
//  Copyright © 2565 BE App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/weather?appid=542ffd081e67f4512b705f89d2a611b2"
    
    func fetchWeather(cityName:String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString:urlString)
    }
    
    func performRequest(urlString:String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url,completionHandler: handle(data:response:error:))
            
            //4.Start the task
            task.resume()
            
        }
    }
    
    func handle(data:Data?,response:URLResponse?,error:Error?){
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data:safeData,encoding: .utf8)
            print(dataString!)
        }
        
    }
}
