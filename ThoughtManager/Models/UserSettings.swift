//
//  PatternData.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 15/10/2020.
//

import SwiftUI


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
    
    func setRetrievedData(fetchedRecords: [RecordDS]?,
                                  recordTypeName: String) {
      DispatchQueue.main.async {
        if let fetchedRecords = fetchedRecords {
            for i in 0..<fetchedRecords.count {
                self.setValueUserPatternData(
                    recordTypeName: recordTypeName,
                    date: fetchedRecords[i].date.foundationDate,
                    index: i,
                    size: fetchedRecords.count,
                    value: (RecordType(name: fetchedRecords[i].patternName,
                                        baseName: ModelMappings.instance.activityMap[fetchedRecords[i].patternName]!.0,
                                        value: ModelMappings.instance.activityMap[fetchedRecords[i].patternName]!.1,
                                        desc: "",
                                        color: Color.purple),
                             RecordType(name: fetchedRecords[i].scoreName,
                                        baseName: ModelMappings.instance.feelingMap[fetchedRecords[i].scoreName]!.0,
                                        value: ModelMappings.instance.feelingMap[fetchedRecords[i].scoreName]!.1,
                                        desc: ModelMappings.instance.feelingMap[fetchedRecords[i].scoreName]!.2,
                                        color: ModelMappings.instance.feelingMap[fetchedRecords[i].scoreName]!.3)
                         )
                    )
                }
            }
        }
    }
    
    func retrieveData(dailyKey: String,
                      recordTypeName: String){
        cancellable = listRecordsByDailyKey(dailyKey: dailyKey)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              print(error)
            case .finished: ()
            }
          }, receiveValue: { user in
            self.setRetrievedData(fetchedRecords: user,
                             recordTypeName: recordTypeName)
          })
    }

    func retrieveData(startDate: Date,
                      endDate: Date,
                      recordTypeName: String){
        cancellable = listRecordsByDateRange(startDate: startDate, endDate: endDate)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              print(error)
            case .finished: ()
            }
          }, receiveValue: { user in
            self.setRetrievedData(fetchedRecords: user,
                             recordTypeName: recordTypeName)
          })
    }
}

