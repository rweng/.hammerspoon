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

-- move window to next screen
winman:bind({}, "N", function()
	local win = hs.window.focusedWindow()
	win:moveToScreen(win:screen():next())
end)

-- maximize current window
winman:bind({}, "F", function()
	hs.window.focusedWindow():maximize()
end)

-- 1/2 of the screen bindings
winman:bind({}, "left", function()
	hs.grid.set(hs.window.focusedWindow(), { x=0, y=0, w=1, h=2 })
end)

winman:bind({}, "right", function()
	hs.grid.set(hs.window.focusedWindow(), { x=1, y=0, w=1, h=2 })
end)

-- up and down behave differently in the way that they keep the width and x position,
-- but push the window in the upper or lower half of the screen
winman:bind({}, "up", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=0, w=cell.w, h=1 })
end)

winman:bind({}, "down", function()
	local win = hs.window.focusedWindow()
    local cell = hs.grid.get(win)
	hs.grid.set(hs.window.focusedWindow(), { x=cell.x, y=1, w=cell.w, h=1 })
end)

winman:bind({}, "1", launchOrCycleFocus("/Applications/Google Chrome.app"))
winman:bind({}, "2", launchOrCycleFocus("/Applications/Visual Studio Code.app"))
winman:bind({}, "3", launchOrCycleFocus("/Applications/iTerm.app"))
winman:bind({}, "4", launchOrCycleFocus("/System/Library/CoreServices/Finder.app"))
winman:bind({}, 'q', function() hs.window.focusedWindow():close() end)