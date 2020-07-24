//
//  IntervalTimer.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 27.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

let myTimerData = IntervalTimerManager()
let myTimerSeconds = 0

struct IntervalTimer: View {
    @ObservedObject var intervalTimerManager : IntervalTimerManager = myTimerData
     
    let availableSeconds = Array (0...59)
    let availableMinutes = Array (0...59)
    let availableHours = Array (0...23)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(SecondsToHoursAndMinutesAndSeconds(seconds: intervalTimerManager.secondsLeft))
                    .font(.system(size: 70))
                    .padding(.top, 80)
                
                Text("Full time = \(intervalTimerManager.secondsLeft): \n\n     ready time: \(intervalTimerManager.myIntervalTimerStruct.readyVal) \n\n     work time: \(intervalTimerManager.myIntervalTimerStruct.workVal) \n\n     rest time: \(intervalTimerManager.myIntervalTimerStruct.restVal) \n\n     rounds: \(intervalTimerManager.myIntervalTimerStruct.roundVal) \n\n     sets: \(intervalTimerManager.myIntervalTimerStruct.setVal) \n\n     rest between sets: \(intervalTimerManager.myIntervalTimerStruct.rfsVal) \n\n     relax time: \(intervalTimerManager.myIntervalTimerStruct.relaxVal)")
                    .font(.system(size: 10))
                    .padding(.top, 20)
                    .foregroundColor(.blue)
                
                if intervalTimerManager.timerMode == .initial {}
                
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: "gobackward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .onTapGesture (perform: {
                            // gobackward - reset only this current round
                            if (self.intervalTimerManager.timerMode == .running) {
                                self.intervalTimerManager.reset()
                                self.intervalTimerManager.start()
                            } else if (self.intervalTimerManager.timerMode == .paused) {
                                self.intervalTimerManager.reset()
                            }
                        })
                        Text(" ")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity((intervalTimerManager.timerMode == .running || intervalTimerManager.timerMode == .paused) ? 1 : 0)
                    
                    Image(systemName: intervalTimerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.yellow)
                        .onTapGesture (perform: {
                            if self.intervalTimerManager.timerMode == .initial {
                                self.intervalTimerManager.setTimeLength(seconds: self.intervalTimerManager.secondsLeft)
                            }
                            self.intervalTimerManager.timerMode == .running ? self.intervalTimerManager.pause() : self.intervalTimerManager.start()
                    })
                    
                    VStack {
                        Image(systemName: "stop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .foregroundColor(.red)
                        .onTapGesture (perform: {
                            // here should be reset all timer
                            self.intervalTimerManager.reset()
                        })
                        Text("Stop")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity((intervalTimerManager.timerMode == .running || intervalTimerManager.timerMode == .paused) ? 1 : 0)
                }
            }
            .navigationBarTitle("Interval Timer", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.intervalTimerManager.soundState = self.intervalTimerManager.soundState ? false : true
                }) {
                    Image(systemName: self.intervalTimerManager.soundState ? "speaker" : "speaker.slash").imageScale(.large)
                }
            )
        }
    }
}

struct IntervalTimer_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimer()
    }
}
