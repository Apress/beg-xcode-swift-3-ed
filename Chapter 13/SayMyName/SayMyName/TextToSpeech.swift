//
//  TextToSpeech.swift
//  SayMyName
//
//  Created by Matthew Knott on 21/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import AVFoundation

class TextToSpeech: NSObject {
    class func SayText(input : String) {
        var synth : AVSpeechSynthesizer = AVSpeechSynthesizer()
        var utterance : AVSpeechUtterance = AVSpeechUtterance(string: input)
        utterance.rate = (AVSpeechUtteranceMinimumSpeechRate) * 0.25
        utterance.volume = 1
        utterance.pitchMultiplier = 1
        synth.speakUtterance(utterance)
        
        
        
    }
    
    class func SayText(input : String, iRate : Float) {
        var synth : AVSpeechSynthesizer = AVSpeechSynthesizer()
        var utterance : AVSpeechUtterance = AVSpeechUtterance(string: input)
        utterance.rate = iRate
        utterance.volume = 1
        utterance.pitchMultiplier = 1
        synth.speakUtterance(utterance)
        
    }
}