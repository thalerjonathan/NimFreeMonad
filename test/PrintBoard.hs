module PrintBoard where

import Test.Tasty
import Test.Tasty.HUnit

import TestInterpreter

import Nim

test_printBoard :: TestTree 
test_printBoard = testGroup "Test printBoard"
  [ test_printBoard_initial
  , test_printBoard_empty
  ]

test_printBoard_initial :: TestTree
test_printBoard_initial = testCase "initial printBoard" $ do
  let script     = printBoard initialBoard
      input      = []
      (ret, out) = testNimScript input script

      expectRet = ()
      expectOut = "1: \n* * * * * \n2: \n* * * * \n3: \n* * * \n4: \n* * \n5: \n* \n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret

test_printBoard_empty :: TestTree
test_printBoard_empty = testCase "empty printBoard" $ do
  let script     = printBoard [0,0,0,0,0]
      input      = []
      (ret, out) = testNimScript input script

      expectRet = ()
      expectOut = "1: \n\n2: \n\n3: \n\n4: \n\n5: \n\n"

  assertEqual "Mismatching Output" expectOut out
  assertEqual "Mismatching Return" expectRet ret