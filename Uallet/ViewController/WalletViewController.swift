//
//  WalletsViewController.swift
//  Uallet
//
//  Created by Serena Donato on 29/03/2022.
//

import UIKit

class WalletViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtnNewWallet()
    }
    
    func addBtnNewWallet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(save))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    @objc func save(){
        goToController(controller: WalletAddViewController())
    }
    
    func goToController(controller: UIViewController){
       let viewController = controller
       present(UINavigationController(rootViewController: viewController), animated: true)
   }
}
