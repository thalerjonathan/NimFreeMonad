module PlayerMove where

import Test.Tasty
import Test.Tasty.HUnit

import TestInterpreter

import Nim

test_playerMove :: TestTree 
test_playerMove = testGroup "Test playerMove"
  [ test_playerMove_valid
  , test_playerMove_invalid
  ]

test_playerMove_valid :: TestTree
test_playerMove_valid = testCase "valid playerMove" $ do
  let script     = playerMove initialBoard mkFirstPlayer
      input      = ["1", "5"]
      (ret, out) = testNimScript input script

      expectRet = [0,4,3,2,1]
      expectOut = "Player 1 make your move!\n  Line: \n  Stars: \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret

test_playerMove_invalid :: TestTree
test_playerMove_invalid = testCase "Invalid playerMove" $ do
  let script     = playerMove initialBoard mkFirstPlayer
      input      = ["1", "6", "1", "5"]
      (ret, out) = testNimScript input script

      expectRet = [0,4,3,2,1]
      expectOut = "Player 1 make your move!\n  Line: \n  Stars: \nInvalid Move!\n\nPlayer 1 make your move!\n  Line: \n  Stars: \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret
