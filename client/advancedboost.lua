vehicle_info = { }	 -- Array were each vehicle's class will be stored.

vehicle_info[9] = "Bike"
vehicle_info[22] = "Bike"
vehicle_info[47] = "Bike"
vehicle_info[83] = "Bike"
vehicle_info[32] = "Bike"
vehicle_info[90] = "Bike"
vehicle_info[61] = "Bike"
vehicle_info[89] = "Bike"
vehicle_info[43] = "Bike"
vehicle_info[74] = "Bike"
vehicle_info[21] = "Bike"
vehicle_info[36] = "Bike"
vehicle_info[11] = "Bike"

vehicle_info[44] = "Car"
vehicle_info[29] = "Car"
vehicle_info[15] = "Car"
vehicle_info[70] = "Car"
vehicle_info[55] = "Car"
vehicle_info[13] = "Car"
vehicle_info[54] = "Car"
vehicle_info[8] = "Car"

vehicle_info[78] = "Sportcar"
vehicle_info[2] = "Sportcar"
vehicle_info[91] = "Sportcar"
vehicle_info[35] = "Sportcar"

vehicle_info[48] = "Jeep"
vehicle_info[87] = "Jeep"
vehicle_info[52] = "Jeep"
vehicle_info[10] = "Jeep"
vehicle_info[46] = "Jeep"
vehicle_info[72] = "Jeep"
vehicle_info[84] = "Jeep"
vehicle_info[77] = "Jeep"

vehicle_info[60] = "Pickup"
vehicle_info[26] = "Pickup"
vehicle_info[73] = "Pickup"
vehicle_info[23] = "Pickup"
vehicle_info[63] = "Pickup"
vehicle_info[68] = "Pickup"
vehicle_info[33] = "Pickup"
vehicle_info[86] = "Pickup"
vehicle_info[7] = "Pickup"

vehicle_info[66] = "Bus"
vehicle_info[12] = "Bus"

vehicle_info[42] = "Truck"
vehicle_info[49] = "Truck"
vehicle_info[71] = "Truck"
vehicle_info[41] = "Truck"
vehicle_info[4] = "Truck"
vehicle_info[79] = "Truck"

vehicle_info[40] = "Heavy"
vehicle_info[31] = "Heavy"
vehicle_info[76] = "Heavy"
vehicle_info[18] = "Heavy"
vehicle_info[56] = "Heavy"

vehicle_info[1] = "Tractor"

vehicle_info[3] = "Heli"
vehicle_info[14] = "Heli"
vehicle_info[67] = "Heli"
vehicle_info[57] = "Heli"
vehicle_info[64] = "Heli"
vehicle_info[65] = "Heli"
vehicle_info[62] = "Heli"

vehicle_info[59] = "Plane"
vehicle_info[81] = "Plane"
vehicle_info[51] = "Plane"
vehicle_info[30] = "Plane"
vehicle_info[34] = "Plane"
vehicle_info[39] = "Plane"
vehicle_info[85] = "Plane"

vehicle_info[38] = "Boat"
vehicle_info[5] = "Boat"
vehicle_info[6] = "Boat"
vehicle_info[19] = "Boat"
vehicle_info[45] = "Boat"
vehicle_info[16] = "Boat"
vehicle_info[25] = "Boat"
vehicle_info[28] = "Boat"
vehicle_info[50] = "Boat"
vehicle_info[80] = "Boat"
vehicle_info[27] = "Boat"
vehicle_info[88] = "Boat"
vehicle_info[69] = "Boat"

vehicle_info[75] = "DLC"
vehicle_info[58] = "DLC"
vehicle_info[82] = "DLC"
vehicle_info[20] = "DLC"
vehicle_info[53] = "DLC"
vehicle_info[24] = "DLC"

local timer = Timer()		 -- Timer to allow us the delay between frames and apply boost accordingly
local amount_boost = 70		 -- Amount of boost to be applied every second
local boost_enabled = true	 -- If the boost is enabled by the player, followed by individual checks for each vehicle category
local boost_bike = true
local boost_car = true
local boost_sportcar = true
local boost_jeep = true
local boost_pickup = true
local boost_bus = true
local boost_truck = true
local boost_heavy = true
local boost_tractor = true
local boost_heli = false
local boost_plane = false
local boost_boat = true
local boost_dlc = false

