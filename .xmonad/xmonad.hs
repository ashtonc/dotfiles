-- Imports
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing)

-- Change the mod key to the windows (super) key
myModMask            = mod4Mask

-- No borders on fullscreen content, borders around boxes, borders of width 4
-- Small bug: with the smartSpacing I can still see the clock in the space it creates
myLayoutHook         = smartSpacing 1 $ smartBorders (layoutHook defaultConfig)
myBorderWidth        = 4

-- Border colors
myNormalBorderColor  = "#272B34"
myFocusedBorderColor = "#60AFFC"

-- Command to launch the bar
myBar                = "xmobar"

-- Custom pretty printer of xmonad log
myPP                 = xmobarPP { ppCurrent = xmobarColor "#60AFFC" "" . wrap "" ""
                                , ppTitle   = xmobarColor "#DCDFE4"  "" . shorten 64
                                , ppSep             = " | "
                                , ppLayout   = const ""
                                }

-- Key binding to toggle the gap for the bar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Configuration using changed defaults
myConfig = defaultConfig { modMask            = myModMask
                         , layoutHook         = myLayoutHook
                         , borderWidth        = myBorderWidth
                         , normalBorderColor  = myNormalBorderColor
                         , focusedBorderColor = myFocusedBorderColor }

-- Run xmonad and xmobar
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

