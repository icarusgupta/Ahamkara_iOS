//
//  DbUtils.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 01/01/2021.
//

import SwiftUI
import Amplify


enum DbOperation: String{
    case Create, Update, Delete
}

class DbUtils: ObservableObject{
    
    @EnvironmentObject var settings: UserSettings
    
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

