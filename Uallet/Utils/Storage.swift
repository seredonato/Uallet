//
//  Storage.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import Foundation

class Storage{
    
    static func saveData(value: String, nameKey: String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: nameKey)
    }
    
    static func saveStatusLogIn(value: Bool){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "logueado")
    }
    
    static func getData(nameKey: String)->String{
        let defaults = UserDefaults.standard
        let result = defaults.string(forKey: nameKey)
    
        return result == nil ? "" : result!
    }
    
    static func saveDate(value: Date){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "Date")
    }
}