function CanUse()

	if	boost_enabled and									 -- If the global boost is enabled and
		Game:GetState() == GUIState.Game and				 -- we're in the game, and
		LocalPlayer:InVehicle() and							 -- we're in a vehicle, and
		LocalPlayer:GetState() == PlayerState.InVehicle and	 -- we're driving that vehicle, and
		LocalPlayer:GetWorld() == DefaultWorld				 -- we're in the right world, and
	then													 -- this vehicle's category is enabled
		if vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Bike" and boost_bike then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Car" and boost_car then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Sportcar" and boost_sportcar then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Jeep" and boost_jeep then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Pickup" and boost_pickup then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Bus" and boost_bus then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Truck" and boost_truck then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Heavy" and boost_heavy then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Tractor" and boost_tractor then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Heli" and boost_heli then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Plane" and boost_plane then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "Boat" and boost_boat then
			return true
		elseif vehicle_info[LocalPlayer:GetVehicle():GetModelId()] == "DLC" and boost_dlc then
			return true
		end
	end

	return false
end

function InputEvent( args )	 -- Process the input
	if CanUse() then
		if Game:GetSetting( GameSetting.GamepadInUse ) == 1 then
			if args.input == Action.VehicleFireLeft then
				ForwardBoost()
			end
			if args.input == Action.VehicleFireRight then
				ReverseBoost()
			end
		else
			if args.input == Action.PlaneIncTrust then
				ForwardBoost()
			end
			if args.input == Action.PlaneDecTrust then
				ReverseBoost()
			end
		end
	end
end

function ForwardBoost()	 -- Apply boost in the direction the vehicle is facing
	local v = LocalPlayer:GetVehicle()									 -- The player's vehicle
	local forward = v:GetAngle() * Vector3(0, 0, -1)					 -- The forward vector multiplied by the the angle of the vehicle
	local vel = v:GetLinearVelocity()									 -- The vehicle's current velocity
	local new_vel = vel + (forward * amount_boost * timer:GetSeconds())	 -- Adding the new velocity to the current velocity

	if new_vel:IsNaN() then			 -- If something went wrong at the velocity is Not a Number, set it to 0
		new_vel = Vector3( 0, 0, 0 )
	end

	v:SetLinearVelocity( new_vel )	 -- Apply the velocity to the vehicle
end

function ReverseBoost()	 -- Exactly the same as the ForwardBoost function, but the vector points in the opposite direction
	local v = LocalPlayer:GetVehicle()
	local backward = v:GetAngle() * Vector3(0, 0, 1)
	local vel = v:GetLinearVelocity()
	local new_vel = vel + (backward * amount_boost * timer:GetSeconds())

	if new_vel:IsNaN() then
		new_vel = Vector3( 0, 0, 0 )
	end

	v:SetLinearVelocity( new_vel )
end

function PostTick( args )	 -- We reset the timer once every frame to have time it took, allowing us to apply the boost properly
	timer:Restart()
end

function LocalPlayerChat( args )
	if args.text == "/boost" then
		SetWindowOpen(not GetWindowOpen())
	end
end

