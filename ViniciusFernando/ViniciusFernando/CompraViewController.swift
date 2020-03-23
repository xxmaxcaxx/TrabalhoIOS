//
//  CompraViewController.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import UIKit

class CompraViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbEstado: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var Cartao: UISwitch!
    @IBOutlet weak var ivCover: UIImageView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbTitle.text = product.title
        lbPreco.text = product.valor
        lbEstado.text = product.state?.name
        Cartao.isOn = product.cartao
        if let image = product.cover as? UIImage {
            ivCover.image = image
        }else {
            ivCover.image = UIImage(named: "noCover")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.product = product
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
