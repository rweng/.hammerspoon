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

-- Bind the Hyper Arrow Keys
local function bindHyper(modifiers, key, toModifiers, toKey)
  hyper:bind(modifiers, key, 
    function() hs.eventtap.event.newKeyEvent(toModifiers, toKey, true):post() end, 
    function() hs.eventtap.event.newKeyEvent(toModifiers, toKey, false):post() end,
    function() 
      hs.eventtap.event.newKeyEvent(toModifiers, toKey, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post() 
    end
  )
end

for i, modifiers in ipairs(modifierCombinations) do
  hs.hotkey.bind(modifiers, hyperKey, function() hyper:enter() end, function() hyper:exit() end)
  bindHyper(modifiers, 'j', modifiers, 'left')
  bindHyper(modifiers, 'l', modifiers, 'right')
  bindHyper(modifiers, 'i', modifiers, 'up')
  bindHyper(modifiers, 'k', modifiers, 'down')
  bindHyper(modifiers, 'u', modifiers, 'delete')
  bindHyper(modifiers, 'o', modifiers, 'forwarddelete')
end

-- Bind Hyper Coding Simplifications for German Keyboard

-- []
bindHyper({}, 'ö', {'alt'}, '5')
bindHyper({}, 'ä', {'alt'}, '6')

-- {}
bindHyper({'shift'}, 'ö', {'alt'}, '8')
bindHyper({'shift'}, 'ä', {'alt'}, '9')

-- /\
bindHyper({}, 'ü', {'shift'}, '7')
bindHyper({'shift'}, 'ü', {'shift', 'alt'}, '7')


-- applications
hyper:bind({}, "1", launchOrCycleFocus("/Applications/Google Chrome.app"))
hyper:bind({}, "2", launchOrCycleFocus("/Applications/Visual Studio Code.app"))
hyper:bind({}, "3", launchOrCycleFocus("/Applications/iTerm.app"))
hyper:bind({}, "4", launchOrCycleFocus("/System/Library/CoreServices/Finder.app"))
hyper:bind({}, "5", launchOrCycleFocus("/Applications/Todoist.app"))
hyper:bind({}, 'q', function() hs.window.focusedWindow():close() end)

return hyper
