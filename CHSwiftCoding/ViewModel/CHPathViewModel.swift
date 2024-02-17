//
//  CHPathViewModel.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import UIKit

final class CHPathViewModel {
    func showAlertView(_ alertType: CHAlert) -> UIAlertController {
        let alertController = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okButton)
        return alertController
    }
    
    func convertFromStringToGridArray(input: String) -> [[Int]]? {
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
    
    func getResponseLabelText(inputArray: [[Int]]) -> String {
        let solution = CHSolution(mat: inputArray)
        return "\(solution.solve().sum) \n\(solution.solve().isPathAvailable) \n \(solution.solve().pathArray)"
    }
}
