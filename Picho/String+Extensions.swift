//
//  String+Extensions.swift
//  Picho
//
//  Created by Windy on 15/11/20.
//

import UIKit

extension String {
    func changeToDate() -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        
        return dateFormat.date(from: self)!
    }
    func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.date(from: self) ?? Date()
    }
}
