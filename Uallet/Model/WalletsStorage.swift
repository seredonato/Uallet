//
//  WalletsStorage.swift
//  Uallet
//
//  Created by Serena Donato on 05/04/2022.
//

import Foundation

class WalletsStorage{
    
    static var shared = WalletsStorage()

    var wallets: [Wallet] = []
        
    func add(_ wallet: Wallet) {
        wallets.append(wallet)
        Storage.saveData(value: "$\(wallet.balance) \(wallet.currency.rawValue)", nameKey: wallet.name)
    }
}
