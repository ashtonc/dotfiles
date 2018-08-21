--
--
--

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing)

-- No borders on fullscreen content, borders around boxes, borders of width 4
myLayoutHook         = smartSpacing 1 $ smartBorders (layoutHook defaultConfig)
myBorderWidth        = 4

-- Border colors
myNormalBorderColor  = "#272B34"
myFocusedBorderColor = "#60AFFC"

-- Change the mod key to the windows (super) key
myModMask            = mod4Mask

-- 
--myLogHook            = 

main = xmonad =<< xmobar defaultConfig
	{ modMask            = myModMask
    , layoutHook         = myLayoutHook
--	, logHook            = myLogHook
	, borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor }


