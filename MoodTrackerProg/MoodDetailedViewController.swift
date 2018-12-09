//
//  MoodDetailedViewController.swift
//  MoodTrackerProg
//
//  Created by Kandice McGhee on 11/25/18.
//  Copyright © 2018 Kandice McGhee. All rights reserved.
//

import UIKit

protocol moveData {
    func saveTapped(mood: MoodEntry.Mood, date: Date, index: Int)
}

class MoodDetailedViewController: UIViewController {
    var date: Date!
    var mood: MoodEntry.Mood!
    var isEditingEntry = false
    var delegate: moveData?
    var index: Int!
    
    
    private func updateUI(){
        updateMood(to: mood)
        datePicker.date = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isEditingEntry)
        view.backgroundColor = .white
        setupOuterStackView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain
            , target: self, action: #selector(saveTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self , action: #selector(cancelTapped))
        
        updateUI()

    }
    
    @objc func cancelTapped (){
        navigationController?.popViewController(animated: true)
    }
    
    // Delegation
    @objc func saveTapped (){
        
        if let selectedIndex = index{
            delegate?.saveTapped(mood: mood, date: date, index: selectedIndex)
        }else{
            delegate?.saveTapped(mood: mood, date: date, index: 0)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "Mood"
        label.textAlignment = .center
        label.font = UIFont(name: "Title 2", size: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textAlignment = .center
        label.font = UIFont(name: "Title 2", size: 16)
        return label
    }()
    
    var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Amazing", for: .normal)
        button.tag = 1
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Good", for: .normal)
        button.tag = 2
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Neutral", for: .normal)
        button.tag = 3
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var button4: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Bad", for: .normal)
        button.tag = 4
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var button5: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Terrible", for: .normal)
        button.tag = 5
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func moodButtonTapped(_ sender: UIButton){
        switch sender.tag {
        case 1:
            updateMood(to: .amazing)
        case 2:
            updateMood(to: .good)
        case 3:
            updateMood(to: .neutral)
        case 4:
            updateMood(to: .bad)
        case 5:
            updateMood(to: .terrible)
        default:
            print("Unhandled button tag")
        }
    }

    func setupButtonsStackView() -> UIStackView {
        let buttonsStackView = UIStackView(arrangedSubviews: [button1,button2,button3,button4,button5])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 8
        
        return buttonsStackView
    }
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.addTarget(self, action: #selector(datePickerChanged), for: .touchUpInside)
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    @objc func datePickerChanged(_ sender: UIDatePicker){
        date = sender.date
    }
    
    func setupOuterStackView(){
        let outerStackView = UIStackView(arrangedSubviews: [moodLabel,setupButtonsStackView(),dateLabel, datePicker])
        outerStackView.axis = .vertical
        outerStackView.distribution = .fill
        outerStackView.spacing = 8
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            
            outerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            outerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            outerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            outerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    private func updateMood(to newMood: MoodEntry.Mood) {
        let unselectedColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        switch newMood {
        case .none:
            button1.backgroundColor = unselectedColor
            button2.backgroundColor = unselectedColor
            button3.backgroundColor = unselectedColor
            button4.backgroundColor = unselectedColor
            button5.backgroundColor = unselectedColor
        case .amazing:
            button1.backgroundColor = newMood.colorValue
            button2.backgroundColor = unselectedColor
            button3.backgroundColor = unselectedColor
            button4.backgroundColor = unselectedColor
            button5.backgroundColor = unselectedColor
        case .good:
            button1.backgroundColor = unselectedColor
            button2.backgroundColor = newMood.colorValue
            button3.backgroundColor = unselectedColor
            button4.backgroundColor = unselectedColor
            button5.backgroundColor = unselectedColor
        case .neutral:
            button1.backgroundColor = unselectedColor
            button2.backgroundColor = unselectedColor
            button3.backgroundColor = newMood.colorValue
            button4.backgroundColor = unselectedColor
            button5.backgroundColor = unselectedColor
        case .bad:
            button1.backgroundColor = unselectedColor
            button2.backgroundColor = unselectedColor
            button3.backgroundColor = unselectedColor
            button4.backgroundColor = newMood.colorValue
            button5.backgroundColor = unselectedColor
        case .terrible:
            button1.backgroundColor = unselectedColor
            button2.backgroundColor = unselectedColor
            button3.backgroundColor = unselectedColor
            button4.backgroundColor = unselectedColor
            button5.backgroundColor = newMood.colorValue
        }
        
        mood = newMood
    }
    
}
