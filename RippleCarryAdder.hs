{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

import Clash.Prelude
import Clash.Explicit.Testbench
import qualified FullAdder as FullAdder

type ErrorDetection = Bit
type Xs = Vec 4 FullAdder.X
type Ss = Vec 4 FullAdder.S
type Input = (FullAdder.C, Xs)
type Output = (FullAdder.C, Ss, ErrorDetection)

rippleCarryAdder :: Input -> Output
rippleCarryAdder (c_in, xs) = (c_out, s, e)
  where
    f c x = FullAdder.fullAdder(x,c)
    (c_out, s) = mapAccumR f c_in xs
    e = c_in `xor` c_out

adderS :: Signal System Input -> Signal System Output
adderS = fmap rippleCarryAdder

topEntity
  :: Clock System
  -> Reset System
  -> Enable System
  -> Signal System Input
  -> Signal System Output
topEntity = exposeClockResetEnable adderS
