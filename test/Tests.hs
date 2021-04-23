module Main where

import Test.Tasty

import PlayerMove
import PlayerInput
import PrintBoard
import ApplyMoveToBoard
import GameLoop

-- clear & stack test

main :: IO ()
main = do
  let nimTests 
        = testGroup "Nim Tests" 
            [ test_playerMove
            , test_playerInput
            , test_printBoard
            , test_applyMoveToBoard
            , test_gameLoop ]
  
  defaultMain nimTests

