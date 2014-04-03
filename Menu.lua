function buildControlPanel()

	sc.menuId = sc.menu:CreateControlPanel('scConfig', 'SimpleClock')

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
		function() return sc.sv.hideWithOverlay end,
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
		function() return sc.sv.use24Hour end,
		sc.ui.toggleUse24Hour
	)

	-- Show/Hide meridiem
	sc.menu:AddCheckbox(
		sc.menuId,
		'scConfigChkbox_VisibleMeridiem',
		'Hide Meridiem Indicator',
		'Disable the A.M./P.M. text.',
		function() return sc.sv.hideMeridiem end,
		sc.ui.toggleHideMeridiem
	)

	-- Use lowercase AM/PM
	sc.menu:AddCheckbox(
		sc.menuId,
		'scConfigChkbox_LowercaseMeridiem',
		'Lowercase Meridiem Indicator',
		'Have the A.M./P.M. text display in lowercase.',
		function() return sc.sv.lowercaseMeridiem end,
		sc.ui.toggleLowercaseMeridiem
	)

	-- Hide dots in AM/PM
	sc.menu:AddCheckbox(
		sc.menuId,
		'scConfigChkbox_NoDotsMeridiem',
		'Hide Dots in Meridiem Indicator',
		'Hide the dots in A.M./P.M.',
		function() return sc.sv.noDotsMeridiem end,
		sc.ui.toggleNoDotsMeridiem
	)

	-- -----------------------------------------------------------------------------
	-- Positioning
	-- -----------------------------------------------------------------------------
	sc.menu:AddHeader(sc.menuId, 'scHeaderPositioning', 'Positioning')

	-- Text alignment
	sc.menu:AddDropdown(
		sc.menuId,
		'scConfigDrpdwn_TextAlign',
		'Text Alignment',
		'Which way the numbers on the clock should expand from.',
		{'Left', 'Right', 'Center'},
		function() return sc.sv.textAlign end,
		function(val) sc.ui:setTextAlign(val) end
	)

	-- -----------------------------------------------------------------------------
	-- Font
	-- -----------------------------------------------------------------------------
	sc.menu:AddHeader(sc.menuId, 'scHeaderFont', 'Font')

	-- Font family
	sc.menu:AddDropdown(
		sc.menuId,
		'scConfigDrpdwn_FontFamily',
		'Family',
		'The font family used to display the clock.',
		LMP:List('font'),
		function() return sc.sv.font.family end,
		function(val) sc.ui:setFontFamily(val) end
	)

	-- Font size
	sc.menu:AddSlider(
		sc.menuId,
		'scConfigDrpdwn_FontSize',
		'Size',
		'The size of the font use for the clock.',
		12,
		48,
		1,
		function() return sc.sv.font.size end,
		function(val) sc.ui:setFontSize(val) end
	)

	-- Font style
	sc.menu:AddDropdown(
		sc.menuId,
		'scConfigDrpdwn_FontStyle',
		'Style',
		'Additional borders and shadows for the text.',
		sc.ui.styles,
		function() return sc.sv.font.style end,
		function(val) sc.ui:setFontStyle(val) end
	)

	-- Font color
	sc.menu:AddColorPicker(
		sc.menuId,
		'scConfigDrpdwn_FontColor',
		'Color',
		'Set the colour of the text.',
		function() return sc.sv.font.color.r, sc.sv.font.color.g, sc.sv.font.color.b, sc.sv.font.color.a end,
		function(r, g, b, a) sc.ui:setFontColor(r, g, b, a) end
	)
		 --panelID = integer; the reference returned by LAM:CreateControlPanel() above
		 --controlName = string; a unique name for this object
		 --text = string; the text to display for this option
		 --tooltip = string; the tooltip text
		 --getFunc = function; a function to return the current values (r, g, b[, a]) this option is set to
		 --setFunc = function; a function to save the new value this option is set to - passes through 4 arguments, the new values (integer)
		 --warning = boolean; display a warning icon for this option
		 --warningText = string; the tooltip text to display for the warning icon

end