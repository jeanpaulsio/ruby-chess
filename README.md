# Command Line Chess  
  
[Chess Rules](https://www.chess.com/article/view/chess-rules--basics)

## TODO
```
» Need to implement:
    - en passant
    - stalemate
    - pawn promotion
    - save/load game
```

## Instructions
```
 ██████╗  █████╗ ███╗   ███╗███████╗     ██████╗ ███████╗     ██████╗██╗  ██╗███████╗███████╗███████╗
██╔════╝ ██╔══██╗████╗ ████║██╔════╝    ██╔═══██╗██╔════╝    ██╔════╝██║  ██║██╔════╝██╔════╝██╔════╝
██║  ███╗███████║██╔████╔██║█████╗      ██║   ██║█████╗      ██║     ███████║█████╗  ███████╗███████╗
██║   ██║██╔══██║██║╚██╔╝██║██╔══╝      ██║   ██║██╔══╝      ██║     ██╔══██║██╔══╝  ╚════██║╚════██║
╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗    ╚██████╔╝██║         ╚██████╗██║  ██║███████╗███████║███████║
 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝     ╚═════╝ ╚═╝          ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

» When you play the Game of Chess, you win or die.      
```

## Special Moves
###Castling
Castling is a move where the King and the Rook make a move simultaneously. The following conditions must be met:
* The King has not yet moved in the game
* The Rook involved has not yet moved in the game
* The King is not in check
* The castling move does not put the King in check

```ruby
e1 g1 castle    # white kingside
e8 g8 castle    # black kingside
e1 c1 castle    # white queenside
e8 c8 castle    # black queenside
```

## Game Board Screenshot
![alt tag](https://cloud.githubusercontent.com/assets/8096483/17498914/15e144c8-5d7f-11e6-9b8d-e8b69c201231.jpg)

## Installation
```
$ gem install colorize
```
* [Colorize gem](https://github.com/fazibear/colorize) used to color strings

## Run Game
To play game, run the following in your terminal from the root directory

```
$ ruby lib/game/play.rb
```
