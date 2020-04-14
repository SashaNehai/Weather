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
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var weatherDescriptionLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
    @IBOutlet weak private var weekDayLabel: UILabel!
    @IBOutlet weak private var todayMaxLabel: UILabel!
    @IBOutlet weak private var todayMinLabel: UILabel!
    
    // MARK: - Variables
    var viewModel = WeatherViewModelImpl()
    var weather: Weather?
    
    let locationManager = CLLocationManager()
    var locationRecieved = false
    
    let flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
        
        setCollectionView()
        registerCells()
        showPreviousWeather()
    }
    
    // MARK: - Methods    
    func setCollectionView() {
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: 75, height: 100)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100), collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    func registerCells() {
        let nibFutureCellName = UINib(nibName: "FutureCell", bundle: nil)
        tableView.register(nibFutureCellName, forCellReuseIdentifier: "FutureCell")
        
        let nibAdditionalCellName = UINib(nibName: "AdditionalCell", bundle: nil)
        tableView.register(nibAdditionalCellName, forCellReuseIdentifier: "AdditionalCell")
        
        let nibCollectionCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCollectionCell, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func saveWeather(weather: Weather) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(weather), forKey: Constants.saveKey)
    }
    
    func getSavedWeather() -> Weather? {
        guard let data = UserDefaults.standard.value(forKey: Constants.saveKey) as? Data else { return nil }
        return try? PropertyListDecoder().decode(Weather.self, from: data)
    }
    
    func showPreviousWeather() {
        weather = getSavedWeather()
        reloadAllLabels()
        reloadAllViews()
    }
    
    func reloadAllLabels() {
        setMainLabels(temp: "\(weather?.temp ?? "")", description: weather?.main)
        let today = weather?.forecast?[0]
        setTodayLabels(weekDay: today?.day, tempMax: today?.tempMax, tempMin: today?.tempMin)
    }
    
    func setMainLabels(temp: String?, description: String?) {
        tempLabel.text = temp
        weatherDescriptionLabel.text = description
    }
    
    func setTodayLabels(weekDay: String?, tempMax: String?, tempMin: String?) {
        weekDayLabel.text = weekDay
        todayMaxLabel.text = tempMax
        todayMinLabel.text = tempMin
    }
    
    func reloadAllViews() {
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func addSeparatorToView(view: UIView, y: CGFloat) {
        let separatorView = UIView()
        separatorView.backgroundColor = Constants.Color.separator
        separatorView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 0.75)
        view.addSubview(separatorView)
    }
    
}

// MARK: - WeatherViewModelImpl
extension ViewController {
    
    func requestWeather(lat: Double, lon: Double) {
        viewModel.requestWeather(lat: lat, lon: lon) { (weather) in
            self.weather = weather
            self.reloadAllLabels()
            self.reloadAllViews()
            self.saveWeather(weather: weather)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        view.addSubview(collectionView)
        view.backgroundColor = .white
        addSeparatorToView(view: view, y: view.frame.minY)
        addSeparatorToView(view: view, y: view.frame.maxY)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecast = weather?.forecast, let info = weather?.info else { return 0 }
        return forecast.count + info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let forecast = weather?.forecast else { return UITableViewCell() }
        
        if indexPath.row < forecast.count - 1 {
            
            guard let cell: FutureCell = tableView.dequeueReusableCell(withIdentifier: "FutureCell", for: indexPath) as? FutureCell,
                var dayForecast = weather?.forecast else { return UITableViewCell() }
            dayForecast.removeFirst()
            cell.setFutureCell(forecast: dayForecast[indexPath.row])
            guard indexPath.row + 2 != forecast.count else {
                cell.preservesSuperviewLayoutMargins = false
                cell.separatorInset = UIEdgeInsets.zero
                cell.layoutMargins = UIEdgeInsets.zero
                return cell
            }
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
            
        } else if indexPath.row == forecast.count - 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = weather?.description ?? ""
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell
            
        } else {
            
            guard let cell: AdditionalCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCell", for: indexPath) as? AdditionalCell,
                let info = weather?.info else { return UITableViewCell() }
            cell.setAdditionalCell(info: info[indexPath.row - forecast.count])
            cell.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hourForecast = weather?.hourForecast else { return 0 }
        return hourForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell,
            let hourForecast = weather?.hourForecast else { return UICollectionViewCell() }
        cell.setCollectionCell(forecast: hourForecast[indexPath.row])
        return cell
    }
    
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
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
