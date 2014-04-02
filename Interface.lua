sc.ui = {
	wm = GetWindowManager(),
}

function sc.ui:create()

	self.clock = CreateControlFromVirtual('SimpleClock', GuiRoot, 'SimpleClock')

	local x = sc.sv.offsetX
	local y = sc.sv.offsetY
	local scale = sc.sv.scale

	self.clock:SetAnchor(CENTER, GuiRoot, TOPLEFT, x, y)
	self.clock:SetScale(scale)

	-- Allow the clock to go outside the screen's boundaries
	self.clock:SetClampedToScreen(false)

	-- Load the text alignment setting
	sc.ui:setTextAlign(sc.sv.textAlign)

	-- Immediately update the time display
	sc:updateLocalTime(true)

end

function sc.ui:show()
	SimpleClock:SetAlpha(1)
end

function sc.ui:hide()
	SimpleClock:SetAlpha(0)
end

-- -----------------------------------------------------------------------------
-- Toggles for control panel options
-- =============================================================================
function sc.ui:toggleUse24Hour()
	sc.sv.use24Hour = not sc.sv.use24Hour
	sc:updateLocalTime(true)
end

function sc.ui:toggleLowercaseMeridiem()
	sc.sv.lowercaseMeridiem = not sc.sv.lowercaseMeridiem
	sc:updateLocalTime(true)
end

function sc.ui:toggleHideMeridiem()
	sc.sv.hideMeridiem = not sc.sv.hideMeridiem
	sc:updateLocalTime(true)
end

function sc.ui:toggleNoDotsMeridiem()
	sc.sv.noDotsMeridiem = not sc.sv.noDotsMeridiem
	sc:updateLocalTime(true)
end

---
-- Toggles whether or not to hide the clock when in viewing screens like
-- inventory, conversation, settings, main menu, etc.
function sc.ui:toggleHideWithOverlay()

	sc.sv.hideWithOverlay = not sc.sv.hideWithOverlay

	if (sc.sv.hideWithOverlay == true) then
		sc.ui:hide()
	else
		sc.ui:show()
	end

end

function sc.ui:setTextAlign(val)

	local alignMap = {
		Left   = TEXT_ALIGN_LEFT,
		Right  = TEXT_ALIGN_RIGHT,
		Center = TEXT_ALIGN_CENTER
	}

	SimpleClockLabel:SetHorizontalAlignment(alignMap[val])

	sc.sv.textAlign = val

end

function sc.ui:setFont()

	local fontPath = LMP:Fetch('font', sc.sv.font.family)
	local fontString = string.format('%s|%u|%s', fontPath, sc.sv.font.size, sc.sv.font.style)

	SimpleClockLabel:SetFont(fontString)

end

function sc.ui:setFontFamily(val)

	sc.sv.font.family = val

	sc.ui.setFont()

end