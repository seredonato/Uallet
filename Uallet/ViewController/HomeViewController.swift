//
//  HomeViewController.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lblInfo: UILabel!
    //comentario prueba
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        addBtnLogout()
        
        updateInfo()
        
        WalletsStorage.shared.addDataChanged {
            self.updateInfo()
        }
    }
    
    func updateInfo() {
        lblInfo.text = "Hay \(WalletsStorage.shared.wallets.count) wallet(s)"
    }
    
    func addBtnLogout(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    @objc func logout() {
        UserDefaults.standard.set(false, forKey: "logueado")
        dismiss(animated: true)
    }
    
}
