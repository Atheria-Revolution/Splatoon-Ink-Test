--= Music Util Module by Danael_21 X StarShadow64 =--

--= Main Module =--

local Module = {}
local Musics = {}
local CurrentMusic = nil
local InstanceUtil = require(game.ReplicatedStorage:FindFirstChild("ToolibsUtils"):FindFirstChild("InstanceUtil"))

function Module.Enable()
    local MF = game.Workspace:FindFirstChild("MusicFolder")
    if MF then
        local TM = #MF:GetChildren()
        for i=1, TM do
            for _, musics in pairs(MF:GetChildren()) do
                if musics:FindFirstChild("ID").Value == i then
                    table.insert(Musics, musics.ID.Value, {["Musice"] = musics.SoundId})
                    print("Inserting music with id "..musics.ID.Value.." on slot "..i)
                end
            end
        end
    end

    MF:Destroy()

    warn("Musics transfered succesfully !")
end

function Module.LoadMusic(Id)
    if CurrentMusic == nil then
        local MFolder = InstanceUtil.Instanciate("Folder", game.ReplicatedStorage, {["Name"] = "MusicFolder"})
        CurrentMusic = InstanceUtil.Instanciate("Sound", MFolder, {["Name"] = "CurentPlaying", ["SoundId"] = Musics[Id].Musice, ["Looped"] = true, ["Volume"] = 0})
        CurrentMusic:Play()
        local t  = game.TweenService:Create(CurrentMusic, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Volume = 0.5})
        t:Play()
    else
        local t  = game.TweenService:Create(CurrentMusic, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Volume = 0})
        t:Play()
        local NMusic = InstanceUtil.Instanciate("Sound", game.ReplicatedStorage:FindFirstChild("MusicFolder"), {["Name"] = "CurentPlaying", ["SoundId"] = Musics[Id].Musice, ["Looped"] = true, ["Volume"] = 0})
        NMusic:Play()
        local t2  = game.TweenService:Create(NMusic, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Volume = 0.5})
        t2:Play()
        wait(0.21)
        CurrentMusic:Destroy()
        CurrentMusic = NMusic
    end
end


return Module