--= INK ENGINE Module by Danael_21 X StarShadow64 =--

--= Root =--

local ENGINE = { }

--= Constants =--

local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local InstanceUtil = require(Toolibs:FindFirstChild("InstanceUtil"))

local Workspace = game.Workspace
local CurrentTerrain

local inkColor = Color3.fromRGB(0, 32, 96)
local inkPos = Vector3.new(7,10,36.5)
local inkOrient = Vector3.new(0,0,90)
local mpSize = Vector3.new(0.05, math.random(5,10), math.random(5,10))

--= Instance Lib =--

local instanceLib = { }

instanceLib.InkBlob = {
    ["Name"] = "InkBlob",
    ["Anchored"] = false,
    ["Size"] = Vector3.new(0.25,0.25,0.25),
    ["Position"] = inkPos,
    ["TopSurface"] = Enum.SurfaceType.Smooth,
    ["BottomSurface"] = Enum.SurfaceType.Smooth,
    ["Shape"] = Enum.PartType.Ball,
    ["Material"] = Enum.Material.Neon,
    ["Color"] = inkColor,
    ["AssemblyLinearVelocity"] = Vector3.new(0,10,0)
}

instanceLib.InkSplash = {
    ["Name"] = "InkSplash",
    ["Anchored"] = true,
    ["Size"] = mpSize,
    ["Position"] = inkPos,
    ["TopSurface"] = Enum.SurfaceType.Smooth,
    ["BottomSurface"] = Enum.SurfaceType.Smooth,
    ["Shape"] = Enum.PartType.Cylinder,
    ["Material"] = Enum.Material.Neon,
    ["Color"] = inkColor,
    ["Orientation"] = inkOrient
}

--= Functions =--

function getOrientation(BPart, LPart)
    --warn("Position : "..LPart.Position.Y.."/"..(LPart.Size.Y/2))
    local orie = Vector3.new(BPart.Position.X, (LPart.Position.Y + (LPart.Size.Y / 2) + 0.025), BPart.Position.Z)
    return orie
end

