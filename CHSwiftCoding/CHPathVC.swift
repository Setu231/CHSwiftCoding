//
//  CHPathVC.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import UIKit

class CHPathVC: UIViewController {
    
    private(set) lazy var CHTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 20.0)
        textView.textAlignment = .left
        textView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return textView
    }()
    
    private(set) lazy var CHInformationLabel: UILabel = {
        let CHInformationLabel = UILabel()
        CHInformationLabel.font = UIFont.italicSystemFont(ofSize: 12.0)
        CHInformationLabel.numberOfLines = 0
        CHInformationLabel.textAlignment = .center
        CHInformationLabel.text = "Enter row of the matrix with a comma seperated values and use new line for all new rows. Please keep in mind to give same number of columns for each row."
        CHInformationLabel.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return CHInformationLabel
    }()
    
    private(set) lazy var CHFindButton: UIButton = {
        let CHFindButton = UIButton()
        CHFindButton.setTitle("Evaluate", for: .normal)
        CHFindButton.backgroundColor = .blue
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
        CHTextView.translatesAutoresizingMaskIntoConstraints = false
        CHInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        CHFindButton.translatesAutoresizingMaskIntoConstraints = false
        CHResponseLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CHTextView)
        view.addSubview(CHInformationLabel)
        view.addSubview(CHFindButton)
        view.addSubview(CHResponseLabel)
        CHTextView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        CHTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        CHTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        CHTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        CHInformationLabel.topAnchor.constraint(equalTo: CHTextView.bottomAnchor, constant: 50).isActive = true
        CHInformationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        CHInformationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        CHFindButton.topAnchor.constraint(equalTo: CHInformationLabel.bottomAnchor, constant: 80).isActive = true
        CHFindButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        CHFindButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        CHResponseLabel.topAnchor.constraint(equalTo: CHFindButton.bottomAnchor, constant: 50).isActive = true
        CHResponseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        CHResponseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        CHResponseLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100).isActive = true
        CHFindButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func onPressOfButton() {
        guard let textValue = CHTextView.text else {
            //put alert
            return
        }
        guard let inputArray = convertFromStringToGridArray(input: textValue) else {
            //put alert
            return
        }
        let solution = CHSolution(mat: inputArray)
        CHResponseLabel.text = "\(solution.solve().0) \n\(solution.solve().1) \n \(solution.solve().2)"
    }
    
    private func convertFromStringToGridArray(input: String) -> [[Int]]? {
        let rows = input.split(separator: "\n")
        guard let columns = rows.first?.split(separator: ",") else { return nil }
        var output = Array(repeating: Array(repeating: 0, count: columns.count), count: rows.count)
        
        for (rowIndex, row) in rows.enumerated() {
            let column = row.split(separator: ",")
            for (columnIndex, eachColumn) in column.enumerated() {
                if columnIndex < output[0].count {
                    output[rowIndex][columnIndex] = Int(eachColumn) ?? 0
                }
            }
        }
        
        return output
    }
}

