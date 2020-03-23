//
//  PrecoTableViewController.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import UIKit
import CoreData

class PrecoTableViewController: UITableViewController {

    @IBOutlet weak var cotacao: UITextField!
    @IBOutlet weak var iof: UITextField!
    
    var stateManager = StateManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStates()
        
        let cotacaoDefaults = UserDefaults.standard
        cotacao.text = cotacaoDefaults.object(forKey: "COTACAO") as? String
        iof.text = cotacaoDefaults.object(forKey: "IOF") as? String
    }

    func loadStates(){
        stateManager.loadStates(with: context)
        tableView.reloadData()
    }
    
    @IBAction func addPrice2(_ sender: UIButton) {
        showAlert(with: nil)
    }
    @IBAction func addPrice(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    func showAlert(with state: State?){
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " Estado", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do Estado"
            if let name = state?.name {
                textField.text = name
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
            if let imposto = state?.imposto {
                textField.text = imposto
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? State(context: self.context)
            state.name = alert.textFields?.first?.text
            state.imposto = alert.textFields?.last?.text
            do{
                try self.context.save()
                self.loadStates()
            }catch{
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateManager.states.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let state = stateManager.states[indexPath.row]
        showAlert(with: state)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            stateManager.deleteState(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let state = stateManager.states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.imposto
        cell.detailTextLabel?.textColor = UIColor.red
        
        return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
