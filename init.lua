package.path = "/Users/rowe/.luarocks/share/lua/5.2/?.lua;"..package.path

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.consoleOnTop(true)


require 'reload-config'
require 'window-management'
require 'hyper'
require 'appman'
