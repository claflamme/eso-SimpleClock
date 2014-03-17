sc = {}
sc.menu = LibStub:GetLibrary("LibAddonMenu-1.0")

--- Main config settings
config = {
	name = "SimpleClock",
	svName = "SimpleClock_SavedVariables",
	svDefaults = {
		offsetX = 0,
		offsetY = 0,
		scale = 1.0
	}
}

--- Saved Variables table
sv = {}

--- Updates the local time clock.
function updateLocalTime()
	SimpleClockLocalLabel:SetText(getTimeString())
end

--- Updates the saved variables for the clock's position.
function savePositions()

	local x, y = SimpleClock:GetCenter()

	sv.LocalTime.offsetX = x
	sv.LocalTime.offsetY = y

end

--- Shows or hides the clock.
function toggleClock()
	SimpleClock:ToggleHidden()
end

--- Gets a formatted string representing the current time.
function getTimeString()

	local seconds   = GetSecondsSinceMidnight()
	local style     = TIME_FORMAT_STYLE_CLOCK_TIME
	local precision = TIME_FORMAT_PRECISION_TWELVE_HOUR
	local direction = TIME_FORMAT_DIRECTION_NONE

	return FormatTimeSeconds(seconds, style, precision, direction)

end

--- Loads settings from saved variables.
function loadSavedVariables()

	sv = {
		LocalTime = ZO_SavedVars:New(config.svName, 1, "LocalTime", config.svDefaults)
	}

	local x = sv.LocalTime.offsetX
	local y = sv.LocalTime.offsetY
	local scale = sv.LocalTime.scale

	SimpleClock:SetAnchor(CENTER, GuiRoot, TOPLEFT, x, y)
	SimpleClock:SetScale(scale)

	-- Allow the clock to go outside the screen's boundaries
	SimpleClock:SetClampedToScreen(false)

end

--- Handler for AddonLoaded event
function OnAddonLoaded(eventCode, name)

	if (name == config.name) then
		EVENT_MANAGER:UnregisterForEvent(config.name, eventCode)
		loadSavedVariables()
	end
end

-- Set up some events
EVENT_MANAGER:RegisterForEvent(config.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)
EVENT_MANAGER:RegisterForEvent(config.name, EVENT_GUI_HIDDEN, toggleClock)
EVENT_MANAGER:RegisterForEvent(config.name, EVENT_SHOW_GUI, toggleClock)