//
//  PedidoTableViewCell.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 03/02/23.
//

import UIKit

class PedidoTableViewCell: UITableViewCell {
    @IBOutlet weak var idProducto: UILabel!
    @IBOutlet weak var priceProducto: UILabel!
    
    @IBOutlet weak var timePedido: UILabel!
    @IBOutlet weak var statusPedido: UILabel!
    
    @IBOutlet weak var imgProducto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
