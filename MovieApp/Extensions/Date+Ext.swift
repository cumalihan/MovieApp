//
//  Date+Ext.swift
//  MovieApp
//
//  Created by Cumali Han Ünlü on 2.09.2022.
//

import Foundation

extension Date {
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
}
