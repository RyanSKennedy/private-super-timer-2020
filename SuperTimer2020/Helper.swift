//
//  Helper.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 22.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import Foundation
import SwiftUI

struct IntervalTimerStruct {
    var readyVal : Int = 0
    var workVal : Int = 0
    var restVal : Int = 0
    var roundVal : Int = 0
    var setVal : Int = 0
    var rfsVal : Int = 0
    var relaxVal : Int = 0
}

enum TimerMode {
    case running
    case paused
    case initial
}

func SecondsToHoursAndMinutesAndSeconds (seconds: Int) -> String {
    let hours = "\((seconds % (60*60*60)) / (60 * 60))"
    let minutes = "\((seconds % (60*60)) / 60)"
    let seconds = "\(seconds % 60)"
    
    let hourStamp = hours.count > 1 ? hours : "0" + hours
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(hourStamp) : \(minuteStamp) : \(secondStamp)"
}

func GetFinalTimeValue (readyValue: String, workValue: String, restValue: String, roundValue: String, setValue: String, restForSetValue: String, relaxValue: String) -> Int {
    var readyValueInt = Int(readyValue)
    var workValueInt = Int(workValue)
    var restValueInt = Int(restValue)
    var roundValueInt = Int(roundValue)
    var setValueInt = Int(setValue)
    var restForSetValueInt = setValueInt! < 2 ? 0 : Int(restForSetValue)
    var relaxValueInt = Int(relaxValue)
    
    return (readyValueInt! + (((workValueInt! + restValueInt!) * roundValueInt!) + restForSetValueInt!) * setValueInt! + relaxValueInt!)
}

func SetLimits (recordsLimit : Int = 10, timersLimit : Int = 10) {
    if (UserDefaults.standard.value(forKey: "RecordsLimit") == nil) {
        UserDefaults.standard.set(recordsLimit, forKey: "RecordsLimit")
    }
    
    if (UserDefaults.standard.value(forKey: "RecordsCurrentValue") == nil) {
        UserDefaults.standard.set(0, forKey: "RecordsCurrentValue")
    }
    
    if (UserDefaults.standard.value(forKey: "TimersLimit") == nil) {
        UserDefaults.standard.set(timersLimit, forKey: "TimersLimit")
    }
    
    if (UserDefaults.standard.value(forKey: "TimersCurrentValue") == nil) {
        UserDefaults.standard.set(0, forKey: "TimersCurrentValue")
    }
}

func SetEnvVariablesToDefault (recordsLimit : Int = 10, recordsCurrentNumber : Int = 0, timersLimit : Int = 10, timersCurrentNumber : Int = 0) {
    UserDefaults.standard.set(recordsLimit, forKey: "RecordsLimit")
    UserDefaults.standard.set(recordsCurrentNumber, forKey: "RecordsCurrentValue")
    
    UserDefaults.standard.set(timersLimit, forKey: "TimersLimit")
    UserDefaults.standard.set(timersCurrentNumber, forKey: "TimersCurrentValue")
}

func GetRecordsArray (rawDataArray : [String]) -> [MyRecord] {
    
    var result : [MyRecord] = []
    
    if !rawDataArray.isEmpty {
        for item in rawDataArray {
            result.append(MyRecord(rawData: item))
        }
    }
    
    return result
}

func GetTimersArray (rawDataArray : [String]) -> [MyTimer] {
    
    var result : [MyTimer] = []
    
    if !rawDataArray.isEmpty {
        for item in rawDataArray {
            result.append(MyTimer(rawData: item))
        }
    }
    
    return result
}

class MyRecord : Hashable {
    
    lazy var rawData: String = ""
    lazy var recTitle : String = ""
    lazy var recDescription : String = ""
    lazy var recDateTime : String = ""
    lazy var recFullResult : String = ""
    var recLapsData : [String : String ] = [:]
    
    var hashValue: Int {
        return rawData.hashValue
    }
    
    static func == (lhs: MyRecord, rhs: MyRecord) -> Bool {
        return lhs.rawData == rhs.rawData
    }
    
    init (rawData: String) {
        self.rawData = rawData
        
        var dataArray : [String] = rawData.components(separatedBy: ["|"])
        
        for item in dataArray {
            if (item.contains("Title:")) {
                self.recTitle = String(item.split(separator: ":", maxSplits: 1)[1])
            } else if (item.contains("Description:")) {
                self.recDescription = item != "Description:" ? String(item.split(separator: ":", maxSplits: 1)[1]) : ""
            } else if (item.contains("DateTime:")) {
                self.recDateTime = String(item.components(separatedBy: [":", "+"])[1]) +
                ":" + String(item.components(separatedBy: [":", "+"])[2]) +
                ":" + String(item.components(separatedBy: [":", "+"])[3])
            } else if (item.contains("FullResult:")) {
                self.recFullResult = String(item.split(separator: ":", maxSplits: 1)[1])
            } else if (item.contains("LapsData:")) {
                var rawLapsData : String = String(item.split(separator: ":", maxSplits: 1)[1])
                rawLapsData = rawLapsData.components(separatedBy: ["{", "}"])[1]
                var lapDataArray : [String] = rawLapsData.components(separatedBy: ["&"])
                
                for itemLap in lapDataArray {
                    var lapData : [String] = itemLap.components(separatedBy: [">"])
                    
                    self.recLapsData[lapData[0].components(separatedBy: [":"])[1]] = lapData[1].components(separatedBy: [":"])[1]
                }
            }
        }
    }
}

class MyTimer : Hashable {
    
    lazy var rawData: String = ""
    lazy var timerTitle : String = ""
    lazy var timerDescription : String = ""
    lazy var timerDateTime : String = ""
    lazy var timerScheme : String = ""
    lazy var timerType : String = ""
    
    var hashValue: Int {
        return rawData.hashValue
    }
    
    static func == (lhs: MyTimer, rhs: MyTimer) -> Bool {
        return lhs.rawData == rhs.rawData
    }
    
    init (rawData: String) {
        self.rawData = rawData
        
        var dataArray : [String] = rawData.components(separatedBy: ["|"])
        
        for item in dataArray {
            if (item.contains("Title:")) {
                self.timerTitle = String(item.split(separator: ":", maxSplits: 1)[1])
            } else if (item.contains("Description:")) {
                self.timerDescription = item != "Description:" ? String(item.split(separator: ":", maxSplits: 1)[1]) : ""
            } else if (item.contains("DateTime:")) {
                self.timerDateTime = String(item.components(separatedBy: [":", "+"])[1]) +
                ":" + String(item.components(separatedBy: [":", "+"])[2]) +
                ":" + String(item.components(separatedBy: [":", "+"])[3])
            } else if (item.contains("TimerScheme:")) {
                self.timerScheme = String(item.split(separator: ":", maxSplits: 1)[1])
            } else if (item.contains("TimerType:")) {
                self.timerType = String(item.split(separator: ":", maxSplits: 1)[1])
            }
        }
    }
}

extension Array where Element: Equatable {

    mutating func remove(_ element: Element) {
        _ = index(of: element).flatMap {
            self.remove(at: $0)
        }
    }
}
