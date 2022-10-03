warn("Loading Ink Engine")

local InkENGINE = require(script:FindFirstChild("InkEngine"))

delay(.05, function()
    InkENGINE.Start(true)
end)