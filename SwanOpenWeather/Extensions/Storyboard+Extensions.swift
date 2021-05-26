//
//  Storyboard+Extensions.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static var WeatherForcastHome: UIStoryboard {
        return UIStoryboard(name: "WeatherForcast", bundle: nil)
    }
 
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        
        return viewController
    }
    
}

extension UIApplication {
  class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let tabController = controller as? UITabBarController {
      return topViewController(controller: tabController.selectedViewController)
    }
    if let navController = controller as? UINavigationController {
      return topViewController(controller: navController.visibleViewController)
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
}

