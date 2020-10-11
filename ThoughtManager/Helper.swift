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

struct TextButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
    }
}

struct TextInput: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(Color.orange)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.purple, lineWidth: 5))
    }
}

struct TextInfo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(Color.purple)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.purple, lineWidth: 0))
    }
}


extension View {
    func textButtonStyle() -> some View {
        self.modifier(TextButton())
    }
    func textInputStyle() -> some View {
        self.modifier(TextInput())
    }
    func textInfoStyle() -> some View {
        self.modifier(TextInfo())
    }
}

