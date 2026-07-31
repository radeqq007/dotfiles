local terminal    = "ghostty"
local browser     = "flatpak run app.zen_browser.zen"
local fileManager = "thunar"

local b = hl.bind
local exec = hl.dsp.exec_cmd
local focus = hl.dsp.focus

local mainMod = "SUPER"

b(mainMod .. " + L", exec("noctalia msg session lock"))
b(mainMod .. " + Q", exec(terminal))
b(mainMod .. " + B", exec(browser))
b(mainMod .. " + C", hl.dsp.window.close())

b(mainMod .. " + M", exec("uwsm stop"))

b(mainMod .. " + F", exec(fileManager))
b(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

b(mainMod .. " + space",  exec("noctalia msg panel-toggle launcher"))
b(mainMod .. " + PERIOD",  exec("noctalia msg panel-toggle launcher /emo"))

b(mainMod .. " + P",     hl.dsp.window.pseudo())
b(mainMod .. " + slash", hl.dsp.layout("togglesplit"))

b(mainMod .. " + left",  focus({ direction = "left" }))
b(mainMod .. " + right", focus({ direction = "right" }))
b(mainMod .. " + up",    focus({ direction = "up" }))
b(mainMod .. " + down",  focus({ direction = "down" }))

b(mainMod .. " + h", focus({ direction = "left" }))
b(mainMod .. " + l", focus({ direction = "right" }))
b(mainMod .. " + k", focus({ direction = "up" }))
b(mainMod .. " + j", focus({ direction = "down" }))

b(mainMod .. " + X", exec("noctalia msg panel-toggle control-center"))
b(mainMod .. " + Z", exec("noctalia msg settings-open"))

for i = 1, 10 do
  local key = i % 10
  b(mainMod .. " + " .. key, focus({ workspace = i }))
  b(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
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
  b(mainMod .. " + " .. key, focus({ workspace = i }))
  b(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

b(mainMod .. " + mouse_down", focus({ workspace = "e+1" }))
b(mainMod .. " + mouse_up",   focus({ workspace = "e-1" }))

b(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
b(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

b(mainMod .. " + SHIFT + S", exec("noctalia msg screenshot-region"))

b(mainMod .. " + SHIFT + p", exec("hyprpicker"))

-- Zoom
b("CTRL + " .. mainMod .. " + equal", function()
  local zf = hl.get_config("cursor.zoom_factor")
  hl.config({ cursor = { zoom_factor = zf + 0.5 } })
end)

b("CTRL + " .. mainMod .. " + minus", function()
  local zf = hl.get_config("cursor.zoom_factor")
  hl.config({ cursor = { zoom_factor = math.max(zf - 0.5, 1) } })
end)

b("CTRL + " .. mainMod .. " + 0", function()
  hl.config({ cursor = { zoom_factor = 1.0 } })
end)

b("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
b("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
b("XF86AudioMute",        exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
b("XF86AudioMicMute",     exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
b("XF86MonBrightnessUp",  exec("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
b("XF86MonBrightnessDown",exec("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })

b("XF86AudioNext",  exec("playerctl next"),        { locked = true })
b("XF86AudioPause", exec("playerctl play-pause"),  { locked = true })
b("XF86AudioPlay",  exec("playerctl play-pause"),  { locked = true })
b("XF86AudioPrev",  exec("playerctl previous"),    { locked = true })

