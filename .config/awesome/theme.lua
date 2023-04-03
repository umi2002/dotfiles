local awful = require( "awful" )
local gears = require( "gears" )
local naughty = require( "naughty" )
local beautiful = require( "beautiful" )
local wibox = require( "wibox" )

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init( gears.filesystem.get_themes_dir() .. "default/theme.lua" )

beautiful.wallpaper =
    "/home/umi/.config/awesome/wallpapers/suzume_wallpaper.jpg"
beautiful.wallpaper = awful.util.get_configuration_dir() ..
                          "wallpapers/suzume_wallpaper.jpg"

beautiful.useless_gap = 5
beautiful.border_width = 2
beautiful.border_normal = "#DAECF5"
beautiful.border_focus = "#FFA500"

local function set_wallpaper( s )
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type( wallpaper ) == "function" then
            wallpaper = wallpaper( s )
        end
        gears.wallpaper.maximized( wallpaper, s, true )
    end
end

awful.screen.connect_for_each_screen(
    function( s )
        set_wallpaper( s )
        awful.tag(
            { "1 󰙯 ", "2", "3", "4", "5", "6", "7", "8 󰇮", "9  " }, s,
            awful.layout.suit.fair
         )
         s.padding = { top = 40, bottom = 40 }
    end
 )

beautiful.notification_font = "MonoMaple Bold"
beautiful.notification_bg = "#129DD6"
beautiful.notification_fg = "#021352"
beautiful.notification_border_color = "#DAECF5"
beautiful.notification_border_width = 2

naughty.config.defaults["icon_size"] = 100
naughty.config.padding = 45
