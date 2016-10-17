-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- HYPER+J: Act like left arrow.
efun = function()
  hs.eventtap.keyStroke({}, 'left')
  k.triggered = true
end
k:bind({}, 'j', nil, efun)

-- HYPER+L: Act like right arrow.
efun = function()
  hs.eventtap.keyStroke({}, 'right')
  k.triggered = true
end
k:bind({}, 'l', nil, efun)

-- HYPER+I: Act like up arrow.
efun = function()
  hs.eventtap.keyStroke({}, 'up')
  k.triggered = true
end
k:bind({}, 'i', nil, efun)

-- HYPER+K: Act like down arrow.
efun = function()
  hs.eventtap.keyStroke({}, 'down')
  k.triggered = true
end
k:bind({}, 'k', nil, efun)

-- HYPER+U: Act like backdelete.
efun = function()
  hs.eventtap.keyStroke({}, 'delete')
  k.triggered = true
end
k:bind({}, 'u', nil, efun)

-- HYPER+O: Act like forward delete.
efun = function()
  hs.eventtap.keyStroke({}, 'right')
  hs.eventtap.keyStroke({}, 'delete')
  k.triggered = true
end
k:bind({}, 'o', nil, efun)


-- HYPER+E: Act like ⌃e and move to end of line.
efun = function()
  hs.eventtap.keyStroke({'⌃'}, 'e')
  k.triggered = true
end
k:bind({}, 'e', nil, efun)

-- HYPER+A: Act like ⌃a and move to beginning of line.
afun = function()
  hs.eventtap.keyStroke({'⌃'}, 'a')
  k.triggered = true
end
k:bind({}, 'a', nil, afun)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
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
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)



--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local cmd = {'cmd'}
local cmd_ctrl = {"cmd", "ctrl"}
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}
local log = hs.logger.new('config','debug')

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


-- Browser
hs.hotkey.bind(cmd, "f1", function()
	hs.application.open("Google Chrome")
end)

-- Terminal
hs.hotkey.bind(cmd, "f2", function()
	hs.application.open("iTerm")
end)

-- Editor
hs.hotkey.bind(cmd, "f3", function()
	hs.application.open("Visual Studio Code")
end)

-- hs.hotkey.bind({"shift", "cmd"}, "f3", function()
-- 	hs.application.open("Visual Studio Code")
--     hs.application.open("Google Chrome Cannery")
-- end)

-- Finder
hs.hotkey.bind(cmd, "f4", function()
	hs.application.open("Finder")
end)

-- Todos
-- hs.hotkey.bind(cmd, "f5", function()
-- 	hs.application.open("Todoist")
-- end)


-- ---
-- local usbWatcher = nil

-- -- This is our usbWatcher function
-- -- lock when yubikey is removed
-- function usbDeviceCallback(data)
--     -- this line will let you know the name of each usb device you connect, useful for the string match below
--     hs.notify.show("USB", data["productName"], data["eventType"])
--     -- Replace "Yubikey" with the name of the usb device you want to use.
--     if string.match(data["productName"], "Yubikey") then
--         if (data["eventType"] == "added") then
--             -- hs.notify.show("Yubikey", "You just connected", data["productName"])
--             -- wake the screen up
--             os.execute("caffeinate -u -t 5")
--         elseif (data["eventType"] == "removed") then
--             -- replace +000000000000 with a phone number registered to iMessage
--             --- hs.messages.iMessage("+000000000000", "Your Yubikey was just removed from your Work iMac.")
--             -- this locks to screensaver
--             os.execute("pmset displaysleepnow")
--        end
--    end
-- end

-- -- Start the usb watcher
-- usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
-- usbWatcher:start()

-- ----