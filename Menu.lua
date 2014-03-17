sc.menuId = sc.menu:CreateControlPanel("scConfig", "SimpleClock")
sc.menu:AddHeader(sc.menuId, "scHeaderSizeAndPosition", "Size & Position")

function getScale()
	return math.floor(SimpleClock:GetScale() * 100)
end

function setScale(val)

	local scale = val / 100

	SimpleClock:SetScale(scale)
	sv.LocalTime.scale = scale

end

--- Resets the clock's position to the center of the screen
function resetPosition()
	SimpleClock:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	savePositions()
end

--- Resets the Local Time clock to the default scale
function resetScaleLocal()

	SimpleClock:SetScale(config.svDefaults.scale)
	sv.LocalTime.scale = config.svDefaults.scale

end

-- Scale slider
sc.menu:AddSlider(sc.menuId, "scConfigSlider_Scale", "Scale", "The size of the clock, relative to the global UI scale.", 50, 200, 1, getScale, setScale, false, "")

-- Reset Scale button
sc.menu:AddButton(sc.menuId, "scConfigBtn_ResetScaleLocal", "Reset Scale", "Resets the scale of the Local Time clock to 100%.", resetScaleLocal, false, "")

-- Reset Position button
sc.menu:AddButton(sc.menuId, "scConfigBtn_ResetPos", "Reset Position", "Resets the position of the clock to the top left of the screen.", resetPosition, false, "")