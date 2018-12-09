//
//  MoodRow.swift
//  WatchMoodTracker Extension
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//
import UIKit
import WatchKit

class MoodCell: NSObject {
    
    @IBOutlet weak var moodImage: WKInterfaceImage!
    
    @IBOutlet weak var moodLabel: WKInterfaceLabel!
    
    var moodObj: MoodEntry? {
        didSet{
            guard let moodObj = moodObj else {return}
            moodImage.setImage(UIImage(named: moodObj.mood.stringValue))
            moodLabel.setText(moodObj.mood.stringValue)
        }
    }
}
