--- Global to contain the whole addon
sc = {}

--- Saved Variables table
sc.sv = {}

--- Table for event buffer
sc.bufferTable = {}

--- Control panel menu
sc.menu = LibStub:GetLibrary('LibAddonMenu-1.0')

--- Main config settings
sc.config = {
	name = 'SimpleClock',
	svName = 'SimpleClock_SavedVariables',
	svDefaults = {
		offsetX = 0,
		offsetY = 0,
		scale = 1.0,
		use24Hour = false,
		lowercaseMeridiem = false,
		noDotsMeridiem = false,
		hideMeridiem = false,
		hideWithOverlay = false
	}
}

--- Basic event buffering, cribbed from http://wiki.esoui.com/Event_%26_Update_Buffering
function sc:bufferReached(key, buffer)

	if sc.bufferTable[key] == nil then
		sc.bufferTable[key] = {}
	end

	sc.bufferTable[key].buffer = buffer or 1
	sc.bufferTable[key].now = GetFrameTimeSeconds()

	if sc.bufferTable[key].last == nil then
		sc.bufferTable[key].last = sc.bufferTable[key].now
	end

	sc.bufferTable[key].diff = sc.bufferTable[key].now - sc.bufferTable[key].last
	sc.bufferTable[key].eval = sc.bufferTable[key].diff >= sc.bufferTable[key].buffer

	if sc.bufferTable[key].eval then
		sc.bufferTable[key].last = sc.bufferTable[key].now
	end

	return sc.bufferTable[key].eval

end

--- Updates the local time clock.
function sc:updateLocalTime(ignoreBuffer)

	if (sc.sv.hideWithOverlay == true) and ZO_Compass:IsHidden() then
		SimpleClockLocal:SetAlpha(0)
	else
		SimpleClockLocal:SetAlpha(1)
	end

	-- Add a one second buffer for updates, otherwise we'd be running this
	-- literally every frame refresh.
	if ignoreBuffer ~= true and not self:bufferReached('clockUpdateBuffer', 1) then
		return
	end

	SimpleClockLocalLabel:SetText(self:getTimeString())

end

--- Updates the saved variables for the clock's position.
function sc:savePositions()

	local x, y = SimpleClockLocal:GetCenter()

	sc.sv.offsetX = x
	sc.sv.offsetY = y

end

--- Gets a formatted string representing the current time.
-- @return string The formatted time
function sc:getTimeString()

	local seconds   = GetSecondsSinceMidnight()
	local style     = TIME_FORMAT_STYLE_CLOCK_TIME
	local precision = TIME_FORMAT_PRECISION_TWELVE_HOUR
	local direction = TIME_FORMAT_DIRECTION_NONE

	local formatted

	if (sc.sv.use24Hour) then
		precision = TIME_FORMAT_PRECISION_TWENTY_FOUR_HOUR
	end

	formatted = FormatTimeSeconds(seconds, style, precision, direction)

	if (sc.sv.hideMeridiem) then
		return formatted:gsub('%a%.', '')
	end

	if (sc.sv.lowercaseMeridiem) then
		formatted = formatted:lower();
	end

	if (sc.sv.noDotsMeridiem) then
		formatted = formatted:gsub('%.', '')
	end

	return formatted

end

--- Loads settings from saved variables.
function sc:loadSavedVariables()
	sc.sv = ZO_SavedVars:NewAccountWide(sc.config.svName, 1, 'SimpleClock', sc.config.svDefaults)
end

--- Handler for AddonLoaded event
function OnAddonLoaded(eventCode, name)

	if (name == sc.config.name) then
		EVENT_MANAGER:UnregisterForEvent(sc.config.name, eventCode)
		sc:loadSavedVariables()
		sc.ui:create()
	end

end

-- Set up some events
EVENT_MANAGER:RegisterForEvent(sc.config.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)