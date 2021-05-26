//
//  WeatherForcastViewController.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.
//

import UIKit



// MARK: - Protocols


protocol WeatherMainView: AnyObject {

    func setupCityName(name:String)
    func locationError()
    func reloadTableViewAsPerData(ForcastArray: [List]?)
}

class WeatherForcastViewController: UIViewController {

    
    // MARK: - Properties
    var presenter: WeatherViewPresenter!
    @IBOutlet weak var placeholder: UILabel!
    var weatherForcastArray = [List]()
    
    @IBOutlet weak var btnSearchOutlet: UIButton!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
       
        
    }
    
    // MARK: - Actions
    
    @IBAction func btnSearchClicked(_ sender: Any)
    {
        self.navigateToRecentSearchesVC()
    }
    
}



// MARK: - View Protocol
extension WeatherForcastViewController: WeatherMainView {
    func locationError() {
        self.placeholder.text = "Error while getting your location..."
    }
    
   
    
    
    func reloadTableViewAsPerData(ForcastArray: [List]?) {
        guard let finalArray = ForcastArray else {
            return
        }
        self.weatherForcastArray = finalArray
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func setupCityName(name: String) {
        DispatchQueue.main.async {
            self.setupNavTitle(title: name)
        }
    }

    
}
// MARK: - UITableView Data Source
extension WeatherForcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = self.weatherForcastArray.isEmpty
        self.placeholder.isHidden = !self.weatherForcastArray.isEmpty
        return self.weatherForcastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherForcastTblCustomCell
        if indexPath.row < self.weatherForcastArray.count
        {
            cell.setupView(obj: self.weatherForcastArray[indexPath.row])
        }
        return cell
    }
}

// MARK: - UI Setup & Navigation
extension WeatherForcastViewController {
    
    private func navigateToRecentSearchesVC()
    {
        if let vc = UIStoryboard.WeatherForcastHome.get(CurrentWeatherViewController.self)
        {
            let presenter = CurrentWeatherPresenter(view: vc)
            vc.presenter = presenter
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupUI() {

        self.view.backgroundColor = .black
        self.weatherTableView.tableFooterView = UIView()
        if Reachability.isConnectedToNetwork() == true
        {
            self.placeholder.text = "Loading weather data please wait...."
        }else
        {
            self.placeholder.text = "Please check your connection.."
        }
        
    }
    
    private func setupNavTitle(title:String) {
        self.title = title
    }
}


