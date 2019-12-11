module Main (main) where

import XMonad

import XMonad.Actions.DwmPromote
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import qualified Data.Map as M

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myConfig = def {
    modMask = mod4Mask
    , terminal = "alacritty"
    , keys = myKeys <+> keys def
    , borderWidth = 3
    , layoutHook = myLayout
}

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
            [ ((modm, xK_Return), dwmpromote)
            , ((modm .|. shiftMask,xK_l), spawn "slock")
            ]

myLayout = smartBorders $ layoutHook defaultConfig

myBar = "pkill xmobar; xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
