//
//  WeatherForcastTblCustomCell.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.
//

import UIKit

class WeatherForcastTblCustomCell: UITableViewCell {

    
    // MARK: - Properties
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var imgWeatherType: UIImageView!
    @IBOutlet weak var lblDateTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Fill Cells
    
   func setupView(obj:List)
    {
    
    self.lblTemperature.text = "\(getFormatedTemp(current: obj.main?.temp_min ?? 0.0) ?? "")"
    self.lblFeelsLike.text = "feels like: \(getFormatedTemp(current: obj.main?.feels_like ?? 0.0) ?? "")"
    if obj.weather?.count != 0
    {
        let innerObj = obj.weather?[0]
        self.lblWeatherType.text = innerObj?.main
        switch WeatherEnum.init(rawValue: innerObj?.main ?? "") {
        case .clear:
            self.imgWeatherType.image = UIImage.init(named: "Clear")
            break
        case .cloudy:
            self.imgWeatherType.image = UIImage.init(named: "Cloudy")
        break
        default:
            self.imgWeatherType.image = UIImage.init(named: "default")
            break
        }
    }
    
    let formatedDate =  self.getFormatedDate(date: obj.dt_txt ?? "")
    self.lblDateTime.text = "\(formatedDate.day)\n\(formatedDate.time)"
    }
    
    func getFormatedDate(date: String) -> (day: String, time: String)
    {
        //2021-05-29 09:00:00
        var day = ""
        var time = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let dateConverted = dateFormatter.date(from: date)
        {
            dateFormatter.dateFormat = "MMM dd"
            day =  dateFormatter.string(from: dateConverted)
            
            dateFormatter.dateFormat = "hh:mma"
            time =  dateFormatter.string(from: dateConverted)
            
        }else
        {
            dateFormatter.dateFormat = "MMM dd"
            day =  dateFormatter.string(from: Date())
            
            dateFormatter.dateFormat = "hh:mm a"
            time =  dateFormatter.string(from: Date())
            
        }
       return (day, time)

    }

}


enum WeatherEnum: String
{
    case cloudy   = "Clouds"
    case clear   = "Clear"
    
}
