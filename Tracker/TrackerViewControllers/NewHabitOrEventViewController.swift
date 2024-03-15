//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Александр Медведев on 02.12.2023.
//

import Foundation
import UIKit

final class NewHabitOrEventViewController: UIViewController {
    
    private let screenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 900)
        return scrollView
    }()
    
    var headerString: String
    
    var trackerCategoryHeader: String?
    
    var optionsString: [String]
    
    let optionsTableView = UITableView()
    
    let textField = TrackerNameTextField()
    
    var timeTable: [Int] = []
    
    let createButton: UIButton = {
        var createButton = UIButton(type: .custom)
        return createButton
    }()

    let cancelButton: UIButton = {
        var cancelButton = UIButton(type: .custom)
        return cancelButton
    }()
    
    let emojies = ["🙂","😻","🌺","🐶","❤️","😱","😇","😡","🥇","🥶","🤔","🙌","🍔","🥦","🏓","🎸","🏝","😪"]
    
    let emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var helperColorCollection:  HelperColorCollection?
    
    var emoji: String?
    
    var color: UIColor?
    
    weak var delegate: IntermediateDelegateProtocol?
    
    init(headerString: String, optionsString: [String], delegate: IntermediateDelegateProtocol) {
        self.headerString = headerString
        self.optionsString = optionsString
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        helperColorCollection = HelperColorCollection(delegate: self)
        
        addScreenScroll()
        addHeader()
        addInputTextField()
        addOptionsTable()
        addEmoji()
        addColorSelection()
        addCancelAndCreateButtons()
    }
    private func addScreenScroll() {
        view.addSubview(screenScrollView)
        NSLayoutConstraint.activate([
            screenScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            screenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            screenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    private func addColorSelection() {
        let colorHeader = UILabel()
        colorHeader.text = "Цвет"
        colorHeader.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        colorHeader.textColor = .ypBlackDay
        colorHeader.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(colorHeader)
        NSLayoutConstraint.activate([
            colorHeader.topAnchor.constraint(equalTo: emojiCollectionView.bottomAnchor, constant: 16),
            colorHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28)
            ])
        
        colorCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseIdentifier)
        colorCollectionView.dataSource = helperColorCollection
        colorCollectionView.delegate = helperColorCollection
        colorCollectionView.allowsMultipleSelection = false
        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(colorCollectionView)
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: colorHeader.bottomAnchor),
            colorCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            colorCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            colorCollectionView.heightAnchor.constraint(equalToConstant: 180)
            ])
    }
    
    private func addOptionsTable() {
       optionsTableView.register(TrackerOptionCell.self, forCellReuseIdentifier: TrackerOptionCell.reuseIdentifier)
       optionsTableView.dataSource = self
       optionsTableView.delegate = self
       optionsTableView.layer.cornerRadius = 16
       optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(optionsTableView)
        NSLayoutConstraint.activate([
            optionsTableView.widthAnchor.constraint(equalToConstant: 343),
            optionsTableView.heightAnchor.constraint(equalToConstant: CGFloat(optionsString.count*75)),
            optionsTableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            optionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    private func addEmoji() {
        let emojiHeader = UILabel()
        emojiHeader.text = "Emoji"
        emojiHeader.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        emojiHeader.textColor = .ypBlackDay
        emojiHeader.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(emojiHeader)
        NSLayoutConstraint.activate([
            emojiHeader.topAnchor.constraint(equalTo: optionsTableView.bottomAnchor, constant: 32),
            emojiHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            ])
            
        emojiCollectionView.allowsMultipleSelection = false
        emojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(emojiCollectionView)
        NSLayoutConstraint.activate([
            emojiCollectionView.topAnchor.constraint(equalTo: emojiHeader.bottomAnchor),
            emojiCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            emojiCollectionView.heightAnchor.constraint(equalToConstant: 180),
            emojiCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            ])
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier)
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
    }
    
    private func addHeader()  {
        let header = UILabel()
        header.text = headerString
        header.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        header.textColor = .ypBlackDay
        header.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: screenScrollView.topAnchor, constant: 35),
            header.centerXAnchor.constraint(equalTo: screenScrollView.centerXAnchor)
        ])
        return
    }
    
    private func addInputTextField() {
        //let textField = TrackerNameTextField()
        textField.delegate = self
        textField.placeholder = "Введите название трекера"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .ypGrayBackground
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.topAnchor.constraint(equalTo: screenScrollView.topAnchor, constant: 100),
            textField.centerXAnchor.constraint(equalTo: screenScrollView.centerXAnchor)
        ])
        return
    }
    
    private func addCancelAndCreateButtons() {
        cancelButton.backgroundColor = .ypWhiteDay
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.ypRedCancelButton, for: .normal)
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.masksToBounds = true                            // даём разрешение на рамку
        cancelButton.layer.borderWidth = 1                                 // толщина рамки
        cancelButton.layer.borderColor = UIColor.ypRedCancelButton.cgColor // красим рамку
        cancelButton.addTarget(self, action: #selector(self.didTapCancelButton), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(cancelButton)
                
        
        createButton.backgroundColor = .ypGray
        createButton.setTitle("Создать", for: .normal)
        createButton.setTitleColor(.ypWhiteDay, for: .normal)
        createButton.layer.cornerRadius = 16
        createButton.addTarget(self, action: #selector(self.didTapCreateButton), for: .touchUpInside)
        createButton.isEnabled = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        screenScrollView.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalTo: createButton.widthAnchor, multiplier: 1),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -8),
            cancelButton.topAnchor.constraint(equalTo: colorCollectionView.bottomAnchor, constant: 16),
            //
            createButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            ])
    }
            
    @objc private func didTapCancelButton() {
        delegate?.closeView()
    }
            
    @objc private func didTapCreateButton() {
        if let trackerCategoryHeader {
            createTracker()
        }
    }
    
    func createTracker() {
        guard let trackerCategoryHeader,
              let emoji else { return }
        //создание расписания для нерегулярного трекера
        if timeTable.count == 0 {
            timeTable = [1,2,3,4,5,6,7]
        }
            let tracker = Tracker(id: UUID(),
                                  name: textField.text ?? "",
                                  color: color ?? .blue,
                                  emoji: emoji,
                                  schedule: timeTable,
                                  records: []
                                  )
        delegate?.addTracker(trackerCategoryHeader, tracker)
        }
    
    func refreshTable(indexPath: IndexPath) {
        optionsTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func makeCreateButtonActive() {
        createButton.isEnabled = true
        createButton.backgroundColor = .ypBlackDay
    }
}

