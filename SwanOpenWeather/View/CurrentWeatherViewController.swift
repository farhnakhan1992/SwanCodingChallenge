//
//  CurrentWeatherViewController.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//

import UIKit
import KRProgressHUD

// MARK: - Protocols

protocol CurrentView: AnyObject {
    func onItemsRetrieval(titles: [String])
    func reloadTableViewAsPer(CurrentWeather: CurrentWeatherClass?)
    func onItemAddSuccess(title: String)
    func onItemAddFailure(message: String)
    
}


class CurrentWeatherViewController: UIViewController {

    // MARK: - Properties
    var presenter: CurrentWeatherPresenter!
    var recentSearches: [String] = []
    var currentWeather : CurrentWeatherClass?
    var isSearchEnabled = true
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searhBar: UISearchBar!
    @IBOutlet weak var currentTempView: UIView!
    
    
    // MARK: - weatherView Properties
    
    @IBOutlet weak var imgWeatherType: UIImageView!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var lblMinMaxTemp: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        self.showAndHideWeatherView(isHide: isSearchEnabled)
        presenter.viewDidLoad()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searhBar.becomeFirstResponder()
    }


}

// MARK: - View Protocol
extension CurrentWeatherViewController: CurrentView {
    func reloadTableViewAsPer(CurrentWeather: CurrentWeatherClass?) {
        self.isSearchEnabled = false
        self.currentWeather = CurrentWeather
        self.showAndHideWeatherView(isHide: isSearchEnabled)
        DispatchQueue.main.async {
            KRProgressHUD.dismiss()
            self.setupCurrentWeather()
            self.tableView.reloadData()
        }
      
    }
    
    func onItemsRetrieval(titles: [String]) {
        self.recentSearches = titles.suffix(5)
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
    }
    
    func onItemAddSuccess(title: String) {
        //items successfully added
        self.recentSearches.append(title)
        self.recentSearches = recentSearches.suffix(5)
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
    }
    
    func onItemAddFailure(message: String) {
        //unable to save show a error message
    }
}

// MARK: - UITableView Data Source
extension CurrentWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Searches"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath)
            cell.textLabel?.text = recentSearches[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searhBar.resignFirstResponder()
        if Reachability.isConnectedToNetwork()
        {
            KRProgressHUD.show()
            presenter.getCurrenLocation()
        }else
        {
            ShowAlertViewOnTop(msg: networkError)
        }
       
    }
}


// MARK: - UI Setup
extension CurrentWeatherViewController {
    
    
    private func setupUI() {

        let backBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), style: .plain, target: self, action: #selector(goBack))
        // self.navigationItem.backBarButtonItem = backBarButton
        self.navigationItem.leftBarButtonItems = [ backBarButton ]
        self.navigationItem.leftItemsSupplementBackButton = false
        self.view.backgroundColor = .black
        self.tableView.tableFooterView = UIView()
        self.setupNavTitle(title: "Recent Searches")
    }
    
    private func setupNavTitle(title:String) {
        self.title = title
    }
    
    func showAndHideWeatherView(isHide:Bool)
    {
        if isHide
        {
            DispatchQueue.main.async {
                self.currentTempView.isHidden = true
                self.tableView.isHidden = false
            }
        }else
        {
            DispatchQueue.main.async {
                self.currentTempView.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }
    
    func setupCurrentWeather()
    {
        guard let object = self.currentWeather else {return}
        self.lblCurrentTemp?.text = "\(getFormatedTemp(current: object.main?.temp_min ?? 0.0) ?? "")"
        
        self.lblMinMaxTemp?.text = "min \(getFormatedTemp(current: object.main?.temp_min ?? 0.0) ?? "") - max \(getFormatedTemp(current: object.main?.temp_max ?? 0.0) ?? "")"
        self.lblWindSpeed?.text = "Wind Speed: \(object.wind?.speed ?? 0.0)"
        if object.weather?.count != 0
        {
            let innerObj = object.weather?[0]
            self.lblWeatherType?.text = innerObj?.main
            self.lblDescription?.text = innerObj?.description ?? ""
            switch WeatherEnum.init(rawValue: innerObj?.main ?? "") {
            case .clear:
                self.imgWeatherType?.image = UIImage.init(named: "Clear")
                break
            case .cloudy:
                self.imgWeatherType?.image = UIImage.init(named: "Cloudy")
            break
            default:
                self.imgWeatherType?.image = UIImage.init(named: "default")
                break
            }
        }
    }
    
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - Search bar delegates

extension CurrentWeatherViewController : UISearchBarDelegate
{
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text?.count ?? 0) > 1
        {
            searchBar.resignFirstResponder()
            if Reachability.isConnectedToNetwork()
            {
                presenter.searchButtonClicked(with: searchBar.text ?? "")
                presenter.getCurrenLocation()
                searhBar.text = nil
                KRProgressHUD.show()
            }else
            {
                ShowAlertViewOnTop(msg: networkError)
            }
           
          
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
 
      
        self.showAndHideWeatherView(isHide: true)
       
        DispatchQueue.main.async {
            searchBar.setShowsCancelButton(true, animated: true)
            self.tableView.reloadData()
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
     
    }
    
}
