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
    
    var switchStates = [false, false, false, false, false, false, false,]
    
    weak var delegate: NewHabitOrEventViewController?
    
    private var timeTable: [Int] = []
    
    init(delegate: NewHabitOrEventViewController) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
           ])
           return
        }
    
    @objc private func didTapDoneButton() {
        for i in 0..<switchStates.count {
            if switchStates[i] == true {
                timeTable.append(i+1)
            }
        }
        delegate?.timeTable = timeTable
        delegate?.refreshTable(indexPath: IndexPath(row: 1, section: 0))
        dismiss(animated: true)
        //print(timeTable)
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
        cell.switchDay.tag = indexPath.row
        cell.switchDay.addTarget(self, action: #selector(self.switchValueDidChange(_:)), for: .valueChanged)
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if indexPath.row == 6 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        }
        
        cell.configureScheduleCell(for: indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        switchStates[sender.tag] = sender.isOn
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}