extension NewHabitOrEventViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackerOptionCell.reuseIdentifier, for: indexPath)
        
        guard let cell = (cell as? TrackerOptionCell) else {
            print("Cell of the needed type was not created")
            return UITableViewCell()
        }
        
        cell.mainTitleView.text = optionsString[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        if indexPath.row == optionsString.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        }
        cell.selectionStyle = .none
        // set the subtitle in case of "category" cell after pushing the row
        if indexPath.row == 0 && trackerCategoryHeader != nil {
            cell.subTitleView.text = trackerCategoryHeader
        }
        // set the subtitle in case of "timeTable" cell after pushing "Готово"
        if indexPath.row == 1 && timeTable.count > 0 {
            var days: String = ""
            for day in timeTable {
                if day == 1 {
                    days += "Пон., "
                } else if day == 2 {
                    days += "Вт., "
                } else if day == 3 {
                    days += "Ср., "
                } else if day == 4 {
                    days += "Чет., "
                } else if day == 5 {
                    days += "Пят., "
                } else if day == 6 {
                    days += "Суб., "
                } else if day == 7 {
                    days += "Вос., "
                }
            }
            
            if timeTable.count < 7  {
                days.removeLast(2)
                cell.subTitleView.text = days
            } else if timeTable.count == 7 {
                cell.subTitleView.text = "Каждый день"
            }
    }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            trackerCategoryHeader = "Важное"
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            let scheduleViewController = ScheduleViewController(delegate: self)
            present(scheduleViewController, animated: true)
        }
    }
}
extension NewHabitOrEventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier, for: indexPath)
        guard let cell = (cell as? EmojiCollectionViewCell) else {
            print("Cell of the needed type was not created")
            return UICollectionViewCell()
        }
        cell.emojiSymbol.text = emojies[indexPath.row]
        return cell
    }
}

extension NewHabitOrEventViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 52, height: 52)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
}
extension NewHabitOrEventViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = (collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell)
        cell.contentView.backgroundColor = .ypGrayForChoosingEmoji
        cell.contentView.layer.cornerRadius = 16
        emoji = emojies[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = (collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell)
        cell.contentView.backgroundColor = .none
    }
    
}

extension NewHabitOrEventViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
