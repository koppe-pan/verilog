{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

module FullAdder where

import Clash.Prelude
import Clash.Explicit.Testbench

type A = Bit
type B = Bit
type C = Bit
type X = (A, B)
type S = Bit

type Input = (X, C)
type Output = (S, C)

fullAdder :: Input -> Output
fullAdder ((a, b), c) = (s, c_out)
  where
    ab_xor = a `xor` b
    ab_and = a .&. b
    ab_xor_c_and = ab_xor .&. c
    s = ab_xor `xor` c
    c_out = ab_xor_c_and .|. ab_and 

adderS :: Signal System Input -> Signal System Output
adderS = fmap fullAdder


topEntity
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System Input
  -> Signal System Output
topEntity = exposeClockResetEnable adderS

testBench :: Signal System Bool
testBench = done
 where
  testInput    = stimuliGenerator clk rst 
    (((0,0),0)
    :> ((0,0),1)
    :> ((0,1),0)
    :> ((0,1),1)
    :> ((1,0),0)
    :> ((1,0),1)
    :> ((1,1),0)
    :> ((1,1),1)
    :> Nil)
  expectOutput = outputVerifier' clk rst 
    ((0,0)
    :> (1,0)
    :> (1,0)
    :> (0,1)
    :> (1,0)
    :> (0,1)
    :> (0,1)
    :> (1,1)
    :> Nil)
  done         = expectOutput (topEntity clk rst en testInput)
  en           = enableGen
  clk          = tbSystemClockGen (fmap not done)
  rst          = systemResetGen
