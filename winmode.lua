require 'extensions'

local hyper = require 'hyper'
local logger = hs.logger.new('window-management.lua', 'info')
local winman = hs.hotkey.modal.new()

hyper:bind({}, 'w', nil, function() 
	winman:enter()
	hs.alert.show('Window Mode') 
end)

local origialHyperExited = hyper.exited
function hyper:exited()
	winman:exit()
	origialHyperExited(hyper)
end

hs.window.animationDuration = 0
hs.grid.setGrid'2x2'
hs.grid.setMargins({x=0, y=0})

-- move window to next screen
winman:bind({}, "n", function()
	local win = hs.window.focusedWindow()
	win:moveToScreen(win:screen():next())
end)

-- maximize current window
winman:bind({}, "f", function()
	hs.window.focusedWindow():maximize()
end)

-- 1/2 of the screen bindings
winman:bind({}, "j", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=0, w=1, h=2 })
end)

winman:bind({}, "l", function()
	hs.grid.set(hs.window.focusedWindow(), { x=1, y=0, w=1, h=2 })
end)

-- up and down behave differently in the way that they keep the width and x position,
-- but push the window in the upper or lower half of the screen
winman:bind({}, "i", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=0, w=cell.w, h=1 })
end)

winman:bind({}, "k", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=1, w=cell.w, h=1 })
end)
