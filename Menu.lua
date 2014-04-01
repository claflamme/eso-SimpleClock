sc.menuId = sc.menu:CreateControlPanel("scConfig", "SimpleClock")

-- -----------------------------------------------------------------------------
-- 24 hour time format
-- -----------------------------------------------------------------------------
function toggleUse24Hour(val)
	sc.sv.LocalTime.use24Hour = not sc.sv.LocalTime.use24Hour
	sc:updateLocalTime(true)
end

function getUse24Hour()
	return sc.sv.LocalTime.use24Hour
end

-- -----------------------------------------------------------------------------
-- Lowercase meridiem indicator
-- -----------------------------------------------------------------------------
function toggleLowercaseMeridiem(val)
	sc.sv.LocalTime.lowercaseMeridiem = not sc.sv.LocalTime.lowercaseMeridiem
	sc:updateLocalTime(true)
end

function getLowercaseMeridiem()
	return sc.sv.LocalTime.lowercaseMeridiem
end

-- -----------------------------------------------------------------------------
-- Visible meridiem indicator
-- -----------------------------------------------------------------------------
function toggleHideMeridiem(val)
	sc.sv.LocalTime.hideMeridiem = not sc.sv.LocalTime.hideMeridiem
	sc:updateLocalTime(true)
end

function getHideMeridiem()
	return sc.sv.LocalTime.hideMeridiem
end

-- -----------------------------------------------------------------------------
-- Meridiem dots
-- -----------------------------------------------------------------------------
function toggleNoDotsMeridiem(val)
	sc.sv.LocalTime.noDotsMeridiem = not sc.sv.LocalTime.noDotsMeridiem
	sc:updateLocalTime(true)
end

function getNoDotsMeridiem()
	return sc.sv.LocalTime.noDotsMeridiem
end

-- -----------------------------------------------------------------------------
-- Hide with overlay
-- -----------------------------------------------------------------------------
function toggleHideWithOverlay(val)
	sc.sv.LocalTime.hideWithOverlay = not sc.sv.LocalTime.hideWithOverlay
	sc:updateLocalTime(true)
end

function getHideWithOverlay()
	return sc.sv.LocalTime.hideWithOverlay
end

-- -----------------------------------------------------------------------------
-- Visibility
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, "scHeaderVisibility", "Visibility")

-- Hide with overlay
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_HideWithOverlay',
	'Hide when viewing menus',
	'Hides the clock when viewing inventory or similar screens.',
	getHideWithOverlay,
	toggleHideWithOverlay
)

-- -----------------------------------------------------------------------------
-- 24 hour display
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, "scHeader24Hour", "24 Hour Display")

-- Time Format dropdown (24hr vs. 12hr)
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_24HourTime',
	'24 Hour (Military) Time',
	'Choose whether to use 24hr time (00:30) or 12hr time (12:30AM).',
	getUse24Hour,
	toggleUse24Hour
)

-- -----------------------------------------------------------------------------
-- Meridiem indicators
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, "scHeaderMeridiem", "Meridiem Indicators")

-- Show/Hide meridiem
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_VisibleMeridiem',
	'Hidden',
	'Hide AM/PM text.',
	getHideMeridiem,
	toggleHideMeridiem
)

-- Use lowercase AM/PM
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_LowercaseMeridiem',
	'Lowercase',
	'Have the AM/PM text display in lowercase.',
	getLowercaseMeridiem,
	toggleLowercaseMeridiem
)

-- Hide dots in AM/PM
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_NoDotsMeridiem',
	'No Dots',
	'Hide the dots in A.M./P.M.',
	getNoDotsMeridiem,
	toggleNoDotsMeridiem
)