//
//  StopwatchManager.swift
//  SuperTimer2020
//
//  Created by Ryan S.Kennedy on 24.06.2020.
//  Copyright © 2020 Ryan S.Kennedy. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation

class StopwatchManager: ObservableObject {
    
    @Published var timerMode: TimerMode = .initial

    @Published  var secondsLeft = 0 //UserDefaults.standard.integer(forKey: "timerLength")
    
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
                if self.secondsLeft > ((24 * 60 * 60) - 1) {
                    if self.soundState { AudioServicesPlaySystemSound(SystemSoundID(1017)) }
                    self.pause()
                    return
                }
            
                self.secondsLeft += 1
            
                if self.soundState {
                    AudioServicesPlaySystemSound(SystemSoundID(1016))
                }
            }
        )
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = 0 
        timer.invalidate()
    }
    
    func pause () {
        self.timerMode = .paused
        timer.invalidate()
    }
}

struct StopwatchManager_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
