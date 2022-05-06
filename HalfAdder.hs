import Clash.Prelude
import Clash.Explicit.Testbench

halfAdder :: (BitVector 4, BitVector 4) -> (BitVector 4, BitVector 4)
halfAdder (a, b) = (s, c)
  where
    s = a `xor` b
    c = a .&. b


adderS :: Signal System (BitVector 4, BitVector 4) -> Signal System (BitVector 4, BitVector 4)
adderS = fmap halfAdder


topEntity
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System (BitVector 4, BitVector 4)
  -> Signal System (BitVector 4, BitVector 4)
topEntity = exposeClockResetEnable adderS

testBench :: Signal System Bool
testBench = done
 where
  testInput    = stimuliGenerator clk rst ((0,0) :> (0,1) :> (1,0) :> (1,1) :> Nil)
  expectOutput = outputVerifier' clk rst ((0,0) :> (1,0) :> (1,0) :> (0,1) :> Nil)
  done         = expectOutput (topEntity clk rst en testInput)
  en           = enableGen
  clk          = tbSystemClockGen (fmap not done)
  rst          = systemResetGen
