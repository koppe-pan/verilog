{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

module Mul where

import Clash.Prelude
import Clash.Signal
import Clash.Explicit.Testbench

createDomain (knownVDomain @System){vName="HSystem", vResetPolarity=ActiveLow}
type HSystemClockResetEnable = (Hidden (HiddenClockName "HSystem") (Clock "HSystem"), Hidden (HiddenResetName "HSystem") (Reset "HSystem"), Hidden (HiddenEnableName "HSystem") (Enable "HSystem"))

type A = BitVector 8
type B = BitVector 8
type Y = BitVector 17
type ST = Int
type Fin = Bool
type State = (Y, ST, Fin)
type O = BitVector 17
type Input = (A, B)
type Output = (O, Fin)

mac
  :: State           -- Current state
  -> Input           -- Input
  -> (State,Output)  -- (Updated state, output)
mac acc input = (newAcc, (y, fin))
  where
    (a, b) = input
    (y, st, fin) = acc
    y_a = (shiftL y 1) +  extend(a * ((1 :: B) .&. shiftR b (7-st)))
    st_a = st+1
    fin_a = st==7
    newAcc = (y_a, st_a, fin_a)

topEntity
  :: HSystemClockResetEnable
  => Signal "HSystem" Input
  -> Signal "HSystem" Output
topEntity = mealy mac (0, 0, False)
