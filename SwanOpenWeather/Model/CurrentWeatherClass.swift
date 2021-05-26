//  CurrentWeatherClass.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 24/05/2021.

import Foundation
struct CurrentWeatherClass : Codable {
	
	let weather : [Weather]?
	let main : Main?
	let wind : Wind?
	let name : String?
	let cod : Int?

	enum CodingKeys: String, CodingKey {

		case weather = "weather"
		case main = "main"
		case wind = "wind"
		case name = "name"
		case cod = "cod"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
		main = try values.decodeIfPresent(Main.self, forKey: .main)
		wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		cod = try values.decodeIfPresent(Int.self, forKey: .cod)
	}

}
