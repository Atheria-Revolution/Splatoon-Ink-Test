--= Module Loader by Danael_21 X StarShadow64 =--

--= Main Module =--

local Module = {}
local InstanceUtil = require(game.ReplicatedStorage:FindFirstChild("ToolibsUtils"):FindFirstChild("InstanceUtil"))
local ClientModuleFolder = InstanceUtil.Instanciate("Folder", game.ReplicatedStorage, {["Name"] = "ClientModules"})
local ServerModuleFolder = InstanceUtil.Instanciate("Folder", game.ServerScriptService, {["Name"] = "ServerModules"})

function Module.Load(ModuleFolder, serversided)
    warn("Loading "..#ModuleFolder:GetChildren().." modules...")
    for i, modules in pairs(ModuleFolder:GetChildren()) do
        if modules:IsA("ModuleScript") then
            if serversided == true then
                modules.Parent = ServerModuleFolder
                delay(.05, function()
                    require(modules)()
                end)
            else
                modules.Parent = ClientModuleFolder
                delay(.05, function()
                    require(modules)()
                end)
            end
        elseif modules:IsA("Script") then
            if serversided == true then
                modules.Parent = ServerModuleFolder
                --modules.Disabled = false
            else
                modules.Parent = ClientModuleFolder
                modules.Disabled = false
            end
        end
    end
end

return Module