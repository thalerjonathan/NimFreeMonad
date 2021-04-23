module PlayerInput where

import Test.Tasty
import Test.Tasty.HUnit

import TestInterpreter

import Nim

test_player_input :: TestTree 
test_player_input = testGroup "Test playerInput"
  [ test_player_input_valid
  ]

test_player_input_valid :: TestTree
test_player_input_valid = testCase "valid playerInput" $ do
  let script     = getPlayerInput mkFirstPlayer
      input      = ["1", "5"]
      (ret, out) = testNimScript input script

      expectRet = (0,5)
      expectOut = "Player 1 make your move!\n  Line: \n  Stars: \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret
