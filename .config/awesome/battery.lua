local wibox = require("wibox")
local timer = require("gears.timer")

-- Create the textbox that will be used to print the battery percentage and initialize it with an empty string
batterywidget = wibox.widget({
    text = "",
    forced_width = 50,
    widget = wibox.widget.textbox,
})
-- Create the imagebox that will be used to show battery icon and initialize it 
-- with "empty battery" one
batteryicon = wibox.widget({
    text = "󱃍",
    forced_width = 20,
    widget = wibox.widget.textbox,
})
-- Create the timer which will allow to repeat battery status command (every 1 sec)
batterywidgettimer = timer({ timeout = 1 })
dischargetimer = timer({ timeout = 1 })
-- Initialize the timer and execute the function every 1 seconds
batterywidgettimer:connect_signal("timeout",
  function()
    -- Cut the 'acpi' output, so that it only remains the percentage number;
    -- Put it into the file 'fperc', then put its content into the numeric
    -- variable 'perc'
    fperc = assert(io.popen("acpi | cut -d' ' -f 4 | cut -d% -f 1", "r"))
    local perc = fperc:read("*number")
    -- Set 'batterywidget' textbox with the percentage
    batterywidget:set_text(perc..'%')
    -- Cut the 'acpi' output, so that it only remains the status string (which
    -- Can be " Full", " Charging" or " Discharging"; put it into the file
    -- 'fstatus', then put its content into the variable 'status'
    fstatus = assert(io.popen("acpi | cut -d: -f 2,2 | cut -d, -f 1,1", "r"))
    local status = fstatus:read("*l")
    -- if status is " Discharging", set batteryicon imagebox with the proper
    -- icon, depending charge status (0-19, 20-49, 50-79, 80-100). If the
    -- status is different (" Full" or " Charging"), set it with "A/C" icon
    if status == " Discharging" then
         if perc > 97 then
             batteryicon:set_text("󰁹")
         elseif perc > 90 then
             batteryicon:set_text("󰂂")
         elseif perc > 80 then
             batteryicon:set_text("󰂁")
         elseif perc > 70 then
             batteryicon:set_text("󰂀")
         elseif perc > 60 then
             batteryicon:set_text("󰁿")
         elseif perc > 50 then
             batteryicon:set_text("󰁾")
         elseif perc > 40 then
             batteryicon:set_text("󰁽")
         elseif perc > 30 then
             batteryicon:set_text("󰁼")
         elseif perc > 20 then
             batteryicon:set_text("󰁻")
         elseif perc > 10 then
             batteryicon:set_text("󰁺")
         else
             batteryicon:set_text("󱃍")
         end
    else
         if perc > 96 then
             batteryicon:set_text("󰂅")
         elseif perc > 90 then
             batteryicon:set_text("󰂋")
         elseif perc > 80 then
             batteryicon:set_text("󰂊")
         elseif perc > 70 then
             batteryicon:set_text("󰢞")
         elseif perc > 60 then
             batteryicon:set_text("󰂉")
         elseif perc > 50 then
             batteryicon:set_text("󰢝")
         elseif perc > 40 then
             batteryicon:set_text("󰂈")
         elseif perc > 30 then
             batteryicon:set_text("󰂇")
         elseif perc > 20 then
             batteryicon:set_text("󰂇")
         elseif perc > 10 then
             batteryicon:set_text("󰢜")
         else
             batteryicon:set_text("󰢟")
         end
    end
    -- Close the files
    fperc:close()
    fstatus:close()
  end
)
-- Start the timer
batterywidgettimer:start()
dischargetimer:start()
