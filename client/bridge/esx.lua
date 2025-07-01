local Core = Config.Core

CreateThread(function()
	Wait(10)
	if Core == 'esx' then
		local ESX = exports.es_extended:getSharedObject()

		local ui = false
		local display = false

		-- funcs

		function UI()

			if not ui then 
				SetDisplay(true)       
			else 
				SetDisplay(not ui)
			end

		end

		function SendNotification(type, text, duration)

			lib.notify({
			   
				title = '[ADS]',
				description = text,
				showDuration = false,
				duration = duration,
				position = 'top-right',
				style = {
					backgroundColor = '#141517',
					color = '#C1C2C5',
					['.description'] = {
					color = '#909296'
					}
				},
				type = type,
				icon = 'info',
				iconColor = '#C53030'
			})



		end

		RegisterCommand('alert', function()

			UI()
		end)

		function SetDisplay(bool)

			display = bool
			SendNUIMessage({
				type = 'open',
				status = bool
				
			}) 
		end

		-- events

		RegisterNUICallback("exit", function(data)

			SendNUIMessage({
				type = 'close',
				status = bool,
				
			})
			SetDisplay(false)
		end)




		-- MAGIC HAPPENS HERE

		RegisterNetEvent('SendAlert', function()

			local input = lib.inputDialog(Language.UI, {
				{type = 'input', label = Language.Title, description = Language.EnterTitle, required = true},
				{type = 'textarea', label = Language.Description, description = Language.EnterDescription, icon = 'hashtag', required = true, autosize = true},

			
			})

			

			if input then
				local title = input[1]

				local text = input[2]
				TriggerServerEvent('SendAlert:Server', title, text)
			else 
				return 
			end 
			
		end)



		-- For server side trigger
		RegisterNetEvent('SendAd', function(title, text, job)
		   
			job = job or "UNKNOWN"

			print(json.encode({ job = job }))

			SendNUIMessage({
				type = 'sendAlert',
				title = job,
				text = text or "",
				id = math.random(100000, 999999) 
			})

			UI()
		end)




	end
end)