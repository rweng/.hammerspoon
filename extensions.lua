-- t/h https://github.com/oskarols/dotfiles/blob/master/hammerspoon/extensions.lua

local filter = hs.fnutils.filter
local indexOf = hs.fnutils.indexOf

-- Needed to enable cycling of application windows
local lastToggledApplication = ''

-- Fetch next index but cycle back when at the end
--
-- > getNextIndex({1,2,3}, 3)
-- 1
-- > getNextIndex({1}, 1)
-- 1
-- @return int
local function getNextIndex(table, currentIndex)
  nextIndex = currentIndex + 1
  if nextIndex > #table then
    nextIndex = 1
  end

  return nextIndex
end

-- Returns the next successive window given a collection of windows
-- and a current selected window
--
-- @param  windows  list of hs.window or applicationName
-- @param  window   instance of hs.window
-- @return hs.window
local function getNextWindow(windows, window)
  if type(windows) == "string" then
    windows = hs.appfinder.appFromName(windows):allWindows()
  end

  windows = filter(windows, hs.window.isStandard)
  windows = filter(windows, hs.window.isVisible)

  -- need to sort by ID, since the default order of the window
  -- isn't usable when we change the mainWindow
  -- since mainWindow is always the first of the windows
  -- hence we would always get the window succeeding mainWindow
  table.sort(windows, function(w1, w2)
    return w1:id() > w2:id()
  end)

  lastIndex = indexOf(windows, window)

  return windows[getNextIndex(windows, lastIndex)]
end

function launchOrCycleFocus(appPath)
  return function()
    local nextWindow = nil
    local targetWindow = nil
    local focusedWindow = hs.window.focusedWindow()

    if not focusedWindow then return nil end

    if focusedWindow:application():path() == appPath then
      nextWindow = getNextWindow(focusedWindow:application():allWindows(), focusedWindow)
      nextWindow:becomeMain()
    else
      hs.application.launchOrFocus(appPath)
    end
  end
end
