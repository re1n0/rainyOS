local super    = "SUPER"
local superMod = "SUPER + SHIFT"

local function launch_mime(key, mime)
    hl.bind(super .. " + " .. key, hl.dsp.exec_cmd("handlr launch " .. mime))
end


launch_mime("I", "x-scheme-handler/terminal")
launch_mime("B", "x-scheme-handler/http*")

hl.bind(super    .. " + Q", hl.dsp.window.close())
hl.bind(super    .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(superMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(superMod .. " + T", hl.dsp.window.float({ action = "toggle" }))


hl.bind(super .. " + H", hl.dsp.focus({ direction = "left"  }))
hl.bind(super .. " + J", hl.dsp.focus({ direction = "down"  }))
hl.bind(super .. " + K", hl.dsp.focus({ direction = "up"    }))
hl.bind(super .. " + L", hl.dsp.focus({ direction = "right" }))


for i = 1, 10 do
    local key = i % 10
    hl.bind(super    .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(superMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(super .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(super .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))


hl.bind(super    .. " + S", hl.dsp.exec_cmd("screenshot --full"))
hl.bind(superMod .. " + S", hl.dsp.exec_cmd("screenshot --crop"))


hl.bind(super .. " + F4", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(super .. " + F5", hl.dsp.exec_cmd("brightnessctl set 5%+"))


hl.bind(super .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