function CreateSettings()	 -- Settings. Base code taken from the boost_lite script
	window_open = false

	window = Window.Create()
	window:SetSize(Vector2(300, 350))
	window:SetPosition((Render.Size - window:GetSize()) / 2)

	window:SetTitle("Boost Settings")
	window:SetVisible(window_open)
	window:Subscribe("WindowClosed", function() SetWindowOpen(false) end)

	local enabled_checkbox_g = LabeledCheckBox.Create(window)	 -- This creates a checkbox for each bool. It's a huge
	enabled_checkbox_g:SetSize(Vector2(300, 20))				 -- copy pasted mess, but it works
	enabled_checkbox_g:SetDock(GwenPosition.Top)
	enabled_checkbox_g:GetLabel():SetText("GLOBAL Enabled")
	enabled_checkbox_g:GetCheckBox():SetChecked(boost_enabled)
	enabled_checkbox_g:GetCheckBox():Subscribe("CheckChanged",
		function() boost_enabled = enabled_checkbox_g:GetCheckBox():GetChecked() end)

	local enabled_checkbox_bike = LabeledCheckBox.Create(window)
	enabled_checkbox_bike:SetSize(Vector2(300, 20))
	enabled_checkbox_bike:SetDock(GwenPosition.Top)
	enabled_checkbox_bike:GetLabel():SetText("Bike Enabled")
	enabled_checkbox_bike:GetCheckBox():SetChecked(boost_bike)
	enabled_checkbox_bike:GetCheckBox():Subscribe("CheckChanged",
		function() boost_bike = enabled_checkbox_bike:GetCheckBox():GetChecked() end)

	local enabled_checkbox_car = LabeledCheckBox.Create(window)
	enabled_checkbox_car:SetSize(Vector2(300, 20))
	enabled_checkbox_car:SetDock(GwenPosition.Top)
	enabled_checkbox_car:GetLabel():SetText("Car Enabled")
	enabled_checkbox_car:GetCheckBox():SetChecked(boost_car)
	enabled_checkbox_car:GetCheckBox():Subscribe("CheckChanged",
		function() boost_car = enabled_checkbox_car:GetCheckBox():GetChecked() end)

	local enabled_checkbox_jeep = LabeledCheckBox.Create(window)
	enabled_checkbox_jeep:SetSize(Vector2(300, 20))
	enabled_checkbox_jeep:SetDock(GwenPosition.Top)
	enabled_checkbox_jeep:GetLabel():SetText("Jeep Enabled")
	enabled_checkbox_jeep:GetCheckBox():SetChecked(boost_jeep)
	enabled_checkbox_jeep:GetCheckBox():Subscribe("CheckChanged",
		function() boost_jeep = enabled_checkbox_jeep:GetCheckBox():GetChecked() end)

	local enabled_checkbox_pickup = LabeledCheckBox.Create(window)
	enabled_checkbox_pickup:SetSize(Vector2(300, 20))
	enabled_checkbox_pickup:SetDock(GwenPosition.Top)
	enabled_checkbox_pickup:GetLabel():SetText("Pickup Enabled")
	enabled_checkbox_pickup:GetCheckBox():SetChecked(boost_pickup)
	enabled_checkbox_pickup:GetCheckBox():Subscribe("CheckChanged",
		function() boost_pickup = enabled_checkbox_pickup:GetCheckBox():GetChecked() end)

	local enabled_checkbox_bus = LabeledCheckBox.Create(window)
	enabled_checkbox_bus:SetSize(Vector2(300, 20))
	enabled_checkbox_bus:SetDock(GwenPosition.Top)
	enabled_checkbox_bus:GetLabel():SetText("Bus Enabled")
	enabled_checkbox_bus:GetCheckBox():SetChecked(boost_bus)
	enabled_checkbox_bus:GetCheckBox():Subscribe("CheckChanged",
		function() boost_bus = enabled_checkbox_bus:GetCheckBox():GetChecked() end)

	local enabled_checkbox_truck = LabeledCheckBox.Create(window )
	enabled_checkbox_truck:SetSize(Vector2(300, 20))
	enabled_checkbox_truck:SetDock(GwenPosition.Top)
	enabled_checkbox_truck:GetLabel():SetText("Truck Enabled")
	enabled_checkbox_truck:GetCheckBox():SetChecked(boost_truck)
	enabled_checkbox_truck:GetCheckBox():Subscribe("CheckChanged",
		function() boost_truck = enabled_checkbox_truck:GetCheckBox():GetChecked() end)

	local enabled_checkbox_heavy = LabeledCheckBox.Create(window)
	enabled_checkbox_heavy:SetSize(Vector2(300, 20))
	enabled_checkbox_heavy:SetDock(GwenPosition.Top)
	enabled_checkbox_heavy:GetLabel():SetText("Heavy Enabled")
	enabled_checkbox_heavy:GetCheckBox():SetChecked(boost_heavy)
	enabled_checkbox_heavy:GetCheckBox():Subscribe("CheckChanged",
		function() boost_heavy = enabled_checkbox_heavy:GetCheckBox():GetChecked() end)

	local enabled_checkbox_tractor = LabeledCheckBox.Create(window)
	enabled_checkbox_tractor:SetSize(Vector2( 300, 20))
	enabled_checkbox_tractor:SetDock(GwenPosition.Top)
	enabled_checkbox_tractor:GetLabel():SetText("Tractor Enabled")
	enabled_checkbox_tractor:GetCheckBox():SetChecked(boost_tractor)
	enabled_checkbox_tractor:GetCheckBox():Subscribe("CheckChanged",
		function() boost_tractor = enabled_checkbox_tractor:GetCheckBox():GetChecked() end)

	local enabled_checkbox_heli = LabeledCheckBox.Create(window)
	enabled_checkbox_heli:SetSize(Vector2(300, 20))
	enabled_checkbox_heli:SetDock(GwenPosition.Top)
	enabled_checkbox_heli:GetLabel():SetText("Heli Enabled")
	enabled_checkbox_heli:GetCheckBox():SetChecked(boost_heli)
	enabled_checkbox_heli:GetCheckBox():Subscribe("CheckChanged",
		function() boost_heli = enabled_checkbox_heli:GetCheckBox():GetChecked() end)

	local enabled_checkbox_plane = LabeledCheckBox.Create(window)
	enabled_checkbox_plane:SetSize(Vector2(300, 20))
	enabled_checkbox_plane:SetDock(GwenPosition.Top)
	enabled_checkbox_plane:GetLabel():SetText("Plane Enabled")
	enabled_checkbox_plane:GetCheckBox():SetChecked(boost_plane)
	enabled_checkbox_plane:GetCheckBox():Subscribe("CheckChanged",
		function() boost_plane = enabled_checkbox_plane:GetCheckBox():GetChecked() end)

	local enabled_checkbox_boat = LabeledCheckBox.Create(window)
	enabled_checkbox_boat:SetSize(Vector2(300, 20))
	enabled_checkbox_boat:SetDock(GwenPosition.Top)
	enabled_checkbox_boat:GetLabel():SetText("Boat Enabled")
	enabled_checkbox_boat:GetCheckBox():SetChecked(boost_boat)
	enabled_checkbox_boat:GetCheckBox():Subscribe("CheckChanged",
		function() boost_boat = enabled_checkbox_boat:GetCheckBox():GetChecked() end)

	local enabled_checkbox_dlc = LabeledCheckBox.Create(window)
	enabled_checkbox_dlc:SetSize(Vector2( 300, 20))
	enabled_checkbox_dlc:SetDock(GwenPosition.Top)
	enabled_checkbox_dlc:GetLabel():SetText("DLC Enabled")
	enabled_checkbox_dlc:GetCheckBox():SetChecked(boost_dlc)
	enabled_checkbox_dlc:GetCheckBox():Subscribe("CheckChanged",
		function() boost_dlc = enabled_checkbox_dlc:GetCheckBox():GetChecked() end)

	local amount_slider = HorizontalSlider.Create(window)	 -- The slider that controlls the amount of boost
	amount_slider:SetDock(GwenPosition.Top)
	amount_slider:SetRange(0, 100)							 -- The boost amount can be a value from 0 to 100m/s
	amount_slider:SetClampToNotches(true)
	amount_slider:SetNotchCount(11)							 -- This is divided in 11 10m/s segments (0, 10, 20 ... 100)
	amount_slider:SetValue(amount_boost)
	amount_slider:Subscribe("ValueChanged",
		function() amount_boost = amount_slider:GetValue() end)

	--local label = Label.Create(window)	 -- A label to write the amount of boost, but still haven't figured how it works
	--label:SetDock(GwenPosition.Top)
	--label:SetTextSize(14)
	--label:SetWidth(80)
	--label:SetText(amount_boost)
end

function GetWindowOpen()
    return window_open
end

function SetWindowOpen( state )
	window_open = state
	window:SetVisible( window_open )
	Mouse:SetVisible( window_open )
end

function ModulesLoad()
	Events:Fire( "HelpAddItem",
        {
            name = "Boost",
            text = 
				"The boost lets you increase or decrease the speed of any vehicle.\n" ..
				"To use it, use the key corresponding to increasing/decreasing the" ..
				"thrust of a plane." ..
				"To open the options menu, type /boost into chat." ..
				"Vehicles are divided in the same categories found in the script" ..
				"'Advanced Buy Menu'."
	} )
end

function ModuleUnload()
	Events:Fire( "HelpRemoveItem", { name = "Boost" } )
end

CreateSettings()

Events:Subscribe("LocalPlayerChat", LocalPlayerChat)
Events:Subscribe("LocalPlayerInput", InputEvent)
Events:Subscribe("ModulesLoad", ModulesLoad)
Events:Subscribe("ModuleUnload", ModuleUnload)
Events:Subscribe("PostTick", PostTick)