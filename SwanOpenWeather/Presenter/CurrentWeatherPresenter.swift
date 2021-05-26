//
//  CurrentWeatherPresenter.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//

import Foundation
import UIKit
import RealmSwift


protocol CurrentViewPresenter: AnyObject {
    init(view: CurrentView)
    func viewDidLoad()
    func searchButtonClicked(with SearchText: String)
}


class CurrentWeatherPresenter: CurrentViewPresenter
{
    
    weak var view: CurrentView?
    var networkManager = NetworkManager()
    private var recentSearchItems: Results<Item>?
    private var realm = try! Realm()
    required init(view: CurrentView) {
        self.view = view
    }
    
    
    // MARK: - Protocol methods
    
    func viewDidLoad() {
        print("View notifies the Presenter that it has loaded.")
        retrieveItems()
    }
    
    
    
    func searchButtonClicked(with SearchText: String) {
        addToRececntSearches(searchText: SearchText)
    }
    
    
    // MARK: - Private methods
    private func retrieveItems() {
        print("Presenter retrieves Item objects from the Realm Database.")
        self.recentSearchItems = realm.objects(Item.self)
        let titles: [String]? = self.recentSearchItems?
            .compactMap { $0.title }
        view?.onItemsRetrieval(titles: titles ?? [])
    }
    
    // MARK: - Private methods
    private func getCurrentLocationWeatherForcast(lat:Double, lng: Double) {
        networkManager.getCurrentWeather(lat: lat, lng: lng) { weather, errorMsg in
            if errorMsg == nil
            {
                self.view?.reloadTableViewAsPer(CurrentWeather: weather)
            }else
            {
                ShowAlertViewOnTop(msg: errorMsg ?? "Something went wrong!")
            }
        }
    }
    
    private func addToRececntSearches(searchText: String) {
        print("Presenter adds an Item object to the Realm Database.")
        let item = Item(title: searchText)
        do {
            try self.realm.write {
                self.realm.add(item)
            }
        } catch {
            view?.onItemAddFailure(message: error.localizedDescription)
        }
        view?.onItemAddSuccess(title: item.title)
    }
    
    func getCurrenLocation()
    {
        LocationManager.shared.getLocation { location, error in
            if error != nil
            {
                ShowAlertViewOnTop(msg: (error?.localizedDescription ?? "Error while getting location"))
                return
            }
            guard let _ = location else {
                ShowAlertViewOnTop(msg: ("We are not able to get your location. Please check location settings"))
                return
            }
            self.getCurrentLocationWeatherForcast(lat: location?.coordinate.latitude ?? 25.0805, lng: location?.coordinate.longitude ?? 55.1403)
        }
    }
    
    
}
