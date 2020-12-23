//
//  PatternData.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 15/10/2020.
//

import Foundation


class UserSettings: ObservableObject {
    @Published var userActivityData: [Date: [(RecordType, RecordType)]] = [:]
    @Published var userThoughtData: [Date: [(RecordType, RecordType)]] = [:]
    
    func userPatternData(recordTypeName: String, date: Date) -> [(RecordType, RecordType)]{
        if recordTypeName == UserPatternType.Activity.rawValue{
            return userActivityData[date] ?? []
        }
        else{
            return userThoughtData[date] ?? []
        }
    }
    
    func resetUserPatternData(recordTypeName: String, date: Date){
        if recordTypeName == UserPatternType.Activity.rawValue{
            userActivityData[date] = []
        }
        else{
            userThoughtData[date] = []
        }
    }

    func appendUserPatternData(recordTypeName: String, date: Date, value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            if userActivityData.index(forKey: date) == nil{
                userActivityData[date] = [value]
            }
            else{
                userActivityData[date]!.append(value)
            }
        }
        else{
            if userThoughtData.index(forKey: date) == nil{
                userThoughtData[date] = [value]
            }
            else{
                userThoughtData[date]!.append(value)
            }
        }
    }
    
    func setValueUserPatternData(recordTypeName: String, date: Date, index: Int, value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            userActivityData[date]?[index] = value
        }
        else{
            userThoughtData[date]?[index] = value
        }
    }

}

