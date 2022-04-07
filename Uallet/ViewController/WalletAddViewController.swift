//
//  WalletAddViewController.swift
//  Uallet
//
//  Created by Serena Donato on 30/03/2022.
//

import UIKit

class WalletAddViewController: UIViewController {
    
    @IBOutlet weak var txtNameWallet: UITextField!
    @IBOutlet weak var txtBalanceWallet: UITextField!
    @IBOutlet weak var selectedCurrency: UISegmentedControl!
    var callback: ((Bool) -> Void)?
    
    func set(callback: @escaping (Bool)->Void) {
        self.callback = callback
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtnsWallet()
    }


    
    // MARK: - Btn of Add Wallet
    
    @IBAction func addNewWallet() {
        let nameWallet = txtNameWallet.text!
        let balanceWallet = txtBalanceWallet.text!
        let currency = Currency.from(index: selectedCurrency.selectedSegmentIndex)
        
        let resultValidateEmptyFields = validateEmptyFields(nameWallet, balanceWallet)
        
        if resultValidateEmptyFields{
            let alert = Utils.showAlert(title: "Agregar Wallet", message: "Complete los campos vacíos")
            present(alert, animated: true)
        }else{
            let resultSave = saveWalletInStorage(nameWallet, currency, balanceWallet)
            if resultSave{
                dismiss(animated: true)
                if let callback = callback {
                    callback(true)
                }
            }
        }
    }
    
    func saveWalletInStorage(_ nameWallet: String, _ currencyWallet: Currency, _ balanceWallet: String)-> Bool {
        let getWallet = Storage.getData(nameKey: nameWallet)
        if getWallet.isEmpty{
            let wallet = Wallet(name: nameWallet, balance: Double(balanceWallet) ?? 0, currency: currencyWallet)
            WalletsStorage.shared.add(wallet)
            return true
        }else{
            let alert = Utils.showAlert(title: "Agregar Wallet", message: "Oops! Ya existe una Wallet con ese nombre")
            present(alert, animated: true)
            return false
        }
    }
    
    
    
    // MARK: - Events of UI
    
    func addBtnsWallet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    
    @objc func cancel(){
        dismiss(animated: true)
        
        if let callback = callback {
            callback(false)
        }
    }
    
    @objc func save(){
        addNewWallet()
    }
    
    
    // MARK: - EmptyFields
    func validateEmptyFields(_ name: String, _ balance: String) -> Bool{
        name.isEmpty || balance.isEmpty ? true : false
    }
}
