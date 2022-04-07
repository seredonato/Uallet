//
//  WalletDetailsViewController.swift
//  Uallet
//
//  Created by Serena Donato on 06/04/2022.
//

import UIKit

class WalletDetailsViewController: UIViewController {

    @IBOutlet weak var txtBalance: UITextField!
    @IBOutlet weak var lblCurrency: UILabel!
    
    var wallet: Wallet?
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = wallet?.name
        
        txtBalance.text = "\(wallet!.balance)"
        lblCurrency.text = wallet?.currency.rawValue
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        WalletsStorage.shared.editBalance(wallet: self.wallet!, balance: Double(txtBalance.text!) ?? 0)
    }
    

    @IBAction func removeWallet(_ sender: Any) {
        let alert = UIAlertController(title: "Eliminar Wallet", message: "¿Estás seguro/a que querés eliminar la wallet? No se puede recuperar", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { _ in
                 WalletsStorage.shared.delete(wallet: self.wallet!)
                 self.navigationController?.popViewController(animated: true)
             }))
             alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
             present(alert, animated: true)
    }
    
}
