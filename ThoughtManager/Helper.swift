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
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

class UserSettings: ObservableObject {
    @Published var score = 0
    @Published public var enteredRecordAndScoreList: [(RecordType, RecordType)] = []
}

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}


