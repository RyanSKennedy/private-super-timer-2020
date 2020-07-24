//
//  TimerDetails.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 22.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import Foundation
import SwiftUI

struct TimerDetails: View {
    
    @State var timerClass : MyTimer = MyTimer(rawData: "")
    
    @EnvironmentObject var userSettings : UserSettings
    
    @Environment(\.presentationMode) var presentationMode

    let ud = UserDefaults.standard
    
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            
            NavigationView {
                
                Text("My Timer Details View...")
            }
        }
        .navigationBarTitle("\(timerClass.timerTitle)", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            NavigationLink(destination: TimerDetailsEdit(timerClass: self.$timerClass)) {
                Image(systemName: "pencil.circle")
            }, trailing:
            Button(action: {
                
                self.showingAlert = true
                
            }) {
                Image(systemName: "trash")
            }
            .alert(isPresented: $showingAlert) {
                
                Alert(title: Text("Delete timer"), message: Text("Are you sure?"), primaryButton: .default(Text("OK")) {
                    
                    var timersArray : [String] = self.ud.value(forKey: "Timers") == nil ? [] : self.ud.value(forKey: "Timers") as! [String]
                                        
                    timersArray.remove(self.timerClass.rawData)
                    
                    self.ud.set(timersArray, forKey: "Timers")
                    
                    self.userSettings.AddSubtractTimer(value: -1)
                    
                    self.userSettings.updateTimers()
                    
                    self.presentationMode.wrappedValue.dismiss()
                    }, secondaryButton: .destructive(Text("Cancel")))
            }
        )
    }
}

struct TimerDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        TimerDetails()
    }
}
