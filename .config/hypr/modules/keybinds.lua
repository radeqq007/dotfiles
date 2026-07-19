local terminal    = "ghostty"
local browser     = "zen-browser"
local fileManager = "thunar"
local menu        = "wofi"

local mainMod = "SUPER"

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.window.close())

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))

hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("wofimoji"))

hl.bind(mainMod .. " + P",     hl.dsp.window.pseudo())
hl.bind(mainMod .. " + slash", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Numpad numbers
local numpadKeys = {
  "KP_End",
  "KP_Down",
  "KP_Next",
  "KP_Left",
  "KP_Begin",
  "KP_Right",
  "KP_Home",
  "KP_Up",
  "KP_Prior",
  "KP_Insert",
}

for i, key in ipairs(numpadKeys) do
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("Print", hl.dsp.exec_cmd("hyprshot --freeze -m output -o ~/Pictures/Screenshots/"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --freeze -m region -o ~/Pictures/Screenshots/"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot --freeze -m window -o ~/Pictures/Screenshots/"))

hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd("hyprpicker"))

-- Zoom
hl.bind("CTRL + " .. mainMod .. " + equal", function()
  local zf = hl.get_config("cursor.zoom_factor")
  hl.config({ cursor = { zoom_factor = zf + 0.5 } })
end)

hl.bind("CTRL + " .. mainMod .. " + minus", function()
  local zf = hl.get_config("cursor.zoom_factor")
  hl.config({ cursor = { zoom_factor = math.max(zf - 0.5, 1) } })
end)

hl.bind("CTRL + " .. mainMod .. " + 0", function()
  hl.config({ cursor = { zoom_factor = 1.0 } })
end)

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })


