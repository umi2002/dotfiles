local wibox = require( "wibox" )
local theme = require( "theme" )

local widget = {}

function widget.get_widget()

    local font = theme.font

    return wibox.widget {
        {
            {
                id = "icon",
                widget = wibox.widget.textbox,
                font = theme.font,
                forced_width = 20,
            },
            valign = "center",
            layout = wibox.container.place,
        },
        { id = "txt", font = font, widget = wibox.widget.textbox },
        layout = wibox.layout.fixed.horizontal,
        set_volume_level = function( self, new_value )
            self:get_children_by_id( "txt" )[1]:set_text( new_value )
            local volume_icon_name
            if self.is_muted then
                volume_icon_name = "󰖁"
            else
                local new_value_num = tonumber( new_value )
                if (new_value_num == 0) then
                    volume_icon_name = "󰕿"
                elseif (new_value_num > 0 and new_value_num < 33) then
                    volume_icon_name = "󰖀"
                elseif (new_value_num < 66) then
                    volume_icon_name = "󰕾"
                else
                    volume_icon_name = ""
                end
            end
            self:get_children_by_id( "icon" )[1]:set_text( volume_icon_name )
        end,
        mute = function( self )
            self.is_muted = true
            self:get_children_by_id( "icon" )[1]:set_text( "󰖁" )
        end,
        unmute = function( self )
            self.is_muted = false
        end,
    }
end

return widget
