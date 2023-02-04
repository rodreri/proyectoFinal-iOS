//
//  ProductsService.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 25/01/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreData

class ProductService {
    
    let db = Firestore.firestore()
    
    var fetchProducts : (() -> ()) = { }

    private var products: [Product] = []
    
    var productList: [Product]? {
        didSet {
            fetchProducts()
        }
    }
    
    func fetch(){
        print("Obteniendo products...")
        db.collection("products").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                print("Deserializando...")
                DispatchQueue.main.async {
                    for document in querySnapshot!.documents {
                        do {
                            var product = try document.data(as: Product.self)
                            product.id = document.documentID
                            self.products.append(product)                            
                        } catch {
                            print("Error en la conversión: \(error)")
                        }
                    }
                    self.productList = self.products
                }
            }
        }
    }
    
    func productsCount() -> Int{
        return products.count
    }
    
    func producAt(index: Int) -> Product{
        return products[index]
    }
    
    func getproducts() -> [Product]{
        print(self.products)
        return products
    }
}





/*db.collection("products").getDocuments() { (querySnapshot, err) in
    if let err = err {
        print("Error getting documents: \(err)")
    } else {
        for document in querySnapshot!.documents {
            //print("\(document.documentID) => \(document.data())")
            //print("Leegue a fetch")
            //self.fetchBook(documentId: document.documentID)
            do {
                let book = try document.data(as: Product.self)
                print("App end...")
                //print(book)
                productsss.append(book)
                //print(self.products)
            } catch {
              print(error)
            }
        }
        print("Terminando el for dentro de fetch")
        print(productsss)
        self.products = productsss
    }
}
print("Terminando el fetch")
print(self.products)
 
 
 let productsCollection = self.db.collection("products")
 productsCollection.getDocuments(completion: {snapshot, error in
     if let err = error{
         print(err.localizedDescription)
         return
     }
     
     guard let prod = snapshot?.documents else {return}
     
     for product in prod {
         do {
             let book = try product.data(as: Product.self)
             print("App end...")
             //print(book)
             self.products.append(book)
             //print(self.products)
         } catch {
           print(error)
         }
     }
     completion(self.products)
 })
 
 
 
 */