function getPosFromPoint(part, point, size)
    --warn("--CREATING POINT VECTOR3 POS--")

    --warn("Starting process with parameters : "..point)
    --warn("Size used : "..size.X.."/"..size.Y.."/"..size.Z)
    if point == 1 then
        --warn("POINT1")
        --warn(part.Position.X.."/"..part.Position.Y.."/"..part.Position.Z - (size.Z / 2))
        return Vector3.new(part.Position.X, part.Position.Y, part.Position.Z - (size.Z / 2)), 0, -1
    elseif point == 2 then
        --warn("POINT2")
        --warn(part.Position.X + (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z - (size.Z / 2))
        return Vector3.new((part.Position.X + (size.Y / 2))-0.5, part.Position.Y, (part.Position.Z - (size.Z / 2))+0.5), 1, -1
    elseif point == 3 then
        --warn("POINT3")
        --warn(part.Position.X + (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z)
        return Vector3.new(part.Position.X + (size.Y / 2), part.Position.Y, part.Position.Z), 1, 0
    elseif point == 4 then
        --warn("POINT4")
        --warn(part.Position.X + (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z + (size.Z / 2))
        return Vector3.new((part.Position.X + (size.Y / 2))-0.5, part.Position.Y, (part.Position.Z + (size.Z / 2))-0.5), 1, 1
    elseif point == 5 then
        --warn("POINT5")
        --warn(part.Position.X.."/"..part.Position.Y.."/"..part.Position.Z + (size.Z / 2))
        return Vector3.new(part.Position.X, part.Position.Y, part.Position.Z + (size.Z / 2)), 0, 1
    elseif point == 6 then
        --warn("POINT6")
        --warn(part.Position.X - (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z + (size.Z / 2))
        return Vector3.new((part.Position.X - (size.Y / 2))+0.5, part.Position.Y, (part.Position.Z + (size.Z / 2))-0.5), -1, 1
    elseif point == 7 then
        --warn("POINT7")
        --warn(part.Position.X - (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z)
        return Vector3.new(part.Position.X - (size.Y / 2), part.Position.Y, part.Position.Z), -1, 0
    elseif point == 8 then
        --warn("POINT8")
        --warn(part.Position.X - (size.Y / 2).."/"..part.Position.Y.."/"..part.Position.Z - (size.Z / 2))
        return Vector3.new((part.Position.X - (size.Y / 2))+0.5, part.Position.Y, (part.Position.Z - (size.Z / 2))+0.5), -1, -1
    end
end

function calculateAdditionnalSize(pSize, removal)
    if pSize <= 1 then
        return 0
    else
        local sizeToGo = (pSize/2) - removal
        --warn("SIZE TO GO : "..sizeToGo.." WITH REMOVAL OF "..removal.." AND PSIZE OF "..pSize)
        local beforeCalculation = sizeToGo * 100
        local calculatedNumber = math.random(0, beforeCalculation)
        local afterCalculation = calculatedNumber / 100
        return afterCalculation
    end
end

function calculatePos(cPart, point1, point2, pSize, cSize)

    -- cPart = MainInkPart and cSize = mpSize
    if point2 then
        --Duo Point Calculation
        --print("Dual Calculation")
    else
        --Single Point Calculation
        local oringinPointPos, X, Z = getPosFromPoint(cPart, point1, cSize)
        local XAddition, ZAddition
        local rng = math.random(1,2)
        local removal

        --warn("Single calculation with parameters : "..oringinPointPos.X.."."..oringinPointPos.Y.."."..oringinPointPos.Z.." / "..X.." / "..Z)

        --print(pSize.." IS THE PSIZE")
        if pSize <= 1 then
            --print("0.25 IS THE REMOVAL")
            removal = 0.25
        else
            --print("1 IS THE REMOVAL")
            removal = 0.5
        end

        if rng == 1 then
            --warn("--ADDITION TYPE--")
            if X == 0 then
            else
                if Z == 0 then
                else
                    if (pSize/2) <= 0.5 then
                    else
                        removal = (pSize/2) - 0.25
                    end
                end
            end

            if X == 1 then
                --warn("XUPLEVEL")
                XAddition = calculateAdditionnalSize(pSize, removal)
                --print((pSize / 2) - removal)
            elseif X == -1 then
                --warn("XDOWNLEVEL")
                XAddition = -(calculateAdditionnalSize(pSize, removal))
                --print((pSize / 2) - removal)
            else
                --warn("XNOT NORMAL")
                XAddition = 0
            end

            if Z == 1 then
                --warn("ZUPLEVEL")
                ZAddition = calculateAdditionnalSize(pSize, removal)
                --print((pSize / 2) - removal)
            elseif Z == -1 then
                --warn("ZDOWNLEVEL")
                ZAddition = -(calculateAdditionnalSize(pSize, removal))
                --print((pSize / 2) - removal)
            else
                --warn("ZNOT NORMAL")
                ZAddition = 0
            end
        else
            --warn("--SUBSTRACTION TYPE --")
            if X == 1 then
                --warn("XUPLEVEL")
                XAddition = math.random(0, removal*100)
                XAddition = -(XAddition/100)
                --print((pSize / 2) - removal)
            elseif X == -1 then
                --warn("XDOWNLEVEL")
                XAddition = math.random(0, removal*100)
                XAddition = XAddition/100
                --print((pSize / 2) - removal)
            else
                --warn("XNOT NORMAL")
                XAddition = 0
            end

            if Z == 1 then
                --warn("ZUPLEVEL")
                ZAddition = math.random(0, removal*100)
                ZAddition = -(ZAddition/100)
                --print((pSize / 2) - removal)
            elseif Z == -1 then
                --warn("ZDOWNLEVEL")
                ZAddition = math.random(0, removal*100)
                ZAddition = ZAddition/100
                --print((pSize / 2) - removal)
            else
                --warn("ZNOT NORMAL")
                ZAddition = 0
            end
        end

        --warn("Process ended with final parameters : "..XAddition.." / "..ZAddition.." / "..oringinPointPos.X.."."..oringinPointPos.Y.."."..oringinPointPos.Z)

        return oringinPointPos + Vector3.new(XAddition, 0, ZAddition)
    end
end

function getPossibilityList(currentList)
    local newList = {}
    for i=1, 8 do
        if table.find(currentList, i) then
        else
            table.insert(newList, i)
        end
    end

    return newList
end

function checkOverlap()

end

function generateInk(Ink, PartTouched)
    Ink.Anchored = true
    Ink.Locked = true
    Ink.Transparency = 1
    Ink.CanCollide = false
    --print(PartTouched.Name)
    inkPos = getOrientation(Ink, PartTouched)
    instanceLib.InkSplash.Position = inkPos
    instanceLib.InkSplash.Size = Vector3.new(0.05,1,1)
    instanceLib.InkSplash.Color = inkColor
    instanceLib.InkSplash.Orientation = inkOrient
    local MainInkPart = InstanceUtil.Instanciate("Part", game.Workspace, instanceLib.InkSplash)
    local t = game.TweenService:Create(MainInkPart, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Size = mpSize})
    t:Play()

    local usedPoints = {}

    for i=1, 3 do
        local used = false
        local rndPoint, rndPoint2, partSize
        local possiblePoints = getPossibilityList(usedPoints)

        repeat
            rndPoint = math.random(1, #possiblePoints)
            rndPoint = possiblePoints[rndPoint]
            local rngB = 2 --math.random(1,2)
            if rngB == 1 then
                if table.find(possiblePoints, rndPoint + 1) or table.find(possiblePoints, rndPoint - 1) then
                    if table.find(possiblePoints, rndPoint + 1) and not rndPoint2 then rndPoint2 = rndPoint + 1 end
                    if table.find(possiblePoints, rndPoint - 1) and not rndPoint2 then rndPoint2 = rndPoint - 1 end
                elseif rndPoint == 8 and not table.find(possiblePoints, 1) and not rndPoint2 then
                    rndPoint2 = 1
                elseif rndPoint == 1 and not table.find(possiblePoints, 8) and not rndPoint2 then
                    rndPoint2 = 8
                end
            end
        until used == false
        if rndPoint2 then 
            --warn(rndPoint2.." is rnd2")
            table.insert(usedPoints, rndPoint2)
        end
        --warn(rndPoint.." IS POINT 1")
        table.insert(usedPoints, rndPoint)

        partSize = math.random(1, mpSize.Y - 1)
        inkPos = calculatePos(MainInkPart, rndPoint, rndPoint2, partSize, mpSize)
        print(inkPos.X, inkPos.Y, inkPos.Z.." : INKPOS")
        instanceLib.InkSplash.Position = inkPos
        instanceLib.InkSplash.Size = Vector3.new(0.05,0.5,0.5)

        local NewInkSplash = InstanceUtil.Instanciate("Part", game.Workspace, instanceLib.InkSplash)

        local t2 = game.TweenService:Create(NewInkSplash, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {Size = Vector3.new(0.05,partSize,partSize)})
        t2:Play()
    end
end

function debugEngine()
end

function ENGINE.Start(debug)
    warn("Initialising ENGINE...")
    local cT = os.time()
    if debug then local debugV = debugEngine() end

    Workspace.ChildAdded:Connect(function(child)
        print("Child ADDED !")
        print(child.Name)
        if child:IsA("Part") then
            child.Touched:Connect(function(hit)
                if child.Name == "InkBlob" and child.Locked == false then
                    if debug then warn("InkBlob Activated !") end
                    if hit:FindFirstChild("Inkable") then
                        warn("InkableTouched")
                        generateInk(child, hit)
                    elseif hit.Parent:FindFirstChild("HumanoidRootPart") then
                        local humanoid = hit.Parent:FindFirstChild("Humanoid")
                        humanoid.Health = humanoid.Health - 25
                    end
                end
            end)
        end
    end)

    warn("ENGINE STARTED IN "..os.time() - cT.." SECONDS")

    local newInkBlob = InstanceUtil.Instanciate("Part", game.Workspace, instanceLib.InkBlob)

    for i=1, 30 do
        instanceLib.InkBlob.Position = Vector3.new(math.random(-100,100), 10, math.random(-100,100))
        instanceLib.InkBlob.Size = Vector3.new(0.05, math.random(5,10), math.random(5,10))
        local newInkBlob = InstanceUtil.Instanciate("Part", game.Workspace, instanceLib.InkBlob)
    end
end

--= Module Sender =--

return ENGINE