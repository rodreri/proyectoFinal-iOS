//
//  ViewController.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 13/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

class AuthViewController: UIViewController {

    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var registroButton: UIButton!
    @IBOutlet weak var ingresarButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ad = UIApplication.shared.delegate as! AppDelegate
        if ad.internetStatus {
            let ac = UIAlertController(title:"Error", message:"Lo sentimos, pero al parecer no hay conexión a Internet", preferredStyle: .alert)
            let action = UIAlertAction(title: "Enterado", style: .default)
            ac.addAction(action)
            self.present(ac, animated: true)
        }else{
        
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Bienvenido"
        
        //Comprobar la sesion del usuario autenticado
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            authStackView.isHidden = true
            //self.navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
            self.performSegue(withIdentifier: "entrandoSegue", sender: self)
        }
    }

    @IBAction func registrarseButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passTextField.text{
            
            Auth.auth().createUser(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil{
                    
                
                    //self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    
                    self.performSegue(withIdentifier: "entrandoSegue", sender: self)
                    
                    //Guardando datos del usuario
                    let defaults = UserDefaults.standard
                    defaults.set(result.user.email!, forKey: "email")
                    defaults.set("basic", forKey: "provider")
                    defaults.synchronize()
                    
                }else{
                    let ac = UIAlertController(title: "Error", message: "Error al registrar el usuario", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    ac.addAction(action)
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    @IBAction func ingresarButtonAction(_ sender: Any) {
        if let email = emailTextField.text, let password = passTextField.text{
            
            Auth.auth().signIn(withEmail: email, password: password){
                (result, error) in
                
                if let result = result, error == nil{
                    
                    //self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                    self.performSegue(withIdentifier: "entrandoSegue", sender: self)
                    
                    //Guardando datos del usuario
                    let defaults = UserDefaults.standard
                    defaults.set(result.user.email!, forKey: "email")
                    defaults.set("basic", forKey: "provider")
                    defaults.synchronize()
                    
                    
                }else{
                    let ac = UIAlertController(title: "Error", message: "Error, revisa tus datos", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    ac.addAction(action)
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    @IBOutlet weak var googleButtonAction: UIStackView!
    
    
}

