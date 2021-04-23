module Nim 
  ( Player
  , mkFirstPlayer

  , initialBoard
  
  , nim

  , gameLoop
  , playerMove
  , getPlayerInput
  , printBoard
  , applyMoveToBoard
  ) where 

import Control.Monad

import NimLang 

newtype Player = P Int

instance Show Player where
  show (P i) = "Player " ++ show (i + 1)

nim :: NimScript ()
nim = gameLoop initialBoard mkFirstPlayer

initialBoard :: [Int]
initialBoard = [5,4,3,2,1]

gameLoop :: [Int] -> Player -> NimScript ()
gameLoop b p = do
  printLine "Board:"
  printBoard b
  printLine ""

  b' <- playerMove b p
  printLine ""

  if checkWin b'
    then printLine $ show p ++ " has won!"
    else gameLoop b' (nextPlayer p)

playerMove :: [Int] -> Player -> NimScript [Int]
playerMove b p = do
  (lIdx,n) <- getPlayerInput p
  let moveOk = moveValid b lIdx n

  if not moveOk
    then do
      printLine "Invalid Move!\n"
      playerMove b p
    else return $ applyMoveToBoard b lIdx n

getPlayerInput :: Player -> NimScript (Int, Int)
getPlayerInput p = do
  printLine $ show p ++ " make your move!"
  printLine "  Line: "
  lStr <- readLine
  printLine "  Stars: "
  sStr <- readLine

  let lIdx = read lStr
      n    = read sStr

  -- NOTE: subtract 1 as we start the lines with 1 and not 0
  return (lIdx - 1,n)

printBoard :: [Int] -> NimScript ()
printBoard = zipWithM_ printBoardLine [1..]
  where
    printBoardLine :: Int -> Int -> NimScript ()
    printBoardLine i n 
      = printLine (show i ++ ": ") 
        >> replicateM_ n (printText "* ") 
        >> printLine ""

mkFirstPlayer :: Player
mkFirstPlayer = P 0

nextPlayer :: Player -> Player
nextPlayer (P n) = P ((n + 1) `mod` 2)
{-
nextPlayer (P 1) = P 2
nextPlayer (P 2) = P 1
-}

applyMoveToBoard :: [Int] -> Int -> Int -> [Int]
applyMoveToBoard b lIdx n = front ++ [stars - n] ++ back
  where
    front = take lIdx b
    stars = b !! lIdx
    back  = drop (lIdx + 1) b

checkWin :: [Int] -> Bool
checkWin = all (==0)

moveValid :: [Int] -> Int -> Int -> Bool
moveValid b lIdx n
  | lIdx < 0         = False
  | n <= 0           = False
  | lIdx >= length b = False
  | n > (b !! lIdx)  = False
  | otherwise        = True