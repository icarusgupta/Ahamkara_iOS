//
//  GenericRecordModel.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 08/10/2020.
//

import Foundation

struct RecordByDate {
    var date: Date
    var enteredRecordAndSales: [(RecordType, String)]
}

struct GenericRecordModel: Identifiable {
    var id: String
    var name: String
    var scoreName: String
    var contextName: String
    var recordTypes: [RecordType]
    var scoreTypes: [RecordType]
    
    init?(name: String, scoreName: String, contextName: String = "", recordTypes: [RecordType], scoreTypes: [RecordType]) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The name must not be empty
        guard !scoreName.isEmpty else {
            return nil
        }
                
        // Initialize stored properties.
        self.id = name
        self.name = name
        self.scoreName = scoreName
        self.contextName = contextName
        self.recordTypes = recordTypes
        self.scoreTypes = scoreTypes
    }
}
