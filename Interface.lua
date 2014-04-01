sc.ui = {
	wm = GetWindowManager(),
}

function sc.ui:create()

	self.localClock = CreateControlFromVirtual('SimpleClockLocal', GuiRoot, 'SimpleClockLocal')

	local x = sc.sv.offsetX
	local y = sc.sv.offsetY
	local scale = sc.sv.scale

	self.localClock:SetAnchor(CENTER, GuiRoot, TOPLEFT, x, y)
	self.localClock:SetScale(scale)

	-- Allow the clock to go outside the screen's boundaries
	self.localClock:SetClampedToScreen(false)

	-- Load the text alignment setting
	sc.ui:setTextAlign(sc.sv.textAlign)

	-- Immediately update the time display
	sc:updateLocalTime(true)

end

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

function sc.ui:toggleHideWithOverlay()
	sc.sv.hideWithOverlay = not sc.sv.hideWithOverlay
	sc:updateLocalTime(true)
end

function sc.ui:setTextAlign(val)
	local alignMap = {
		Left   = TEXT_ALIGN_LEFT,
		Right  = TEXT_ALIGN_RIGHT,
		Center = TEXT_ALIGN_CENTER
	}
	SimpleClockLocalLabel:SetHorizontalAlignment(alignMap[val])
	sc.sv.textAlign = val
end