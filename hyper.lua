require 'extensions'

local inspect = require('inspect')
local logger = hs.logger.new('hyper.lua', 'info')

-- A global variable for the Hyper Mode
local hyper = hs.hotkey.modal.new()
local hyperKey = 'F18'

local modifierCombinations = {
  {}, {'cmd'}, {'alt'}, {'shift'}, {'ctrl'},
  {'cmd', 'ctrl'}, {'cmd', 'alt'}, {'cmd', 'shift'}, {'ctrl', 'alt'}, {'ctrl', 'shift'}, {'alt', 'shift'},
  {'cmd', 'ctrl', 'alt'}, {'cmd', 'ctrl', 'shift'}, {'ctrl', 'alt', 'shift'},
  {'cmd', 'ctrl', 'alt', 'shift'}
}

local function bindHyper(modifiers, key, toKey)
  hyper:bind(modifiers, key, 
    function() hs.eventtap.event.newKeyEvent(modifiers, toKey, true):post() end, 
    function() hs.eventtap.event.newKeyEvent(modifiers, toKey, false):post() end,
    function() 
      hs.eventtap.event.newKeyEvent(modifiers, toKey, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post() 
    end
  )
end

-- Bind the Hyper and arrow keys
for i, modifiers in ipairs(modifierCombinations) do
  hs.hotkey.bind(modifiers, hyperKey, function() hyper:enter() end, function() hyper:exit() end)
  bindHyper(modifiers, 'j', 'left')
  bindHyper(modifiers, 'l', 'right')
  bindHyper(modifiers, 'i', 'up')
  bindHyper(modifiers, 'k', 'down')
  bindHyper(modifiers, 'u', 'delete')
  bindHyper(modifiers, 'o', 'forwarddelete')
end

-- applications
hyper:bind({}, "1", launchOrCycleFocus("/Applications/Google Chrome.app"))
hyper:bind({}, "2", launchOrCycleFocus("/Applications/Visual Studio Code.app"))
hyper:bind({}, "3", launchOrCycleFocus("/Applications/iTerm.app"))
hyper:bind({}, "4", launchOrCycleFocus("/System/Library/CoreServices/Finder.app"))
hyper:bind({}, "5", launchOrCycleFocus("/Applications/Todoist.app"))
hyper:bind({}, "space", function() hs.eventtap.keyStroke({'cmd'}, 'space') end)
hyper:bind({}, 'q', function() hs.window.focusedWindow():close() end)

return hyper
