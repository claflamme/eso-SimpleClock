sc.ui = {
	wm = GetWindowManager(),
	styles = {
		'normal',
		'outline',
		'thick-outline',
		'shadow',
		'soft-shadow-thick',
		'soft-shadow-thin'
	}
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

	sc.ui:updateLabel()

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
	sc.ui:updateLabel()
end

function sc.ui:toggleLowercaseMeridiem()
	sc.sv.lowercaseMeridiem = not sc.sv.lowercaseMeridiem
	sc.ui:updateLabel()
end

function sc.ui:toggleHideMeridiem()
	sc.sv.hideMeridiem = not sc.sv.hideMeridiem
	sc.ui:updateLabel()
end

function sc.ui:toggleNoDotsMeridiem()
	sc.sv.noDotsMeridiem = not sc.sv.noDotsMeridiem
	sc.ui:updateLabel()
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

function sc.ui:getFontString()

	local fontPath = LMP:Fetch('font', sc.sv.font.family)
	local fontString = string.format('%s|%u|%s', fontPath, sc.sv.font.size, sc.sv.font.style)

	return fontString

end

---
-- Applies any custom settings to the clock's label control.
function sc.ui:updateLabel()

	local color = sc.sv.font.color

	-- Need to make sure any formatting changes have been done to the text.
	sc:updateLocalTime(true)

	-- Update the label's font and colour, and then...
	SimpleClockLabel:SetFont(sc.ui:getFontString())
	SimpleClockLabel:SetColor(color.r, color.g, color.b, color.a)

	-- Need to reset dimensions to 0 (unlimited) otherwise the text could get
	-- truncated if the previous font size's bounding box was smaller. Then,
	-- when we want to use the TextDimensions, the width would be smaller since
	-- it was broken up in to separate lines! Computers, pfeh.
	self.clock:SetDimensions(0, 0)

	-- NOW set the TopLevelControl to the new dimensions.
	self.clock:SetDimensions(SimpleClockLabel:GetTextDimensions())

	-- Force an update so we don't have to wait for the event buffer
	sc:updateLocalTime(true)

end

function sc.ui:setFontFamily(val)
	sc.sv.font.family = val
	sc.ui:updateLabel()
end

function sc.ui:setFontSize(val)
	sc.sv.font.size = val
	sc.ui:updateLabel()
end

function sc.ui:setFontStyle(val)
	sc.sv.font.style = val
	sc.ui:updateLabel()
end

function sc.ui:setFontColor(r, g, b, a)

	local color = {r = r, g = g, b = b, a = a }

	sc.sv.font.color = color;
	sc.ui:updateLabel()

end