local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");

local LocalPlayer = Players.LocalPlayer;
local LocalPlayerMouse = LocalPlayer:GetMouse();

FLYING = false;

FlySpeed = 1;
VFlySpeed = 1;

Fly = function(vfly)
	FLYING = false;
	while not LocalPlayer or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild('HumanoidRootPart') or not LocalPlayer.Character:FindFirstChild('Humanoid') or not LocalPlayerMouse do
		task.wait();
	end 
	local T = LocalPlayer.Character.HumanoidRootPart;
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};
	local SPEED = 0;
	local function FLY()
		FLYING = true;
		local BG = Instance.new('BodyGyro', T);
		local BV = Instance.new('BodyVelocity', T);
		BG.P = 9e4;
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9);
		BG.cframe = T.CFrame;
		BV.velocity = Vector3.new(0, 0, 0);
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9);
		spawn(function()
			while FLYING do
				if not vfly then
					LocalPlayer.Character:FindFirstChild("Humanoid").PlatformStand = true;
				end

				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50;
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0;
				end

				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED;
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED;
				else
					BV.velocity = Vector3.new(0, 0, 0);
				end

				BG.cframe = Workspace.CurrentCamera.CoordinateFrame;

				task.wait();
			end

			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0};

			SPEED = 0;

			BG:destroy();
			BV:destroy();

			LocalPlayer.Character.Humanoid.PlatformStand = false;
		end)
	end

	LocalPlayerMouse.KeyDown:connect(function(KEY)
		--[[
		if KEY:lower() == 'w' then
			if vfly then
				CONTROL.F = VFlySpeed;
			else
				CONTROL.F = FlySpeed;
			end
		elseif KEY:lower() == 's' then
			if vfly then
				CONTROL.B = - VFlySpeed;
			else
				CONTROL.B = - FlySpeed;
			end
		elseif KEY:lower() == 'a' then
			if vfly then
				CONTROL.L = - VFlySpeed;
			else
				CONTROL.L = - FlySpeed;
			end
		elseif KEY:lower() == 'd' then
			if vfly then
				CONTROL.R = VFlySpeed;
			else
				CONTROL.R = FlySpeed;
			end
		elseif KEY:lower() == 'y' then
			if vfly then
				CONTROL.Q = VFlySpeed*2;
			else
				CONTROL.Q = FlySpeed*2;
			end
		elseif KEY:lower() == 't' then
			if vfly then
				CONTROL.E = -VFlySpeed*2;
			else
				CONTROL.E = -FlySpeed*2;
			end
		end
		]]

		if KEY:lower() == 'w' then
			CONTROL.F = VFlySpeed;
			CONTROL.F = FlySpeed;
		elseif KEY:lower() == 's' then
			CONTROL.B = - VFlySpeed;
			CONTROL.B = - FlySpeed;
		elseif KEY:lower() == 'a' then
			CONTROL.L = -VFlySpeed;
			CONTROL.L = -FlySpeed;
		elseif KEY:lower() == 'd' then
			CONTROL.R = VFlySpeed;
			CONTROL.R = FlySpeed;
		elseif KEY:lower() == 'y' then
			CONTROL.Q = VFlySpeed * 2;
			CONTROL.Q = FlySpeed * 2;
		elseif KEY:lower() == 't' then
			CONTROL.E = -VFlySpeed * 2;
			CONTROL.E = -FlySpeed * 2;
		end
	end)

	LocalPlayerMouse.KeyUp:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0;
		elseif KEY:lower() == 's' then
			CONTROL.B = 0;
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0;
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0;
		elseif KEY:lower() == 'y' then
			CONTROL.Q = 0;
		elseif KEY:lower() == 't' then
			CONTROL.E = 0;
		end
	end)

	FLY();
end

Unfly = function()
	FLYING = false;
	LocalPlayer.Character.Humanoid.PlatformStand = false;
end
