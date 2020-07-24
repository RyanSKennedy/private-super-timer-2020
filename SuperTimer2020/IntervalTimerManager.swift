//
//  IntervalTimerManager.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 25.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation

class IntervalTimerManager: ObservableObject {
    
    @Published var timerMode : TimerMode = .initial
    
    @Published var secondsLeft = 0 //UserDefaults.standard.integer(forKey: "timerLength")
    
    @Published var myIntervalTimerStruct : IntervalTimerStruct = IntervalTimerStruct()
    
    @Published var soundState : Bool = true

    var timer = Timer()
    
    func setTimeLength(seconds: Int) {
        let defaults = UserDefaults.standard
        defaults.set(seconds, forKey: "timerLength")
        secondsLeft = seconds
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                if self.secondsLeft == 0 {
                    if self.soundState { AudioServicesPlaySystemSound(SystemSoundID(1017)) }
                    self.reset()
                    return
                }
            
                self.secondsLeft -= 1
            
                if self.soundState {
                    if self.secondsLeft < 6 && self.secondsLeft != 0 {
                        AudioServicesPlaySystemSound(SystemSoundID(1016))
                    }
                }
            }
        )
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = self.secondsLeft == 0 ? 0 : UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause () {
        self.timerMode = .paused
        timer.invalidate()
    }
}
