local awful = require( "awful" )
local gears = require( "gears" )
local naughty = require( "naughty" )
local beautiful = require( "beautiful" )

beautiful.init( gears.filesystem.get_configuration_dir() .. "theme.lua" )

beautiful.wallpaper =
    "/home/umi/.config/awesome/wallpapers/suzume_wallpaper.jpg"
beautiful.wallpaper = awful.util.get_configuration_dir() ..
                          "wallpapers/suzume_wallpaper.jpg"

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
            { "󰙯 1", "2", "3", "4", "5", "6", "7", "󰇮 8", " 9" }, s,
            awful.layout.suit.fair
         )
        s.padding = { top = 35, bottom = 35 }
    end
 )

client.connect_signal(
    "manage", function( c )
        c.shape = function( cr, w, h )
            gears.shape.rounded_rect( cr, w, h, 10 )
        end
    end
 )

naughty.config.defaults["icon_size"] = 100
naughty.config.padding = 50
beautiful.notification_max_width = 400
beautiful.notification_max_height = 100
