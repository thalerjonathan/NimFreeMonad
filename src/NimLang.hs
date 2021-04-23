module NimLang 
  ( readLine
  , printLine
  , printText

  , NimActions (..)
  , NimScript
) where

import Control.Monad.Free

data NimActions a
    = ReadLine (String -> a)
    | PrintText String a
    | PrintLine String a

instance Functor NimActions where
    fmap g (ReadLine next) = ReadLine (g . next)
    fmap g (PrintText str next) = PrintText str (g next)
    fmap g (PrintLine str next) = PrintLine str (g next)

type NimScript a = Free NimActions a

-- Smart constructors:
readLine :: NimScript String 
readLine = Free (ReadLine Pure)

printLine :: String -> NimScript () 
printLine str = Free (PrintLine str (Pure ()))

printText :: String -> NimScript () 
printText str = Free (PrintText str (Pure ()))
