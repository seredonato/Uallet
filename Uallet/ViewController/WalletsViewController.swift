//
//  WalletsViewController.swift
//  Uallet
//
//  Created by Serena Donato on 05/04/2022.
//

import UIKit

class WalletsViewController: UITableViewController {
        
    let cellIdentifier = "celdaWallets"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.clearsSelectionOnViewWillAppear = false
        addBtnNewWallet()
        
        let nib = UINib(nibName: "WalletViewCell", bundle: nil)
                tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WalletsStorage.shared.wallets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! WalletViewCell
        
        let wallet = WalletsStorage.shared.wallets[indexPath.row]
                
        cell.textLabel!.text = wallet.name

        return cell
    }
    
    
    // MARK: - Events of UI
    
    func addBtnNewWallet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(save))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    @objc func save(){
        let addVC = WalletAddViewController()
        addVC.set { grabo in
            if grabo {
                self.tableView.reloadData()
            }
        }
        present(UINavigationController(rootViewController: addVC), animated: true)
    }
}
