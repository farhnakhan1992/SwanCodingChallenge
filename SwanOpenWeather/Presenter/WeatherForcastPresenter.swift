//
//  WeatherForcastPresenter.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.
//

import UIKit
import RealmSwift
protocol WeatherViewPresenter: AnyObject {
    init(view: WeatherMainView)
    func viewDidLoad()
   
}

class WeatherForcastPresenter: WeatherViewPresenter {
   
    

    weak var view: WeatherMainView?
    var networkManager = NetworkManager()
    private var realm = try! Realm()
    
    
    
    required init(view: WeatherMainView) {
        self.view = view
    }
    
   
    
    // MARK: - Protocol methods
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork()
        {
            self.getCurrentLocation()
        }
        print("View notifies the Presenter that it has loaded.")
    }

    
    // MARK: - Private methods
    private func retrieveWeatherForcast(lat:Double, lng: Double) {
        networkManager.getFiveDaysForcastViaLatLng(lat: lat, lng: lng) { forcastArray, errorMsg in
            if errorMsg == nil
            {
                self.view?.reloadTableViewAsPerData(ForcastArray: forcastArray)
            }else
            {
                ShowAlertViewOnTop(msg: errorMsg ?? "Something went wrong!")
            }
        }
    }
    
    private func getCurrentLocation()
    {
        
        LocationManager.shared.getCurrentReverseGeoCodedLocation { location, placemark, error in
            if error != nil
            {
                
                ShowAlertViewOnTop(msg: (error?.localizedDescription ?? "Error while getting location"))
                self.view?.locationError()
                return
            }
            guard let _ = location, let placemark = placemark else {
                ShowAlertViewOnTop(msg: ("We are not able to get your location. Please check location settings"))
                self.view?.locationError()
                return
            }
            //dubai marina default lat, long in case if they are empty
            self.retrieveWeatherForcast(lat: location?.coordinate.latitude ?? 25.0805, lng: location?.coordinate.longitude ?? 55.1403)
            self.view?.setupCityName(name: placemark.locality ?? "")
        }
    }
    
}
