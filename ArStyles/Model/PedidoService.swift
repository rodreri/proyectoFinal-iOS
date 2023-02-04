//
//  PedidoService.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 04/02/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreData

class PedidoService {
    
    let db = Firestore.firestore()
    
    
    var fetchPedido : (() -> ()) = {}
    
    private var pedidos : [Pedido] = []
    
    private var emailF = ""
    private var providerF = ""
    
    
    var pedidoList: [Pedido]? {
        didSet {
            fetchPedido()
        }
    }
    
    func fetch(){
        print("Obteniendo Pedidos")
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String {
            self.emailF = email
            self.providerF = provider
        }
        
        db.collection("users").document(emailF).collection("pedidos").getDocuments(){ (querySnapshot, err) in
            if let err = err{
                print("Error: \(err)")
            }else{
                print("Deserializando...")
                DispatchQueue.main.async {
                    for document in querySnapshot!.documents{
                        do{
                            var pedido = try document.data(as: Pedido.self)
                            self.pedidos.append(pedido)
                        }catch{
                            print("Error en la conversion: \(error)")
                        }
                    }
                    self.pedidoList = self.pedidos
                }
            }
            
        }
    }
    
    func pedidosCount() -> Int{
        return pedidos.count
    }
    
    func pedidosAt(index: Int) -> Pedido{
        return pedidos[index]
    }
    
    func getPedidos() -> [Pedido]{
        return pedidos
    }
}
