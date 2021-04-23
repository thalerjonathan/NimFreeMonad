module Interpreters
  ( interpretIO
  , Interpreter(..)
  , interpretAbstract 
  ) where

import Control.Monad.Free

import NimLang

class Monad m => Interpreter m where
  onReadLine :: m String
  onWriteLine :: String -> m ()
  onWriteText :: String -> m ()

interpretAbstract :: Interpreter m => NimScript a -> m a
interpretAbstract (Pure a) = return a
interpretAbstract (Free (ReadLine nextF)) = do
  lStr <- onReadLine
  interpretAbstract (nextF lStr)
interpretAbstract (Free (PrintLine str next)) = do
  onWriteLine str
  interpretAbstract next
interpretAbstract (Free (PrintText str next)) = do
  onWriteText str
  interpretAbstract next

interpretIO :: NimScript a -> IO a
interpretIO (Pure a) = return a
interpretIO (Free (ReadLine nextF)) = do
  lStr <- getLine
  interpretIO (nextF lStr)
interpretIO (Free (PrintLine str next)) = do
  putStrLn str
  interpretIO next
interpretIO (Free (PrintText str next)) = do
  putStr str
  interpretIO next

instance Interpreter IO where
  onReadLine = getLine
  onWriteLine = putStrLn
  onWriteText = putStr

