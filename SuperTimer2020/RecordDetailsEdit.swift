//
//  RecordDetailsEdit.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 19.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI
import Foundation

struct RecordDetailsEdit: View {
    
    @Binding var recordClass : MyRecord
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userSettings : UserSettings
    
    let ud = UserDefaults.standard
    
    @State var recordsArray : [String] = UserDefaults.standard.value(forKey: "Records") == nil ? [] : UserDefaults.standard.value(forKey: "Records") as! [String]
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Title: ")
                        .bold()
                    
                    TextField(self.recordClass.recTitle, text: $recordClass.recTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.default)
                }

                Text("Description: ")
                    .bold()
                    .padding(.bottom, -10)
                
                MultiLineTF(txt: $recordClass.recDescription, defValue: recordClass.recDescription, isEditable: true)
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
                            
                            var defVal : String = self.recordClass.rawData
                            
                            var record : String = "Title:\(self.recordClass.recTitle)|Description:\(self.recordClass.recDescription)|DateTime:\(self.recordClass.recDateTime)+0000|FullResult:\(self.recordClass.recFullResult)|LapsData:{\(self.recordClass.rawData.components(separatedBy: ["{", "}"])[1])}"
                            
                            var index : Int = self.recordsArray.lastIndex(of: defVal)!
                            self.recordsArray.replaceSubrange(index...index, with: [record])
                            
                            self.ud.set(self.recordsArray, forKey: "Records")
                            self.userSettings.updateRecords()
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

struct RecordDetailsEdit_Previews: PreviewProvider {
    
    @State static var tmpRec : MyRecord = MyRecord(rawData: "")
    
    static var previews: some View {
        RecordDetailsEdit(recordClass: $tmpRec)
    }
}
