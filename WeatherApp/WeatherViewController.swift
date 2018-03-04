//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alexandr on 2/26/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weatherItemCell", for: indexPath) as! WeatherTableViewCell
        cell.commonInit(temperature: weatherArray![indexPath.row].temperature, description: weatherArray![indexPath.row].description, time: weatherArray![indexPath.row].time)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    let locationManager = CLLocationManager()
    
    var latitude : Double = 0
    var longitude : Double = 0

    
    var currentWeatherMain : CurrentWeatherMain?
    var weatherArray : [CurrentWeather]?
    
    @IBOutlet weak var mainWeatherView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var stripe: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var weatherTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
//        Storage.clear(.documents)
        
        
        let nibName = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        weatherTable.register(nibName, forCellReuseIdentifier: "weatherItemCell")
        
        updateForecast()
        
//        Storage.clear(.documents)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        updateUI()
        
        self.mainWeatherView.backgroundColor = UIColor(displayP3Red: 0, green: 225/255, blue: 255/255, alpha: 1)
        placeLabel.textColor = .white
        
        
        weatherTable.backgroundColor = UIColor(displayP3Red: 22/255, green: 34/255, blue: 44/255, alpha: 1)
        weatherTable.separatorStyle = .none
        weatherTable.showsVerticalScrollIndicator = false
        
        stripe.backgroundColor = UIColor(displayP3Red: 128/255, green: 240/255, blue: 255/255, alpha: 1)
    }
    
    private func updateLocation(){
        guard let locValue : CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        print("locations: \(locValue.latitude) \(locValue.longitude)")
    }
    
    
    private func updateUI() {
        
        self.temperatureLabel.text = currentWeatherMain!.temperature
        self.descriptionLabel.text = currentWeatherMain!.description
        self.placeLabel.text = currentWeatherMain!.place
        self.icon.image = IconChooser.chooseIcon(forDescription: currentWeatherMain!.description)
        
    }
    
    private func updateForecast() {
        updateLocation()
        if self.latitude != 0 && self.longitude != 0 {
            WeatherModel.updateDataWithLocations(latitude: self.latitude, longitude: self.longitude)
        }
        self.currentWeatherMain = WeatherModel.getCurrentWeatherMain()!
        self.weatherArray = WeatherModel.getCurrentWeather()!
        updateUI()
        weatherTable.reloadData()
    }
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        self.updateForecast()
    }


}

