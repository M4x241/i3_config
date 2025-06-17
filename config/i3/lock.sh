#!/bin/bash

# Ruta de la imagen original (usa tu propia imagen)
WALLPAPER="$HOME/.lock.png"
TMP_IMG="/tmp/lockscreen_scaled.png"

# Detectar la resolución activa de la pantalla principal
RES=$(xrandr | grep '*' | awk '{print $1}' | head -n 1)

# Redimensionar la imagen exactamente a la resolución actual
convert "$WALLPAPER" -resize "${RES}!" "$TMP_IMG"

# Bloquear pantalla con i3lock usando la imagen redimensionada
i3lock -i "$TMP_IMG" 
#i3lock -i "$TMP_IMG" \
#    --inside-color=00000088 \
#    --ring-color=ffffffcc \
#    --line-color=00000000 \
#    --keyhl-color=00ff00ff \
#    --bshl-color=ff0000ff \
#    --separator-color=00000000 \
#    --insidever-color=00000088 \
#    --ringver-color=00ffffff \
#    --insidewrong-color=00000088 \
#    --ringwrong-color=ff0000ff
