-- Imports
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- Start xmonad with xmobar
main = do
    xmobar <- spawnPipe myBar

    xmonad
        $ docks
        $ ewmh
        $ fullscreenSupport
        $ defaultConfig
            { modMask            = myModMask
            , workspaces         = myWorkspaces
            , terminal           = myTerminal
            , borderWidth        = myBorderWidth
            , normalBorderColor  = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            , layoutHook         = myLayoutHook
            , logHook            = myLogHook xmobar
            , handleEventHook    = myHandleEventHook
            , manageHook         = myManageHook
            } `additionalKeys`     myKeys

-- Log hook, customize the look of xmobar
myLogHook xmobar = do
    dynamicLogWithPP $ def
        { ppCurrent         = xmobarColor "#61AFEF" "" . wrap "" ""
        , ppHidden          = xmobarColor "#DFDFE4" "" . wrap "" ""
        , ppHiddenNoWindows = xmobarColor "#595D64" "" . wrap "" ""
        , ppTitle           = xmobarColor "#DFDFE4" "" . shorten 64
        , ppSep             = " <fc=#595D64>|</fc> "
        , ppLayout          = const ""
        , ppOutput          = hPutStrLn xmobar
        }
 
-- Command to launch  xmobar
myBar                = "xmobar /home/ashton/.xmonad/xmobar/.xmobarrc"

-- Change the default terminal
myTerminal           = "alacritty"

-- Change the mod key to the windows (super) key
myModMask            = mod4Mask

-- Layouts
myLayoutHook         = avoidStruts
                       $ spacingRaw True (myWindowSpacing) True (myWindowSpacing) True
                       $ smartBorders
                       $ myLayouts
                     where
                       myLayouts        = myTall ||| myFull
                       myFull           = fullscreenFull $ Full
                       myTall           = fullscreenFull $ Tall myNMaster myRatioIncrement myRatio
                       myNMaster        = 1
                       myRatioIncrement = (2 / 100)
                       myRatio          = (6 / 10)

myHandleEventHook    = XMonad.Layout.Fullscreen.fullscreenEventHook
myManageHook         = fullscreenManageHook

-- Layout border
myNormalBorderColor  = "#282C34"
myFocusedBorderColor = "#61AFEF"
myWindowSpacing      = Border 4 4 4 4
myBorderWidth        = 4

-- Custom workspace numbers
myWorkspaces         = [ "<fn=1>一</fn>"
                       , "<fn=1>二</fn>"
                       , "<fn=1>三</fn>"
                       , "<fn=1>四</fn>"
                       , "<fn=1>五</fn>"
                       , "<fn=1>六</fn>"
                       , "<fn=1>七</fn>"
                       , "<fn=1>八</fn>"
                       , "<fn=1>九</fn>"
                       ]

-- Key bindings
myKeys               = [ ((myModMask               , xK_b    ), sendMessage ToggleStruts)
                       , ((myModMask               , xK_p    ), spawn "rofi -show run")
                       , ((myModMask .|. shiftMask , xK_p    ), spawn "rofi -show window")
                       , ((myModMask               , xK_a    ), spawn "rofi -show emoji")
                       , ((myModMask               , xK_z    ), spawn "/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh do pauseplay")
                       , ((myModMask               , xK_Up   ), spawn "/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh do pauseplay")
                       , ((myModMask               , xK_Down ), spawn "/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh do stop")
                       , ((myModMask               , xK_Right), spawn "/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh do next")
                       , ((myModMask               , xK_Left ), spawn "/home/ashton/.xmonad/xmobar/scripts/gpmdp-control.sh do previous")
                       ]

