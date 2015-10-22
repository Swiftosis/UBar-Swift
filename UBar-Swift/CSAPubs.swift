//
//  CSAPubs.swift
//  UBar-Swift
//
//  Created by Bettina Hegedus on 2015. 10. 22..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import Foundation

class CSAPubs {
    var name:String?
    var city:String?
    var street:String?
    var number:Int?
    var imageName:String?
    
    init(name:String? ,city:String?, street:String?, number:Int?, imageName:String?) {
        
        self.name = name
        self.city = city
        self.street = street
        self.number = number
        self.imageName = imageName
    }
}
