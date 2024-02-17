//
//  CHAlert.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import Foundation

enum CHAlert {
    case emptyInput, invalidArray
    
    var title: String {
        switch self {
        case .emptyInput:
            return "Please Enter Valid Input"
        case .invalidArray:
            return "Could not be Mapped"
        }
    }
    
    var message: String {
        switch self {
        case .emptyInput:
            return "Do not leave the text area empty, please enter a value you need to evaluate"
        case .invalidArray:
            return "Please follow the instruction given below the text area to get the solution"
        }
    }
}
