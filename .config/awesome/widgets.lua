local awful = require( "awful" )
local gears = require( "gears" )
local wibox = require( "wibox" )
local theme = require( "theme" )

local spotify_widget = require( "awesome-wm-widgets.spotify-widget.spotify" )
local volume_widget = require( "awesome-wm-widgets.volume-widget.volume" )
local ram_widget = require( "awesome-wm-widgets.ram-widget.ram-widget" )
local cpu_widget = require( "awesome-wm-widgets.cpu-widget.cpu-widget" )
local calendar_widget = require( "awesome-wm-widgets.calendar-widget.calendar" )
local logout_menu_widget = require(
                               "awesome-wm-widgets.logout-menu-widget.logout-menu"
                            )
local weather_widget = require( "awesome-wm-widgets.weather-widget.weather" )
local brightness_widget = require(
                              "awesome-wm-widgets.brightness-widget.brightness"
                           )
require( "battery" )

-- {{{ Wibar

local calendar = calendar_widget(
                     {
        theme = "custom",
        placement = "top_right",
        start_sunday = true,
    }
                  )

-- Create a textclock widget
local clock = wibox.widget.textclock()
clock.format = "%a, %b %d %H:%M:%S"
clock.refresh = 1
clock.font = theme.font
clock = wibox.container.margin( clock, 5, 5, 5, 5 )

clock:connect_signal(
    "button::press", function( _, _, _, button )
        if button == 1 then
            calendar.toggle()
        end
    end
 )

-- Create a keyboard widget
local function keyboardlayout_with_font( font )
    local result = awful.widget.keyboardlayout()
    result.widget.font = font
    return result
end
local keyboard = keyboardlayout_with_font( theme.font )
keyboard = wibox.container.margin( keyboard, 5, 5, 5, 5 )

awful.screen.connect_for_each_screen(
    function( s )
        -- Wallpaper

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = function( t )
                return t.selected or #t:clients() > 0
            end,
            style = { spacing = 20 },
        }
        s.mytaglist = wibox.container.margin( s.mytaglist, 5, 5, 5, 5 )

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.focused,
            style = { bg_focus = "#129DD6" },
        }

        -- Create the wibox
        s.topWibox = wibox(
                         {
                screen = s,
                width = 1800,
                height = 30,
                visible = true,
                border_width = 2,
                border_color = theme.border_normal,
                bg = theme.bg_normal,
                fg = theme.fg_normal,
                opacity = 0.7,
                shape = gears.shape.rounded_rect,
                x = (s.geometry.width - 1800) / 2,
                y = 5,
            }
                      )

        -- Add widgets to the wibox
        s.topWibox:setup{
            layout = wibox.layout.align.horizontal,
            expand = "none",
            s.mytaglist,
            {
                s.mytasklist,
                max_widget_size = 500,
                layout = wibox.layout.flex.horizontal,
            },
            {
                weather_widget(
                    {
                        api_key = "666138682a8b8d5ef709506c18cbb728",
                        coordinates = { 45.5074, -73.7825 },
                    }
                 ),
                clock,
                layout = wibox.layout.fixed.horizontal,
            },
        }

        s.bottomWibox = wibox(
                            {
                screen = s,
                width = 1800,
                height = 30,
                visible = true,
                border_width = 2,
                border_color = theme.border_normal,
                bg = theme.bg_normal,
                fg = theme.fg_normal,
                opacity = 0.7,
                shape = gears.shape.rounded_rect,
                x = (s.geometry.width - 1800) / 2,
                y = s.geometry.height - 40,
            }
                         )
        s.bottomWibox:setup{
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
                logout_menu_widget(),
                batteryicon,
                batterywidget,
                ram_widget(),
                cpu_widget( { step_spacing = 0, color = theme.border_normal } ),
            },
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 5,
                spotify_widget(
                    {
                        show_tooltip = false,
                        max_length = 100,
                        dim_when_paused = true,
                        font = theme.font,
                        play_icon = "",
                        pause_icon = "",
                    }
                 ),
                volume_widget({
                    font = theme.font,
                    show_current_level = true,
                    display_notification = true,
                    notification_position = "bottom_left",
                }),
            },
            { layout = wibox.layout.fixed.horizontal, spacing = 5, keyboard },
        }
    end
 )
-- }}}
