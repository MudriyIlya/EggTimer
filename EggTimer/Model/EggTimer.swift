//
//  EggTimer.swift
//  EggTimer
//
//  Created by Ilya Mudriy on 09/03/2019.
//  Copyright © 2019 Ilya Mudriy. All rights reserved.
//

import Foundation
protocol EggTimerProtocol {
    func timeRemainingOnTimer(_ timer: EggTimer, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: EggTimer)
}
class EggTimer {
    
    var delegate: EggTimerProtocol?
    
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 360
    var elapsedTime: TimeInterval = 0
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    var isPaused: Bool {
        return timer == nil && elapsedTime > 0
    }
    
    @objc dynamic func timerAction() {
        // 1
        guard let startTime = startTime else {
            return
        }
        // 2
        elapsedTime = -startTime.timeIntervalSinceNow
        // 3
        let secondsRemaining = (duration - elapsedTime).rounded()
        // 4
        if secondsRemaining <= 0 {
            resetTimer()
            delegate?.timerHasFinished(self)
        } else {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    func stopTimer() {
        // really just pauses the timer
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    func resetTimer() {
        // stop the timer & reset back to start
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 360
        elapsedTime = 0
        
        timerAction()
    }
}
