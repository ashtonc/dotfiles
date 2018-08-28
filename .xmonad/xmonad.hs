-- Imports
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Util.Run

-- Change the default terminal
myTerminal           = "alacritty"

-- Change the mod key to the windows (super) key
myModMask            = mod4Mask

-- No borders on fullscreen content, borders around boxes, borders of width 4
-- Small bug: with the smartSpacing I can still see the clock in the space it creates
myLayoutHook         = smartSpacing 2 $ smartBorders (layoutHook defaultConfig)
myBorderWidth        = 4

-- Border colors
myNormalBorderColor  = "#282C34"
myFocusedBorderColor = "#61AFEF"

-- Command to launch the bar
myBar                = "xmobar"

-- Custom pretty printer of xmonad log
myPP                 = xmobarPP { ppCurrent         = xmobarColor "#61AFEF" "" . wrap "" ""
                                , ppHidden          = xmobarColor "#DFDFE4" "" . wrap "" ""
                                , ppHiddenNoWindows = xmobarColor "#595D64" "" . wrap "" ""
                                , ppTitle           = xmobarColor "#DFDFE4" "" . shorten 64
                                , ppSep             = " <fc=#595D64>|</fc> "
                                , ppLayout          = const ""
                                }

-- Custom workspace numbers
myWorkspaces         = [ "<fn=1>一</fn>"
                       , "<fn=1>二</fn>"
                       , "<fn=1>三</fn>"
                       , "<fn=1>四</fn>"
                       , "<fn=1>五</fn>"
                       , "<fn=1>六</fn>"
                       , "<fn=1>七</fn>"
                       , "<fn=1>八</fn>"
                       , "<fn=1>九</fn>" ]

-- Configuration using changed defaults
myConfig = defaultConfig { modMask            = myModMask
                         , workspaces         = myWorkspaces
                         , terminal           = myTerminal
                         , layoutHook         = myLayoutHook
                         , borderWidth        = myBorderWidth
                         , normalBorderColor  = myNormalBorderColor
                         , focusedBorderColor = myFocusedBorderColor }

-- Key binding to toggle the gap for the bar
myKeys XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Run xmonad and xmobar
main = xmonad =<< statusBar myBar myPP myKeys myConfig

