-- =============================================================================
-- Addon Initialization
-- -----------------------------------------------------------------------------
-- Bootstrapping happens in Events.lua, in the EVENT_ADD_ON_LOADED function.
-- =============================================================================

---
-- Main namespace for the addon.
--
-- @field  events    Contains event handler functions named after the events
--                   they respond to.
-- @field  sv        Saved variables get stored here once they're loaded.
-- @field  buffer    Event buffer table.
-- @field  config    Reusable config data for scripts.
-- @field  defaults  Default SavedVariables settings.
-- -----------------------------------------------------------------------------
sc = { events = {},	sv = {}, buffer = {}, config = {}, defaults = {} }

---
-- Main config settings.
--
-- @field  name    Name of the addon, mostly for generating controls.
-- @field  svName  Name to use for saving/loading SavedVariables.
-- -----------------------------------------------------------------------------
sc.config = {
	name   = 'SimpleClock',
	svName = 'SimpleClock_SavedVariables'
}

--- Control panel menu
LAM = LibStub:GetLibrary('LibAddonMenu-1.0')
LMP = LibStub:GetLibrary("LibMediaProvider-1.0")



--- Basic event buffering, cribbed from http://wiki.esoui.com/Event_%26_Update_Buffering
function sc:bufferReached(key, buffer)

	if sc.buffer[key] == nil then
		sc.buffer[key] = {}
	end

	sc.buffer[key].buffer = buffer or 1
	sc.buffer[key].now = GetFrameTimeSeconds()

	if sc.buffer[key].last == nil then
		sc.buffer[key].last = sc.buffer[key].now
	end

	sc.buffer[key].diff = sc.buffer[key].now - sc.buffer[key].last
	sc.buffer[key].eval = sc.buffer[key].diff >= sc.buffer[key].buffer

	if sc.buffer[key].eval then
		sc.buffer[key].last = sc.buffer[key].now
	end

	return sc.buffer[key].eval

end

--- Updates the saved variables for the clock's position.
function sc:savePositions()

	local x, y = SimpleClock:GetCenter()

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
	sc.sv = ZO_SavedVars:NewAccountWide(sc.config.svName, 1, 'SimpleClock', sc.defaults)
end