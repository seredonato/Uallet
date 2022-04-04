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
        readValues()
    }
    
    @IBAction func refreshBtn() {
        readValues()
    }
    
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblDolarOfficialBuy: UILabel!
    @IBOutlet weak var lblDolarOfficialSale: UILabel!
    @IBOutlet weak var lblDolarBlueBuy: UILabel!
    @IBOutlet weak var lblDolarBlueSale: UILabel!
    @IBOutlet weak var lblBitcoinPrice: UILabel!
    
    func readValues() {
        activityLoading.isHidden = false
        activityLoading.startAnimating()
        
        firstly {
            when(fulfilled:
                    APIValuesPromises.bitcoinRatePromises(),
                 APIValuesPromises.dolarOfficialBuyRatePromises(),
                 APIValuesPromises.dolarOfficialSaleRatePromises(),
                 APIValuesPromises.dolarBlueBuyRatePromises(),
                 APIValuesPromises.dolarBlueSaleRatePromises()
            )
            
        }
        .done { rates in
            self.lblBitcoinPrice.text = "$\(rates.0)"
            self.lblDolarOfficialBuy.text = "$\(rates.1)"
            self.lblDolarOfficialSale.text = "$\(rates.2)"
            self.lblDolarBlueBuy.text = "$\(rates.3)"
            self.lblDolarBlueSale.text = "$\(rates.4)"
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
