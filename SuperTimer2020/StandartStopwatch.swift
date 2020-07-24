//
//  StandartStopwatch.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 24.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct Lap : Identifiable {
    var id = UUID()
    var secondsMarker: Int
    var secondsForCurrentLap: Int
    var lapNumber: Int
}

struct StandartStopwatch: View {
    
    @ObservedObject var stopwatchManager = StopwatchManager()
     
    @State var selectedPickerIndexSecond = 0
    @State var selectedPickerIndexMinute = 0
    @State var selectedPickerIndexHour = 0
    
    let availableSeconds = Array (0...59)
    let availableMinutes = Array (0...59)
    let availableHours = Array (0...23)
    
    @State var laps : [Lap] = []
    @State var lapsRaw : String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("  HH      :      MM      :      SS  ")
                .font(.system(size: 30))
                .padding(.top, 40)
                    .foregroundColor(.blue)
                
                Text(SecondsToHoursAndMinutesAndSeconds(seconds: stopwatchManager.secondsLeft))
                    .font(.system(size: 70))
                    .padding(.top, 10)
                
                Spacer()
                
                List(laps) { lap in
                    HStack {
                        Text ("Lap #\(lap.lapNumber)")
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Text ("\(SecondsToHoursAndMinutesAndSeconds(seconds: lap.secondsForCurrentLap))")
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                HStack {
                    VStack {
                        NavigationLink(destination: SaveRecordDialog(myStopwatchManager: self._stopwatchManager, myLaps: $laps, myLapRaw: $lapsRaw)) {
                            VStack {
                                Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(.top, 30)
                                .padding(.horizontal, 20)
                                .foregroundColor(.blue)
                        
                                Text("Save")
                                .font(.subheadline)
                                .padding(.top, -5)
                                .foregroundColor(.gray)
                            }
                            .padding(10.0)
                        }
                        .opacity(stopwatchManager.timerMode == .paused ? 1 : 0)
                        .zIndex(2.0)
                        .padding(.top, 15)
                        
                        VStack {
                            Image(systemName: "goforward.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.horizontal, 20)
                            .foregroundColor(.black)
                            .onTapGesture (perform: {
                                if self.stopwatchManager.timerMode == .running  {
                                    self.laps.append(Lap(id: UUID(), secondsMarker: self.stopwatchManager.secondsLeft, secondsForCurrentLap: self.stopwatchManager.secondsLeft - (self.laps.count > 0 ? self.laps.last!.secondsMarker : 0), lapNumber: self.laps.count + 1))
                                }
                            })
                            Text("Lap")
                            .font(.subheadline)
                            .padding(.top, -5)
                            .foregroundColor(.gray)
                        }
                        .opacity(stopwatchManager.timerMode == .running ? 1 : 0)
                        .zIndex(1.0)
                        .padding(.top, -85)
                    }
                    
                    Image(systemName: stopwatchManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.green)
                        .onTapGesture (perform: {
                            if self.stopwatchManager.timerMode == .initial {
                                self.stopwatchManager.setTimeLength(seconds:
                                    self.availableHours[self.selectedPickerIndexHour] * 60 * 60 +
                                    self.availableMinutes[self.selectedPickerIndexMinute] * 60 +
                                    self.availableSeconds[self.selectedPickerIndexSecond])
                            }
                            
                            self.stopwatchManager.timerMode == .running ? self.stopwatchManager.pause() : self.stopwatchManager.start()
                            
                            if self.stopwatchManager.timerMode == .paused
                            {
                                self.laps.append(Lap(id: UUID(), secondsMarker: self.stopwatchManager.secondsLeft, secondsForCurrentLap: self.stopwatchManager.secondsLeft - (self.laps.count > 0 ? self.laps.last!.secondsMarker : 0), lapNumber: self.laps.count + 1))
                            } else if self.stopwatchManager.timerMode == .running && self.laps.count > 0 {
                                self.laps.removeLast()
                            }
                            
                            self.lapsRaw = ""
                            
                            for lap in self.laps {
                                self.lapsRaw += "Lap#:\(lap.lapNumber)>LapResult:\(lap.secondsForCurrentLap)>LapMarker:\(lap.secondsMarker)\(lap.lapNumber == self.laps.last!.lapNumber ? "" : "&")"
                            }
                    })
                    
                    VStack {
                        Image(systemName: stopwatchManager.timerMode == .running ? "gobackward" : "stop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top, 30)
                        .padding(.horizontal, 30)
                        .foregroundColor(stopwatchManager.timerMode == .running ? .black : .red)
                        .onTapGesture (perform: {
                            if (self.stopwatchManager.timerMode == .running) {
                                self.stopwatchManager.reset()
                                self.stopwatchManager.start()
                                self.laps.removeAll()
                            } else if (self.stopwatchManager.timerMode == .paused) {
                                self.stopwatchManager.reset()
                                self.laps.removeAll()
                            }
                        })
                        Text(stopwatchManager.timerMode == .running ? " " : "Stop")
                        .font(.subheadline)
                        .padding(.top, -5)
                        .foregroundColor(.gray)
                    }
                    .opacity((stopwatchManager.timerMode == .running || stopwatchManager.timerMode == .paused) ? 1 : 0)
                }
            }
            .navigationBarTitle("Standart Stopwatcher", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.stopwatchManager.soundState = self.stopwatchManager.soundState ? false : true
                }) {
                    Image(systemName: self.stopwatchManager.soundState ? "speaker" : "speaker.slash").imageScale(.large)
                }
            )
        }
    }
}

struct StandartStopwatch_Previews: PreviewProvider {
    
    static var previews: some View {
        StandartStopwatch()
    }
}
