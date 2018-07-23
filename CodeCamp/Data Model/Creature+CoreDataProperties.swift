//
//  Creature+CoreDataProperties.swift
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//
//

import Foundation
import CoreData


extension Creature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Creature> {
        return NSFetchRequest<Creature>(entityName: "Creature")
    }


}
