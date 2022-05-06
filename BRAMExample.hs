{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

module BRAMExample where

import Clash.Prelude
import Clash.Explicit.Testbench
import           Data.Either         (isLeft)

type We = BitVector 1
type Addr = BitVector 5
type Data = BitVector 4

type Input = (We, Addr, Data)
type Output = BitVector 4
data State = NotStarted | One | Zero0 | Zero1 | Zero2

instance NFDataX State where
  deepErrorX = errorX
  rnfX = rwhnfX
  hasUndefined = isLeft . isX
  ensureSpine = id

calculator :: Input -> Output
calculator (we, addr, data) = out
  where
    if we==1 then kkkkkkk
    out = hoge

calculatorS :: Signal System Input -> Signal System Output
calculatorS = fmap calculator

-- mealy :: (s -> i -> (s,o))
--    -> s
--    -> (Signal i -> Signal o)
-- mealy f initS = ...


topEntity
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System Input
  -> Signal System Output
topEntity = exposeClockResetEnable calculatorS

testBench :: Signal System Bool
testBench = done
 where
  testInput    = stimuliGenerator clk rst $(listToVecTH [0 :: BitVector 1,0,1,0,0,0,0,0,1,0,0,0,1,0,0])
  expectOutput = outputVerifier' clk rst $(listToVecTH [0b0:: BitVector 1,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b0])
  done         = expectOutput (topEntity clk rst en testInput)
  en           = enableGen
  clk          = tbClockGen (fmap not done)
  rst          = resetGen --unsafeFromHighPolarity $ fmap not (unsafeToHighPolarity $ resetGenN (SNat @3))
