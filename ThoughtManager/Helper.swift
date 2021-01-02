//
//  Helper.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//
import SwiftUI
import Amplify


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

func stringFromDate(_ date: Date, format: String = "yyyy-MM-dd") -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = format
    return formatter.string(from: date)
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
            .padding(0)
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
            .font(.custom("Helvetica Neue", size: 15))
            .frame(height: 25)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.purple, lineWidth: 0))
    }
}

struct CompactTextInfo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .foregroundColor(Color.purple)
            .cornerRadius(0)
            .font(.custom("Helvetica Neue", size: 15))
            .font(.caption)
            .frame(height: 25)
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
    func textCompactInfoStyle() -> some View {
        self.modifier(CompactTextInfo())
    }
    
}

