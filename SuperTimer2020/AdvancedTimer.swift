//
//  AdvancedTimer.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 29.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct AdvancedTimer: View {
    @ObservedObject var advancedTimerManager = AdvancedTimerManager()
     
    @State var selectedPickerIndexSecond = 0
    @State var selectedPickerIndexMinute = 0
    @State var selectedPickerIndexHour = 0
    
    let availableSeconds = Array (0...59)
    let availableMinutes = Array (0...59)
    let availableHours = Array (0...23)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(SecondsToHoursAndMinutesAndSeconds(seconds: advancedTimerManager.secondsLeft))
                    .font(.system(size: 70))
                    .padding(.top, 80)
                
                if advancedTimerManager.timerMode == .initial {
                    HStack {
                        Picker(selection: $selectedPickerIndexHour, label: Text("")) {
                            ForEach (0 ..< availableHours.count) {
                                Text("\(self.availableHours[$0]) h")
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .clipped()
                        .labelsHidden()
                        
                        Picker(selection: $selectedPickerIndexMinute, label: Text("")) {
                            ForEach (0 ..< availableMinutes.count) {
                                Text("\(self.availableMinutes[$0]) min")
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .clipped()
                        .labelsHidden()
                        
                        Picker(selection: $selectedPickerIndexSecond, label: Text("")) {
                            ForEach (0 ..< availableSeconds.count) {
                                Text("\(self.availableSeconds[$0]) sec")
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                        .clipped()
                        .labelsHidden()
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack {
                        Image(systemName: "goforward.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .onTapGesture (perform: {
                            // some code here...
                        })
                        Text("Lap")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity(advancedTimerManager.timerMode == .running ? 1 : 0)
                    
                    Image(systemName: advancedTimerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                        .onTapGesture (perform: {
                            if self.advancedTimerManager.timerMode == .initial {
                                self.advancedTimerManager.setTimeLength(seconds:
                                    self.availableHours[self.selectedPickerIndexHour] * 60 * 60 +
                                    self.availableMinutes[self.selectedPickerIndexMinute] * 60 +
                                    self.availableSeconds[self.selectedPickerIndexSecond])
                            }
                            self.advancedTimerManager.timerMode == .running ? self.advancedTimerManager.pause() : self.advancedTimerManager.start()
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
                            self.advancedTimerManager.reset()
                        })
                        Text("Stop")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity((advancedTimerManager.timerMode == .running || advancedTimerManager.timerMode == .paused) ? 1 : 0)
                }
            }
            .navigationBarTitle("Advanced Timer", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.advancedTimerManager.soundState = self.advancedTimerManager.soundState ? false : true
                }) {
                    Image(systemName: self.advancedTimerManager.soundState ? "speaker" : "speaker.slash").imageScale(.large)
                }
            )
        }
    }
}

struct AdvancedTimer_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedTimer()
    }
}
