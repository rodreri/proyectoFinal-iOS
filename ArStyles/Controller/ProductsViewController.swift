//
//  ProductsViewController.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 25/01/23.
//

import UIKit
import Foundation
import FirebaseFirestore

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var productsList: [Product] = []
    
    let productService = ProductService()
    
    private let db = Firestore.firestore()
    private var emailF: String = ""
    private var providerF: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        self.registerTableViewCells()
        
        print("Llamamos fetch")
        productService.fetch()
        
        self.productService.fetchProducts = {
            DispatchQueue.main.async {
                if let products = self.productService.productList{
                    //print(products)
                    self.productsList = products
                    
                }else{
                    print("Errr")
                }
                print(self.productsList)
                self.tableView.reloadData()
            }
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            self.emailF = email
            self.providerF = provider
        }
                
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productService.productsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell") as? ProductTableViewCell{
            
            cell.priceLabel.text = productsList[indexPath.row].price
            cell.sizeLabel.text = productsList[indexPath.row].size
            cell.typeLabel.text = productsList[indexPath.row].type
            //cell.imgView.image = UIImage(named: "Carpeta")
            switch(productsList[indexPath.row].id){
            case "product01":
                cell.imgView.image = UIImage(named: "Mantel1")
            case "product02":
                cell.imgView.image = UIImage(named: "Mantel2")
            case "product03":
                cell.imgView.image = UIImage(named: "Servilleta")
            case "product04":
                cell.imgView.image = UIImage(named: "Carpeta")
                
            default:
                print("No hay imagen")
            }
            
            
            cell.pedirButton.tag = indexPath.row
            cell.closure = {
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                
                self.db.collection("users").document(self.emailF).collection("pedidos").document().setData([
                    "price": self.productsList[indexPath.row].price,
                    "productid": self.productsList[indexPath.row].id!,
                    "status": "pedido",
                    "time": formatter.string(from: date)
                ])
            }
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "collectionCell")
    }
    

}




/*
 cell.btnActionPedir{
     let date = Date()
     let formatter = DateFormatter()
     formatter.dateFormat = "yyyy/MM/dd HH:mm"
     
     self.db.collection("users").document(self.emailF).collection("pedidos").document().setData([
         "price": self.productsList[indexPath.row].price,
         "productid": self.productsList[indexPath.row].id!,
         "status": "pedido",
         "time": formatter.string(from: date)
     ])
 }
 */
