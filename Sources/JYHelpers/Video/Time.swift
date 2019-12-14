//
//  Time.swift
//  JYHelpers
//
//  Created by Jake Young on 4/18/19.
//  Copyright © 2019 Jake Young. All rights reserved.
//

import AVKit

/** Formatting time objects from Int, Double, and Floats is hard. These helper methods try to make string interpolation for these types of objects easier.
 
    In the past you might have done something like this:
 
    ```
     10000.asString(style: .positional)  // 2:46:40
     10000.asString(style: .abbreviated) // 2h 46m 40s
     10000.asString(style: .short)       // 2 hr, 46 min, 40 sec
     10000.asString(style: .full)        // 2 hours, 46 minutes, 40 seconds
     10000.asString(style: .spellOut)    // two hours, forty-six minutes, forty seconds
     10000.asString(style: .brief)       // 2hr 46min 40sec

    ```

    Adding an instance method with a `DateFormatter.UnitsStyle` creates different strings with the time formatted, these methods simplify this approach by taking advantage of Swift's string interpolation extensibility.
 
 **/

extension String.StringInterpolation {
    /// Easily format a duration in seconds (Double) in a string. The default is HH:MM:SS but you can pass any `DateComponent` unit types you desire. This is common to most time reporting with media controls.
    ///
    /// This uses the date components formatter and should take localization into account.
    /// - Parameters:
    ///   - duration: The duration in seconds (assumes 60s = minute)
    ///   - style: The style in which the values will be localized.
    ///   - units: The precision of units for the formatter. Default is `.hour, .minute, .second` and formats to HH:MM:SS.
    public mutating func appendInterpolation(duration: Double, style: DateComponentsFormatter.UnitsStyle, units: NSCalendar.Unit = [.hour, .minute, .second]) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = style
        guard let value = formatter.string(from: TimeInterval(duration)) else { return }
        appendLiteral(value)
    }
    /// Easily format a duration in seconds (Double) to HH:MM:SS string. This is common to most time reporting with media controls.
    ///
    /// This uses the date components formatter and should take localization into account.
    /// - Parameters:
    ///   - time: The time as a `CMTime` object.
    ///   - style: The style in which the values will be localized.
    ///   - units: The precision of units for the formatter. Default is `.hour, .minute, .second` and formats to HH:MM:SS.
    public mutating func appendInterpolation(time: CMTime, style: DateComponentsFormatter.UnitsStyle, units: NSCalendar.Unit = [.hour, .minute, .second]) {
        appendInterpolation(duration: Double(CMTimeGetSeconds(time)), style: style, units: units)
    }
}

extension CMTime {
    /// Gets a new time object based on the % of an existing time object. For example, if you needed 80% of 10 minutes, you would get back an CMTime of 8 minutes. This is helpful when working with audio or video based timelines and pairs well with `AVPlayer` and `AVFoundation` concepts.
    ///
    /// - Parameter percentage: The % of time we'd like to create the new object from.
    /// - Returns: A new `CMTime` object scaled by the provided percentage.
    public func time(from percentage: Double) -> CMTime {
        
        let percentageTime = CMTimeMultiplyByFloat64(self, multiplier: Float64(percentage))
        
        guard percentageTime.isValid && percentageTime.isNumeric else { return CMTime.invalid }
        
        let targetTime = percentageTime.convertScale(self.timescale, method: .default)
        
        // Sanity checks
        guard targetTime.isValid && targetTime.isNumeric else { return CMTime.invalid }
        
        return targetTime
        
    }
}
