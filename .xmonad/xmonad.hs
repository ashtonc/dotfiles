-- Imports
import XMonad
import XMonad.Actions.DynamicProjects
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive (isUnfocusedOnCurrentWS)
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- Start xmonad and xmobar
main = do
    xmobar <- spawnPipe myBar

    xmonad
        $ dynamicProjects myProjects
        $ docks
        $ ewmh
        $ fullscreenSupport
        $ withUrgencyHook NoUrgencyHook
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

-- Colors (sonph/onehalf)
colorDarkBackground  = "#282C34"
colorDarkForeground  = "#DCDFE4"
colorDarkFadedFG     = "#595D64"
colorDarkRed         = "#E06C75"
colorDarkGreen       = "#98C379"
colorDarkYellow      = "#E5C07B"
colorDarkBlue        = "#61AFEF"
colorDarkMagenta     = "#C678DD"
colorDarkCyan        = "#56B6C2"
colorLightBackground = "#FAFAFA"
colorLightForeground = "#383A42"
colorLightRed        = "#E45649"
colorLightGreen      = "#50A14F"
colorLightYellow     = "#C18401"
colorLightBlue       = "#0184BC"
colorLightMagenta    = "#A626A4"
colorLightCyan       = "#0997B3"

-- Design
myBackgroundColor    = colorDarkBackground
myForegroundColor    = colorDarkForeground
myFadedFGColor       = colorDarkFadedFG
myHighlightColor     = colorDarkBlue
myUrgentColor        = colorDarkRed

myNormalBorderColor  = myBackgroundColor
myFocusedBorderColor = myHighlightColor

myWindowSpacing      = Border 4 4 4 4
myBorderWidth        = 0

myUnfocusedFade      = 0.90
myFloatingFade       = 0.96
myUnfocusedFloatFade = 0.80

-- Custom workspace names
myWorkspace1Name     = "<fn=1>一</fn>"
myWorkspace2Name     = "<fn=1>二</fn>"
myWorkspace3Name     = "<fn=1>三</fn>"
myWorkspace4Name     = "<fn=1>四</fn>"
myWorkspace5Name     = "<fn=1>五</fn>"
myWorkspace6Name     = "<fn=1>六</fn>"
myWorkspace7Name     = "<fn=1>七</fn>"
myWorkspace8Name     = "<fn=1>八</fn>"
myWorkspace9Name     = "<fn=1>九</fn>"

-- Workspace-specific program launching
myProjects           = [ Project { projectName      = myWorkspace3Name
                                 , projectDirectory = "~"
                                 , projectStartHook = Just $ do spawn myTerminal
                                 }
                       ]

-- Launch xmobar with config
myBar                = "xmobar /home/ashton/.xmonad/xmobar/.xmobarrc"

-- Set the default terminal
myTerminal           = "alacritty"

-- Set the mod key to the windows (super) key
myModMask            = mod4Mask

-- Customize xmobar and the log hook
myLogHook xmobar     = do
    fadeWindowsLogHook myFadeHook
    ewmhDesktopsLogHook
    dynamicLogWithPP $ def
        { ppCurrent         = xmobarColor myHighlightColor "" . wrap "" ""
        , ppHidden          = xmobarColor myForegroundColor "" . wrap "" ""
        , ppHiddenNoWindows = xmobarColor myFadedFGColor "" . wrap "" ""
        , ppUrgent          = xmobarColor myUrgentColor "" . wrap "" ""
        , ppTitle           = xmobarColor myForegroundColor "" . shorten 64
        , ppSep             = " <fc=" ++ myFadedFGColor ++ ">|</fc> "
        , ppLayout          = xmobarColor myForegroundColor "" .
                              (\x -> case x of
                                "Spacing Tall" -> "T"
                                "Spacing Full" -> "F"
                                _              -> "?"
                              )
        , ppOutput          = hPutStrLn xmobar
        }

-- Customize the layouts
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

myHandleEventHook    = fadeWindowsEventHook
                   <+> XMonad.Layout.Fullscreen.fullscreenEventHook

myManageHook         = fullscreenManageHook

-- Set window fading
myFadeHook           = composeAll [ opaque
                                  , isFloating --> opacity myFloatingFade
                                  , isUnfocusedOnCurrentWS --> opacity myUnfocusedFade
                                  ]

-- Set the workspace names
myWorkspaces         = [ myWorkspace1Name
                       , myWorkspace2Name
                       , myWorkspace3Name
                       , myWorkspace4Name
                       , myWorkspace5Name
                       , myWorkspace6Name
                       , myWorkspace7Name
                       , myWorkspace8Name
                       , myWorkspace9Name
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

