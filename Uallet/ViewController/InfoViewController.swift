//
//  InfoViewController.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import UIKit

import Alamofire
import PromiseKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readRates()
    }
    
    @IBAction func refreshBtn() {
        readRates()
    }
    
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblDolarOfficialBuy: UILabel!
    @IBOutlet weak var lblDolarOfficialSale: UILabel!
    @IBOutlet weak var lblDolarBlueBuy: UILabel!
    @IBOutlet weak var lblDolarBlueSale: UILabel!
    @IBOutlet weak var lblBitcoinPrice: UILabel!
    
    func readRates() {
        activityLoading.isHidden = false
        activityLoading.startAnimating()
        
        firstly {
            when(fulfilled:
                    APIRatePromises.bitcoinRatePromises(),
                 APIRatePromises.dolarOfficialRatePromises(),
                 APIRatePromises.dolarBlueRatePromises()
            )
            
        }
        .done { rates in
            self.lblBitcoinPrice.text = "$\(rates.0)"
            self.lblDolarOfficialBuy.text = "$\(rates.1.buy)"
            self.lblDolarOfficialSale.text = "$\(rates.1.sale)"
            self.lblDolarBlueBuy.text = "$\(rates.2.buy)"
            self.lblDolarBlueSale.text = "$\(rates.2.sale)"
        }
        .catch { error in
            self.lblErrorMessage.isHidden = false
        }
        .finally {
            self.activityLoading.stopAnimating()
            self.activityLoading.isHidden = true
        }
    }
}
