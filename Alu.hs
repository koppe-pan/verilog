{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

module Alu where

import Clash.Prelude
import Clash.Signal
import Clash.Explicit.Testbench

createDomain (knownVDomain @System){vName="HSystem", vResetPolarity=ActiveLow}
type HSystemClockResetEnable = (Hidden (HiddenClockName "HSystem") (Clock "HSystem"), Hidden (HiddenResetName "HSystem") (Reset "HSystem"), Hidden (HiddenEnableName "HSystem") (Enable "HSystem"))

type A = BitVector 8
type B = BitVector 8
type CTR = BitVector 4
type O = BitVector 8
type Input = (A, B, CTR)
type Output = O

data Operator = Add | Sub | LogicalAnd | LogicalOr | ExclusiveOr | Inversion | ShiftR | ShiftL | RotateR | RotateL | Undefined
  deriving (Eq, Show)

decode :: CTR -> Operator
decode 0b0000 = Add
decode 0b0001 = Sub
decode 0b1000 = LogicalAnd
decode 0b1001 = LogicalOr
decode 0b1010 = ExclusiveOr
decode 0b1011 = Inversion
decode 0b1100 = ShiftR
decode 0b1101 = ShiftL
decode 0b1110 = RotateR
decode 0b1111 = RotateL
decode _      = Undefined


alu :: Operator -> A -> B -> Output
alu Add   x y = x + y
alu Sub   x y = x - y
alu LogicalAnd x y = x .&. y
alu LogicalOr x y = x .|. y
alu ExclusiveOr x y = x `xor` y
alu ShiftR x _ = shiftR x 1
alu ShiftL x _ = shiftL x 1
alu RotateR x _ = rotateR x 1
alu RotateL x _ = rotateL x 1
alu Undefined _ _ = 0

mac
  :: O           -- Current state
  -> Input           -- Input
  -> (O,Output)  -- (Updated state, output)
mac acc (a, b, c) = (newAcc,acc)
  where
    newAcc = alu (decode c) a b

topEntity
  :: HSystemClockResetEnable
  => Signal "HSystem" Input
  -> Signal "HSystem" Output
topEntity = mealy mac 0
