#!/bin/bash
#
# Gnome Performance of SUSE Linux
# By: Sontaya Photibut, <susethailand.com@gmail.com>, 9/11/2012
# Website: http://www.susethailand.com
# For OpenSUSE11, SLEx11
# Path schemas "/usr/share/gconf/schemas/"
# How to use: Copy this script to "/etc/profile.d" and set execute it. 

### gnome-session.schemas ###
# Don't show the Gnome splash page (Default=false)
gconftool-2 --type bool --set /apps/gnome-session/options/show_splash_screen false

###  apps_nautilus_preferences.schemas ###
# Don't count how many files and their sizes in the Nautilus windows (Default=local_only)
gconftool-2 --type string --set /apps/nautilus/preferences/show_directory_item_counts never
# Don't try to preview a sound (Default=local_only)
gconftool-2 --type string --set /apps/nautilus/preferences/preview_sound never

# Don't show the text below the icon that describes the file (Default=local_only)
gconftool-2 --type string --set /apps/nautilus/preferences/show_icon_text never

# Don't show image thumbnails
gconftool-2 --type string --set /apps/nautilus/preferences/show_image_thumbnails never
gconftool-2 --type Integer --set /apps/nautilus/preferences/thumbnail_limit 512000

### desktop_gnome_background.schemas ###
# Don't use wallpaper (Default=zoom)
gconftool-2 --type string --set /desktop/gnome/background/picture_options none
# Don't use a gradient backdrop (Default=solid)
gconftool-2 --type string --set /desktop/gnome/background/color_shading_type solid
# Set the background color to blue - Really purple :) (Default=#66ba00)
gconftool-2 --type string --set /desktop/gnome/background/primary_color \#666699
# Disable desktop picture background
gconftool-2 --type bool --set /desktop/gnome/background/draw_background false

### desktop_gnome_interface.schemas ### 
# Set the Icon theme to gnome
gconftool-2 --type string --set /desktop/gnome/interface/icon_theme gnome
# Set the GTK them to Sample (Default=>Clearlooks)
gconftool-2 --type string --set /desktop/gnome/interface/gtk_theme Simple 


### desktop_gnome_sound.schemas ###
# Don't start ESD (Default=false)
gconftool-2 --type bool --set /desktop/gnome/sound/event_sounds false
gconftool-2 --type bool --set /desktop/gnome/sound/enable_esd false

### apps_nautilus_preferences.schemas ###
# Don't show hidden files (Default=false)
gconftool-2 --type bool --set /desktop/gnome/file_views/show_hidden_files false
# Don't show backup files (those marked with a ~)
gconftool-2 --type bool --set /desktop/gnome/file_views/show_backup_files false

# Enable VNC
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type list --list-type=string --set /desktop/gnome/remote_access/authentication_methods [vnc]
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/icon_visibility never 
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/enabled True
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/prompt_enabled False
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/require_encryption False
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/remote_access/view_only False
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /desktop/gnome/remote_access/vnc_password XXXXXXXXX

# Change Screensaver Behaviour
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/gnome-screensaver/cycle_delay 30
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/idle_activation_enabled True
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/gnome-screensaver/idle_delay 30
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type int --set /apps/gnome-screensaver/lock_delay 30
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/lock_enabled False
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type string --set /apps/gnome-screensaver/mode blank-only
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gnome-screensaver/user_switch_enabled False

### Keyboard stetting 
# us,th
gconftool-2 --type list --list-type=string --set /desktop/gnome/peripherals/keyboard/kbd/layouts [us,th]
# Keys change(Alt+Shift)
gconftool-2 --type list --list-type=string --set /desktop/gnome/peripherals/keyboard/kbd/options ["grp  grp:alt_shift_toggle"]
# Gnome mouse keys
gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /desktop/gnome/accessibility/keyboard/mousekeys_enable False
