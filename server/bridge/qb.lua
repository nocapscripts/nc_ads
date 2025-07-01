local CoreName = Config.Core or 'qb'

CreateThread(function()
    Wait(10)

    if CoreName == 'qb' then
        local QBCore = exports[Config.FW]:GetCoreObject()

      
        local function IsPlayerInJob(source, jobList)
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                local playerJob = Player.PlayerData.job.name
                for _, job in ipairs(jobList) do
                    if playerJob == job then
                        return true
                    end
                end
            end
            return false
        end

       
        local function GetPlayerJobName(source)
            local Player = QBCore.Functions.GetPlayer(source)
            return Player and Player.PlayerData.job.name or nil
        end

        QBCore.Commands.Add(Config.Command, Language.UI or 'Send an alert', {}, false, function(source)
            local allowedJobs = Config.Jobs
            if IsPlayerInJob(source, allowedJobs) then
                TriggerClientEvent('SendAlert', source)
            else
                if Config.CustomNotify then
                    TriggerClientEvent('DoLongHudText', source, Language.Nojob or 'You are not authorized', 'error')
                else
                    TriggerClientEvent('chat:addMessage', source, {
                        color = {255, 0, 0},
                        multiline = true,
                        args = {'System', Language.Error or 'You cannot use this command'}
                    })
                end
            end
        end, 'user')

       
        RegisterNetEvent('SendAlert:Server', function(title, text)
            local src = source
            local srcJob = GetPlayerJobName(src)

            if not srcJob then return end

            local sentToSrc = false
            local players = QBCore.Functions.GetPlayers()

            for _, playerId in pairs(players) do
                local Player = QBCore.Functions.GetPlayer(playerId)
                if Player then
                    local jobData = Player.PlayerData.job
                    if jobData.name == srcJob and jobData.onduty then
                        TriggerClientEvent('SendAd', playerId, title, text, string.upper(jobData.name))
                        if playerId == src then sentToSrc = true end
                    end
                end
            end

            for _, playerId in pairs(players) do
                local Player = QBCore.Functions.GetPlayer(playerId)
                if Player then
                    local jobName = Player.PlayerData.job and Player.PlayerData.job.name
                    if not jobName or jobName == '' then
                        TriggerClientEvent('SendAd', playerId, title, text, "UNEMPLOYED")
                        if playerId == src then sentToSrc = true end
                    end
                end
            end

          
            if not sentToSrc then
                TriggerClientEvent('SendAd', src, title, text, string.upper(srcJob))
            end
        end)
    end
end)
