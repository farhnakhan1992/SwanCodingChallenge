//
//  Constants.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.
//

import Foundation
import UIKit


let networkError = "Please check your internet connection!"

func ShowAlertViewOnTop(msg:String){
    let alert = UIAlertController(title: "SWAN", message:msg, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
    }))
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
 }


func getFormatedTemp(current: Double) -> String?
{
    let measurement = Measurement(value: current, unit: UnitTemperature.kelvin)
    let measurementFormatter = MeasurementFormatter()
    measurementFormatter.unitStyle = .short
    measurementFormatter.numberFormatter.maximumFractionDigits = 0
    measurementFormatter.unitOptions = .naturalScale
    return measurementFormatter.string(from: measurement)
}
