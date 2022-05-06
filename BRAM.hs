{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}



import Clash.Prelude
import Clash.Explicit.Testbench

type Output = BitVector 4

topEntity 
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System Output
topEntity = exposeClockResetEnable $ romFile (4) "mem.hex" (fromList [0..10])

testBench :: Signal System Bool
testBench = done
 where
  expectOutput = outputVerifier' clk rst $(listToVecTH [0b0:: BitVector 4,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b1,0b0,0b0,0b0,0b1,0b0,0b0])
  done         = expectOutput (topEntity clk rst en)
  en           = enableGen
  clk          = tbClockGen (fmap not done)
  rst          = resetGen --unsafeFromHighPolarity $ fmap not (unsafeToHighPolarity $ resetGenN (SNat @3))
