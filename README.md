# NimFreeMonad
This is an implementation of the Nim game in Haskell using Free Monads following Alexander Granins approach from his Functional Architecture Book. The Nim game example is taken from Graham Huttons "Programming in Haskell" 2nd. Edition.

The initial board comprises five rows of stars as follows:
1. \* \* \* \* \* 
2. \* \* \* \* 
3. \* \* \* 
4. \* \*
5. \*

Two players take it turn about to remove one or more stars from the end of a single, arbitrary row.
The winner is the player who removes the last star or stars from the board.
