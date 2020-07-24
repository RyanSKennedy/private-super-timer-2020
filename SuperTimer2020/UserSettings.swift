//
//  UserSettings.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 06.07.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var records : [String : String] {
        didSet {
            UserDefaults.standard.set(records, forKey: "Records")
        }
    }
    
    @Published var maxRecordsValue : Int {
        didSet {
            UserDefaults.standard.set(maxRecordsValue, forKey: "RecordsLimit")
        }
    }
    
    @Published var currentRecordsValue : Int {
        didSet {
            UserDefaults.standard.set(currentRecordsValue, forKey: "RecordsCurrentValue")
        }
    }
    
    @Published var myRecords : [MyRecord]
    
    @Published var timers : [String : String] {
        didSet {
            UserDefaults.standard.set(timers, forKey: "Timers")
        }
    }
    
    @Published var maxTimersValue : Int {
        didSet {
            UserDefaults.standard.set(maxTimersValue, forKey: "TimersLimit")
        }
    }
    
    @Published var currentTimersValue : Int {
        didSet {
            UserDefaults.standard.set(currentTimersValue, forKey: "TimersCurrentValue")
        }
    }
    
    @Published var myTimers : [MyTimer]
    
    init() {
        self.records = UserDefaults.standard.object(forKey: "Records") as? [String : String] ?? [:]
        
        self.maxRecordsValue = UserDefaults.standard.value(forKey: "RecordsLimit") as? Int ?? 0
        
        self.currentRecordsValue = UserDefaults.standard.value(forKey: "RecordsCurrentValue") as? Int ?? 0
        
        self.myRecords = GetRecordsArray(rawDataArray: UserDefaults.standard.value(forKey: "Records") != nil ? UserDefaults.standard.value(forKey: "Records") as! [String] : [])
        
        self.timers = UserDefaults.standard.object(forKey: "Timers") as? [String : String] ?? [:]
        
        self.maxTimersValue = UserDefaults.standard.value(forKey: "TimersLimit") as? Int ?? 0
        
        self.currentTimersValue = UserDefaults.standard.value(forKey: "TimersCurrentValue") as? Int ?? 0
        
        self.myTimers = GetTimersArray(rawDataArray: UserDefaults.standard.value(forKey: "Timers") != nil ? UserDefaults.standard.value(forKey: "Timers") as! [String] : [])
    }
    
    func updateAppend(title : String, value : String) {
        self.records[title] = value
    }
    
    func updateTimersAppend(title : String, value : String) {
        self.timers[title] = value
    }
    
    func updateRecords () {
        self.maxRecordsValue = UserDefaults.standard.value(forKey: "RecordsLimit") as! Int
        
        self.currentRecordsValue = UserDefaults.standard.value(forKey: "RecordsCurrentValue") as! Int
        
        self.myRecords = self.currentRecordsValue > 0 ? GetRecordsArray(rawDataArray: UserDefaults.standard.value(forKey: "Records") as! [String]) : []
    }
    
    func updateTimers () {
        self.maxTimersValue = UserDefaults.standard.value(forKey: "TimersLimit") as! Int
        
        self.currentTimersValue = UserDefaults.standard.value(forKey: "TimersCurrentValue") as! Int
        
        self.myTimers = self.currentTimersValue > 0 ? GetTimersArray(rawDataArray: UserDefaults.standard.value(forKey: "Timers") as! [String]) : []
    }
    
    func AddSubtractRecord (value : Int) {
        
        UserDefaults.standard.set(currentRecordsValue + value, forKey: "RecordsCurrentValue")
        
        self.currentRecordsValue = UserDefaults.standard.value(forKey: "RecordsCurrentValue") as! Int

    }
    
    func AddSubtractTimer (value : Int) {
        
        UserDefaults.standard.set(currentTimersValue + value, forKey: "TimersCurrentValue")
        
        self.currentTimersValue = UserDefaults.standard.value(forKey: "TimersCurrentValue") as! Int

    }
}
