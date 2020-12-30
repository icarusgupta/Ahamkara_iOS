//
//  ModelMappings.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 08/10/2020.
//

import Foundation
import SwiftUI

enum FeelingType: String{
    case blissful, happy, excited, neutral, anxious, stressed, depressed, angry
}

enum ContextType: String{
    case weekday, weekend, holiday
}

enum UserPatternType: String{
    case Activity, Thought, Feeling
}

struct RecordType{
    var name: String
    var baseName: String
    var value: Float
    var desc: String
    var color: Color
    
    init(name: String, baseName: String = "", value: Float = 0.0, desc: String = "", color: Color = Color.black){
        self.name = name
        self.baseName = baseName
        self.value = value
        self.desc = desc
        self.color = color
    }
}

struct AggFuncs{
    public static func getScoreGlobalDelta(fTypeList: [RecordType]) -> Float{
        let values = fTypeList.map { $0.value }
        return values.max()! - values.min()!
    }
}

struct ModelMappings{
    
    static let instance: ModelMappings = ModelMappings()
    
    var feelingTypeList: [RecordType] = []
    var activityTypeList: [RecordType] = []
    var thoughtTypeList: [RecordType] = []
    
    private init(){
        feelingList.forEach {
            let rec = RecordType(name: $0,
                                 baseName: feelingMap[$0]!.0,
                                 value:  feelingMap[$0]!.1,
                                 desc:  feelingMap[$0]!.2,
                                 color:  feelingMap[$0]!.3)
            self.feelingTypeList.append(rec)
        }
        activityList.forEach {
            let rec = RecordType(name: $0,
                                 baseName: activityMap[$0]!.0,
                                 value: activityMap[$0]!.1)
            self.activityTypeList.append(rec)
        }
        thoughtList.forEach {
            let rec = RecordType(name: $0,
                                 baseName: thoughtMap[$0]!.0,
                                 value: thoughtMap[$0]!.1)
            self.thoughtTypeList.append(rec)
        }
    }
    
    let feelingMap: [String: (String, Float, String, Color)]
        = [FeelingType.blissful.rawValue : (baseName: "positive", value: 4, desc: "😇", color: Color.purple),
           FeelingType.happy.rawValue: (baseName: "positive", value: 2, desc: "😎", color: Color.green),
           FeelingType.excited.rawValue: (baseName: "positive", value: 2, desc: "🥳", color: Color.green),
           FeelingType.neutral.rawValue: (baseName: "positive", value: 0, desc: "😐", color: Color.gray),
           FeelingType.anxious.rawValue: (baseName: "negative", value: -2, desc: "😟", color: Color.yellow),
           FeelingType.stressed.rawValue: (baseName: "negative", value: -4, desc: "☹️", color: Color.yellow),
           FeelingType.depressed.rawValue: (baseName: "negative", value: -8, desc: "😢", color: Color.red),
           FeelingType.angry.rawValue: (baseName: "negative", value: -8, desc: "😡", color: Color.red)]
    
    let activityMap: [String: (String, Float)]
        = ["office_work": (baseName: "work", value: 4),
           "diy_project": (baseName: "work", value: 4),
           "commercial_project": (baseName: "work", value: 4),
           "exercise": (baseName: "recreation", value: 4),
           "outdoor_activity": (baseName: "recreation", value: 4),
           "hobby": (baseName: "recreation", value: 4),
           "home_made": (baseName: "meal", value: 4),
           "restaurant": (baseName: "meal", value: 4),
           "new_skill": (baseName: "learn", value: 4),
           "new_language": (baseName: "learn", value: 4),
           "vacation": (baseName: "plan", value: 4),
           "charitable": (baseName: "plan", value: 4),
           "investment": (baseName: "work", value: 4),
           "Virtual": (baseName: "social", value: 4),
           "Real": (baseName: "social", value: 4)]
    
    let thoughtMap: [String: (String, Float)]
        = ["being_judged": (baseName: "people", value: 4),
           "imagining_being_judged": (baseName: "people", value: 4),
           "envy_with_others_success": (baseName: "people", value: 4),
           "personal_historical_event": (baseName: "event", value: 4),
           "personal_recent_event": (baseName: "event", value: 4),
           "anxiety_for_future_event": (baseName: "event", value: 4),
           "mental_block": (baseName: "ideas", value: 4),
           "feeling_unproductive": (baseName: "ideas", value: 4),
           "feeling_productive": (baseName: "ideas", value: 4),
           "feeling_creative": (baseName: "ideas", value: 4),
           "feeling_out_of_options": (baseName: "ideas", value: 4),
           "in_a_dilemma": (baseName: "ideas", value: 4)]
    
    let feelingList: [String]
        = [FeelingType.blissful.rawValue,
           FeelingType.happy.rawValue,
           FeelingType.excited.rawValue,
           FeelingType.neutral.rawValue,
           FeelingType.anxious.rawValue,
           FeelingType.stressed.rawValue,
           FeelingType.depressed.rawValue,
           FeelingType.angry.rawValue]
    
    let activityList: [String]
        = ["office_work",
           "diy_project",
           "commercial_project",
           "exercise",
           "outdoor_activity",
           "hobby",
           "home_made",
           "restaurant",
           "new_skill",
           "new_language",
           "vacation",
           "charitable",
           "investment",
           "Virtual",
           "Real"]
    
    let thoughtList:[String]
        = ["being_judged",
           "imagining_being_judged",
           "envy_with_others_success",
           "personal_historical_event",
           "personal_recent_event",
           "anxiety_for_future_event",
           "mental_block",
           "feeling_unproductive",
           "feeling_productive",
           "feeling_creative",
           "feeling_out_of_options",
           "in_a_dilemma"]
}
