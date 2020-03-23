//
//  CompraTableViewCell.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import UIKit

class CompraTableViewCell: UITableViewCell {

    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Product){
        lbTitle.text = product.title
        lbPrice.text = product.valor
        if let image = product.cover as? UIImage{
            ivCover.image = image
        }else{
            ivCover.image = UIImage(named: "noCover")
        }
    }

}
