{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

import Clash.Prelude
import Clash.Explicit.Testbench

mac :: (Num a) => a -> (a, a) -> (a, a)
mac acc (x, y) = (acc + x * y, acc)

macS :: (HiddenClockResetEnable dom, Num a, NFDataX a) => Signal dom (a, a) -> Signal dom a
macS = mealy mac 0

topEntity
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System (Int, Int)
  -> Signal System Int
topEntity = exposeClockResetEnable macS

testBench :: Signal System Bool
testBench = done
 where
  testInput    = stimuliGenerator clk rst ((1,1) :> (2,2) :> (3,3) :> (4,4) :> Nil)
  expectOutput = outputVerifier' clk rst (0 :> 1 :> 5 :> 14 :> 30 :> 46 :> 62 :> Nil)
  done         = expectOutput (topEntity clk rst en testInput)
  en           = enableGen
  clk          = tbSystemClockGen (fmap not done)
  rst          = systemResetGen
