//
// Tic Tac Toe Game
// Created by Geoff Lewis on 22/04/2025.
// 
import SwiftUI

struct ContentView: View {
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var currentPlayer: String = "X" // Keeps track of whose turn it is
    @State private var winner: String? = nil

    var body: some View {
        VStack(spacing: 10) {
            if let winner = winner {
                Text(winner == "Draw" ? "It's a Draw!" : "Winner: \(winner) 🎉")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                Text("Current Turn: \(currentPlayer)")
                    .font(.headline)
            }

            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { column in
                        Button(action: {
                            makeMove(row: row, column: column)
                        }) {
                            Text(board[row][column])
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .border(Color.black, width: 1)
                                .font(.largeTitle)
                                .foregroundColor(board[row][column] == "X" ? .blue : .red)
                        }
                        .disabled(!board[row][column].isEmpty || winner != nil) // Prevents moves after win
                    }
                }
            }

            Button("Restart Game") {
                resetGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    /// Function to make a move on the board
    func makeMove(row: Int, column: Int) {
        if board[row][column].isEmpty && winner == nil {  // Prevent moves after game ends
            board[row][column] = currentPlayer
            checkForWinner()
            if winner == nil {
                currentPlayer = (currentPlayer == "X") ? "O" : "X"
                if currentPlayer == "O" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        makeComputerMove()
                    }
                }
            }
        }
    }
    
    func makeComputerMove() {
        var availableMoves = [(Int, Int)]()
        for row in 0..<3 {
            for column in 0..<3 {
                if board[row][column].isEmpty {
                    availableMoves.append((row, column))
                }
            }
        }
        if let move = availableMoves.randomElement() {
            board[move.0][move.1] = "O"
            checkForWinner()
            if winner == nil {
                currentPlayer = "X"
            }
                    
        }
    }

    /// Function to check if a player has won
    func checkForWinner() {
        // 1. Check Rows
        for row in 0..<3 {
            if board[row][0] != "" && board[row][0] == board[row][1] && board[row][1] == board[row][2] {
                winner = board[row][0] // Set winner to "X" or "O"
                return
            }
        }

        // 2. Check Columns
        for col in 0..<3 {
            if board[0][col] != "" && board[0][col] == board[1][col] && board[1][col] == board[2][col] {
                winner = board[0][col]
                return
            }
        }

        // 3. Check Diagonals
        if board[0][0] != "" && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            winner = board[0][0]
            return
        }

        if board[0][2] != "" && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            winner = board[0][2]
            return
        }

        // 4. Check for Draw
        if !board.joined().contains("") {
            winner = "Draw"
        }
    }

    /// Function to reset the game
    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentPlayer = "X"
        winner = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
