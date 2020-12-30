//
//  PatternData.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 15/10/2020.
//

import Foundation


class UserSettings: ObservableObject {
    @Published var userActivityData: [Date: [(RecordType, RecordType)]]
    @Published var userThoughtData: [Date: [(RecordType, RecordType)]]
    
    init(){
        self.userActivityData = [:]
        self.userThoughtData = [:]
    }
    
    func userPatternData(recordTypeName: String, date: Date) -> [(RecordType, RecordType)]{
        if recordTypeName == UserPatternType.Activity.rawValue{
            return self.userActivityData[date] ?? []
        }
        else{
            return self.userThoughtData[date] ?? []
        }
    }
    
    func resetUserPatternData(recordTypeName: String, date: Date){
        if recordTypeName == UserPatternType.Activity.rawValue{
            self.userActivityData[date] = []
        }
        else{
            self.userThoughtData[date] = []
        }
    }

    func appendUserPatternData(recordTypeName: String, date: Date, value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            if self.userActivityData.index(forKey: date) == nil{
                self.userActivityData[date] = [value]
            }
            else{
                self.userActivityData[date]!.append(value)
            }
        }
        else{
            if self.userThoughtData.index(forKey: date) == nil{
                self.userThoughtData[date] = [value]
            }
            else{
                self.userThoughtData[date]!.append(value)
            }
        }
    }
    
    func setValueUserPatternData(recordTypeName: String,
                                 date: Date,
                                 index: Int,
                                 size: Int,
                                 value: (RecordType, RecordType)){
        if recordTypeName == UserPatternType.Activity.rawValue{
            if self.userActivityData[date] != nil{
                self.userActivityData[date]![index] = value
            }
            else{
                self.userActivityData[date] = [(RecordType, RecordType)](repeating: (RecordType(name: ""), RecordType(name: "")), count: size)
                self.userActivityData[date]![index] = value
            }
        }
        else{
            if self.userThoughtData[date] != nil{
                self.userThoughtData[date]![index] = value
            }
            else{
                self.userThoughtData[date] = [(RecordType, RecordType)](repeating: (RecordType(name: ""), RecordType(name: "")), count: size)
                self.userThoughtData[date]![index] = value
            }
        }
    }
}

