local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

local isUIVisible = true

Config = Config or {}

local jobName = "Loading..."
local jobRank = "Loading..."

local nuiLoaded = false

local function updateJobAndRank(jobName, jobRank)
    if nuiLoaded then
        SendNUIMessage({
            type = "updateJobInfo",
            jobName = jobName,
            jobRank = jobRank
        })
    end
end

local function fetchPlayerJobData()
    if PlayerData and PlayerData.job then
        jobName = PlayerData.job.label
        jobRank = PlayerData.job.grade.name
        updateJobAndRank(jobName, jobRank)
    else
        SetTimeout(1000, fetchPlayerJobData)
    end
end

local function updateMoneyDisplay(money, items)
    if not nuiLoaded then return end

    local blackMoneyCount = 0

    if items then
        for _, item in pairs(items) do
            if item.name == 'black_money' then
                blackMoneyCount = item.amount
                break
            end
        end
    end

    SendNUIMessage({
        type = "updateMoneyDisplay",
        cash = math.floor(money.cash),
        bank = math.floor(money.bank),
        black_money = blackMoneyCount
    })
end

local function updatePlayerID()
    if not nuiLoaded then return end

    local playerServerID = GetPlayerServerId(PlayerId())
    if playerServerID then
        SendNUIMessage({
            type = "updatePlayerID",
            playerID = playerServerID
        })
    else
        SetTimeout(1000, updatePlayerID)
    end
end

local function sendConfigToNUI()
    if not nuiLoaded then return end

    SendNUIMessage({
        type = "setConfig",
        config = {
            showCash = Config.ShowCash,
            showBank = Config.ShowBank,
            showBlackMoney = Config.ShowBlackMoney,
            showJob = Config.ShowJob,
            showRank = Config.ShowRank,
            showPlayerID = Config.ShowPlayerID
        }
    })
end

RegisterNUICallback('loaded', function(data, cb)
    nuiLoaded = true
    initializeUI()
    cb('ok')
end)

function initializeUI()
    if not nuiLoaded then
        SetTimeout(100, initializeUI)
        return
    end

    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData and next(PlayerData) then
        updateMoneyDisplay(PlayerData.money, PlayerData.items)
        fetchPlayerJobData()
        updatePlayerID()
        sendConfigToNUI()
        SendNUIMessage({
            type = "ui",
            display = true
        })
    else
        SetTimeout(1000, initializeUI)
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    initializeUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetTimeout(500, function()
            if nuiLoaded then
                initializeUI()
            else
                SetTimeout(500, initializeUI)
            end
        end)
    end
end)

RegisterCommand('moneyon', function()
    isUIVisible = true
    if nuiLoaded then
        SendNUIMessage({
            type = "ui",
            display = isUIVisible
        })
    end
end, false)

RegisterCommand('moneyoff', function()
    isUIVisible = false
    if nuiLoaded then
        SendNUIMessage({
            type = "ui",
            display = isUIVisible
        })
    end
end, false)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    updateMoneyDisplay(val.money, val.items)
end)

RegisterNetEvent('money:update')
AddEventHandler('money:update', function(money)
    PlayerData.money = money
    updateMoneyDisplay(money, PlayerData.items)
end)

RegisterNetEvent('QBCore:Player:MoneyChange')
AddEventHandler('QBCore:Player:MoneyChange', function(type, amount, isAddition)
    TriggerServerEvent('money:update')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    jobName = JobInfo.label
    jobRank = JobInfo.grade.name
    updateJobAndRank(jobName, jobRank)
end)
