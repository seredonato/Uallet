//
//  ViewController.swift
//  Uallet
//
//  Created by Serena Donato on 25/03/2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "logueado"){
            goToHome(animated: false)
        }
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        do{
            try API.logIn(txtUser.text!, txtPassword.text!) { logueado in
                if logueado {
                    goToHome()
                }else{
                    let alert = Utils.showAlert(title: "Log In", message: "Oops! Las credenciales son inválidas. Intente nuevamente.")
                    present(alert, animated: true)
                }
            }
        }catch APIError.UserIncomplete {
            let alert = Utils.showAlert(title: "Log In", message: "No se ingresó el usuario correctamente")
            present(alert, animated: true)
        } catch APIError.PasswordIncomplete {
            let alert = Utils.showAlert(title: "Log In", message: "No se ingresó la contraseña correctamente")
            present(alert, animated: true)
        } catch {
            let alert = Utils.showAlert(title: "Log In", message: "Error desconocido")
            present(alert, animated: true)
        }
    }
    
    @IBAction func switchAutoComplete() {
        txtUser.text = "admin"
        txtPassword.text = "123456"
    }
    
    
    func goToHome(animated isAnimated: Bool = true) {
        let homeVC = MainTabViewController()
        homeVC.modalTransitionStyle = .coverVertical
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: isAnimated)
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "logueado")
    }
    
    // MARK: - Disabled Rotation
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    // MARK: - Keyboard Off
    @IBAction func tapBackground(_ sender: Any) {
        txtUser.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

