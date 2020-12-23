//
//  RecordChart.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 09/10/2020.
//

import Foundation
import SwiftUI

struct OneDayRecord: View {
    var recordTypeName: String
    var index: Int = 100
    var delayAnim: Double = 0.2
    var lowest_val: Int = -8
    var gradient: GradientColor?
    var curDate: Date
    @State var scaleValue: Int = 0
    @EnvironmentObject var settings: UserSettings
    
    init(recordTypeName: String, curDate: Date){
        self.recordTypeName = recordTypeName
        self.curDate = curDate
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).fill(Color.white)
                .shadow(color: Color.gray, radius: 8)
            List(settings.userPatternData(recordTypeName: self.recordTypeName, date: self.curDate), id:\.0.name) { elem in
                HStack {
                    Text("\(elem.0.name)").frame(width: 200, height: 25).textCompactInfoStyle()
                    Text("\(elem.1.desc)").frame(width: 50, height: 25).textCompactInfoStyle()
                }
            }
            HStack {
                let userPatternData = settings.userPatternData(recordTypeName: self.recordTypeName, date: curDate)
                if userPatternData.count > 0 {
                    ForEach(0..<userPatternData.count) { index in
                        let userPatternDataElem = settings.userPatternData(recordTypeName: self.recordTypeName, date: curDate)[index]
                        let recordName = userPatternDataElem.0.name
                        let scoreDesc = userPatternDataElem.1.desc
                        let scoreColor = userPatternDataElem.1.color
                        let score = userPatternDataElem.1.value + AggFuncs.getScoreGlobalDelta(fTypeList: ModelMappings.instance.feelingTypeList)
                        VStack {
                            Spacer()
                            Text(scoreDesc)
                                .frame(width: 25, height: (CGFloat(score)) * 4.0 + 10)
                                .scaleEffect(CGSize(width: 2, height: self.scaleValue), anchor: .bottom)
                                .onAppear(){
                                    self.scaleValue = 2
                                }
                                .animation(Animation.spring().delay(self.delayAnim))
                            RoundedRectangle(cornerRadius: 4)
                                .fill(scoreColor)
                                .frame(width: 10, height: (CGFloat(score)) * 4.0)
                                .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
                                .onAppear(){
                                    self.scaleValue = 2
                                }
                                .animation(Animation.spring().delay(self.delayAnim))
                            Text(recordName)
                                .rotationEffect(.degrees(-90))
                                .foregroundColor(Color.black)
                                .font(.footnote)
                                .frame(height: 120)
                        }
                    }

                }
            }
        }
    }
}

