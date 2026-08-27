local dispatch = {
	cmd = function(a)
		return hl.dsp.exec_cmd(a.command)
	end,
	windowClose = function(a)
		return hl.dsp.window.close()
	end,
	windowFullscreen = function(a)
		return hl.dsp.window.fullscreen({ mode = a.mode == "fullscreen" and 1 or 0 })
	end,
	windowFloat = function(a)
		return hl.dsp.window.float({ action = a.state })
	end,
	focus = function(a)
		return hl.dsp.focus({ direction = a.direction })
	end,
	workspace = function(a)
		return hl.dsp.focus({ workspace = a.index })
	end,
	moveToWorkspace = function(a)
		return hl.dsp.window.move({ workspace = a.index })
	end,
	workspaceRelative = function(a)
		return hl.dsp.focus({ workspace = a.direction == "next" and "e+1" or "e-1" })
	end,
	windowDrag = function(a)
		return hl.dsp.window.drag()
	end,
	windowResize = function(a)
		return hl.dsp.window.resize()
	end,
}

local function toFlagsTable(flags)
	local t = {}
	for _, f in ipairs(flags) do
		t[f] = true
	end
	return t
end
