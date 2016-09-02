#!/bin/sh

gpu=$(prime-select query)

if [ $gpu = intel ] ; then
	newgpu=nvidia
elif [ $gpu = nvidia ] ; then
	newgpu=intel
else
	newgpu=error
fi

if [ $newgpu = error ] ; then
	zenity --error --text="<span size=\"xx-large\"><b>Erreur. Status gpu non reconnu.</b></span>" --title="Nvidia GPU switch" --ok-label="Quitter" && exit
fi

gksu prime-select $newgpu && DISPLAY=:0 gnome-session-quit --force
