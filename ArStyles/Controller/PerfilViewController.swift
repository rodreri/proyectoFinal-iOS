//
//  PerfilViewController.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 21/01/23.
//

import Foundation

//
//  HomeViewController.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 13/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var closeSessionButton: UIButton!
    
    @IBOutlet weak var addresTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var emailFinal: String = ""
    private var providerFinal: String = ""
    
    
    
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            
            emailLabel.text = email
            emailFinal = email
            providerFinal = provider
        }
        
        //Recuperando datos de usuario
        db.collection("users").document(emailFinal).getDocument { documentSnapshot, error in
            if let document = documentSnapshot, error == nil {
                if let addres = document.get("addres") as? String {
                    self.addresTextField.text = addres
                }else{
                    self.addresTextField.text = ""
                }
                if let phone = document.get("phone") as? String {
                    self.phoneTextField.text = phone
                }else{
                    self.phoneTextField.text = ""
                }
            }else{
                self.addresTextField.text = ""
                self.phoneTextField.text = ""
            }
        }
        
    }
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        do{
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch{
            // Se ha producifo un error
        }

    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        view.endEditing(true)
        db.collection("users").document(emailFinal).setData([
        "provider":providerFinal,
        "addres":addresTextField.text ?? "",
        "phone":phoneTextField.text ?? ""
        ])
    }
    
    //De momento no se utiliza
    @IBAction func getButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(emailFinal).getDocument { documentSnapshot, error in
            if let document = documentSnapshot, error == nil {
                if let addres = document.get("addres") as? String {
                    self.addresTextField.text = addres
                }else{
                    self.addresTextField.text = ""
                }
                if let phone = document.get("phone") as? String {
                    self.phoneTextField.text = phone
                }else{
                    self.phoneTextField.text = ""
                }
            }else{
                self.addresTextField.text = ""
                self.phoneTextField.text = ""
            }
        }
    }
    
    // De momento no se utiliza
    @IBAction func deleteButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        db.collection("users").document(emailFinal).delete()
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        do{
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch{
            // Se ha producifo un error
        }
    }
    
}



