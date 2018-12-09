//
//  ViewController.swift
//  MoodTrackerProg
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//

import UIKit
import WatchConnectivity

extension Date{
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .short)
    }
}


class ViewController: UITableViewController, moveData, WCSessionDelegate{
    //Watch connectivity
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if error != nil {
            print("Error: \(error)")
        }else{
            print("Ready to communicate with apple watch.")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Deactivated")
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async {
            print("This is the user info \(userInfo)")
            
            guard let mood = userInfo["mood"] as? String, let date =  userInfo["date"] as? Date else{ return}
            let newEntry : MoodEntry!
            
            switch mood {
            case "amazing":
                newEntry = MoodEntry(mood: .amazing, date: date)
            case "good":
                newEntry = MoodEntry(mood: .good, date: date)
            case "bad":
                newEntry = MoodEntry(mood: .bad, date: date)
            case "terrible":
                newEntry = MoodEntry(mood: .terrible, date: date)
            case "neutral":
                newEntry = MoodEntry(mood: .neutral, date: date)
            default:
                return
            }
            
            self.entries.append(newEntry)
            self.tableView.reloadData()
        }
        
    }
    
    
    var entries: [MoodEntry] = []
    let cellId = "moodEntryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.rowHeight = 72
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Mood", style: .plain , target: self, action: #selector(addEntry))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Calendar", style: .plain, target: self, action: #selector(calendarTapped))
        
        if WCSession.isSupported(){
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(entries.count)
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    func saveTapped(mood: MoodEntry.Mood, date: Date, index: Int) {
        if index == 0{
            createEntry(mood: mood, date: date)
        }else{
            updateEntry(mood: mood, date: date, index: index)
        }
    }

    @objc func calendarTapped(){
        let calendarVC = CalendarViewController()
        present(calendarVC, animated: true, completion: nil )
    }
    
    @objc func addEntry () {
        print("working")
        let nextVC = MoodDetailedViewController()
        nextVC.delegate = self
        nextVC.mood = MoodEntry.Mood.none
        nextVC.date = Date()
        nextVC.index = nil
        navigationController?.pushViewController(nextVC, animated: true)
    }
    // Todo: Figure this out
    func createEntry(mood: MoodEntry.Mood, date: Date){
        let newEntry = MoodEntry.init(mood: mood, date: date)
        entries.insert(newEntry, at: 0)
        print(entries)
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func updateEntry(mood: MoodEntry.Mood, date: Date, index: Int){
        entries[index].mood = mood
        entries[index].date = date
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func deleteEntry(at index: Int){
        entries.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.configure(entry)
        
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailVC = MoodDetailedViewController()
        let selectedCell = entries[indexPath.row]
        DetailVC.mood = selectedCell.mood
        DetailVC.date = selectedCell.date
        DetailVC.isEditingEntry = true
        DetailVC.index = indexPath.row
        navigationController?.pushViewController(DetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteEntry(at: indexPath.row)
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
