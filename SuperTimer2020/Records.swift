//
//  Records.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 30.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import SwiftUI
import Foundation

struct Records: View {
    
    @EnvironmentObject var userSettings : UserSettings
    
    //@State var myfullTitleText : String = ""
    
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
                    
                    Text("Result")
                        .font(.system(size: 15))
                        .bold()
                }
                .padding()
                
                if !userSettings.myRecords.isEmpty {
                    List {
                        ForEach (self.userSettings.myRecords, id: \.hashValue) { record in
                            NavigationLink(destination: RecordDetails(recordClass: MyRecord(rawData: record.rawData))) {
                                
                                HStack {
                                    Text(record.recTitle)
                                        .font(.system(size: 15))
                                        .frame(maxHeight: 10.0)
                                    
                                    Spacer()
                                    
                                    Text(record.recDateTime)
                                        .font(.system(size: 15))
                                    
                                    Spacer()
                                    
                                    Text(record.recFullResult)
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
            .navigationBarTitle("My Records \(self.userSettings.currentRecordsValue)\\\(self.userSettings.maxRecordsValue)", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.userSettings.updateRecords()
                }) {
                    Image(systemName: "arrow.2.circlepath")
                }
            )
        }
    }
}

struct Records_Previews: PreviewProvider {
    
    static var previews: some View {
        Records()
    }
}
