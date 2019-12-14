//
//  AVPlayer.swift
//  JYHelpers
//
//  Created by Jake Young on 4/18/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

import AVKit
import AVFoundation

extension AVPlayer {
    
    /// Seeks to a given percentage of the video, based on the duration.
    ///
    /// - Parameters:
    ///   - percentage: The percentage of content in the timeline to navigate to.
    ///   - addingToCurrentTime: Wether or not you want to use 0 as a starting point, or the current time. Defaults to `false`. If this were `true`, 20% would simply jump ahead 20% from the current time.
    public func seek(to percentage: Double, addingToCurrentTime: Bool = false) {
        print(#function)
        guard let durationTime = currentItem?.duration else { return }
        
        // Percentage of duration
        let percentageTime = durationTime.time(from: percentage)
        
        guard percentageTime.isValid && percentageTime.isNumeric else { return }
        
        // Percentage plus current time
        var targetTime: CMTime
        if addingToCurrentTime {
            targetTime = currentTime() + percentageTime
        } else {
            targetTime = percentageTime
        }
        targetTime = targetTime.convertScale(durationTime.timescale, method: .default)
        
        // Sanity checks
        guard targetTime.isValid && targetTime.isNumeric else { return }
        
        if targetTime > durationTime {
            targetTime = durationTime // seek to end
        }
        
        seek(to: targetTime)
    }
}

extension AVPlayer {
    
    /// The duration of the current asset.
    public var playerDuration: CMTime {
        let thePlayerItem = self.currentItem
        if thePlayerItem?.status == .readyToPlay {
            return thePlayerItem!.duration
        }
        return CMTime.invalid
    }
    
    /// The progress of the current asset.
    public var progress: Float {
        if CMTIME_IS_INVALID(playerDuration) { return 0.0 }
        let duration = Float(CMTimeGetSeconds(playerDuration))
        if duration.isFinite && duration > 0 {
            let time = Float(CMTimeGetSeconds(self.currentTime()))
            return time/duration
        }
        return 0.0
    }
    
}
