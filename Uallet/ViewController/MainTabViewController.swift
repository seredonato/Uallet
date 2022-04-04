//
//  MainTabViewController.swift
//  Uallet
//
//  Created by Serena Donato on 30/03/2022.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        addTabBar()
    }
    
    func addTabBar() {
        let homeNavigationVC = addNavigationAndTab(controller: HomeViewController(), title: "Home", icon: "house.fill")
        let walletNavigationVC = addNavigationAndTab(controller: WalletViewController(), title: "Wallets", icon: "folder.fill")
        let dashboardNavigationVC = addNavigationAndTab(controller: DashboardViewController(), title: "Dashboard", icon: "chart.pie.fill")
        let infoNavigationVC = addNavigationAndTab(controller: InfoViewController(), title: "Information", icon: "info.circle.fill")
        
        self.tabBar.tintColor = UIColor(named: "SecondaryColor")
        self.viewControllers = [homeNavigationVC, walletNavigationVC, dashboardNavigationVC, infoNavigationVC]
    }
    
    
    func addNavigationAndTab(controller: UIViewController, title: String, icon: String) -> UINavigationController{
        controller.title = title
        let icon = UIImage(systemName: icon)
        let navigationVC = UINavigationController(rootViewController: controller)

        navigationVC.tabBarItem = UITabBarItem(title: title, image: icon, selectedImage: nil)
        
        return navigationVC
    }

}
