//
//  MoodController.swift
//  WatchMoodTracker Extension
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MoodController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var entries: [MoodEntry] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let amazingEntry = MoodEntry.init(mood: .amazing, date: Date())
        let goodEntry = MoodEntry.init(mood: .good, date: Date())
        let neutralEntry = MoodEntry.init(mood: .neutral, date: Date())
        let badEntry = MoodEntry.init(mood: .bad, date: Date())
        let terribleEntry = MoodEntry.init(mood: .terrible, date: Date())
        
        entries = [amazingEntry, goodEntry, neutralEntry, badEntry, terribleEntry]
        
        // Set the number of rows in the table in the watch
        table.setNumberOfRows(entries.count, withRowType: "moodCell")
        
        for index in 0 ..< entries.count{
            guard let controller = table.rowController(at: index) as? MoodCell else {return}
            controller.moodObj = entries[index]
        }
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let mood = entries[rowIndex]
        
        if WCSession.default.isReachable == true {
            // App is reachable
            WCSession.default.transferUserInfo(["mood": mood.mood.stringValue, "date": mood.date])
        }
        pop()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
