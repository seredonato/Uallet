//
//  Wallet.swift
//  Uallet
//
//  Created by Serena Donato on 05/04/2022.
//

import Foundation

struct Wallet: Codable, Equatable{
    var name: String
    var balance: Double
    var currency: Currency
    
    
    static func == (w1: Wallet, w2: Wallet) -> Bool {
        return w1.name == w2.name
    }
}
