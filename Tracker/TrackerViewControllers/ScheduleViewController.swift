//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Александр Медведев on 04.12.2023.
//

import Foundation
import UIKit

final class ScheduleViewController: UIViewController {
    
    let week = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        addHeader()
        addScheduleTable()
        addDoneButton()
    }

        private func addHeader()  {
            let header = UILabel()
            header.text = "Расписание"
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

    private func addScheduleTable() {
        let scheduleTable = UITableView()
        scheduleTable.dataSource = self
        scheduleTable.delegate = self
        scheduleTable.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.reuseIdentifier)
        scheduleTable.translatesAutoresizingMaskIntoConstraints = false
        scheduleTable.layer.cornerRadius = 16
        view.addSubview(scheduleTable)
        NSLayoutConstraint.activate([
            scheduleTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scheduleTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scheduleTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            scheduleTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100),
            ])
    }
    
    private func addDoneButton() {
        let doneButton = UIButton()
        doneButton.backgroundColor = .ypBlackDay
        doneButton.setTitle("Готово", for: .normal)
        doneButton.setTitleColor(.ypWhiteDay, for: .normal)
        doneButton.layer.cornerRadius = 16
        doneButton.addTarget(self, action: #selector(self.didTapDoneButton), for: .touchUpInside
           )
        doneButton.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(doneButton)
           NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: 75),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
           ])
           return
        }
    
    @objc private func didTapDoneButton() {
    print("Did tap 'Готово' button")
    }
}
extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseIdentifier, for: indexPath)
        guard let cell = (cell as? ScheduleCell) else { 
            print("Did not produce the desired cell")
            return UITableViewCell()
        }
        cell.textView.text = week[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cell
    }
    
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}
