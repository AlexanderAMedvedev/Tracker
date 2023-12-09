//
//  Trackers.swift
//  Tracker
//
//  Created by Александр Медведев on 23.11.2023.
//

import Foundation
import UIKit

final class TrackersViewController: UIViewController {
    
    var currentDate = Date()
    
    //var weekDay: String = ""
    
    var categories: [TrackerCategory] = [
        TrackerCategory(header: "Важное",
                        relevantTrackers: [Tracker(name: "Полить растение",
                                                   color: .red,
                                                   emoji: "🍇",
                                                   timetable: TimeTable(daysInWeek: [7]))]),
        TrackerCategory(header: "Хорошо бы сделать",
                        relevantTrackers: [Tracker(name: "Убрать комнату",
                                                   color: .blue,
                                                   emoji: "🍉",
                                                   timetable: TimeTable(daysInWeek: [3,7])),
                                           Tracker(name: "Погулять",
                                                   color: .green,
                                                   emoji: "🍊",
                                                   timetable: TimeTable(daysInWeek: [1,2,3,4,5,6,7]))])]
    var showCategories: [TrackerCategory] = []
    
    var completedTrackers: [TrackerRecord] = []
    
    let trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem?.tintColor = .ypBlackDay
        
        addDatePicker()
        addHeader()
        setTrackersToShow()
        if showCategories.isEmpty {
            addStub()
        } else {
            addCollectionView()
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        currentDate = selectedDate
        setTrackersToShow()
        if showCategories.isEmpty {
            addStub()
        } else {
            trackersCollectionView.reloadData() 
        }
    }
    
    @objc private func didTapAdd() {
        let chooseTrackerType = ChooseTrackerTypeViewController()
        present(chooseTrackerType, animated: true)
    }
    
    private func addHeader()  {
        let header = UILabel()
        header.text = "Трекеры"
        header.font = UIFont.boldSystemFont(ofSize: 34)
        header.textColor = .ypBlackDay
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        return
    }
    
    private func addStub() {
        let image = UIImage(named: "trackerStub")
        let stubPicture = UIImageView(image: image)
        stubPicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubPicture)
        NSLayoutConstraint.activate([
            stubPicture.heightAnchor.constraint(equalToConstant: 80),
            stubPicture.widthAnchor.constraint(equalToConstant: 80),
            stubPicture.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stubPicture.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 147)
        ])
        
        let stubText = UILabel()
        stubText.text = "Что будем отслеживать?"
        stubText.font = UIFont.systemFont(ofSize: 12)
        stubText.textColor = .ypBlackDay
        stubText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubText)
        NSLayoutConstraint.activate([
            stubText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stubText.topAnchor.constraint(equalTo: stubPicture.bottomAnchor, constant: 8)
        ])
    }
    
    private func addDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    private func setTrackersToShow() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "cccc"
        let weekDay = dateFormatter.string(from: currentDate)
        var today: Int = 0
        if weekDay == "Monday" {
             today = 1
        } else if weekDay == "Tuesday" {
             today = 2
        } else if weekDay == "Wednesday" {
             today = 3
        } else if weekDay == "Thursday" {
             today = 4
        } else if weekDay == "Friday" {
             today = 5
        } else if weekDay == "Saturday" {
             today = 6
        } else if weekDay == "Sunday" {
             today = 7 }
        
        showCategories = []
        
        for category in categories {
            var trackers: [Tracker] = []
            for tracker in category.relevantTrackers {
                if tracker.timetable.daysInWeek.contains(today) {
                    trackers.append(tracker)
                }
            }
            if !trackers.isEmpty {
                var newCategory = TrackerCategory(header: category.header, relevantTrackers: trackers)
                showCategories.append(newCategory)
                //print(showCategories)
            }
         }
    }
    
    private func addCollectionView() {
        //trackersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        trackersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackersCollectionView)
        NSLayoutConstraint.activate([
            trackersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            trackersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -84),
            trackersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            trackersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ])
        trackersCollectionView.register(TrackerViewCell.self, forCellWithReuseIdentifier: TrackerViewCell.reuseIdentifier)
        trackersCollectionView.register(TrackerCellSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        trackersCollectionView.dataSource = self
        trackersCollectionView.delegate = self
    }
}
extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return showCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        showCategories[section].relevantTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerViewCell.reuseIdentifier, for: indexPath)
        guard let cell = (cell as? TrackerViewCell) else {
            print("Cell of the needed type was not created")
            return UICollectionViewCell()
        }
        cell.trackerName.text = showCategories[indexPath.section].relevantTrackers[indexPath.item].name
        cell.colorField.backgroundColor = showCategories[indexPath.section].relevantTrackers[indexPath.item].color
        cell.emoji.text = showCategories[indexPath.section].relevantTrackers[indexPath.item].emoji
        cell.trackerDoneButton.tintColor = cell.colorField.backgroundColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! TrackerCellSupplementaryView
        view.title.text = showCategories[indexPath.section].header
            return view
    }
}
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.bounds.width - 16) / 2, height: 148)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 9
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
            let indexPath = IndexPath(row: 0, section: section)
        
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                             height: UIView.layoutFittingExpandedSize.height),
                                                             withHorizontalFittingPriority: .required,
                                                             verticalFittingPriority: .fittingSizeLevel)
        }
}
