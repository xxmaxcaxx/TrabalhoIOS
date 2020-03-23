//
//  AddEditViewController.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var tfTittle: UITextField!
    @IBOutlet weak var tfEstado: UITextField!
    @IBOutlet weak var tfPreco: UITextField!
    @IBOutlet weak var Cartao: UISwitch!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btCover: UIButton!
    @IBOutlet weak var ivCover: UIImageView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfEstado.inputView = pickerview
        tfEstado.inputAccessoryView = toolbar
        
        if product != nil{
            title = "Editar Compra"
            btAddEdit.setTitle("ALTERAR", for: .normal)
            tfTittle.text = product.title
            tfPreco.text = product.valor
            Cartao.isOn = product.cartao
            if let state = product.state, let index = stateManager.states.index(of: state){
                tfEstado.text = state.name
                pickerview.selectRow(index, inComponent: 0, animated: false)
            }
            ivCover.image = product.cover as? UIImage
            if product.cover != nil {
                btCover.setTitle(nil, for: .normal)
            }
        }
    }
    
    @objc func cancel(){
        tfEstado.resignFirstResponder()
    }
    
    @objc func done(){
        
        tfEstado.text = stateManager.states[pickerview.selectedRow(inComponent: 0)].name
        
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateManager.loadStates(with: context)
    }
    
    lazy var pickerview: UIPickerView = {
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        pickerview.backgroundColor = .white
        return pickerview
    }()
    var stateManager = StateManager.shared
    
    @IBAction func addEditCompra(_ sender: Any) {
        if product == nil {
            product = Product(context: context)
        }
        product.title = tfTittle.text
        product.valor = tfPreco.text
        product.cartao = Cartao.isOn
        if !tfEstado.text!.isEmpty{
            let state = stateManager.states[pickerview.selectedRow(inComponent: 0)]
            product.state = state
        }
        product.cover = ivCover.image
        do{
        try context.save()
        } catch{
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddEditCover(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar Imagem", message: "De onde você quer escolher a imagem?", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) {(action: UIAlertAction) in self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        let photoAction = UIAlertAction(title: "Album de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photoAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        present(imagePicker, animated: true, completion: nil)
    }
}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return stateManager.states.count
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = stateManager.states[row]
        return state.name
    }
    }

extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ivCover.image = image
        btCover.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
