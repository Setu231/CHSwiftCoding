//
//  CHSolution.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import Foundation

class CHSolution {
    
    typealias CHResponseTuple = (sum: Int, isPathAvailable: Bool, pathArray: [Int])
    
    var matrix: [[Int]]
    var rowLength: Int
    var columnLength: Int
    var minimumValue: Int
    var heap: [(Int, Bool, [Int])]
    var oldHeap: [(Int, Bool, [Int])]
    
    init(mat: [[Int]]) {
        self.matrix = mat
        self.rowLength = mat.count
        self.columnLength = mat[0].count
        self.minimumValue = Int.max
        self.heap = []
        self.oldHeap = []
    }
    
    func insertHeap(_ element: (Int, Bool, [Int])) {
        heap.append(element)
        var currentIndex = heap.count - 1
        while currentIndex > 0 && heap[currentIndex].0 < heap[(currentIndex-1)/2].0 {
            heap.swapAt(currentIndex, (currentIndex-1)/2)
            currentIndex = (currentIndex-1)/2
        }
    }
    
    func solve() -> CHResponseTuple {
        for row in 0..<rowLength {
            recursion(row: row, col: 0, rowArr: [], sm: 0, lastVal: nil)
        }
        if heap.isEmpty {
            return oldHeap[0]
        } else {
            return heap[0]
        }
    }
    
    func recursion(row: Int, col: Int, rowArr: [Int], sm: Int, lastVal: Int?) {
        var rowArr = rowArr
        if sm >= 50 {
            oldHeap.append((lastVal ?? 0, false, Array(rowArr.dropLast())))
            return
        }
        if col >= columnLength {
            insertHeap((sm, true, rowArr))
            minimumValue = min(minimumValue, sm)
            return
        }
        if matrix[row][col] == Int.max {
            return
        }
        let coordinates = [(0, 1), (-1, 1), (1, 1)]
        let tmp = matrix[row][col]
        matrix[row][col] = Int.max
        for coordinate in coordinates {
            var new_row = coordinate.0 + row
            let new_col = coordinate.1 + col
            if new_row < 0 {
                new_row = rowLength - 1
            }
            if new_row >= rowLength {
                new_row = 0
            }
            rowArr.append(row + 1)
            recursion(row: new_row, col: new_col, rowArr: rowArr, sm: sm + tmp, lastVal: sm)
            rowArr.removeLast()
        }
        matrix[row][col] = tmp
    }
}
