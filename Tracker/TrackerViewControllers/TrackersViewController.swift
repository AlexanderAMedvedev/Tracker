//
//  Trackers.swift
//  Tracker
//
//  Created by Александр Медведев on 23.11.2023.
//

import Foundation
import UIKit
protocol AddTrackerDelegateProtocol: AnyObject {
    func addTracker(_ trackerCategoryHeader: String, _ tracker: Tracker)
    func closeView()
}

final class TrackersViewController: UIViewController, UITextFieldDelegate {
    
    var helperCoreData = HelperCoreData()
    
    var currentDate = Date()
        
    var categories: [TrackerCategory] = []
        /*TrackerCategory(header: "Важное",
                        relevantTrackers: [Tracker(id: UUID(),
                                                    name: "Полить растение",
                                                   color: .red,
                                                   emoji: "🍇",
                                                   schedule: [7])]),
        TrackerCategory(header: "Хорошо бы сделать",
                        relevantTrackers: [Tracker(id: UUID(),
                                                   name: "Убрать комнату",
                                                   color: .blue,
                                                   emoji: "🍉",
                                                   schedule: [3,7]),
                                           Tracker(id: UUID(),
                                                   name: "Погулять",
                                                   color: .green,
                                                   emoji: "🍊",
                                                   schedule: [1,2,3,4,5,6,7])])]*/
    var showCategories: [TrackerCategory] = []
    
    var completedTrackers: [TrackerRecord] = []
    
    let trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.placeholder = "Поиск"
        textField.delegate = self
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helperCoreData.delegate = self
        if showCategories.isEmpty {
            addStub()
        } else {
            addCollectionView()
        }
        updateTrackers()
        view.backgroundColor = .ypWhiteDay
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "plusAddTracker"), style: .done, target: self, action: #selector(didTapAdd))
            //barButtonSystemItem: .add, target: self, action: )
        navigationItem.leftBarButtonItem?.tintColor = .ypBlackDay
        
        addDatePicker()
        addHeader()
       // addSearchTextField()
    }

    private func addSearchTextField() {
        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.heightAnchor.constraint(equalToConstant: 36),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
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
        let chooseTrackerType = ChooseTrackerTypeViewController(delegate: self)
        present(chooseTrackerType, animated: true)
    }
    
    private func addHeader()  {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Трекеры"
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
        datePicker.locale = Locale(identifier: "ru_RU")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalToConstant: 120)])
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
                if tracker.schedule.contains(today) {
                    trackers.append(tracker)
                }
            }
            if !trackers.isEmpty {
                let newCategory = TrackerCategory(header: category.header, relevantTrackers: trackers)
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
            trackersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
        let tracker = showCategories[indexPath.section].relevantTrackers[indexPath.item]
        
        cell.delegate = self
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        let completedDays = completedTrackers.filter { $0.id == tracker.id}.count
        
        cell.configureCell(tracker, at: indexPath, isCompletedToday: isCompletedToday, completedDays: completedDays)
        
        return cell
    }
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        completedTrackers.contains { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: currentDate)
            return trackerRecord.id == id && isSameDay
        }
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
//MARK: - AddTrackerDelegateProtocol
extension TrackersViewController: AddTrackerDelegateProtocol {
    func closeView() {
        dismiss(animated: true)
    }
    
    func addTracker(_ trackerCategoryHeader: String, _ tracker: Tracker) {
        dismiss(animated: true)
        
        helperCoreData.addTrackerToCoreData(model: tracker, categoryHeader: trackerCategoryHeader)
        /*if !categories.isEmpty {
            var removeIndex: Int?
            var ListOfTrackers: [Tracker] = []
            for i in 0..<categories.count {
                if categories[i].header == trackerCategoryHeader {
                    ListOfTrackers = categories[i].relevantTrackers
                    removeIndex = i
                }
            }
            
            guard let removeIndex else { return }
            categories.remove(at: removeIndex)
            
            ListOfTrackers.append(tracker)
            let remasteredCategory = TrackerCategory(header: trackerCategoryHeader, relevantTrackers: ListOfTrackers)
            categories.insert(remasteredCategory, at: removeIndex)
        } else {
            var firstListOfTrackers: [Tracker] = []
            firstListOfTrackers.append(tracker)
            let firstCategory = TrackerCategory(header: trackerCategoryHeader, relevantTrackers: firstListOfTrackers)
            categories.append(firstCategory)
            
        }
        if showCategories.isEmpty {
            takeNewTrackerIntoAccount(regime: "showCollectionViewFirstTime")
        } else {
            takeNewTrackerIntoAccount(regime: "collectionViewReloadData")
        }*/
    }
    
    private func takeNewTrackerIntoAccount(regime: String) {
        
        setTrackersToShow()
        
        if showCategories.isEmpty {
            addStub()
        } else  if regime == "showCollectionViewFirstTime" {
            addCollectionView()
        } else if regime == "collectionViewReloadData" {
            trackersCollectionView.reloadData()
        }
    }
}

extension TrackersViewController: TrackerCellDelegate {
    func completeTracker(id: UUID, at indexPath: IndexPath) {
        let todayDate = Date()
        if currentDate > todayDate {
            print("Попытка изменить запись для будущей даты")
        } else {
            let trackerRecord = TrackerRecord(id: id, date: currentDate)
            completedTrackers.append(trackerRecord)
            trackersCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    func uncompleteTracker(id: UUID, at indexPath: IndexPath) {
        let todayDate = Date()
        if currentDate > todayDate {
            print("Попытка изменить запись для будущей даты")
        } else {
            completedTrackers.removeAll { trackerRecord in
                let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: currentDate)
                return trackerRecord.id == id && isSameDay
            }
            trackersCollectionView.reloadItems(at: [indexPath])
        }
    }
}

extension TrackersViewController: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TrackersViewController: HelperCoreDataDelegate {
    func updateTrackers() {
        categories = helperCoreData.fetchCategory()
        if showCategories.isEmpty {
            takeNewTrackerIntoAccount(regime: "showCollectionViewFirstTime")
        } else {
            takeNewTrackerIntoAccount(regime: "collectionViewReloadData")
        }
        
    }
}
