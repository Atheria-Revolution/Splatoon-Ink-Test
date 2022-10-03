--= Data Store Module by Danael_21 X StarShadow64 =--

--= Main Module =--

local Module = {}

local DSService = game:GetService("DataStoreService")

function Module.GetData(DataStore, DataName)
    local DataStore = DSService:GetDataStore(DataStore)

    local data = DataStore:GetAsync(DataName)
    if data then
        return data
    else
        return nil
    end
end

function Module.SetData(DataStore, DataName, Data)
    local DataStore = DSService:GetDataStore(DataStore)

    local success, err = pcall(function()
        DataStore:SetAsync(DataName, Data)
    end)

    if not success then warn("Data cannot be saved. Error -> "..err) end
end

return Module