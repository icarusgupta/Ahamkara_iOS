//
//  GenericRecordModelList.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 08/10/2020.
//

import Foundation

struct GenericRecordModelList {
    var recordModelList: [GenericRecordModel]
    
    init(){
        self.recordModelList = []
        if let activityRecordModel = GenericRecordModel(name: "Activity", scoreName: "Feeling Type", recordTypes: ModelMappings.instance.activityTypeList, scoreTypes: ModelMappings.instance.feelingTypeList){
            self.recordModelList.append(activityRecordModel)
        }
        else{
            print("Unable to create Activity Record Model")
        }
        if let thoughtRecordModel = GenericRecordModel(name: "Thought", scoreName: "Feeling Type", recordTypes: ModelMappings.instance.thoughtTypeList, scoreTypes: ModelMappings.instance.feelingTypeList){
            self.recordModelList.append(thoughtRecordModel)
        }
        else{
            print("Unable to create Thought Record Model")
        }
    }
}

