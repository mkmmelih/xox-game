

import UIKit

protocol TicTacToeModelDelegate {
    func gameContinues(with nextPlayer: TicTacToeModel.Player)
    func gameOver(winner: TicTacToeModel.Player?)
}

final class TicTacToeModel {

    typealias Coordinate = (row: Int, column: Int)

    enum Player: String {
        case X
        case O

        var color: UIColor {
            switch self {
            case .X: return .black
            case .O: return .red
            }
        }

        var properName: String {
            return "Player \(self.rawValue)"
        }
    }

    var gameBoard: [[Player?]] = [[nil, nil, nil],
                                  [nil, nil, nil],
                                  [nil, nil, nil]]
    var currentPlayer: Player = .X
    var numberOfMoves = 0
    var delegate: TicTacToeModelDelegate?

    func reset() {
        gameBoard = [[nil, nil, nil],
                     [nil, nil, nil],
                     [nil, nil, nil]]
        currentPlayer = .X
        numberOfMoves = 0
    }

    private func getNextPlayer() -> Player {
        switch currentPlayer {
        case .X: return .O
        case .O: return .X
        }
    }

    func player(didChoose coordinate: Coordinate) {
        guard gameBoard[coordinate.row][coordinate.column] == nil else { return }

        numberOfMoves += 1

        gameBoard[coordinate.row][coordinate.column] = currentPlayer

        if checkForWin() {
            delegate?.gameOver(winner: currentPlayer)
        } else if numberOfMoves == 9 {
            delegate?.gameOver(winner: nil)
        } else {
            let nextPlayer = getNextPlayer()
            currentPlayer = nextPlayer
            delegate?.gameContinues(with: nextPlayer)
        }
    }

    private func checkForWin() -> Bool {
        guard numberOfMoves > 4 else { return false }

      
        if gameBoard[0][0] == currentPlayer,
           gameBoard[1][1] == currentPlayer,
           gameBoard[2][2] == currentPlayer {
            return true
        }

        if gameBoard[0][2] == currentPlayer,
           gameBoard[1][1] == currentPlayer,
           gameBoard[2][0] == currentPlayer {
            return true
        }

        for i in 0...2 {
            
            if gameBoard[i][0] == currentPlayer,
               gameBoard[i][1] == currentPlayer,
               gameBoard[i][2] == currentPlayer {
                return true
            }

            
            if gameBoard[0][i] == currentPlayer,
               gameBoard[1][i] == currentPlayer,
               gameBoard[2][i] == currentPlayer {
                return true
            }
        }

        return false
    }
}


