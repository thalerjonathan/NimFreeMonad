module TestInterpreter
  ( testNimScript
  ) where

import Control.Monad.Free
import Control.Monad.Reader
import Control.Monad.Writer.Lazy

import NimLang

testNimScript :: [String] -> NimScript a -> (a, String)
testNimScript inputs script = runWriter writerRet
  where
    writerRet = runReaderT (interpretPure 0 script) inputs

interpretPure :: Int -> NimScript a -> ReaderT [String] (Writer String) a
interpretPure _ (Pure a) = return a
interpretPure idx (Free (ReadLine nextF)) = do
  lStr <- asks (\is -> is !! idx)
  interpretPure (idx+1) (nextF lStr)
interpretPure idx (Free (PrintLine str next)) = do
  lift $ tell (str ++ "\n")
  interpretPure idx next
interpretPure idx (Free (PrintText str next)) = do
  lift $ tell str
  interpretPure idx next