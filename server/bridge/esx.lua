local Core = Config.Core or nil

CreateThread(function()
	Wait(10)
	if Core == 'esx' then

		local ESX = exports['es_extended']:getSharedObject()


		function IsPlayerInJob(source, jobNames)
				local xPlayer = ESX.GetPlayerFromId(source)
				if xPlayer then
					local playerJob = xPlayer.job.name
					for _, jobName in ipairs(jobNames) do
						if playerJob == jobName then
							return true
						end
					end
				end
				return false
			end

			function GetPlayerJobName(source)
				local xPlayer = ESX.GetPlayerFromId(source)
				if xPlayer then
					return xPlayer.job.name
				else
					return nil
				end
			end

			RegisterCommand(Config.Command, function(pSrc, args, rawCommand)
				local jobNames = Config.Jobs
				local src = tonumber(pSrc)
				
				if IsPlayerInJob(src, jobNames) then
					TriggerClientEvent('SendAlert', src, args[1], args[2]) 
				else
					if Config.CustomNotify then
						TriggerClientEvent('esx:showNotification', src, Language.Nojob)
					else
						TriggerClientEvent('chat:addMessage', src, { args = { '^1Error', Language.Error } })
					end
				end
			end, false)

			RegisterServerEvent('SendAlert:Server')
			AddEventHandler('SendAlert:Server', function(title, text)
				local src = tonumber(source)
				local sourceJob = GetPlayerJobName(src)
				if title then
					title = string.upper(sourceJob).." | "..title
				end

				print(title, text)

				if sourceJob and src then
					local players = ESX.GetPlayers()
					local senderSent = false

					for _, playerId in ipairs(players) do
						local xPlayer = ESX.GetPlayerFromId(playerId)
						if xPlayer then
							
							if xPlayer.job.name == sourceJob and xPlayer.job.onduty then
								TriggerClientEvent('SendAd', playerId, title, text, string.upper(xPlayer.job.name))
							
								if playerId == src then
									senderSent = true
								end
							end
						end
					end

					
					for _, playerId in ipairs(players) do
						local xPlayer = ESX.GetPlayerFromId(playerId)
						if xPlayer then
							if not xPlayer.job or xPlayer.job.name == nil or xPlayer.job.name == '' then
								TriggerClientEvent('SendAd', playerId, title, text, string.upper(xPlayer.job.name))
								if playerId == src then
									senderSent = true
								end
							end
						end
					end

				
					if not senderSent then
						TriggerClientEvent('SendAd', src, title, text)
					end
				end
			end)
	end
end)
