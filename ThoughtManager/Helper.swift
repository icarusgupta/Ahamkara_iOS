//
//  Helper.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 07/10/2020.
//
import SwiftUI
import Amplify

enum DbOperation: String{
    case Create, Update, Delete
}

class DbUtils{
    
    class func getDailyKey(date: Date, pattern: String, score: String) -> String{
        let user = UIDevice.current.name
        return stringFromDate(date) + "." + user + "." + pattern + "." + score
    }
        
    func persistData(genericRecord: GenericRecord,
                     dbOperation: DbOperation,
                     patternScoreList: [(RecordType, RecordType)]) {
        patternScoreList.forEach {
            let pattern = $0.0
            let score = $0.1
            let user = UIDevice.current.name
            let date = Temporal.Date(genericRecord.curDate)
            let rec = RecordDS(dailyKey: DbUtils.getDailyKey(date: genericRecord.curDate,
                                                       pattern: genericRecord.genericRecordModel.name,
                                                       score: genericRecord.genericRecordModel.scoreName),
                               date: date,
                               username: user,
                               pattern: genericRecord.genericRecordModel.name,
                               score: genericRecord.genericRecordModel.scoreName,
                               patternName: pattern.name,
                               scoreName: score.name)
            switch(dbOperation){
                case DbOperation.Create:
                    //Save to DynamoDB
                    createRecord(rec)
                case DbOperation.Update:
                    //Delete from DynamoDB
                    deleteRecord(rec)
                    //Update DynamoDB
                    updateRecord(rec)
                case DbOperation.Delete:
                    //Delete from DynamoDB
                    deleteRecord(rec)
            }
        }
    }
}

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

func stringFromDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "yyyy-MM-dd"
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

