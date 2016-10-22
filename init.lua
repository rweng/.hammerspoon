-- I install lua packages w/ luarocks locally, so adjust path here
package.path = "/Users/rowe/.luarocks/share/lua/5.2/?.lua;"..package.path

-- some hammerspoon config
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.consoleOnTop(true)

-- configurations
require 'reload-config'
require 'winmode'
require 'hyper'
