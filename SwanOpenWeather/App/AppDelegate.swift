//
//  AppDelegate.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.
//

import UIKit
import KRProgressHUD
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability = Reachability()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let vc = UIStoryboard.WeatherForcastHome.get(WeatherForcastViewController.self)
        {
            let presenter = WeatherForcastPresenter(view: vc)
            vc.presenter = presenter
            
          //  reachability.sta
            window = UIWindow()
            window?.rootViewController = UINavigationController(rootViewController: vc)
            window?.makeKeyAndVisible()
        }
        self.setupHud()
      
        return true
        
     
    }
    
    // MARK: - Hud Setup
   func setupHud()
    {
    //public var activityIndicatorColors = [UIColor]([.black, .lightGray])
    KRProgressHUD.set(style: .custom(background: .clear, text: .white, icon: nil))
    KRProgressHUD.set(activityIndicatorViewColors: [.white, .white])
    }

}

