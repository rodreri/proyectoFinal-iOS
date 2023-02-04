//
//  Pedido.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 04/02/23.
//

import Foundation

public struct Pedido: Codable{
    var id: String?
    var price: String
    var productid: String
    var status: String
    var time: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case price
        case productid
        case status
        case time
    }
}
