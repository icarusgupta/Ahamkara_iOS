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
    @Published var userActivityData: [(RecordType, RecordType)] = []
    @Published var userThoughtData: [(RecordType, RecordType)] = []
    
    func userPatternData(recordTypeName: String) -> [(RecordType, RecordType)]{
        if recordTypeName == UserPatternType.Activity.rawValue{
            return userActivityData
        }
        else{
            return userThoughtData
        }
    }
    
    func resetUserPatternData(recordTypeName: String){
        if recordTypeName == UserPatternType.Activity.rawValue{
            userActivityData = []
        }
        else{
            userThoughtData = []
        }
    }

    func appendUserPatternData(recordTypeName: String, value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            userActivityData.append(value)
        }
        else{
            userThoughtData.append(value)
        }
    }
    
    func setValueUserPatternData(recordTypeName: String, index: Int, value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            userActivityData[index] = value
        }
        else{
            userThoughtData[index] = value
        }
    }

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

