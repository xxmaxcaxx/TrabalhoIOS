//
//  StateManager.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import Foundation
import CoreData

class StateManager {
  static let shared = StateManager()
    var states: [State] = []
    
    func loadStates(with context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            states = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext) {
        let state = states[index]
        context.delete(state)
        do{
        try context.save()
            states.remove(at: index)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private init(){
        
    }
}
