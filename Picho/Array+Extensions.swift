//
//  Array+Extensions.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

import Foundation

extension Array {
    
    func convertToString() -> String {
        var container: String = ""
        
        self.forEach { (string) in
            container.append("\(string) \n")
        }
        
        return container
    }
    
}
