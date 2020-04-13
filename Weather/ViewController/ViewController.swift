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
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
    
    // MARK: - Variables
    var viewModel = WeatherViewModelImpl()
    
    var weather: Weather?
    var info = [AdditionalInfo]()
    var dailyforecast = [ForecastByDate]()
    var hourlyForecast = [ForecastByHour]()
    
    let locationManager = CLLocationManager()
    var locationRecieved = false

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
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
    
    func registrTableViewCells() {
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
            self.tempLabel.text = "\(weather.temp!) Cº"
            self.weather = weather
            guard let weatherInfo = weather.info, let weatherForecast = weather.forecast, let hourForecast = weather.hourForecast else { return }
            self.dailyforecast = weatherForecast
            self.info = weatherInfo
            self.hourlyForecast = hourForecast
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !info.isEmpty, !dailyforecast.isEmpty else { return 0 }
        return dailyforecast.count + info.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < dailyforecast.count {
            guard let cell: FutureCell = tableView.dequeueReusableCell(withIdentifier: "FutureCell", for: indexPath) as? FutureCell else { return UITableViewCell() }
            cell.setFutureCell(forecast: dailyforecast[indexPath.row])
            return cell
        } else if indexPath.row == dailyforecast.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = weather?.description ?? ""
            return cell
        } else {
            guard let cell: AdditionalCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCell", for: indexPath) as? AdditionalCell else { return UITableViewCell() }
            cell.setAdditionalCell(info: info[indexPath.row == 0 ? indexPath.row : indexPath.row - dailyforecast.count - 1])
            return cell
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setCollectionCell(forecast: hourlyForecast[indexPath.row])
        return cell
    }
    
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationRecieved == false, let location = locations.first else { return }
        requestWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        locationRecieved = true
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemark, _) in
            self.cityLabel.text = placemark?[0].locality
        }
        
    }
}
