//
//  ProductModel.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 25/01/23.
//

import Foundation

public struct Product: Codable{
    var id: String?
    var color: String
    var image: String
    var price: String
    var size : String
    var type : String
    
    enum CodingKeys: String, CodingKey{
        case id
        case color
        case image
        case price
        case size
        case type
    }
}
