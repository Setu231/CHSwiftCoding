//
//  CHPathVC.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import UIKit

class CHPathVC: UIViewController {
    
    let chPathVM = CHPathViewModel()
    
    private(set) lazy var CHTextViewLabel: UILabel = {
        let CHTextViewLabel = UILabel()
        CHTextViewLabel.font = UIFont.systemFont(ofSize: 18.0)
        CHTextViewLabel.numberOfLines = 0
        CHTextViewLabel.textAlignment = .left
        CHTextViewLabel.text = "Enter Matrix Value:"
        return CHTextViewLabel
    }()
    
    private(set) lazy var CHTextView: UITextView = {
        let CHTextView = UITextView()
        CHTextView.font = UIFont.boldSystemFont(ofSize: 20.0)
        CHTextView.textAlignment = .left
        CHTextView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return CHTextView
    }()
    
    private(set) lazy var CHInformationLabel: UILabel = {
        let CHInformationLabel = UILabel()
        CHInformationLabel.font = UIFont.italicSystemFont(ofSize: 12.0)
        CHInformationLabel.numberOfLines = 0
        CHInformationLabel.textAlignment = .left
        CHInformationLabel.text = "Note: Enter row of the matrix with a comma seperated values and use new line for all new rows. Please keep in mind to give same number of columns for each row.\n\nEg: 1,2,3,4,5\n      5,4,3,2,1\n      4,6,7,8,9"
        CHInformationLabel.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return CHInformationLabel
    }()
    
    private(set) lazy var CHFindButton: UIButton = {
        let CHFindButton = UIButton()
        CHFindButton.setTitle("Evaluate", for: .normal)
        CHFindButton.backgroundColor = .blue.withAlphaComponent(0.5)
        CHFindButton.addTarget(self, action: #selector(onPressOfButton), for: .touchUpInside)
        return CHFindButton
    }()
    
    private(set) lazy var CHResponseLabel: UILabel = {
        let CHInformationLabel = UILabel()
        CHInformationLabel.font = UIFont.systemFont(ofSize: 15.0)
        CHInformationLabel.numberOfLines = 0
        CHInformationLabel.textAlignment = .center
        CHInformationLabel.layer.borderColor = .init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        CHInformationLabel.layer.borderWidth = 1
        return CHInformationLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Least Cost Path"
        setupView()
    }
    
    private func setupView() {
        CHTextViewLabel.translatesAutoresizingMaskIntoConstraints = false
        CHTextView.translatesAutoresizingMaskIntoConstraints = false
        CHInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        CHFindButton.translatesAutoresizingMaskIntoConstraints = false
        CHResponseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(CHTextViewLabel)
        view.addSubview(CHTextView)
        view.addSubview(CHInformationLabel)
        view.addSubview(CHFindButton)
        view.addSubview(CHResponseLabel)
        
        NSLayoutConstraint.activate([
            CHTextViewLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            CHTextViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CHTextViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CHTextView.topAnchor.constraint(equalTo: CHTextViewLabel.bottomAnchor, constant: 20),
            CHTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CHTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CHTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            CHInformationLabel.topAnchor.constraint(equalTo: CHTextView.bottomAnchor, constant: 50),
            CHInformationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CHInformationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CHFindButton.topAnchor.constraint(equalTo: CHInformationLabel.bottomAnchor, constant: 80),
            CHFindButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CHFindButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CHResponseLabel.topAnchor.constraint(equalTo: CHFindButton.bottomAnchor, constant: 50),
            CHResponseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            CHResponseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            CHResponseLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100),
            CHFindButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func onPressOfButton() {
        guard let textValue = CHTextView.text, !textValue.isEmpty else {
            present(chPathVM.showAlertView(.emptyInput), animated: true)
            return
        }
        guard let inputArray = chPathVM.convertFromStringToGridArray(input: textValue) else {
            present(chPathVM.showAlertView(.invalidArray), animated: true)
            return
        }
        CHResponseLabel.text = chPathVM.getResponseLabelText(inputArray: inputArray)
    }
}

