module GameLoop where

import Test.Tasty
import Test.Tasty.HUnit

import TestInterpreter

import Nim

test_gameLoop :: TestTree 
test_gameLoop = testGroup "Test gameLoop"
  [ test_gameLoop_scenario1
  ]

test_gameLoop_scenario1 :: TestTree
test_gameLoop_scenario1 = testCase "gameLoop scenario 1" $ do
  let script     = gameLoop initialBoard mkFirstPlayer
      input      = ["1", "5", "2", "4", "3", "3", "4", "2", "5", "1"]
      (ret, out) = testNimScript input script

      expectRet = ()
      expectOut = "Board:\n1: \n* * * * * \n2: \n* * * * \n3: \n* * * \n4: \n* * \n5: \n* \n\nPlayer 1 make your move!\n  Line: \n  Stars: \n\nBoard:\n1: \n\n2: \n* * * * \n3: \n* * * \n4: \n* * \n5: \n* \n\nPlayer 2 make your move!\n  Line: \n  Stars: \n\nBoard:\n1: \n\n2: \n\n3: \n* * * \n4: \n* * \n5: \n* \n\nPlayer 1 make your move!\n  Line: \n  Stars: \n\nBoard:\n1: \n\n2: \n\n3: \n\n4: \n* * \n5: \n* \n\nPlayer 2 make your move!\n  Line: \n  Stars: \n\nBoard:\n1: \n\n2: \n\n3: \n\n4: \n\n5: \n* \n\nPlayer 1 make your move!\n  Line: \n  Stars: \n\nPlayer 1 has won!\n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret
