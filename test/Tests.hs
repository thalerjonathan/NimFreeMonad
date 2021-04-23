module Main where

import Test.Tasty

import PlayerMove
import PlayerInput

-- clear & stack test --test-arguments="--quickcheck-tests=1000 --quickcheck-replay="

main :: IO ()
main = do
  let nimTests 
        = testGroup "Nim Tests" 
            [ test_player_move
            , test_player_input ]
  
  defaultMain nimTests

