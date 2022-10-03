--= Instance Util Module by Danael_21 X StarShadow64 =--

--= MainModule =--

local Module = {}

function Module.Instanciate(InstanceName, InstanceParent, Properties)
    local Object = Instance.new(InstanceName, InstanceParent)

    for props, value in pairs(Properties) do
        Object[props] = value
    end

    return Object
end

function Module.CloneP(PTC, NewProps)
    local NewObject = PTC:Clone()
    for _, values in pairs(NewProps) do
        NewObject[_] = values
    end

    return NewObject
end

function Module.ChangeProperties(part, NewProperties)
    for props, values in pairs(NewProperties) do
        part[props] = values
    end
end

function Module.Weld(MP, folder)
    for i, parts in pairs(folder:GetChildren()) do
        local NW = Module.Instanciate("WeldConstraint", parts, {["Part0"] = parts, ["Part1"] = MP})
        parts.Anchored = false
    end
end


return Module