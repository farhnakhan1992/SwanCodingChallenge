//
//  WeatherForcastViewController.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.
//

import UIKit

class WeatherForcastViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var mainSearchBar: UISearchBar!
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }

}

// MARK: - UITableView Data Source
extension WeatherForcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.isHidden = self.titles.isEmpty
//        placeholderLabel.isHidden = !self.titles.isEmpty
//        return self.titles.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherForcastTblCustomCell
       // cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    
    
    
}

// MARK: - UI Setup
extension WeatherForcastViewController {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = .black
    }
    
    private func setupNavItem() {
        //self.navigationItem.rightBarButtonItem = addBarItem
    }
}
