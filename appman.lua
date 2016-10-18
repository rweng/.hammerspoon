require 'extensions'
local hyper = require 'hyper'
local appman = hs.hotkey.modal.new()

hyper:bind({}, 'a', nil, function() 
	appman:enter()
	hs.alert.show('App Mode') 
end)

local origialHyperExited = hyper.exited
function hyper:exited()
	appman:exit()
    origialHyperExited(hyper)
end

appman:bind({}, "c", launchOrCycleFocus("/Applications/Google Chrome.app"))
appman:bind({}, "v", launchOrCycleFocus("/Applications/Visual Studio Code.app"))
appman:bind({}, "t", launchOrCycleFocus("/Applications/iTerm.app"))
appman:bind({}, "f", launchOrCycleFocus("/System/Library/CoreServices/Finder.app"))