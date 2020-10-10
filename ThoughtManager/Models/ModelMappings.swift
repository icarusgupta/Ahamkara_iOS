//
//  ModelMappings.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 08/10/2020.
//

import Foundation

enum FeelingType: String{
    case blissful, happy, excited, neutral, anxious, stressed, depressed, angry
}

enum ContextType: String{
    case weekday, weekend, holiday
}

struct RecordType{
    var name: String
    var baseName: String
    var value: Float
    var desc: String
    
    init(name: String, baseName: String = "", value: Float = 0.0, desc: String = ""){
        self.name = name
        self.baseName = baseName
        self.value = value
        self.desc = desc
    }
}


struct ModelMappings{
    
    static var instance: ModelMappings = {return ModelMappings()}()
    
    let feelingTypeList: [RecordType]
        = [RecordType(name: FeelingType.blissful.rawValue, value: 4),
           RecordType(name: FeelingType.happy.rawValue, value: 2),
           RecordType(name: FeelingType.excited.rawValue, value: 2),
           RecordType(name: FeelingType.neutral.rawValue, value: 0),
           RecordType(name: FeelingType.anxious.rawValue, value: -2),
           RecordType(name: FeelingType.stressed.rawValue, value: -4),
           RecordType(name: FeelingType.depressed.rawValue, value: -8),
           RecordType(name: FeelingType.angry.rawValue, value: -8)]
    
    let feelingTypeToEmoji: [String: String]
        = [FeelingType.blissful.rawValue: "😇",
           FeelingType.happy.rawValue: "😎",
           FeelingType.depressed.rawValue: "😢",
           FeelingType.angry.rawValue: "😡",
           FeelingType.neutral.rawValue: "😐",
           FeelingType.stressed.rawValue: "☹️",
           FeelingType.anxious.rawValue: "😟",
           FeelingType.excited.rawValue: "🥳"]
    
    let activityTypeList: [RecordType]
        = [RecordType(name: "office_work", baseName: "work"),
           RecordType(name: "diy_project", baseName: "work"),
           RecordType(name: "commercial_project", baseName: "work"),
           RecordType(name: "exercise", baseName: "recreation"),
           RecordType(name: "outdoor_activity", baseName: "recreation"),
           RecordType(name: "hobby", baseName: "recreation"),
           RecordType(name: "home_made", baseName: "meal"),
           RecordType(name: "restaurant", baseName: "meal"),
           RecordType(name: "new_skill", baseName: "learn"),
           RecordType(name: "new_language", baseName: "learn"),
           RecordType(name: "vacation", baseName: "plan"),
           RecordType(name: "charitable", baseName: "plan"),
           RecordType(name: "investment", baseName: "work"),
           RecordType(name: "Virtual", baseName: "social"),
           RecordType(name: "Real", baseName: "social"),]
    
    let thoughtTypeList:[RecordType]
        = [RecordType(name: "being_judged", baseName: "people"),
           RecordType(name: "imagining_being_judged", baseName: "people"),
           RecordType(name: "envy_with_others_success", baseName: "people"),
           RecordType(name: "personal_historical_event", baseName: "event"),
           RecordType(name: "personal_recent_event", baseName: "event"),
           RecordType(name: "anxiety_for_future_event", baseName: "event"),
           RecordType(name: "mental_block", baseName: "ideas"),
           RecordType(name: "feeling_unproductive", baseName: "ideas"),
           RecordType(name: "feeling_productive", baseName: "ideas"),
           RecordType(name: "feeling_creative", baseName: "ideas"),
           RecordType(name: "feeling_out_of_options", baseName: "ideas"),
           RecordType(name: "in_a_dilemma", baseName: "ideas")]
}
