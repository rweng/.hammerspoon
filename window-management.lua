--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local cmd = {'cmd'}
local cmd_ctrl = {"cmd", "ctrl"}
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}

--------------------------------------------------------------------------------
-- CONFIGURATIONS
--------------------------------------------------------------------------------

hs.window.animationDuration = 0
hs.grid.setGrid'2x2'

--- Bindings

hs.hotkey.bind(cmd_alt_ctrl, "R", function()
    hs.reload()
    hs.alert.show("Config loaded")
end)

hs.hotkey.bind(cmd_ctrl, "N", function()
	local win = hs.window.focusedWindow()
	win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(cmd_ctrl, "F", function()
	hs.window.focusedWindow():maximize()
end)

-- Left 1/2 of the screen
hs.hotkey.bind(cmd_ctrl, "left", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=0, w=1, h=2 })
end)

-- Right 1/2 of the screen
hs.hotkey.bind(cmd_ctrl, "right", function()
	hs.grid.set(hs.window.focusedWindow(), { x=1, y=0, w=1, h=2 })
end)

hs.hotkey.bind(cmd_ctrl, "up", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=0, w=2, h=1 })
end)

hs.hotkey.bind(cmd_ctrl, "down", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=1, w=2, h=1 })
end)