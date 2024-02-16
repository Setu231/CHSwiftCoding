//
//  CHSolution.swift
//  CHSwiftCoding
//
//  Created by Setu Desai on 2/16/24.
//

import Foundation

class CHSolution {
    var mat: [[Int]]
    var rowlen: Int
    var collen: Int
    var mn: Int
    var heap: [(Int, Bool, [Int])]
    var noHeap: [(Int, Bool, [Int])]
    var isPathAvailable = true
    
    init(mat: [[Int]]) {
        self.mat = mat
        self.rowlen = mat.count
        self.collen = mat[0].count
        self.mn = Int.max
        self.heap = []
        self.noHeap = []
    }
    
    func insertHeap(_ element: (Int, Bool, [Int])) {
        heap.append(element)
        var currentIndex = heap.count - 1
        while currentIndex > 0 && heap[currentIndex].0 < heap[(currentIndex-1)/2].0 {
            heap.swapAt(currentIndex, (currentIndex-1)/2)
            currentIndex = (currentIndex-1)/2
        }
    }
    
    func solve() -> (Int, Bool, [Int]) {
        for row in 0..<rowlen {
            recursion(row: row, col: 0, rowArr: [], sm: 0, lastVal: nil)
        }
        if heap.isEmpty {
            return noHeap[0]
        } else {
            return heap[0]
        }
    }
    
    func recursion(row: Int, col: Int, rowArr: [Int], sm: Int, lastVal: Int?) {
        var rowArr = rowArr
        if sm >= 50 {
            noHeap.append((lastVal ?? 0, false, Array(rowArr.dropLast())))
            return
        }
        if col >= collen {
            insertHeap((sm, true, rowArr))
            mn = min(mn, sm)
            print(mn)
            return
        }
        if mat[row][col] == Int.max {
            return
        }
        let coordinates = [(0, 1), (-1, 1), (1, 1)]
        let tmp = mat[row][col]
        mat[row][col] = Int.max
        for coordinate in coordinates {
            var new_row = coordinate.0 + row
            let new_col = coordinate.1 + col
            if new_row < 0 {
                new_row = rowlen - 1
            }
            if new_row >= rowlen {
                new_row = 0
            }
            rowArr.append(row + 1)
                recursion(row: new_row, col: new_col, rowArr: rowArr, sm: sm + tmp, lastVal: sm)
            rowArr.removeLast()
        }
        mat[row][col] = tmp
    }
}
