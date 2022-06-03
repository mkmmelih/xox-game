
import UIKit

class MainViewController: UIViewController, TicTacToeModelDelegate {

    
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private var allGameButtons: [GameButton]!

   
    private var game: TicTacToeModel!
    private var currentPlayerString: String {
        return "\(game.currentPlayer.properName),\nit's your turn 🙂"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = TicTacToeModel()
        game.delegate = self

        setUpViews()
    }

    
    @IBAction func pressGameButton(sender button: GameButton) {
        button.isEnabled = false
        button.setTitle(game.currentPlayer.rawValue, for: .normal)
        button.setTitleColor(game.currentPlayer.color, for: .disabled)
        game.player(didChoose: (button.row, button.column))
    }

    @IBAction func pressRestartButton() {
        game.reset()
        setUpViews()
    }

    
    private func setUpViews() {
        allGameButtons.forEach{
            $0.isEnabled = true
            $0.setTitleColor(.black, for: .disabled)
            $0.setTitle("", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 90)
        }
        bottomLabel.text = currentPlayerString
    }

    
    func gameContinues(with nextPlayer: TicTacToeModel.Player) {
        bottomLabel.text = currentPlayerString
    }

    func gameOver(winner: TicTacToeModel.Player?) {
        allGameButtons.forEach { $0.isEnabled = false }
        if let winner = winner {
            bottomLabel.text = "\(winner.properName.capitalized),\nYOU WIN! 🎉"
        } else {
            bottomLabel.text = "DRAW! Play again?"
        }
    }
}
