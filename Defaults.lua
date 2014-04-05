-- =============================================================================
-- Default SavedVariables Settings
-- -----------------------------------------------------------------------------
-- Namespace 'sc' is defined in Main.lua.
-- =============================================================================

---
-- @field offset             X and Y offsets for positioning.
-- @field use24Hour          Whether or not to use 24 hour time
-- @field lowercaseMeridiem  Use lowercased AM/PM indicator
-- @field noDotsMeridiem     Remove dots from AM/PM
-- @field hideMeridiem       Hide AM/PM altogether
-- @field hideWithOverlay    Hide clock when viewing menu screens
-- @field textAlign          Alignment of the clock text
-- @field font               Various settings for font display
-- -----------------------------------------------------------------------------
sc.defaults = {
	offset = {
		x = 150,
		y = 50
	},
	use24Hour = false,
	lowercaseMeridiem = false,
	noDotsMeridiem = false,
	hideMeridiem = false,
	hideWithOverlay = false,
	textAlign = 'Center',
	font = {
		family = 'Univers 67',
		size = 20,
		style = 'soft-shadow-thin',
		color = {
			r = 1,
			g = 1,
			b = 1,
			a = 1
		}
	}
}