//
//  PedidosViewController.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 02/02/23.
//

import UIKit
import Foundation
import FirebaseFirestore

class PedidosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var pedidosList: [Pedido] = []
    
    let pedidoService = PedidoService()
    
    private let db = Firestore.firestore()
    private var emailF: String = ""
    private var providerF: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        self.registerTableViewCells()
        
        print("Llamamos a fetch")
        pedidoService.fetch()
        
        self.pedidoService.fetchPedido = {
            DispatchQueue.main.async {
                if let pedidos = self.pedidoService.pedidoList{
                    self.pedidosList = pedidos
                }else{
                    print("Error")
                }
                print(self.pedidosList)
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
        return pedidoService.pedidosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pedidoCell") as? PedidoTableViewCell{
            
            cell.priceProducto.text = "Precio: " + pedidosList[indexPath.row].price
            cell.idProducto.text = "ID: " + pedidosList[indexPath.row].productid
            cell.statusPedido.text = "Estatus: " + pedidosList[indexPath.row].status
            cell.timePedido.text = "Pedido el " + pedidosList[indexPath.row].time
            
            switch(pedidosList[indexPath.row].productid){
            case "product01":
                cell.imgProducto.image = UIImage(named: "Mantel1")
            case "product02":
                cell.imgProducto.image = UIImage(named: "Mantel2")
            case "product03":
                cell.imgProducto.image = UIImage(named: "Servilleta")
            case "product04":
                cell.imgProducto.image = UIImage(named: "Carpeta")
                
            default:
                print("No hay imagen")
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "PedidoTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "pedidoCell")
    }

}
