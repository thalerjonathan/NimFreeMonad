module PlayerMove where

import Test.Tasty
import Test.Tasty.HUnit

import TestInterpreter

import Nim

test_player_move :: TestTree 
test_player_move = testGroup "Test playerMove"
  [ test_player_move_valid
  , test_player_move_invalid
  ]

test_player_move_valid :: TestTree
test_player_move_valid = testCase "valid playerMove" $ do
  let script     = playerMove [5,4,3,2,1] mkFirstPlayer
      input      = ["1", "5"]
      (ret, out) = testNimScript input script

      expectRet = [0,4,3,2,1]
      expectOut = "Player 1 make your move!\n  Line: \n  Stars: \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret

test_player_move_invalid :: TestTree
test_player_move_invalid = testCase "Invalid playerMove" $ do
  let script     = playerMove [5,4,3,2,1] mkFirstPlayer
      input      = ["1", "6"]
      (ret, out) = testNimScript input script

      expectRet = [5,4,3,2,1]
      expectOut = "Player 1 make your move!\n  Line: \n  Stars: \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret
