inspect = require('inspect')
logger = hs.logger.new('My Settings', 'info')

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function(modifiers)
  fn = function()
    k.modifiers = modifiers
    k.triggered = false
    k:enter()
  end
  return fn
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
-- hs.hotkey.bind(nil, 'F18', pressedF18({}), releasedF18)
hs.hotkey.bind({'cmd', 'alt'}, 'F18', pressedF18({'cmd'}), releasedF18)

movements = {
 { 'i', 'up'},
 { 'j', 'left'},
 { 'k', 'down'},
 { 'l', 'right'}
}

for i,bnd in ipairs(movements) do
  k:bind({}, bnd[1], function() 
    logger.i('pressed', inspect(k.modifiers))
    hs.eventtap.keyStroke(k.modifiers,bnd[2])
  end)
  k:bind({'cmd'}, bnd[1], function() 
    logger.i('pressed cmd', inspect(k.modifiers))
    hs.eventtap.keyStroke(k.modifiers,bnd[2])
  end)
end