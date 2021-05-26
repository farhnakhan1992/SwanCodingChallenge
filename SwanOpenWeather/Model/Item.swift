//
//  Item.swift
//  SwanOpenWeather
//
//  Created by Farhan Khan on 25/05/2021.

import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
