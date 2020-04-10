//
//  ViewController.swift
//  Weather
//
//  Created by Александр Нехай on 4/8/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Variables
    var viewModel = WeatherViewModelImpl()
    var weather: Weather?
    let locationManager = CLLocationManager()
    var info = [AdditionalInfo]()
    var locationRecieved = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
        
        setMainLabels()
        registrTableViewCells()
    }
    
    // MARK: - Methods
    func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setMainLabels() {
        cityLabel.text = "Minsk"
        tempLabel.text = "13º"
    }
    
    func registrTableViewCells() {
        let nibHourlyInfoCellName = UINib(nibName: "HourlyInfoCell", bundle: nil)
        tableView.register(nibHourlyInfoCellName, forCellReuseIdentifier: "HourlyInfoCell")
        
        let nibFutureCellName = UINib(nibName: "FutureCell", bundle: nil)
        tableView.register(nibFutureCellName, forCellReuseIdentifier: "FutureCell")
        
        let nibAdditionalCellName = UINib(nibName: "AdditionalCell", bundle: nil)
        tableView.register(nibAdditionalCellName, forCellReuseIdentifier: "AdditionalCell")
    }
    
}

// MARK: - WeatherViewModelImpl
extension ViewController {
    
    func requestWeather(lat: Double, lon: Double) {
        viewModel.requestWeather(lat: lat, lon: lon) { (weather) in
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = "\(weather.temp!)"
            
            guard let weatherInfo = weather.info else { return }
            self.info = weatherInfo
            
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AdditionalCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCell", for: indexPath) as? AdditionalCell else { return UITableViewCell() }
        cell.setAdditionalCell(info: info[indexPath.row])
        return cell
    }
    
    
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationRecieved == false, let location = locations.first else { return }
        requestWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        locationRecieved = true
    }
}
