//
//  Car.swift
//  KeyArchiverExercise
//
//  Created by Wismin Effendi on 6/20/17.
//  Copyright © 2017 iShinobi. All rights reserved.
//

import UIKit

class Car: NSObject, NSCoding {
    
    var make: String
    var model: String
    var year: Int
    var color: String
    
    init(make: String, model: String, year: Int, color: String) {
        self.make = make
        self.model = model
        self.year = year
        self.color = color
    }
    
    // MARK: - for compliance with NSCoding 
    required convenience init?(coder aDecoder: NSCoder) {
        guard let make = aDecoder.decodeObject(forKey: "make") as? String,
            let model = aDecoder.decodeObject(forKey: "model") as? String,
            let color = aDecoder.decodeObject(forKey: "color") as? String
            else { return nil }
        
        self.init(make: make, model: model, year: aDecoder.decodeInteger(forKey: "year"), color: color)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.make, forKey: "make")
        aCoder.encode(self.model, forKey: "model")
        aCoder.encode(self.year, forKey: "year")
        aCoder.encode(self.color, forKey: "color")
    }

    override var description: String {
        return "\(color) \(year) \(make) \(model)"
    }
}


struct CarsIterator: IteratorProtocol {
    let makes = ["Audi", "BMW", "Tesla", "Mini"]
    let makesModels = [
        "Audi" : ["A3", "A4", "A6", "RS 7", "Q3", "Q5", "SQ5", "Q7"],
        "BMW" : ["Series 2", "Series 3", "Series 4", "Series 5", "Series 6", "Series 7", "X", "Z4", "M" ],
        "Tesla" : [ "Model S", "Model X", "Model 3"],
        "Mini" : [ "HardTop", "CountryMan", "ClubMan", "Convertible"]
    ]
    let years = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018]
    let colors = ["White", "Silver", "Black", "Grey", "Blue", "Red", "Brown", "Green"]
    
    mutating func next() -> Car? {
        let make = makes[Int(arc4random_uniform(UInt32(makes.count)))]
        let makeModels = makesModels[make]!
        let model = makeModels[Int(arc4random_uniform(UInt32(makeModels.count)))]
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let year = years[Int(arc4random_uniform(UInt32(years.count)))]
        let car = Car(make: make, model: model, year: year, color: color)
        return car
    }
    
}
