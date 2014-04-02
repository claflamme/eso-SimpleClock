---
-- Called whenever an addon is loaded, checks if it's our addon that loaded.
--
-- @param eventCode
-- @param addonName The name of that addon that just loaded.
sc.events.EVENT_ADD_ON_LOADED = function(eventCode, addonName)

	if (addonName == sc.config.name) then
		EVENT_MANAGER:UnregisterForEvent(sc.config.name, eventCode)
		sc:loadSavedVariables()
		sc.ui:create()
	end

end

---
-- Called whenever the target reticle is shown or hidden, used to determine if
-- we should show or hide the clock.
--
-- @param eventCode
-- @param hidden Boolean indicating if the reticle is hidden or not.
sc.events.EVENT_RETICLE_HIDDEN_UPDATE = function(eventCode, hidden)

	if SimpleClock ~= nil then

		if (sc.sv.hideWithOverlay == true) and hidden == true then
			sc.ui.hide()
		else
			sc.ui.show()
		end

	end

end

-- Bind all declared handlers to their respective events.
for eventName, handler in pairs(sc.events) do
	EVENT_MANAGER:RegisterForEvent(sc.config.name, _G[eventName], handler)
end
