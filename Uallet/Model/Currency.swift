//
//  Currency.swift
//  Uallet
//
//  Created by Serena Donato on 05/04/2022.
//

import Foundation

enum Currency: String, Codable{
    case Peso = "pesos"
    case Dollar = "dolares"
    case Bitcoin = "bitcoin"
    
    
    static func from(index: Int) -> Currency {
        switch index {
        case 0:
            return .Bitcoin
        case 1:
            return .Dollar
        default:
            return .Peso
        }
    }
}
