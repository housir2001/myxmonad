# myxmonad
my xmonad configure

# xmonad install at ubuntu 20.04

```=
sudo apt install xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev xmobar xcompmgr nitrogen stalonetray moreutils synapse ssh-askpass-gnome suckless-tools rofi dmenu gmrun feh volumeicon-alsa
sudo apt install libghc-xmonad-extras-dev libghc-xmonad-extras-prof libghc-xmonad-prof
```
# polybar install @ ubuntu 20.04

```
sudo apt-get install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev

sudo apt install libxcb-composite0-dev  
sudo apt install libjsoncpp-dev  
sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json
sudo apt install gcc clang
sudo apt install sphinx-common
sudo apt install libuv1-dev

git clone https://github.com/polybar/polybar.git

./build.sh

cd ~/.xmonad
sudo cp config.ini.polybar /etc/polybar/config.ini
chmod a+x link.py
chmod a+x xmonad-x86_64-linux
chmod a+x ycm_extra_conf.py
chmod a+x rofi-power-menu
sudo cp rofi-power-menu /usr/local/bin

```

# Key binding

- Alt+1...9 Switch desktop
- Alt+p Show dmenu
- Alt+mouse left Move window
- Alt+mouse right Change window size
- Windows Key+TAB Show desktop toggle color block
- Windows Key+b Hide/Show xmobar
- Windows Key+q Show rofi application
- Windows Key+p Show rofi power menu
- Windows Key+c Close focus window
