local exec = hl.exec_cmd

hl.on("hyprland.start", function()
  exec("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  exec("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  exec("noctalia --daemon")
  exec("poweralertd")
end)


