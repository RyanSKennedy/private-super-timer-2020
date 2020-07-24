//
//  TimerDetailsEdit.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 22.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI
import Foundation

struct TimerDetailsEdit: View {
    
    @Binding var timerClass : MyTimer
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userSettings : UserSettings
    
    let ud = UserDefaults.standard
    
    @State var timersArray : [String] = UserDefaults.standard.value(forKey: "Timers") == nil ? [] : UserDefaults.standard.value(forKey: "Timers") as! [String]
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Title: ")
                        .bold()
                    
                    TextField(self.timerClass.timerTitle, text: $timerClass.timerTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.default)
                }

                Text("Description: ")
                    .bold()
                    .padding(.bottom, -10)
                
                MultiLineTF(txt: $timerClass.timerDescription, defValue: timerClass.timerDescription, isEditable: true)
                    .frame(width: 350, height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    )
                
                Spacer()
                
                HStack {
                        Button(action: {
                            
                            var defVal : String = self.timerClass.rawData
                            
                            var timer : String = "Title:\(self.timerClass.timerTitle)|Description:\(self.timerClass.timerDescription)|DateTime:\(self.timerClass.timerDateTime)+0000|TimerScheme:\(self.timerClass.timerScheme)|TimerType:{\(self.timerClass.rawData.components(separatedBy: ["{", "}"])[1])}"
                            
                            var index : Int = self.timersArray.lastIndex(of: defVal)!
                            self.timersArray.replaceSubrange(index...index, with: [timer])
                            
                            self.ud.set(self.timersArray, forKey: "Timers")
                            self.userSettings.updateTimers()
                            self.presentationMode.wrappedValue.dismiss()
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
        .padding()
        }
        .navigationBarTitle("Edit Details", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct TimerDetailsEdit_Previews: PreviewProvider {
    
    @State static var tmpTimer : MyTimer = MyTimer(rawData: "")
    
    static var previews: some View {
        TimerDetailsEdit(timerClass: $tmpTimer)
    }
}
