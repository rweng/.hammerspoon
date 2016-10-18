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

local function left(modifiers) return function() hs.eventtap.keyStroke(modifiers, "left") end end
local function right(modifiers) return function() hs.eventtap.keyStroke(modifiers, "right") end end
local function up(modifiers) return function() hs.eventtap.keyStroke(modifiers, "up") end end
local function down(modifiers) return function()hs.eventtap.keyStroke(modifiers, "down") end end
local function delete(modifiers) return function()hs.eventtap.keyStroke(modifiers, "delete") end end
local function forwarddelete(modifiers) return function()hs.eventtap.keyStroke(modifiers, "forwarddelete") end end

-- Bind the Hyper and arrow keys
for i, modifiers in ipairs(modifierCombinations) do
  hs.hotkey.bind(modifiers, hyperKey, function() hyper:enter() end, function() hyper:exit() end)

  hyper:bind(modifiers, 'j', nil, left(modifiers))
  hyper:bind(modifiers, 'l', nil, right(modifiers))
  hyper:bind(modifiers, 'i', nil, up(modifiers))
  hyper:bind(modifiers, 'k', nil, down(modifiers))
  hyper:bind(modifiers, 'u', nil, delete(modifiers))
  hyper:bind(modifiers, 'o', nil, forwarddelete(modifiers))
end

return hyper