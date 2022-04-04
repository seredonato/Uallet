//
//  WalletAddViewController.swift
//  Uallet
//
//  Created by Serena Donato on 30/03/2022.
//

import UIKit

class WalletAddViewController: UIViewController {
    
    @IBOutlet weak var txtNameWallet: UITextField!
    @IBOutlet weak var txtAmountWallet: UITextField!

    @IBOutlet weak var segmentedCoin: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtnsAddWallet()
    }
    
    
    
    func addBtnsAddWallet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    
    @objc func cancel(){
        dismiss(animated: true)
    }
    
    @objc func saveData(){
        addNewWallet()
    }

    
    @IBAction func addNewWallet() {
        let nameWallet = txtNameWallet.text!
        let amountWallet = txtAmountWallet.text!
        let coinWallet = "lala"
    
        let resultValidateEmptyFields = validateEmptyFields(nameWallet, coinWallet, amountWallet)
        
        if resultValidateEmptyFields{
            let alert = Utils.showAlert(title: "Agregar Wallet", message: "Complete los campos vacíos")
            present(alert, animated: true)
        }else{
            let resultSave = saveWalletInStorage(nameWallet,coinWallet, amountWallet)
            if resultSave{
                dismiss(animated: true)
            }
        }
    }
    

    func saveWalletInStorage(_ nameWallet: String, _ coinWallet: String, _ amountWallet: String)-> Bool {
        let getWallet = Storage.getData(nameKey: nameWallet)
        if getWallet.isEmpty{
            Storage.saveData(value: nameWallet , nameKey: nameWallet)
            Storage.saveData(value: amountWallet , nameKey: amountWallet)
            Storage.saveData(value: coinWallet , nameKey: coinWallet)
            return true
        }else{
            let alert = Utils.showAlert(title: "Agregar Wallet", message: "Oops! Ya existe una Wallet con ese nombre")
            present(alert, animated: true)
            return false
        }
    }

    
    //Empty Fields
    func validateEmptyFields(_ name: String, _ coin: String, _ amount: String) -> Bool{
        name.isEmpty || coin.isEmpty || amount.isEmpty ? true : false
    }
}
