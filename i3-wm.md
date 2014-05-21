#i3-wm basic config

sudo apt-get install -y i3-wm i3lock i3status dmenu rxvt-unicode

cd

vim .Xdefaults

~~~

URxvt*transparent: true
URxvt*shading: 40
URxvt*saveLines: 12000
URxvt*foreground: Green
URxvt*background: Black
URxvt*font: xft:DejaVu Sans Mono:pixelsize=14:antialias=true:hinting=true
URxvt*boldFont: xft:DejaVu Sans  Mono:bold:pixelsize=14:antialias=true:hinting=true
URxvt*color4: RoyalBlue
URxvt*color12: RoyalBlue
URxvt*scrollBar: false
URxvt*scrollBar_right: false
URxvt*scrollstyle: rxvt

~~~

vim .i3/config

~~~

#just the differences from the default config file

set $Mod Mod4 #Win key

#start XFCE panel
bindsym $mod+z exec --no-startup-id xfce4-panel

# start a terminal
bindsym $mod+Return exec urxvt
bindsym $mod+x exec urxvt

# kill focused window
#bindsym $mod+Shift+Q kill
bindsym $mod+c kill

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+E exit

# frame colors          border  backgr. text    indicator
client.focused          #00D700 #007300 #ffffff #00ff00
client.focused_inactive #333333 #5f676a #ffffff #484e50
client.unfocused        #333333 #222222 #888888 #292d2e
client.urgent           #2f343a #900000 #ffffff #900000

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
      position          top
      status_command    i3status
      mode              hide
      workspace_buttons yes
      tray_output       none
      
      font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1

      colors {
        background #000000
        statusline #ffffff
        separator  #00d700
        focused_workspace    #ffffff #00D700
        active_workspace   #ffffff #333333
        inactive_workspace #888888 #222222
        urgent_workspace   #ffffff #900000      
      }  
}

~~~

vim ~/.i3status.conf

~~~

general {
        colors = true
        interval = 5
}

order += "volume master"
order += "ipv6"
order += "disk /"
order += "run_watch DHCP"
order += "run_watch VPN"
order += "wireless wlan0"
order += "ethernet eth0"
order += "battery 0"
order += "cpu_usage"
order += "cpu_temperature 0"
order += "cpu_temperature 1"
order += "cpu_temperature 2"
order += "cpu_temperature 3"
order += "cpu_temperature 4"
order += "load"
order += "tztime local"

volume master {
	format = "♪: %volume"
	device = "default"
	mixer = "Master"
	mixer_idx = 0
}

wireless wlan0 {
	format_up = "W: (%quality at %essid, %bitrate) %ip"
	format_down = "W: down"
}

ethernet eth0 {
        # if you use %speed, i3status requires the cap_net_admin capability
	format_up = "E: %ip (%speed)"
	format_down = "E: down"
}

battery 0 {
	format = "%status %percentage %remaining %emptytime"
	path = "/sys/class/power_supply/BAT%d/uevent"
	low_threshold = 10
}

run_watch DHCP {
	pidfile = "/var/run/dhclient*.pid"
}

run_watch VPN {
	pidfile = "/var/run/vpnc/pid"
}

tztime local {
	format = "Date:%Y-%m-%d Time:%r"
}

load {
	format = "Load5min:%5min"
}

cpu_usage {
	format = "CPU:%usage "
}

cpu_temperature 0 {
	format = "T: %degrees °C"
	path = "/sys/devices/platform/coretemp.0/temp1_input"
}

cpu_temperature 1 {
	format = "T: %degrees °C"
	path = "/sys/devices/platform/coretemp.0/temp2_input"
}

cpu_temperature 2 {
	format = "T: %degrees °C"
	path = "/sys/devices/platform/coretemp.0/temp3_input"
}

cpu_temperature 3 {
	format = "T: %degrees °C"
	path = "/sys/devices/platform/coretemp.0/temp4_input"
}

cpu_temperature 4 {
	format = "T: %degrees °C"
	path = "/sys/devices/platform/coretemp.0/temp5_input"
}

disk "/" {
	format = "%free"
}

~~~
