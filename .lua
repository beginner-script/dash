local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local animateScript = character:WaitForChild("Animate")

local DASH_SPEED = 60
local DASH_TIME = 0.2 
local COOLDOWN = 1 

local canDash = true

local dashAnim = Instance.new("Animation")
dashAnim.AnimationId = "rbxassetid://10479335397"
local dashTrack = humanoid:LoadAnimation(dashAnim)

local function dash()
	canDash = false

	animateScript.Disabled = true

	dashTrack:Play()

	local direction = humanoidRootPart.CFrame.LookVector
	local bv = Instance.new("BodyVelocity")
	bv.Velocity = direction * DASH_SPEED
	bv.MaxForce = Vector3.new(100000, 0, 100000)
	bv.Parent = humanoidRootPart

	task.delay(DASH_TIME, function()
		bv:Destroy()

		dashTrack:Stop()

		animateScript.Disabled = false
	end)

	task.delay(COOLDOWN, function()
		canDash = true
	end)
end

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.Q and canDash then
		dash()
	end
end)
