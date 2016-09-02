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

zenity --question --text="<span size=\"xx-large\"><b>Passer du gpu $gpu au gpu $newgpu ?</b></span>\n\n<span size=\"large\">Passer du gpu $gpu au gpu $newgpu ? Pour appliquer le changement, se déconnecter puis se reconnecter</span>" --title="Nvidia GPU switch" --ok-label="Appliquer et se déconnecter" --cancel-label="Annuler"

if [ $? = 0 ] ; then
	command=$(gksu prime-select $newgpu && DISPLAY=:0 gnome-session-quit --force)
else
	command=$(exit)
fi



