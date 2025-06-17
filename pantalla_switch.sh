#!/bin/bash

# Detectar nombres de las salidas
INTERNAL=$(xrandr | grep " connected" | grep eDP | awk '{print $1}')
EXTERNAL=$(xrandr | grep " connected" | grep -v eDP | awk '{print $1}')

# Verifica que haya una pantalla externa conectada
if [ -z "$EXTERNAL" ]; then
    notify-send "🔌 No hay pantalla externa conectada"
    exit 1
fi

# Menú interactivo
OPCION=$(echo -e "Duplicar\nExtender derecha\nExtender izquierda\nSolo interna\nSolo externa" | dmenu -i -p "Modo de pantalla:")

case "$OPCION" in
  "Duplicar")
    # Buscar resolución compartida básica (1920x1080)
    if xrandr | grep -q "$INTERNAL connected" && xrandr | grep -A20 "^$INTERNAL connected" | grep -q "1920x1080" && xrandr | grep -A20 "^$EXTERNAL connected" | grep -q "1920x1080"; then
        xrandr --output "$INTERNAL" --mode 1920x1080 --output "$EXTERNAL" --mode 1920x1080 --same-as "$INTERNAL"
        notify-send "🖥️ Duplicando en 1920x1080"
    else
        notify-send "⚠️ No hay resolución compartida. Usa 'Solo externa' como alternativa."
    fi
    ;;
  "Extender derecha")
    xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --auto --right-of "$INTERNAL"
    notify-send "🖥️ Pantalla extendida a la derecha"
    ;;
  "Extender izquierda")
    xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --auto --left-of "$INTERNAL"
    notify-send "🖥️ Pantalla extendida a la izquierda"
    ;;
  "Solo interna")
    xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --off
    notify-send "💻 Solo pantalla interna activada"
    ;;
  "Solo externa")
    xrandr --output "$EXTERNAL" --auto --primary --output "$INTERNAL" --off
    notify-send "🖥️ Solo pantalla externa activada"
    ;;
  *)
    notify-send "❌ Acción cancelada"
    ;;
esac
feh --bg-scale ~/.wallpaper.jpg
