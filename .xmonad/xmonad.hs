--
--
--

import XMonad
import XMonad.Hooks.DynamicLog

main = xmonad =<< xmobar defaultConfig
	{ modMask            = mod4Mask
	, borderWidth        = 3
    , normalBorderColor  = "#272B34"
    , focusedBorderColor = "#60AFFC" }
