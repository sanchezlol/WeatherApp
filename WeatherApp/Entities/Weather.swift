//
//  Weather.swift
//  WeatherApp
//
//  Created by Alexandr on 2/26/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import Foundation

struct Weather : Codable {
    let cod : String?
    let list : Array<WeatherItem>?
    struct WeatherItem : Codable {
        let main : MainItem
        struct MainItem : Codable {
            let temp_min : Double
            let temp_max : Double
        }
        let weather : Array<MainWeaterItem>
        struct MainWeaterItem : Codable {
            let description : String
        }
        let dt_txt : String
    }
    let city : City
    struct City : Codable {
        let name : String?
        let country : String?
    }
    

}

