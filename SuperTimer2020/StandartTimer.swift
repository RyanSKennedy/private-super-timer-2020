//
//  StandartTimer.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 21.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct StandartTimer: View {
    @ObservedObject var timerManager = TimerManager()
     
    @State var selectedPickerIndexSecond = 0
    @State var selectedPickerIndexMinute = 0
    @State var selectedPickerIndexHour = 0
    
    let availableSeconds = Array (0...59)
    let availableMinutes = Array (0...59)
    let availableHours = Array (0...23)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(SecondsToHoursAndMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 70))
                    .padding(.top, 80)
                
                if timerManager.timerMode == .initial {
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
                    .opacity(0)
                    
                    Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.red)
                        .onTapGesture (perform: {
                            if self.timerManager.timerMode == .initial {
                                self.timerManager.setTimeLength(seconds:
                                    self.availableHours[self.selectedPickerIndexHour] * 60 * 60 +
                                    self.availableMinutes[self.selectedPickerIndexMinute] * 60 +
                                    self.availableSeconds[self.selectedPickerIndexSecond])
                            }
                            self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
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
                            self.timerManager.reset()
                        })
                        Text("Stop")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity((timerManager.timerMode == .running || timerManager.timerMode == .paused) ? 1 : 0)
                }
            }
            .navigationBarTitle("Standart Timer", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.timerManager.soundState = self.timerManager.soundState ? false : true
                }) {
                    Image(systemName: self.timerManager.soundState ? "speaker" : "speaker.slash").imageScale(.large)
                }
            )
        }
    }
}

struct StandartTimer_Previews: PreviewProvider {
    static var previews: some View {
        StandartTimer()
    }
}
