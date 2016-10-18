local logger = hs.logger.new('window-management.lua', 'info')

local cmd = {'cmd'}
local cmd_ctrl = {"cmd", "ctrl"}
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}

hs.window.animationDuration = 0
hs.grid.setGrid'2x2'

-- move window to next screen
hs.hotkey.bind(cmd_ctrl, "N", function()
	local win = hs.window.focusedWindow()
	win:moveToScreen(win:screen():next())
end)

-- maximize current window
hs.hotkey.bind(cmd_ctrl, "F", function()
	hs.window.focusedWindow():maximize()
end)

-- 1/2 of the screen bindings
hs.hotkey.bind(cmd_ctrl, "left", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=0, w=1, h=2 })
end)

hs.hotkey.bind(cmd_ctrl, "right", function()
	hs.grid.set(hs.window.focusedWindow(), { x=1, y=0, w=1, h=2 })
end)

-- up and down behave differently in the way that they keep the width and x position,
-- but push the window in the upper or lower half of the screen
hs.hotkey.bind(cmd_ctrl, "up", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=0, w=cell.w, h=1 })
end)

hs.hotkey.bind(cmd_ctrl, "down", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=1, w=cell.w, h=1 })
end)