local inspect = require('inspect')
local logger = hs.logger.new('hyper.lua', 'info')

-- A global variable for the Hyper Mode
local k = hs.hotkey.modal.new()
local hyperKey = 'F18'

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
local pressedHyper = function()
  k.modifiers = modifiers
  k.triggered = true
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
local releasedHyper = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

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

-- Bind the Hyper and arrow keys
for i, modifiers in ipairs(modifierCombinations) do
  hs.hotkey.bind(modifiers, hyperKey, pressedHyper, releasedHyper)
  k:bind(modifiers, 'j', left(modifiers))
  k:bind(modifiers, 'l', right(modifiers))
  k:bind(modifiers, 'i', up(modifiers))
  k:bind(modifiers, 'k', down(modifiers))
end

-- fix umlauts
local umlauts = { 'a', 'o', 'u' }
for i, umlaut in ipairs(umlauts) do
  hs.hotkey.bind({'alt'}, umlaut, function() 
    hs.eventtap.keyStroke({'alt'}, 'u')
    hs.timer.doAfter(0.1, function()
    hs.eventtap.keyStroke({}, umlaut)
    end)
  end)

  hs.hotkey.bind({'alt', 'shift'}, umlaut, function() 
    hs.eventtap.keyStroke({'alt'}, 'u')
    hs.timer.doAfter(0.1, function()
    hs.eventtap.keyStroke({'shift'}, umlaut)
    end)
  end)
end
