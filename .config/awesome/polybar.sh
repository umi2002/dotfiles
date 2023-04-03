# Terminate already running bar instances
killall -q polybar

# Launch polybar
polybar top &
polybar bottom &
