sc.menuId = sc.menu:CreateControlPanel('scConfig', 'SimpleClock')

-- -----------------------------------------------------------------------------
-- 24 hour time format
-- -----------------------------------------------------------------------------
function getUse24Hour()
	return sc.sv.use24Hour
end

-- -----------------------------------------------------------------------------
-- Lowercase meridiem indicator
-- -----------------------------------------------------------------------------
function getLowercaseMeridiem()
	return sc.sv.lowercaseMeridiem
end

-- -----------------------------------------------------------------------------
-- Visible meridiem indicator
-- -----------------------------------------------------------------------------
function getHideMeridiem()
	return sc.sv.hideMeridiem
end

-- -----------------------------------------------------------------------------
-- Meridiem dots
-- -----------------------------------------------------------------------------
function getNoDotsMeridiem()
	return sc.sv.noDotsMeridiem
end

-- -----------------------------------------------------------------------------
-- Hide with overlay
-- -----------------------------------------------------------------------------
function getHideWithOverlay()
	return sc.sv.hideWithOverlay
end

function getTextAlign()
	return sc.sv.textAlign
end

-- -----------------------------------------------------------------------------
-- Visibility
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, 'scHeaderVisibility', 'Visibility')

-- Hide with overlay
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_HideWithOverlay',
	'Hide when viewing menus',
	'Hides the clock when viewing inventory or similar screens.',
	getHideWithOverlay,
	sc.ui.toggleHideWithOverlay
)

-- -----------------------------------------------------------------------------
-- Time Format
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, 'scHeaderTimeFormat', 'Time Format')

-- Time Format dropdown (24hr vs. 12hr)
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_24HourTime',
	'24 Hour (Military) Time',
	'Choose whether to use 24hr time (00:30) or 12hr time (12:30AM).',
	getUse24Hour,
	sc.ui.toggleUse24Hour
)

-- Show/Hide meridiem
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_VisibleMeridiem',
	'Hide Meridiem Indicator',
	'Disable the A.M./P.M. text.',
	getHideMeridiem,
	sc.ui.toggleHideMeridiem
)

-- Use lowercase AM/PM
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_LowercaseMeridiem',
	'Lowercase Meridiem Indicator',
	'Have the A.M./P.M. text display in lowercase.',
	getLowercaseMeridiem,
	sc.ui.toggleLowercaseMeridiem
)

-- Hide dots in AM/PM
sc.menu:AddCheckbox(
	sc.menuId,
	'scConfigChkbox_NoDotsMeridiem',
	'Hide Dots in Meridiem Indicator',
	'Hide the dots in A.M./P.M.',
	getNoDotsMeridiem,
	sc.ui.toggleNoDotsMeridiem
)

-- -----------------------------------------------------------------------------
-- Positioning
-- -----------------------------------------------------------------------------
sc.menu:AddHeader(sc.menuId, 'scHeaderPositioning', 'Positioning')

sc.menu:AddDropdown(
	sc.menuId,
	'scConfigDrpdwn_TextAlign',
	'Text Alignment',
	'Which way the numbers on the clock should expand from.',
	{'Left', 'Right', 'Center'},
	getTextAlign,
	function(val) sc.ui:setTextAlign(val) end

)
