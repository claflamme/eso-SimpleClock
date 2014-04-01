sc.ui = {
	wm = GetWindowManager(),
}

function sc.ui:create()

	self.localClock = CreateControlFromVirtual('SimpleClockLocal', GuiRoot, 'SimpleClockLocal')

	local x = sc.sv.LocalTime.offsetX
	local y = sc.sv.LocalTime.offsetY
	local scale = sc.sv.LocalTime.scale

	self.localClock:SetAnchor(CENTER, GuiRoot, TOPLEFT, x, y)
	self.localClock:SetScale(scale)

	-- Allow the clock to go outside the screen's boundaries
	self.localClock:SetClampedToScreen(false)

	-- Immediately update the time display
	sc:updateLocalTime(true)

end