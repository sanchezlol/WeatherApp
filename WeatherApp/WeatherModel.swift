//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Alexandr on 2/28/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import Foundation

class WeatherModel {
    
    static func getCurrentWeatherMain() -> CurrentWeatherMain? {
        
        if Storage.fileExists("weatherData.json", in: .documents) {
            let weatherFromDisk = Storage.retrieve("weatherData.json", from: .documents, as: Weather.self)
//            print("weatherData.json loaded from device file system")
            let current = CurrentWeatherMain(weather: weatherFromDisk)
            return current
        } else {
            let path = Bundle.main.path(forResource: "defaultData", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            
            do {
                let data = try Data(contentsOf: url)
                let weatherFromDisk = try JSONDecoder().decode(Weather.self, from: data)
                let current = CurrentWeatherMain(weather: weatherFromDisk)
                return current
            } catch {}
        }
        return nil
    }
    
    static func getCurrentWeather() -> [CurrentWeather]? {
        
        if Storage.fileExists("weatherData.json", in: .documents) {
            let weatherFromDisk = Storage.retrieve("weatherData.json", from: .documents, as: Weather.self)
//            print("weatherData.json loaded from device file system")
            
            var current : [CurrentWeather] = []
            for i in (1..<weatherFromDisk.list!.count) {
                current.append(CurrentWeather(weather: weatherFromDisk, i: i))
            }
            
            return current
        } else {
            let path = Bundle.main.path(forResource: "defaultData", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            
            do {
                let data = try Data(contentsOf: url)
                let weatherFromDisk = try JSONDecoder().decode(Weather.self, from: data)
                
                var current : [CurrentWeather] = []
                for i in (1..<weatherFromDisk.list!.count) {
                    current.append(CurrentWeather(weather: weatherFromDisk, i: i))
                }
                
                return current
                
            } catch {}
        }
        return nil
    }
    
    static func updateDataWithLocations(latitude: Double, longitude: Double){
        
        if let url = generateUrl(latitude: latitude, longitude: longitude){
            
            let currentTask = URLSession.shared.dataTask(with: url) {
                
                (data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    
                    let content = try JSONDecoder().decode(Weather.self, from: data)
                    
                    Storage.store(content, to: .documents, as: "weatherData.json")
//                    print("Weather data has been downloaded and saved")
                    
                } catch {
                    print(error)
                }
            }
            
            currentTask.resume()
        } else {
            print("Invalid url")
        }
    }
    
    static func generateUrl(latitude lat: Double, longitude lon: Double) -> URL? {
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        
        let queryItem1 = URLQueryItem(name: "lat", value: "\(lat)")
        let queryItem2 = URLQueryItem(name: "lon", value: "\(lon)")
        let queryItem3 = URLQueryItem(name: "appid", value: "1813bf166bb7378f9a051c8f9a12009e")
        
        components.queryItems = [queryItem1, queryItem2, queryItem3]
        
        if let url : URL = components.url {
//            print("Query url: " + String(describing: components.url!))
            return url
        } else {
            return nil
        }
    }
    
    
}
