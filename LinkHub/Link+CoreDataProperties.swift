//
//  Link+CoreDataProperties.swift
//  LinkHub
//
//  Created by Student on 14/12/15.
//  Copyright © 2015 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Link {

    @NSManaged var url: String?
    @NSManaged var data_criacao: NSDate?
    @NSManaged var pasta: Pasta?

}
