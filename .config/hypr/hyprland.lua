local terminal = "alacritty"
local fileManager = "pcmanfm-qt"
local menu = "tofi-drun --drun-launch=true"
local mainMod = "SUPER"
local home_dir = os.getenv("HOME")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("STEAM_FRAME_FORCE_CLOSE", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("GTK_THEME=Adwaita:dark waybar")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("corectrl --minimize-systray -m \"Custom\"")
    hl.exec_cmd("dunst")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
    hl.exec_cmd("hyprctl setcursor WinSur-dark-cursors 32")
    hl.exec_cmd("hypridle")
end)

function is_file_exists(name)
   local f = io.open(name, "r")
   if f ~= nil then
      io.close(f)
      return true
   else
      return false
   end
end


if is_file_exists(home_dir .. "/.config/hypr/monitors.lua") then
  require("monitors")
end

hl.monitor({
  output = "FALLBACK",
  mode = "preferred",
  position = "auto" 
})

hl.config({
  general = {
    allow_tearing = false,
    border_size = 1,
    col = {
      active_border = { colors = {"rgba(0b4685ee)", "rgba(0b4684b0)"}, angle = 135 },
      inactive_border = "rgba(2f2f2faa)",
    },
    gaps_in = 1,
    gaps_out = 0,
    layout = "dwindle",
    resize_on_border = false,
  },
  decoration = {
    active_opacity = 1.0,
    blur = {
      enabled = true,
      passes = 1,
      size = 3,
      vibrancy = 0.1696,
    },
    inactive_opacity = 0.9,
    rounding = 0,
    shadow = {
      color = "rgba(1a1a1aee)",
      enabled = true,
      range = 4,
      render_power = 3,
    }
  },
  input = {
      follow_mouse = 1,
      kb_layout = "us,ru,rs",
      kb_model = "pc104",
      kb_options = "grp:win_space_toggle,terminate:ctrl_alt_bksp",
      kb_rules = "",
      kb_variant = ",,latin",
      sensitivity = 0,
      touchpad = {
          natural_scroll = false,
      },
  },
  misc = {
      -- Wallpapers are overrated!
      background_color = "rgba(00000000)",
      disable_hyprland_logo = true,
      disable_splash_rendering = true,
      force_default_wallpaper = 0,
  },
  xwayland = {
      force_zero_scaling = true,
  },
  dwindle = {
      preserve_split = true,
  },
  master = {
      new_status = "master",
  },
  animations = {
      enabled = true,
  },
})

-- No borders on a single non-floating window
hl.window_rule({
      border_size = 0,
      float = false,
      match = { class = "^$" },
      name = "noborders-nofloat",
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "w[t1]", gaps_out = 0 })
hl.workspace_rule({ workspace = "w[t1]", border_size = 0 })

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("pcmanfm-qt"))
hl.bind(mainMod .. " + grave", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({action = "toggle"}))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m active -m window"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m active -m output"))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down"  }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down"  }))

for i = 1, 10 do
  hl.bind(mainMod .. " + " .. (i % 10), hl.dsp.focus({ workspace = tostring(i % 10) }))
  hl.bind(mainMod .. " + SHIFT + " .. (i % 10), hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%- --min-value 1"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

ecosystem = { no_update_news = true },

-- Curves
hl.curve("expressiveFastSpatial", {
    type = "bezier",
    points = {{0.42, 1.67}, {0.21, 0.90}}
})
hl.curve("expressiveSlowSpatial", {
    type = "bezier",
    points = {{0.39, 1.29}, {0.35, 0.98}}
})
hl.curve("expressiveDefaultSpatial", {
    type = "bezier",
    points = {{0.38, 1.21}, {0.22, 1.00}}
})
hl.curve("emphasizedDecel", {
    type = "bezier",
    points = {{0.05, 0.7}, {0.1, 1}}
})
hl.curve("emphasizedAccel", {
    type = "bezier",
    points = {{0.3, 0}, {0.8, 0.15}}
})
hl.curve("standardDecel", {
    type = "bezier",
    points = {{0, 0}, {0, 1}}
})
hl.curve("menu_decel", {
    type = "bezier",
    points = {{0.1, 1}, {0, 1}}
})
hl.curve("menu_accel", {
    type = "bezier",
    points = {{0.52, 0.03}, {0.72, 0.08}}
})
hl.curve("stall", {
    type = "bezier",
    points = {{1, -0.1}, {0.7, 0.85}}
})


-- Configs

-- windows
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 3,
    bezier = "emphasizedDecel",
    style = "popin 80%"
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 3,
    bezier = "emphasizedDecel"
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "emphasizedDecel",
    style = "popin 90%"
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 2,
    bezier = "emphasizedDecel"
})
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "emphasizedDecel",
    style = "slide"
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "emphasizedDecel"
})

-- layers
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 2.7,
    bezier = "emphasizedDecel",
    style = "popin 93%"
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 2.4,
    bezier = "menu_accel",
    style = "popin 94%"
})

-- fade
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 0.5,
    bezier = "menu_decel"
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 2.7,
    bezier = "stall"
})

-- workspaces
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 7,
    bezier = "menu_decel",
    style = "slide"
})
