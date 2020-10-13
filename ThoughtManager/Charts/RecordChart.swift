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
    @State var scaleValue: Int = 0
    @EnvironmentObject var settings: UserSettings
    
    init(recordTypeName: String){
        self.recordTypeName = recordTypeName
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).fill(Color.white)
                .shadow(color: Color.gray, radius: 8)
            HStack {
                let userPatternData = settings.userPatternData(recordTypeName: self.recordTypeName)
                if userPatternData.count > 0 {
                    ForEach(0..<userPatternData.count) { index in
                        let userPatternDataElem = settings.userPatternData(recordTypeName: self.recordTypeName)[index]
                        let recordName = userPatternDataElem.0.name
                        let scoreDesc = userPatternDataElem.1.desc
                        let scoreColor = userPatternDataElem.1.color
                        let score = userPatternDataElem.1.value + ModelMappings.instance.getScoreGlobalDelta()
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

