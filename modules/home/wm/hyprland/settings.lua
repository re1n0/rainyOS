hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpolkitagent")
end)


for _, m in ipairs(NIX_MONITORS) do
    hl.monitor({
        output   = m.connector,
        mode     = m.width .. "x" .. m.height .. "@" .. m.refresh,
        position = m.position,
        scale    = m.scale,

        supports_wide_color = m.wide_color  and 1 or -1,
        supports_hdr        = m.hdr         and 1 or -1,
        bitdepth            = m.wide_color  and 10 or 8,
        cm                  = m.cm or m.hdr and "hdr" or "srgb",
        sdrsaturation       = m.hdr         and 1.2 or 1.0,
        sdrbrightness       = m.hdr         and 1.2 or 1.0,
        sdr_max_luminance   = m.hdr         and 225 or nil,
        sdr_min_luminance   = m.hdr         and 0.005 or nil,
        sdr_eotf            = m.eotf,
        icc                 = m.icc or nil,
    })
end


hl.config({
    input = {
        kb_layout  = NIX_KB_LAYOUT,
        kb_options = "grp:win_space_toggle",

        repeat_rate  = 50,
        repeat_delay = 240,

        sensitivity = 0,

        touchpad = {
            disable_while_typing = false,
            natural_scroll       = true,
            clickfinger_behavior = true,
        },
    },
})

hl.config({
    gestures = {
        workspace_swipe_min_speed_to_force = 15,
    },
})

hl.config({
    cursor = {
        sync_gsettings_theme = true,
        enable_hyprcursor    = false,
        use_cpu_buffer       = true,
    },
})


hl.config({
    general = {
        border_size      = 3,
        gaps_in          = 5,
        gaps_out         = 7,
        layout           = "dwindle",
        allow_tearing    = true,
        resize_on_border = true,
    },

    decoration = {
        rounding = 0,
        blur     = { enabled = false },
        shadow   = { enabled = false },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("wind",   { type = "bezier", points = { {0.22, 1}, {0.36, 1} } })
hl.curve("winIn",  { type = "bezier", points = { {0.16, 1}, {0.3,  1} } })
hl.curve("winOut", { type = "bezier", points = { {0.33, 1}, {0.68, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind"    })


hl.config({
    dwindle = {
        preserve_split = true,
        force_split    = false,
    },
})


hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    render = {
        cm_auto_hdr = false,
    },

    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
})


-- hl.config({
--     ["plugin:dynamic-cursors"] = {
--         enabled   = true,
--         node      = "tilt",
--         threshold = 1,

--         tilt = {
--             limit        = 5000,
--             ["function"] = "negative_quadratic",  
--         },

--         shake = {
--             enabled   = false,
--             nearest   = true,
--             threshold = 5.0,
--             base      = 1.0,
--             speed     = 1.0,
--             influance = 0.5,   
--             limit     = 0.0,
--             timeout   = 1000,
--             effects   = true,
--             ipc       = false,
--         },

--         hyprcursor = {
--             enabled    = true,
--             nearest    = true,
--             resolution = -1,
--             fallback   = "clientside",
--         },
--     },
-- })
