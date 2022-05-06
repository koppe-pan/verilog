{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}


module Sync where

import Clash.Prelude
import Clash.Explicit.Testbench
import           Data.Either         (isLeft)

type NotStarted = BitVector 2
type One = BitVector 2
type Zero0 = BitVector 2
type Zero1 = BitVector 2
type Zero2 = BitVector 2

type Input = BitVector 1
type Output = BitVector 1
data State = NotStarted | One | Zero0 | Zero1 | Zero2

instance NFDataX State where
  deepErrorX = errorX
  rnfX = rwhnfX
  hasUndefined = isLeft . isX
  ensureSpine = id

mac
  :: State           -- Current state
  -> Input           -- Input
  -> (State,Output)  -- (Updated state, output)
mac acc i = (newAcc,o)
  where
    newAcc =
      if i==1 then One
              else case acc of
                     NotStarted -> NotStarted
                     One -> Zero0
                     Zero0 -> Zero1
                     Zero1 -> Zero2
                     Zero2 -> One
    o    = case newAcc of
      NotStarted -> 0
      One -> 1
      Zero0 -> 0
      Zero1 -> 0
      Zero2 -> 0

macS :: (HiddenClock dom, NFDataX State) => Signal dom Input -> Signal dom Output
macS = mealy mac NotStarted

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
topEntity = exposeClockResetEnable macS

testBench :: Signal System Bool
testBench = done
 where
  testInput    = stimuliGenerator clk rst $(listToVecTH [0 :: BitVector 1,0,1,0,0,0,0,0,1,0,0,0,1,0,0])
  expectOutput = outputVerifier' clk rst $(listToVecTH [0b0:: BitVector 1,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b0])
  done         = expectOutput (topEntity clk rst en testInput)
  en           = enableGen
  clk          = tbClockGen (fmap not done)
  rst          = resetGen --unsafeFromHighPolarity $ fmap not (unsafeToHighPolarity $ resetGenN (SNat @3))
