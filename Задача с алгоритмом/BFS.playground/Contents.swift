import Foundation

func minDistanceMatrix(_ matrix: [[Int]]) -> [[Int]] {
	let A = matrix.count
	let B = matrix[0].count
	var outputMatrix = [[Int]](repeating: [Int](repeating: Int.max, count: B), count: A)
	var queue = [(Int, Int)]()

	// добавляем ячейки со значением 1 в очередь и устанавливаем их расстояние в 0
	for i in 0..<A {
		for j in 0..<B {
			if matrix[i][j] == 1 {
				queue.append((i, j))
				outputMatrix[i][j] = 0
			}
		}
	}

	// обрабатываем ячейки в очереди
	while !queue.isEmpty {
		let (row, col) = queue.removeFirst()
		for (r, c) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
			let newRow = row + r
			let newCol = col + c
			if newRow >= 0 && newRow < A && newCol >= 0 && newCol < B && outputMatrix[newRow][newCol] > outputMatrix[row][col] + 1 {
				outputMatrix[newRow][newCol] = outputMatrix[row][col] + 1
				queue.append((newRow, newCol))
			}
		}
	}

	return outputMatrix
}

let input = [[1,0,1],
			 [0,1,0],
			 [0,0,0]]

minDistanceMatrix(input)
