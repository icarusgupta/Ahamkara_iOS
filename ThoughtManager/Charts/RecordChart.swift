//
//  RecordChart.swift
//  ThoughtManager
//
//  Created by Icarus Gupta on 09/10/2020.
//

import Foundation
import SwiftUI

struct OneDayRecord: View {
    @EnvironmentObject var settings: UserSettings
    var index: Int = 100
    @State var scaleValue: Int = 0
    var delayAnim: Double = 0.2
    var lowest_val: Int = -8
    var gradient: GradientColor?
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20).fill(Color.white)
                .shadow(color: Color.gray, radius: 8)
            HStack {
                if settings.enteredRecordAndScoreList.count > 0 {
                    ForEach(0..<settings.enteredRecordAndScoreList.count) { index in
                        let recordName = settings.enteredRecordAndScoreList[index].0.name
                        let scoreDesc = settings.enteredRecordAndScoreList[index].1.desc
                        let scoreColor = settings.enteredRecordAndScoreList[index].1.color
                        let score = settings.enteredRecordAndScoreList[index].1.value + ModelMappings.instance.getScoreGlobalDelta()
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

