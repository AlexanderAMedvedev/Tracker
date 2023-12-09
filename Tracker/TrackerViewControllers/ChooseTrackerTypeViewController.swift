//
//  ChooseTrackerType.swift
//  Tracker
//
//  Created by Александр Медведев on 01.12.2023.
//

import Foundation
import UIKit

final class ChooseTrackerTypeViewController: UIViewController {
        
    override func viewDidLoad() {
        view.backgroundColor = .ypWhiteDay
        addHeader()
        addHabitButton()
        addOneEventButton()
    }
    
    private func addHeader()  {
        let header = UILabel()
        header.text = "Создание трекера"
        header.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        header.textColor = .ypBlackDay
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 35),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return
    }
    
    private func addHabitButton()  {
        let habitButton = UIButton(type: .custom)
        habitButton.backgroundColor = .ypBlackDay
        habitButton.setTitle("Привычка", for: .normal)
        habitButton.setTitleColor(.ypWhiteDay, for: .normal)
        habitButton.layer.cornerRadius = 16
        habitButton.addTarget(self, action: #selector(self.didTapHabitButton), for: .touchUpInside
       )
        habitButton.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(habitButton)
       NSLayoutConstraint.activate([
        habitButton.heightAnchor.constraint(equalToConstant: 60),
        habitButton.widthAnchor.constraint(equalToConstant: 335),
        habitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 390),
        habitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
       ])
       return
   }
    @objc
    private func didTapHabitButton() {
        let newHabit = NewHabitOrEventViewController(headerString: "Новая привычка", optionsString: ["Категория","Расписание"])
        present(newHabit, animated: true)
    }
    
    private func addOneEventButton() {
        let oneEventButton = UIButton(type: .custom)
        oneEventButton.backgroundColor = .ypBlackDay
        oneEventButton.setTitle("Нерегулярное событие", for: .normal)
        oneEventButton.setTitleColor(.ypWhiteDay, for: .normal)
        oneEventButton.layer.cornerRadius = 16
        oneEventButton.addTarget(self, action: #selector(self.didTapOneEventButton), for: .touchUpInside
       )
        oneEventButton.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(oneEventButton)
       NSLayoutConstraint.activate([
        oneEventButton.heightAnchor.constraint(equalToConstant: 60),
        oneEventButton.widthAnchor.constraint(equalToConstant: 335),
        oneEventButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 466),
        oneEventButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
       ])
       return
    }
    
    @objc
    private func didTapOneEventButton() {
        let newEvent = NewHabitOrEventViewController(headerString: "Новое нерегулярное событие", optionsString: ["Категория"])
        present(newEvent, animated: true)
    }
}
