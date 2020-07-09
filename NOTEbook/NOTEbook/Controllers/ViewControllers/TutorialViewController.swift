//
//  TutorialViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 7/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    let tutorialInformation = [TutorialInfo(imageName: "PickerButton", description: "The picker screen allows you to pick a note and see its fingering."), TutorialInfo(imageName: "TODO", description: "Each note has alternate fingerings that you can scroll through to find the perfect one."), TutorialInfo(imageName: "TODO", description: "Swipe left and right to see notes down a half step, and righ tot left ot see notes up a half step."), TutorialInfo(imageName: "TODO", description: "Use the picker to select any note by swiping left or right or tapping on the desired note if it is visible."), TutorialInfo(imageName: "GridButton", description: "The grid screen allows you to see all the notes and fingerings together."), TutorialInfo(imageName: "gear", description: "Customize your experience in settings and send suggestions to the developer.")]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Welcome to NOTEbook!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "MediumRed")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.setTitleColor(UIColor(named: "LightestAqua"), for: .normal)
        button.backgroundColor = UIColor(named: "MediumRed")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "LightestAqua")
        
        addTitleLabel()
        addBottomButton()
        setupTableView()
    }
    
    func addTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func addBottomButton() {
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bottomButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor)
        ])
    }
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
}

extension TutorialViewController: UITableViewDelegate {}

extension TutorialViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialInformation.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.backgroundColor = .clear
        
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = UIColor(named: "DarkAqua")
        descriptionLabel.text = tutorialInformation[indexPath.row].description
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 200),
            descriptionLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

#if DEBUG
import SwiftUI

struct TutorialViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return TutorialViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update code
    }
}

struct TutorialViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TutorialViewControllerRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            TutorialViewControllerRepresentable()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif