//
//  RecordDetails.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 08.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI
import Foundation

struct RecordDetails: View {
    
    @State var recordClass : MyRecord = MyRecord(rawData: "")
    
    @EnvironmentObject var userSettings : UserSettings
    
    @Environment(\.presentationMode) var presentationMode

    let ud = UserDefaults.standard
    
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                VStack (alignment: .leading) {
                    
                    HStack {
                        Text("When: ")
                            .bold()
                        
                        Text("\(recordClass.recDateTime)")
                    }
                    .padding(.top, 15)
                    
                    HStack {
                        Text("Full result: ")
                            .bold()
                        
                        Text("\(recordClass.recFullResult)")
                    }
                    .padding(.vertical, 15)
                    
                    Text("Description:")
                        .bold()
                        .padding(.bottom, -10)
                        
                    MultiLineTF (txt: $recordClass.recDescription, defValue: recordClass.recDescription)
                    .frame(width: 350, height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    )
                    
                    Text("Laps: ")
                        .bold()
                        .padding(.bottom, -10)

                    List {
                        ForEach(recordClass.recLapsData.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text("Laps#: \(key)")
                                
                                Spacer()
                                
                                Text("\(SecondsToHoursAndMinutesAndSeconds(seconds: Int(self.recordClass.recLapsData[key]!)!))")
                            }
                        }
                    }
                    .padding(.trailing)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "return")
                                Text("Back")
                            }
                            .padding(10.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(lineWidth: 2.0)
                            )
                        }
                        .foregroundColor(.red)
                    }
                }
                .padding()
                .padding(.top, -110)
            }
        }
        .navigationBarTitle("\(recordClass.recTitle)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            NavigationLink(destination: RecordDetailsEdit(recordClass: self.$recordClass)) {
                Image(systemName: "pencil.circle")
            }, trailing:
            Button(action: {
                
                self.showingAlert = true
                
            }) {
                Image(systemName: "trash")
            }
            .alert(isPresented: $showingAlert) {
                
                Alert(title: Text("Delete record"), message: Text("Are you sure?"), primaryButton: .default(Text("OK")) {
                    
                    var recordsArray : [String] = self.ud.value(forKey: "Records") == nil ? [] : self.ud.value(forKey: "Records") as! [String]
                                        
                    recordsArray.remove(self.recordClass.rawData)
                    
                    self.ud.set(recordsArray, forKey: "Records")
                    
                    self.userSettings.AddSubtractRecord(value: -1)
                    
                    self.userSettings.updateRecords()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    }, secondaryButton: .destructive(Text("Cancel")))
            }
        )
    }
}

struct RecordDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        RecordDetails()
    }
}
