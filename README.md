# Command Line Chess

Command Line Chess is a comprehensive, terminal-based chess game implemented in Ruby. It provides a full-fledged chess experience right in your terminal, supporting two-player gameplay and offering a rich set of features that cover the essential rules and strategies of chess.

## Features

### Two-player Gameplay
The game is designed for two players. At the start of the game, each player is prompted to enter their name. The game then alternates between the players, allowing each to make their moves and engage in a competitive chess match.

### Chessboard Display
The game provides a visual representation of the chessboard in the terminal. The chessboard is updated after each move, ensuring players can easily visualize the current state of the game. Each square on the board is labeled with coordinates, and each piece is represented by a unique symbol, allowing for easy identification and movement of pieces.

### Piece Movement
Each chess piece in the game has its own set of legal moves, in accordance with the rules of chess. The game validates these moves, ensuring that players can only make legal moves. This includes everything from the L-shaped moves of the knight to the diagonal moves of the bishop, and the unique move-and-capture rules of the pawn.

### Check and Checkmate
The game fully supports the concepts of 'check' and 'checkmate'. If a player is in check, the game notifies the player, and they must make a move that removes the check. If a player is in checkmate, the game ends, and the other player is declared the winner.

### Pawn Promotion
In chess, when a pawn reaches the opponent's end of the board, it can be promoted to another piece. This game supports pawn promotion, allowing players to choose to promote their pawn to a Queen, Rook, Bishop, or Knight.

### Castling
Castling, a special move that involves the king and a rook, is fully supported in this game. This move allows a player to simultaneously move their king and one of their rooks, providing an additional layer of strategy to the game.

### Stalemate
The game can identify and declare a stalemate situation. A stalemate occurs when a player is not in check but has no legal move to make. In such a situation, the game ends in a draw.

## Usage

To play the game, you need to have Ruby installed on your machine. Once Ruby is installed, clone the repository to your local machine. Navigate to the directory containing the game in your terminal. Start the game by running the command `ruby lib/game.rb`.

## Code Structure

The codebase is organized into several classes and modules, each representing different components of the game:

- `Game`: This class is responsible for managing the game flow. It initializes the board, creates the players, and handles the game loop.

- `Board`: This class represents the chessboard. It is responsible for preparing the chessboard, displaying it in the terminal, and handling the movement of pieces on the board.

- `Piece`: This is the superclass for all the chess pieces. It defines common attributes and methods for all pieces, such as color and possible moves.

- `King`, `Queen`, `Rook`, `Bishop`, `Knight`, `Pawn`: These classes inherit from the `Piece` class. Each class represents a specific type of chess piece and defines the possible moves for that piece.

- `Player`: This class represents a player in the game. It stores the player's name and the color of their pieces.

- `GameLogic`: This module includes methods for various aspects of game logic. This includes checking for valid moves, identifying checks and checkmates, and handling special moves like castling.

- `UserInterface`: This module includes methods for user interaction. This includes displaying messages to the players, getting input from the players, and handling errors.

## Future Improvements

While the game is fully functional and provides a comprehensive chess experience, there are several areas where it could be improved in the future:

- **Stalemate Detection and Handling**: The game currently supports stalemate situations, but the detection and handling of these situations could be improved to make the game more robust and accurate.

- **Castling Implementation**: While the game supports castling, the implementation could be improved to make the gameplay smoother and more intuitive.

- **User Interface Enhancements**: The game's user interface, while functional, could be enhanced to provide a more engaging and visually appealing user experience. This could include color-coding of pieces, better formatting of the chessboard, and more detailed instructions and error messages.

---

## Learning Experience

The development of Command Line Chess was a comprehensive learning experience that provided a deep understanding of various aspects of software development, particularly in the context of Ruby programming and game development.

One of the key learning aspects was the application of object-oriented programming (OOP) principles in Ruby. The game's structure required the creation of several classes and modules, each encapsulating its own behavior and data. This project reinforced the importance of encapsulation, inheritance, and polymorphism. For instance, the `Piece` class was designed as a superclass, with individual chess piece types like `King`, `Queen`, `Rook`, etc., inheriting from it. This design pattern allowed for efficient code reuse and a clear, intuitive structure.

The project also provided a deep dive into game logic and rules implementation. Each chess piece has unique movement rules, and implementing these in code was a challenging yet rewarding task. Special chess rules, such as castling and pawn promotion, added another layer of complexity. Implementing these rules required careful planning, problem-solving, and a thorough understanding of chess.

The development of the user interface was another significant learning aspect. The game uses a command-line interface, which required learning how to effectively present information in a text-based format and how to handle user input. This was a great exercise in user experience design, emphasizing the importance of clear instructions, user feedback, and error handling.

Testing and debugging were integral parts of the development process. They provided valuable insights into the importance of writing testable code and the techniques for identifying and resolving issues. The use of Ruby's debugging tools was particularly enlightening.

Lastly, the project was a lesson in code organization and project management. It required careful planning, consistent coding standards, and clear documentation. The use of Git for version control reinforced the importance of regular commits, clear commit messages, and the overall management of code versions.

Overall, the Command Line Chess project was a testament to the power of programming to bring complex systems to life. It was a challenging yet rewarding journey that significantly enhanced problem-solving, design, and coding skills.

---
