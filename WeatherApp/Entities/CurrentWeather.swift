//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Alexandr on 3/1/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import Foundation

class CurrentWeather {
    let temperature : String
    let time : String
    let description : String
    init(weather : Weather, i : Int) {
        if Int(weather.list![i].main.temp_min - 273.3) != Int(weather.list![i].main.temp_max - 273.3) {
            self.temperature = "\(Int(weather.list![i].main.temp_min - 273.3))...\(Int(weather.list![i].main.temp_max - 273.3))°C"
        } else {
            self.temperature = "\(Int(weather.list![i].main.temp_min - 273.3))°C"
        }
        var str = weather.list![i].dt_txt
        str.removeFirst(5)
        str.removeLast(3)
        self.time = str
        self.description = weather.list![i].weather[0].description
    }
}

class CurrentWeatherMain: CurrentWeather {
    let place : String
    init(weather : Weather) {
        var str = ""
        if weather.city.name != nil {
            str += weather.city.name!
        }
        if weather.city.country != nil {
            str += ", \(weather.city.country!)"
        }
        self.place = str
        super.init(weather: weather, i: 0)
    }
}

