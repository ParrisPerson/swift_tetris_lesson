 print( tetrisMove(array: &strArr))

var strArr = ["I", "2", "4", "3", "4", "5", "2", "0", "2", "2", "3", "3", "3"]

       
         
         func tetrisMove(array: inout [String]) -> Int {
            let gameWidth = 12
            let gameHeight = 10
            let pieceKey = array.removeFirst()
            let pieces = [
                    "I": [[1, 1, 1, 1]],

                    "J": [[1, 1, 1], [0, 0, 1]],

                    "L": [[1, 1, 1], [1, 0, 0]],

                    "O": [[1, 1], [1, 1]],

                    "S": [[0, 1, 1], [1, 1, 0]],

                    "T": [[1, 1, 1], [0, 1, 0]],

                    "Z": [[1, 1, 0], [0, 1, 1]]
            ]
            var board : [[Int]] = []
            for row in 0..<gameHeight {
             var ra : [Int] = []
              for col in 0..<gameWidth {
              ra.append(0)
              }
              board.append(ra)
            }

            for (index, level ) in array.enumerated() {
                for i in 0..<Int(level)! {
                board[gameHeight - 1 - i][index] = 1
              }
            }
         
            var piece = pieces[pieceKey]
            
        var tryPieces = [piece]

        piece = rotateCCW(piece: piece!)
        tryPieces.append(piece)

        piece = rotateCCW(piece: piece!)
        tryPieces.append(piece)

        piece = rotateCCW(piece: piece!)
        tryPieces.append(piece)

        var maxScore = 0

        for piece in tryPieces {
            let pieceHeight = piece?.count
            let pieceWidth = piece![0].count
            
            
            for row in 0..<(gameHeight - pieceHeight!) + 1 {
                for col in 0..<(gameWidth - pieceWidth) + 1 {
                    if validState(piece: piece!, row: row ,col: col, board: board) && validBottomState(piece: piece!, row: row, col: col, board: board) {
                        let score = evaluateScore(piece: piece!, row: row, col: col, board: board)
                        print(score)
                        if (score > maxScore){
                            maxScore = score
                        }
                    }
                }
            }
        }

        return maxScore
    }
    
    func validBottomState(piece: [[Int]], row: Int, col: Int, board: [[Int]]) -> Bool{
        for c in 0..<piece[0].count {
            for r in stride(from: piece.count - 1, through: 0, by: -1){
               
                if piece[r][c] == 1 {
                    if row + r + 1 >= board.count || board[row + r + 1][col + c] == 1 {
                        return true
                    }
                    break
                }
            }
        }
        return false
    }
    
    func validState(piece: [[Int]], row: Int, col: Int, board: [[Int]]) -> Bool{
        for r in 0..<piece.count {
            for c in 0..<piece[0].count {
                if board[row + r][col + c] == 1 && piece[r][c] == 1 {
                    return false
                }
            }
        }
        return true
    }
    
    func rotateCCW(piece: [[Int]]) ->  [[Int]]{
        let pieceHeight = piece.count
        let pieceWidth = piece[0].count

        var newPiece : [[Int]] = []
        
        for row in 0..<pieceWidth {
            var ra : [Int] = []
            for col in 0..<pieceHeight {
                ra.append(0)
            }
            newPiece.append(ra)
        }
        
        for row in 0..<pieceWidth{
            for col in 0..<pieceHeight{
                newPiece[row][col] = piece[col][pieceWidth - 1 - row]
            }
        }
        return newPiece
    }
    
    func evaluateScore(piece: [[Int]], row: Int, col: Int, board: [[Int]]) -> Int{
        var copy = board
        for r in 0..<piece.count{
            for c in 0..<piece[0].count{
                if piece[r][c] == 1{
                    copy[row + r][col + c] = 1
                }
            }
        }
        
        var score = 0
        for row in copy {
            var check = true
            for col in row {
                if col != 1 {
                    check = false
                }
            }
            if check {
                score += 1
            }
            
        }
        return score
    }
