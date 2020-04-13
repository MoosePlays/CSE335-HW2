//
//  cities.swift
//  simonsonLab4
//
//  Created by mjsimons on 2/27/20.
//  Copyright © 2020 mjsimons. All rights reserved.
//

import Foundation
import UIKit

class cities {
    
    var cities:[city] = []
    var sortedFirstLetters: [String] = []
    var sections: [[city]] = [[]]
    
    init(){
        let c1 = city(cn: "Bend", cd: "TEMP", ci: UIImage(named: "bend.jpg")!)
        let c2 = city(cn: "Benicia", cd: "TEMP", ci: UIImage(named: "benicia.jpg")!)
        let c3 = city(cn: "Los Angeles", cd: "TEMP", ci: UIImage(named: "la.jpg")!)
        let c4 = city(cn: "Paris", cd: "TEMP", ci: UIImage(named: "paris.jpg")!)
        let c5 = city(cn: "Tempe", cd: "TEMP", ci: UIImage(named: "tempe.jpg")!)
        
        cities.append(c1)
        cities.append(c2)
        cities.append(c3)
        cities.append(c4)
        cities.append(c5)
        
        sortEverything()
    }
    
    // sorts and sets sections
    func sortEverything(){
        let firstLetters = cities.map { $0.cityFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))
        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return cities
                .filter { $0.cityFirstLetter == firstLetter }
                .sorted { $0.cityName! < $1.cityName! }
        }
    }
    
    //sets the number of rows in a particular section
    func getRowCount(section: Int) -> Int{
        return sections[section].count
    }
    
    //sets the number of sections
    func getSectionCount() -> Int{
        return sections.count
    }
    
    //not needed since we are using sections atm
    /*func getCount() -> Int{
        return cities.count
    }*/
    
    //return city object
    func getCityObject(section: Int, row: Int) -> city{
        return sections[section][row]
    }
    
    //remove city from list
    func removeCityObject(section:Int, row: Int) {
        let temp = sections[section][row]
        if let index = cities.firstIndex(where: { $0.cityName == temp.cityName}){
            cities.remove(at: index)
        }
    }
    
    //add city object to list, update
    func addCityObject(name:String, desc:String, image:UIImage){
        let c = city(cn: name, cd: "Empty Description", ci: UIImage(named: "questionMark.jpg")!)
        cities.append(c)
        sortEverything()
    }
    
}

class city {
    var cityName:String?
    var cityDescription:String?
    var cityImage:UIImage?
    
    init(cn:String, cd:String, ci:UIImage){
        cityName = cn
        cityDescription = cd
        cityImage = ci
    }
    
    var cityFirstLetter: String{
        return String((self.cityName![self.cityName!.startIndex])).uppercased()
    }
}
