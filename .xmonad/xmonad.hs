--
--
--

import XMonad
import XMonad.Hooks.DynamicLog

main = xmonad =<< xmobar defaultConfig
	{ modMask            = mod4Mask
	, borderWidth        = 3
    , normalBorderColor  = "#820333"
    , focusedBorderColor = "#2E112D" }
