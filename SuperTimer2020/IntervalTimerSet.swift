//
//  IntervalTimerSet.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 25.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

struct IntervalTimerSet: View {
    @ObservedObject var intervalTimerManager = IntervalTimerManager()
     
    @State var selectedPickerIndexSecond = 0
    @State var selectedPickerIndexMinute = 0
    @State var selectedPickerIndexHour = 0
    
    let availableSeconds = Array (0...59)
    let availableMinutes = Array (0...59)
    let availableHours = Array (0...23)
    
    @State var startButton = true
    
    @State var preparedTime: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var workTime: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var restTime: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var roundNumbers: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var setNumbers: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var restBetweenSetsTime: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var relaxTime: String = "0" {
        didSet{
            intervalTimerManager.secondsLeft = GetFinalTimeValue(readyValue: preparedTime, workValue: workTime, restValue: restTime, roundValue: roundNumbers, setValue: setNumbers, restForSetValue: restBetweenSetsTime, relaxValue: relaxTime)
        }
    }
    @State var value : CGFloat = 0
    
    @State private var log: String = "Logs: "
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("  HH      :      MM      :      SS  ")
                    .font(.system(size: 30))
                    .padding(.top, 40)
                    .foregroundColor(.blue)
                    
                Text(intervalTimerManager.secondsLeft == 0 ? "00 : 00 : 00" : SecondsToHoursAndMinutesAndSeconds(seconds: intervalTimerManager.secondsLeft))
                    .font(.system(size: 67))
                    .padding(.top, 10)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack {
                            Text("Ready")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                            HStack {
                                Button(action: {
                                    self.preparedTime = self.preparedTime == "" ? "0" : self.preparedTime
                                    self.preparedTime = (Int (self.preparedTime)! > 0 ? String (Int (self.preparedTime)! - 1) : self.preparedTime)
                                }) {
                                    Image(systemName: "minus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.green)
                                
                                TextField(preparedTime, text: $preparedTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 230)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)

                                Button(action: {
                                    self.preparedTime = self.preparedTime == "" ? "0" : self.preparedTime
                                    self.preparedTime = String (Int (self.preparedTime)! + 1)
                                }) {
                                    Image(systemName: "plus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.green)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
                
                VStack {
                    HStack {
                        VStack {
                            Text("Work")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.red)
                            HStack {
                                Button(action: {
                                    self.workTime = self.workTime == "" ? "0" : self.workTime
                                    self.workTime = (Int (self.workTime)! > 0 ? String (Int (self.workTime)! - 1) : self.workTime)
                                }) {
                                    Image(systemName: "minus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.red)
                                
                                TextField("0", text: $workTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 70)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                
                                Button(action: {
                                    self.workTime = self.workTime == "" ? "0" : self.workTime
                                    self.workTime = String (Int (self.workTime)! + 1)
                                }) {
                                    Image(systemName: "plus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.red)
                            }
                        }
                        VStack {
                            Text("Rest")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.blue)
                            HStack {
                                Button(action: {
                                    self.restTime = self.restTime == "" ? "0" : self.restTime
                                    self.restTime = (Int (self.restTime)! > 0 ? String (Int (self.restTime)! - 1) : self.restTime)
                                }) {
                                    Image(systemName: "minus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.blue)
                                
                                TextField("0", text: $restTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 70)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                
                                Button(action: {
                                    self.restTime = self.restTime == "" ? "0" : self.restTime
                                    self.restTime = String (Int (self.restTime)! + 1)
                                }) {
                                    Image(systemName: "plus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    VStack {
                        Text("Rounds")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.orange)
                        HStack {
                            Button(action: {
                                self.roundNumbers = self.roundNumbers == "" ? "0" : self.roundNumbers
                                self.roundNumbers = (Int (self.roundNumbers)! > 0 ? String (Int (self.roundNumbers)! - 1) : self.roundNumbers)
                            }) {
                                Image(systemName: "minus")
                                .padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            } .foregroundColor(.orange)
                            
                            TextField("0", text: $roundNumbers)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 230)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                            
                            Button(action: {
                                self.roundNumbers = self.roundNumbers == "" ? "0" : self.roundNumbers
                                self.roundNumbers = String (Int (self.roundNumbers)! + 1)
                            }) {
                                Image(systemName: "plus")
                                .padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            } .foregroundColor(.orange)
                        }
                    } .padding(.top, 10)
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack {
                            Text("Sets")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.red)
                            HStack {
                                Button(action: {
                                    self.setNumbers = self.setNumbers == "" ? "0" : self.setNumbers
                                    self.setNumbers = (Int (self.setNumbers)! > 0 ? String (Int (self.setNumbers)! - 1) : self.setNumbers)
                                }) {
                                    Image(systemName: "minus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.red)
                                
                                TextField("0", text: $setNumbers)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 70)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                
                                Button(action: {
                                    self.setNumbers = self.setNumbers == "" ? "0" : self.setNumbers
                                    self.setNumbers = String (Int (self.setNumbers)! + 1)
                                }) {
                                    Image(systemName: "plus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.red)
                            }
                        }
                        VStack {
                            Text("Rest for Sets")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.blue)
                            HStack {
                                Button(action: {
                                    self.restBetweenSetsTime = self.restBetweenSetsTime == "" ? "0" : self.restBetweenSetsTime
                                    self.restBetweenSetsTime = (Int (self.restBetweenSetsTime)! > 0 ? String (Int (self.restBetweenSetsTime)! - 1) : self.restBetweenSetsTime)
                                }) {
                                    Image(systemName: "minus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.blue)
                                
                                TextField("0", text: $restBetweenSetsTime)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 70)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                
                                Button(action: {
                                    self.restBetweenSetsTime = self.restBetweenSetsTime == "" ? "0" : self.restBetweenSetsTime
                                    self.restBetweenSetsTime = String (Int (self.restBetweenSetsTime)! + 1)
                                }) {
                                    Image(systemName: "plus")
                                    .padding(10.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .stroke(lineWidth: 2.0)
                                    )
                                } .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    VStack {
                        Text("Relax")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.green)
                        HStack {
                            Button(action: {
                                self.relaxTime = self.relaxTime == "" ? "0" : self.relaxTime
                                self.relaxTime = (Int (self.relaxTime)! > 0 ? String (Int (self.relaxTime)! - 1) : self.relaxTime)
                            }) {
                                Image(systemName: "minus")
                                .padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            } .foregroundColor(.green)
                            
                            TextField("0", text: $relaxTime)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 230)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                            
                            Button(action: {
                                self.relaxTime = self.relaxTime == "" ? "0" : self.relaxTime
                                self.relaxTime = String (Int (self.relaxTime)! + 1)
                            }) {
                                Image(systemName: "plus")
                                .padding(10.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .stroke(lineWidth: 2.0)
                                )
                            } .foregroundColor(.green)
                        }
                    } .padding(.top, 10)
                }
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: Text("Set data for saving...")) {
                        HStack {
                            Image(systemName: "bookmark")
                            Text("Save to my timers")
                        }
                        .padding(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                        )
                    } .foregroundColor(.gray)
                    
                    Spacer()
                    
                    NavigationLink(destination: IntervalTimer(intervalTimerManager: intervalTimerManager)) {
                        HStack {
                            Image(systemName: "play")
                            Text("Start")
                        }
                        .padding(10.0)
                        .overlay(RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 2.0))
                    }
                    .foregroundColor(.red)
                    .simultaneousGesture(TapGesture().onEnded({
                        self.intervalTimerManager.myIntervalTimerStruct.readyVal = Int(self.preparedTime)!
                        self.intervalTimerManager.myIntervalTimerStruct.workVal = Int(self.workTime)!
                        self.intervalTimerManager.myIntervalTimerStruct.restVal = Int(self.restTime)!
                        self.intervalTimerManager.myIntervalTimerStruct.roundVal = Int(self.roundNumbers)!
                        self.intervalTimerManager.myIntervalTimerStruct.setVal = Int(self.setNumbers)!
                        self.intervalTimerManager.myIntervalTimerStruct.rfsVal = Int(self.restBetweenSetsTime)!
                        self.intervalTimerManager.myIntervalTimerStruct.relaxVal = Int(self.relaxTime)!
                    }))
                }
            }
            .navigationBarTitle("Interval Timer setting", displayMode: .inline)
            .padding()
            .offset(y: -self.value)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.value = height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                    
                    self.value = 0
                }
            }
        }
    }
}

struct IntervalTimerSet_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTimerSet()
    }
}
