//
//  Utils.swift
//  Uallet
//
//  Created by Serena Donato on 31/03/2022.
//

import Foundation
import UIKit

class Utils{
    
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let accept = UIAlertAction(title: "Aceptar", style: .default)
        
        alert.addAction(accept)
        
        return alert
    }
    
  
        
}
