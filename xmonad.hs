import Control.Monad
import Graphics.X11.ExtraTypes.XF86
import System.Environment
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Config.Xfce
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Maximize
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Define ManageHooks
myManageHook = composeAll [
    isFullscreen --> (doF W.focusDown <+> doFullFloat),
    isDialog --> doCenterFloat,
    appName =? "desktop_window" --> doIgnore,
    manageDocks
    ]

-- Define StartupHook
myStartupHook = do
    setWMName "LG3D"
    spawnOnce "xcompmgr"
--    spawnOnce "volumeicon"
    spawnOnce "nm-applet"
--    spawnOnce "redshift"
--    spawnOnce "ibus-daemon"
    spawnOnce "feh --bg-scale ~/.xmonad/background-xmonad.png"
    setDefaultCursor xC_left_ptr
--    spawnOnce "flameshot gui"
-- Define the names of all workspaces
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Define Terminal
myTerminal = "terminator"

-- Define Layout
myLayout =  avoidStruts $ tiled ||| Mirror tiled ||| Full
    where tiled = Tall nmaster delta ratio
          nmaster = 1 -- default number of windows in master screen
          delta = 3/100 -- default percent of resizing panes
          ratio = 3/5 -- default proportion of screen occupied by master pane

-- Define Border
myNormalBorderColor = "#353945"
myFocusedBorderColor = "#ffffff"
myBorderWidth = 1

--Define Xmobar color
myXmobarColorfg = "#fdf6e3"
myXmobarColorbg = ""
myLogHook xmproc = dynamicLogWithPP $ xmobarPP {
    ppOutput = hPutStrLn xmproc,
    ppTitle = xmobarColor myXmobarColorfg myXmobarColorbg . shorten 60,
    ppLayout = const "" -- to disable the layout info on xmobar
}

-- Define ShortCuts
myShortCuts = [
    -- ((mod4Mask, xK_l), spawn "slock"),
    ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +5"),
    ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -5"),
    -- browser: firefox
    --((mod4Mask, xK_f), spawn "firefox"),
    -- browser: google-chrome
    --((mod4Mask, xK_c), spawn "google-chrome"),
    -- browser: microsoft-edge
    --((mod4Mask, xK_e), spawn "microsoft-edge-stable"),
    -- Mail
    -- ((mod4Mask, xK_m), spawn "thunderbird"),
    -- Screenshort: scrot
    --((mod4Mask, xK_a), spawn "sleep 0.2; scrot -s -e 'xclip -selection clipboard -t \"image/png\" < $f && rm $f'"),
    --((mod4Mask, xK_s), spawn "sleep 0.2; scrot -s"),
    -- DocViewer: zeal
    --((mod4Mask, xK_d), spawn "zeal"),
    ((mod4Mask, xK_b), sendMessage ToggleStruts),
    ((mod4Mask, xK_Tab), goToSelected def),
    -- alt+p, use dmenu
    -- rofi Run
    --((mod4Mask, xK_q), spawn "rofi -combi-modi window,drun,ssh -icon-theme 'Papirus' -show-icons -theme fancy -show combi"),
    ((mod4Mask, xK_q), spawn "rofi -combi-modi window,drun,ssh -show-icons -show combi"),
	((mod4Mask, xK_p), spawn "rofi -show power-menu -modi power-menu:rofi-power-menu"),
    -- Max window
    --((mod4Mask, xK_f), withFocused (sendMessage . maximizeRestore)),
    -- close window
    ((mod4Mask, xK_c), kill) -- %! Close the focused window
    ]

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad $ ewmh $ desktopConfig {
        manageHook = myManageHook <+> manageHook desktopConfig,
        handleEventHook = docksEventHook <+> handleEventHook desktopConfig,
        layoutHook = avoidStruts $ smartBorders myLayout,
        terminal = myTerminal,
        startupHook = myStartupHook,
        logHook = myLogHook xmproc,
        borderWidth = myBorderWidth,
        workspaces = myWorkspaces,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor
    } `additionalKeys` myShortCuts
