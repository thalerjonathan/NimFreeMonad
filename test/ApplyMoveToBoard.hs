module ApplyMoveToBoard where

import Test.Tasty
import Test.Tasty.HUnit

import Nim

test_applyMoveToBoard :: TestTree 
test_applyMoveToBoard = testGroup "Test applyMoveToBoard"
  [ test_applyMoveToBoard_valid
  ]

test_applyMoveToBoard_valid :: TestTree
test_applyMoveToBoard_valid = testCase "valid applyMoveToBoard" $ do
  let board = [5,4,3,2,1]
      ret   = applyMoveToBoard board 0 5
  
      expectRet = [0,4,3,2,1]

  assertEqual "Mismatching Return" expectRet ret

