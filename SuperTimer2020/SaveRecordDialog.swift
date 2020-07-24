//
//  SaveRecordDialog.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 01.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI

let myTmpStopwatchData = StopwatchManager()

struct SaveRecordDialog: View {
    
    @ObservedObject var stopwatchManager : StopwatchManager //= myTmpStopwatchData
    @Binding var laps : [Lap]
    @Binding var lapsRaw : String
    
    init(myStopwatchManager: ObservedObject<StopwatchManager>, myLaps: Binding<[Lap]>, myLapRaw: Binding<String>){
        self._stopwatchManager = myStopwatchManager
        self._laps = myLaps
        self._lapsRaw = myLapRaw
    }

    @EnvironmentObject var userSettings : UserSettings

    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    @State var isError : Bool = false
    
    let ud = UserDefaults.standard
    
    @State var recordTitle: String = ""
    @State var recordDescription: String = ""
    
    var body: some View {
        
        VStack (spacing : 20) {
            VStack (alignment : .leading, spacing : 5) {
                Text("Record title: ")
                    .bold()
                TextField("Type title here...", text: $recordTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 350)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .keyboardType(.default)
            }
            
            VStack (alignment : .leading, spacing : 5) {
                Text("Record description: ")
                    .bold()
                MultiLineTF(txt: $recordDescription, isEditable: true)
                    .frame(width: 350, height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    )
                    .keyboardType(.default)
            }
            
            VStack {
                HStack {
                    Text("Full result: \(SecondsToHoursAndMinutesAndSeconds(seconds: stopwatchManager.secondsLeft))")
                        .bold()
                }
            
                Spacer()
                
                VStack {
                    Text("Laps:")
                    .bold()
                    .padding(0.0)
                    .frame(width: 350.0)
                    
                    List(laps) { lap in
                        HStack {
                            Text ("Lap #\(lap.lapNumber)")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15))
                            
                            Spacer()
                            
                            Text ("\(SecondsToHoursAndMinutesAndSeconds(seconds: lap.secondsForCurrentLap))")
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 15))
                        }
                    }
                }
            }
            
            HStack {
                Button(action: {
                    // action for button here...
                    
                    if self.ud.value(forKey: "RecordsLimit") != nil && self.ud.value(forKey: "RecordsCurrentValue") != nil {
                        
                        var tmpRecLimit : Int = self.ud.value(forKey: "RecordsLimit") as! Int
                        var tmpRecCurrentValue : Int = self.ud.value(forKey: "RecordsCurrentValue") as! Int
                        
                        if tmpRecCurrentValue < tmpRecLimit {
                            var recordsArray : [String] = self.ud.value(forKey: "Records") == nil ? [] : self.ud.value(forKey: "Records") as! [String]
                                               
                            recordsArray.append("Title:\(self.recordTitle)|Description:\(self.recordDescription)|DateTime:\(Date())|FullResult:\(SecondsToHoursAndMinutesAndSeconds(seconds: self.stopwatchManager.secondsLeft))|LapsData:{\(self.lapsRaw)}")
                           
                            self.ud.set(recordsArray, forKey: "Records")
        
                            tmpRecCurrentValue += 1
                            self.ud.set(tmpRecCurrentValue, forKey: "RecordsCurrentValue")
                            
                            self.userSettings.updateRecords()
                            self.stopwatchManager.reset()
                            self.laps.removeAll()
                            self.lapsRaw = ""
                            self.presentationMode.wrappedValue.dismiss()
                            
                        } else {
                            self.showingAlert = true
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "bag.badge.plus")
                        Text("Save")
                    }
                    .padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                .foregroundColor(.green)
                .alert(isPresented: $showingAlert) {
                    
                    Alert(title: Text("Saving records error"), message: Text("Record limit exceeded!"), primaryButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                        }, secondaryButton: .cancel())
                }
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.octagon")
                        Text("Cancel")
                    }
                    .padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        .padding(.top, 10)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Save new record?", displayMode: .inline)
        
    }
}

struct SaveRecordDialog_Previews: PreviewProvider {
    
    @ObservedObject static var tmpStopwatchManager : StopwatchManager = StopwatchManager()
    @State static var tmpLap : [Lap] = []
    @State static var tmpLapRaw : String = ""
    
    static var previews: some View {
        SaveRecordDialog(myStopwatchManager: _tmpStopwatchManager, myLaps: $tmpLap, myLapRaw: $tmpLapRaw)
    }
}
