{-# OPTIONS_GHC -fplugin GHC.TypeLits.Normalise       #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.Extra.Solver    #-}
{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}

module Count4r2m where

import Clash.Prelude
import Clash.Signal
import Clash.Explicit.Testbench

createDomain (knownVDomain @System){vName="HSystem", vResetPolarity=ActiveLow}
type HSystemClockResetEnable = (Hidden (HiddenClockName "HSystem") (Clock "HSystem"), Hidden (HiddenResetName "HSystem") (Reset "HSystem"), Hidden (HiddenEnableName "HSystem") (Enable "HSystem"))

type State = BitVector 4

topEntity
  :: HSystemClockResetEnable
  => Signal "HSystem" State
topEntity = s
  where
    s = register 1 (s*2)
