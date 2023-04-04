local awful = require( "awful" )
local hotkeys_popup = require( "awful.hotkeys_popup" )
require( "awful.hotkeys_popup.keys" )

local gears = require( "gears" )

modkey = "Mod4"

-- {{{ Key bindings

globalkeys = gears.table.join(
                 awful.key(
                     { modkey }, "s", hotkeys_popup.show_help,
                     { description = "show help", group = "awesome" }
                  ), awful.key(
                     { modkey }, "Left", awful.tag.viewprev,
                     { description = "view previous", group = "tag" }
                  ), awful.key(
                     { modkey }, "Right", awful.tag.viewnext,
                     { description = "view next", group = "tag" }
                  ), awful.key(
                     { modkey }, "Escape", awful.tag.history.restore,
                     { description = "go back", group = "tag" }
                  ), awful.key(
                     { modkey }, "l", function()
            awful.client.focus.byidx( 1 )
        end, { description = "focus next by index", group = "client" }
                  ), awful.key(
                     { modkey }, "h", function()
            awful.client.focus.byidx( -1 )
        end, { description = "focus previous by index", group = "client" }
                  ), awful.key(
                     { modkey }, "w", function()
            mymainmenu:show()
        end, { description = "show main menu", group = "awesome" }
                  ), -- Layout manipulation
    awful.key(
                     { modkey, "Shift" }, "l", function()
            awful.client.swap.byidx( 1 )
        end,
                     {
            description = "swap with next client by index",
            group = "client",
        }
                  ), awful.key(
                     { modkey, "Shift" }, "h", function()
            awful.client.swap.byidx( -1 )
        end,
                     {
            description = "swap with previous client by index",
            group = "client",
        }
                  ), awful.key(
                     { modkey, "Control" }, "l", function()
            awful.screen.focus_relative( 1 )
        end, { description = "focus the next screen", group = "screen" }
                  ), awful.key(
                     { modkey }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, { description = "go back", group = "client" }
                  ), -- Standard program
    awful.key(
                     { modkey }, "Return", function()
            awful.spawn( terminal )
        end, { description = "open a terminal", group = "launcher" }
                  ), awful.key(
                     { modkey, "Shift" }, "r", awesome.restart,
                     { description = "reload awesome", group = "awesome" }
                  ), awful.key(
                     { modkey, "Control" }, "q", awesome.quit,
                     { description = "quit awesome", group = "awesome" }
                  ), awful.key(
                     { modkey }, "n", function()
            awful.spawn( "librewolf" )
        end, { description = "open a browser", group = "application" }
                  ), awful.key(
                     { modkey }, "e", function()
            awful.spawn( "nemo" )
        end, { description = "open a file manager", group = "application" }
                  ), awful.key(
                     { modkey }, "m", function()
            awful.spawn( "spotify" )
        end, { description = "open a music player", group = "application" }
                  ), awful.key(
                     { modkey, "Shift" }, "p", function()
            awful.spawn( "flameshot gui" )
        end, { description = "take a screenshot", group = "application" }
                  ), awful.key(
                     { modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                 )
            end
        end, { description = "restore minimized", group = "client" }
                  ), awful.key(
                     { modkey }, "p", function()
            menubar.show()
        end, { description = "show the menubar", group = "launcher" }
                  ), awful.key(
                     { "Shift" }, "Alt_L", function()
            mykeyboardlayout.next_layout();
        end
                  ), awful.key(
                     { "Mod1" }, "Shift_L", function()
            mykeyboardlayout.next_layout();
        end
                  )
              )

clientkeys = gears.table.join(
                 awful.key(
                     { modkey }, "f", function( c )
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }
                  ), awful.key(
                     { modkey, "Shift" }, "q", function( c )
            c:kill()
        end, { description = "close", group = "client" }
                  ), awful.key(
                     { modkey, "Control" }, "space",
                     awful.client.floating.toggle,
                     { description = "toggle floating", group = "client" }
                  ), awful.key(
                     { modkey, "Control" }, "Return", function( c )
            c:swap( awful.client.getmaster() )
        end, { description = "move to master", group = "client" }
                  ), awful.key(
                     { modkey }, "o", function( c )
            c:move_to_screen()
        end, { description = "move to screen", group = "client" }
                  ), awful.key(
                     { modkey }, "t", function( c )
            c.ontop = not c.ontop
        end, { description = "toggle keep on top", group = "client" }
                  ), -- awful.key({ modkey, }, "n",
    awful.key(
                     { modkey, "Shift" }, "m", function( c )
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }
                  ), awful.key(
                     { modkey, "Control" }, "m", function( c )
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }
                  ), awful.key(
                     { modkey, "Shift" }, "m", function( c )
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }
                  )
              )

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(
                     globalkeys, -- View tag only.
        awful.key(
                         { modkey }, "#" .. i + 9, function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end, { description = "view tag #" .. i, group = "tag" }
                      ), -- Toggle tag display.
        awful.key(
                         { modkey, "Control" }, "#" .. i + 9, function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle( tag )
                end
            end, { description = "toggle tag #" .. i, group = "tag" }
                      ), -- Move client to tag.
        awful.key(
                         { modkey, "Shift" }, "#" .. i + 9, function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag( tag )
                    end
                end
            end,
                         {
                description = "move focused client to tag #" .. i,
                group = "tag",
            }
                      ), -- Toggle tag on focused client.
        awful.key(
                         { modkey, "Control", "Shift" }, "#" .. i + 9,
                         function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag( tag )
                    end
                end
            end, {
                description = "toggle focused client on tag #" .. i,
                group = "tag",
            }
                      )
                  )
    awful.key(
        { "F3" }, "XF86AudioLowerVolume", function()
            awful.spawn( "pactl set-sink-volume @DEFAULT_SINK@ -5%" )
        end, { description = "lower volume", group = "system" }
     )
    awful.key(
        { "F4" }, "XF86AudioRaiseVolume", function()
            awful.spawn( "pactl set-sink-volume @DEFAULT_SINK@ +5%" )
        end, { description = "increase volume", group = "system" }
     )
end

-- Set keys
root.keys( globalkeys )
-- }}}

-- {{{ Mouse bindings
root.buttons(
    gears.table.join(
        awful.button(
            {}, 3, function()
                mymainmenu:toggle()
            end
         ), awful.button( {}, 4, awful.tag.viewnext ),
        awful.button( {}, 5, awful.tag.viewprev )
     )
 )
-- }}}

clientbuttons = gears.table.join(
                    awful.button(
                        {}, 1, function( c )
            c:emit_signal( "request::activate", "mouse_click", { raise = true } )
        end
                     ), awful.button(
                        { modkey }, 1, function( c )
            c:emit_signal( "request::activate", "mouse_click", { raise = true } )
            awful.mouse.client.move( c )
        end
                     ), awful.button(
                        { modkey }, 3, function( c )
            c:emit_signal( "request::activate", "mouse_click", { raise = true } )
            awful.mouse.client.resize( c )
        end
                     )
                 )
