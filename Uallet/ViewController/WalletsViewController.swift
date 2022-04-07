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
        
        WalletsStorage.shared.addDataChanged {
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wallet = WalletsStorage.shared.wallets[indexPath.row]
        
        let detailsVC = WalletDetailsViewController()
        detailsVC.wallet = wallet
        detailsVC.indexPath = indexPath.row
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WalletsStorage.shared.wallets.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! WalletViewCell
        
        let wallet = WalletsStorage.shared.wallets[indexPath.row]
                
        cell.lblName!.text = wallet.name
        let icon = currencyIcon(wallet.currency)
        cell.currencyIcon.image = icon
        cell.lblBalance!.text = String(wallet.balance)

        return cell
    }
    
    
    // MARK: - Events of UI
    
    func addBtnNewWallet(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(save))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
    }
    
    @objc func save(){
        let addVC = WalletAddViewController()
        present(UINavigationController(rootViewController: addVC), animated: true)
    }
    
    
    func currencyIcon(_ currency: Currency) -> UIImage{
        switch currency {
        case .Peso:
            return UIImage(systemName: "parkingsign.circle.fill")!
        case .Dollar:
            return UIImage(systemName: "dollarsign.circle.fill")!
        default:
            return UIImage(systemName: "bitcoinsign.circle.fill")!
        }
    }
}
