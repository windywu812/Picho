//
//  DailyIntake+Extensions.swift
//  Picho
//
//  Created by Wendy Kurniawan on 15/11/20.
//

import Foundation
import CoreData

extension Array where Element == DailyIntake {
    func count() {
        let groupArgument = NSExpression(forKeyPath: "foodId")
        let expression = NSExpression(forFunction: "count:", arguments: [groupArgument])
        
        let countDesc = NSExpressionDescription()
        countDesc.expression = expression
        countDesc.name = "count"
        countDesc.expressionResultType = .integer64AttributeType
    }
}
