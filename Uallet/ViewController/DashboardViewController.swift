//
//  DashboardsViewController.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import UIKit
import PromiseKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var lblBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WalletsStorage.shared.addDataChanged {
            self.updateBalance()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // actualizar balance si hubiera cambio en cotizaciones
        updateBalance() // por si cambian las cotizaciones
    }
    
    func updateBalance() {
        self.lblBalance.text = "⌛️"
        firstly {
            when(fulfilled:
                    APIRatePromises.bitcoinRatePromises(),
                 APIRatePromises.dolarBlueRatePromises(),
                 WalletsStorage.shared.walletsPromise()
            )
        }
        .done { (rateBitcoin, rateDolarBlue, wallets) in
            var suma: Double = 0
            for wallet in wallets {
                switch wallet.currency {
                case .Peso:
                    suma += wallet.balance / rateDolarBlue.buy
                case .Dollar:
                    suma += wallet.balance
                case .Bitcoin:
                    suma += wallet.balance * rateBitcoin
                }
            }
            self.lblBalance.text = "USD$ \(Int(suma))"
            
            
        }
        .catch { error in
            self.lblBalance.text = "Error"
        }
    }
}
