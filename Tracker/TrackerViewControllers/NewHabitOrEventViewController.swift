//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Александр Медведев on 02.12.2023.
//

import Foundation
import UIKit

final class NewHabitOrEventViewController: UIViewController {
    
    var headerString: String
    
    var optionsString: [String]
    
    let optionsTableView = UITableView()

    let emojies = ["🙂","😻","🌺","🐶","❤️","😱","😇","😡","🥇","🥶","🤔","🙌","🍔","🥦","🏓","🎸","🏝","😪"]
    
    init(headerString: String, optionsString: [String]) {
        self.headerString = headerString
        self.optionsString = optionsString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        addHeader()
        addInputTextField()
        addOptionsTable()
        addEmoji()
        addCancelAndCreateButtons()
    }
    
    private func addOptionsTable() {
       optionsTableView.register(TrackerOptionCell.self, forCellReuseIdentifier: TrackerOptionCell.reuseIdentifier)
       optionsTableView.dataSource = self
       optionsTableView.delegate = self
       optionsTableView.layer.cornerRadius = 16
       optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionsTableView)
        NSLayoutConstraint.activate([
            optionsTableView.widthAnchor.constraint(equalToConstant: 343),
            optionsTableView.heightAnchor.constraint(equalToConstant: CGFloat(optionsString.count*75)),
            optionsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 237),
            optionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }
    
    private func addEmoji() {
        let emojiHeader = UILabel()
        emojiHeader.text = "Emoji"
        emojiHeader.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        emojiHeader.textColor = .ypBlackDay
        emojiHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojiHeader)
        NSLayoutConstraint.activate([
            emojiHeader.topAnchor.constraint(equalTo: optionsTableView.bottomAnchor, constant: 32),
            emojiHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            ])
            
        
        let emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        emojiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emojiCollectionView)
        NSLayoutConstraint.activate([
            emojiCollectionView.topAnchor.constraint(equalTo: emojiHeader.bottomAnchor),
            emojiCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emojiCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 348),
            emojiCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier)
        emojiCollectionView.dataSource = self
       // emojiCollectionView.delegate = EmojiCollectionViewClass()
    }
    
    private func addHeader()  {
        let header = UILabel()
        header.text = headerString
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
    
    private func addInputTextField() {
        let textField = TrackerNameTextField()
        textField.placeholder = "Введите название трекера"
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .ypGrayBackground
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return
    }
    
    private func addCancelAndCreateButtons() {
        let cancelButton = UIButton(type: .custom)
        cancelButton.backgroundColor = .ypWhiteDay
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.ypRedCancelButton, for: .normal)
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.masksToBounds = true                            // даём разрешение на рамку
        cancelButton.layer.borderWidth = 1                                 // толщина рамки
        cancelButton.layer.borderColor = UIColor.ypRedCancelButton.cgColor // красим рамку
        cancelButton.addTarget(self, action: #selector(self.didTapCancelButton), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
                
        let createButton = UIButton(type: .custom)
        createButton.backgroundColor = .ypGray
        createButton.setTitle("Создать", for: .normal)
        createButton.setTitleColor(.ypWhiteDay, for: .normal)
        createButton.layer.cornerRadius = 16
        createButton.addTarget(self, action: #selector(self.didTapCreateButton), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalTo: createButton.widthAnchor, multiplier: 1),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -8),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //
            createButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
            
    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
            
    @objc private func didTapCreateButton() {
        print("Create was Tapped")
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
        cell.textView.text = optionsString[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("Tapped Category button")
        } else {
            let scheduleViewController = ScheduleViewController()
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
        cell.symbol.text = emojies[indexPath.row]
        return cell
    }
}
