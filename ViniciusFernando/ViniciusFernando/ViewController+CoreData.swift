//
//  ViewController+CoreData.swift
//  ViniciusFernando
//
//  Created by Luiza Hruschka on 22/03/20.
//  Copyright © 2020 ViniciusFernando. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
    let appDelegete = UIApplication.shared.delegate as! AppDelegate
    return appDelegete.persistentContainer.viewContext
    }
}
