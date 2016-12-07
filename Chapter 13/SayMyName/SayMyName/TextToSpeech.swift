//
//  TextToSpeech.swift
//  SayMyName
//
//  Created by Matthew Knott on 31/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit
import AVFoundation


class TextToSpeech: NSObject {
    
    class func SayText(input : String) {
        let synth : AVSpeechSynthesizer = AVSpeechSynthesizer()
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: input)
        synth.speak(utterance)

    }

}
