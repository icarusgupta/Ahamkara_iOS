//
//  Helper.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//
import SwiftUI

class Helper{
    static var app: Helper = {
        return Helper()
    }()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

