//
//  SavedTimers.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 30.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI
import Foundation

struct SavedTimers: View {
    
    @EnvironmentObject var userSettings : UserSettings
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading, spacing: 15) {
                
                HStack {
                    Text("Title")
                        .font(.system(size: 15))
                        .bold()
                    
                    Spacer()
                    
                    Text("When")
                        .font(.system(size: 15))
                        .bold()
                    
                    Spacer()
                    
                    Text("Type")
                        .font(.system(size: 15))
                        .bold()
                }
                .padding()
                
                if !userSettings.myTimers.isEmpty {
                    List {
                        ForEach (self.userSettings.myTimers, id: \.hashValue) { timer in
                            NavigationLink(destination: TimerDetails(timerClass: MyTimer(rawData: timer.rawData))) {
                                
                                HStack {
                                    Text(timer.timerTitle)
                                        .font(.system(size: 15))
                                        .frame(maxHeight: 10.0)
                                    
                                    Spacer()
                                    
                                    Text(timer.timerDateTime)
                                        .font(.system(size: 15))
                                    
                                    Spacer()
                                    
                                    Text(timer.timerType)
                                        .font(.system(size: 15))
                                }
                            }
                        }
                    }
                    .padding(.top, -20)
                } else {
                    Spacer()
                }
            }
            .navigationBarTitle("My Timers \(self.userSettings.currentTimersValue)\\\(self.userSettings.maxTimersValue)", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.userSettings.updateTimers()
                }) {
                    Image(systemName: "arrow.2.circlepath")
                }
            )
        }
    }
}

struct SavedTimers_Previews: PreviewProvider {
    
    static var previews: some View {
        SavedTimers()
    }
}
