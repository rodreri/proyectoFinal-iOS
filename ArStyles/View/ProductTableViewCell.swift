//
//  ProductTableViewCell.swift
//  ArStyles
//
//  Created by Erick Rodrigo Minero Pineda on 01/02/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pedirButton: UIButton!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var closure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionPedir(_ sender: UIButton) {
        closure?()
    }
}
