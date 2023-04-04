-------------------------------------------------
-- Logout Menu Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/logout-menu-widget
-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------
local awful = require( "awful" )
local wibox = require( "wibox" )
local gears = require( "gears" )
local theme = require( "theme" )

local logout_menu_widget = wibox.widget {
    {
        {
            font = theme.font,
            forced_width = 20,
            bg = theme.bg_normal,
            fg = theme.fg_normal,
            widget = wibox.widget.textbox( "" ),
        },
        margins = 4,
        layout = wibox.container.margin,
    },
    shape = function( cr, width, height )
        gears.shape.rounded_rect( cr, width, height, 4 )
    end,
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    widget = wibox.container.background,
}

local popup = awful.popup {
    ontop = true,
    visible = false,
    shape = function( cr, width, height )
        gears.shape.rounded_rect( cr, width, height, 4 )
    end,
    border_width = 2,
    border_color = theme.border_normal,
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    maximum_width = 400,
    offset = { y = 5 },
    widget = {},
    opacity = 0.7,
    hide_on_right_click = true,
}

local function worker( user_args )
    local rows = { layout = wibox.layout.fixed.vertical }

    local args = user_args or {}

    local font = theme.font

    local onlogout = args.onlogout or function()
        awesome.quit()
    end
    local onlock = args.onlock or function()
        awful.spawn.with_shell( "i3lock" )
    end
    local onreboot = args.onreboot or function()
        awful.spawn.with_shell( "reboot" )
    end
    local onsuspend = args.onsuspend or function()
        awful.spawn.with_shell( "systemctl hibernate" )
    end
    local onpoweroff = args.onpoweroff or function()
        awful.spawn.with_shell( "shutdown now" )
    end

    local menu_items = {
        { name = "Log out", icon_name = "󰍃", command = onlogout },
        { name = "Lock", icon_name = "", command = onlock },
        { name = "Reboot", icon_name = "", command = onreboot },
        { name = "Suspend", icon_name = "󰤄", command = onsuspend },
        { name = "Power off", icon_name = "", command = onpoweroff },
    }

    for _, item in ipairs( menu_items ) do
        local row = wibox.widget {
            {
                {
                    {
                        font = font,
                        forced_width = 20,
                        bg = theme.bg_normal,
                        fg = theme.fg_normal,
                        widget = wibox.widget.textbox( item.icon_name ),
                    },
                    {
                        text = item.name,
                        font = font,
                        bg = theme.bg_normal,
                        fg = theme.fg_normal,
                        widget = wibox.widget.textbox,
                    },
                    spacing = 12,
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = 8,
                layout = wibox.container.margin,
            },
            bg = theme.bg_normal,
            fg = theme.fg_normal,
            widget = wibox.container.background,
        }
        row:connect_signal(
            "mouse::enter", function( c )
                c:set_bg( theme.border_normal )
            end
         )
        row:connect_signal(
            "mouse::leave", function( c )
                c:set_bg( theme.bg_normal )
            end
         )

        local old_cursor, old_wibox
        row:connect_signal(
            "mouse::enter", function()
                local wb = mouse.current_wibox
                old_cursor, old_wibox = wb.cursor, wb
                wb.cursor = "hand1"
            end
         )
        row:connect_signal(
            "mouse::leave", function()
                if old_wibox then
                    old_wibox.cursor = old_cursor
                    old_wibox = nil
                end
            end
         )

        row:buttons(
            awful.util.table.join(
                awful.button(
                    {}, 1, function()
                        popup.visible = not popup.visible
                        item.command()
                    end
                 )
             )
         )

        table.insert( rows, row )
    end
    popup:setup( rows )

    logout_menu_widget:buttons(
        awful.util.table.join(
            awful.button(
                {}, 1, function()
                    if popup.visible then
                        popup.visible = not popup.visible
                    else
                        popup:move_next_to( mouse.current_widget_geometry )
                    end
                end
             )
         )
     )

    return logout_menu_widget
end

return worker
