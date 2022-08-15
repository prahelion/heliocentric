
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()

local Player = game.Players.LocalPlayer

local Players = game:GetService("Players")

local UI = library.new("A Heliocentric Time")


--// Pages
local playerPage = UI:addPage("Player", 8950959091)
local farmPage = UI:addPage("Farming", 10595805195)
local teleportPage = UI:addPage("Teleports")


--// Character Page
local characterSection = playerPage:addSection("Character")

game:GetService("UserInputService").InputBegan:Connect(function(Input, Proc)
	if Proc then return end
	if Input.KeyCode == Enum.KeyCode.End then
		UI:toggle()
	end
end)

characterSection:addButton("Respawn", function()
	local Character = Player.Character
	Character:Destroy()
end)

characterSection:addButton("Godmode", function()
	local Character = Player.Character

	Character.Values.Block:Destroy()
end)

characterSection:addButton("Invisibility", function()
	local Character = Player.Character

	local currentPosition = Character.HumanoidRootPart.Position

	Character.Torso.Position = Vector3.new(-800.879, 1084.86, -1029.35)
	Character.Torso.Anchored = true
	wait(1)
	Character.HumanoidRootPart.RootJoint:Destroy()
	wait(.5)
	Character.HumanoidRootPart.Position = currentPosition


end)

characterSection:addSlider("Walk Speed", 16, 16, 300, function(value, update)
	local Character = Player.Character

	Character.Humanoid.WalkSpeed = value
end)

characterSection:addSlider("Jump Power", 50, 25, 300, function(value, update)
	local Character = Player.Character

	Character.Humanoid.JumpPower = value
end)

local emoteSection = playerPage:addSection("Emotes")

emoteSection:addDropdown("Emote List", 
	{
		"DefaultDance",
		"TortureDance",
		"CaramellDansen",
		"Smug", 
		"LoseControl",
		"Infestation",
		"FNF",
		"PAC-MAN",
		"Backflip",
		"SmoothMoves",
		"SmoothCriminal",
		"Kazotsky",
		"IevanPolkka",
		"God-Step",
		"90s",
		"Rodeo",
		"Cshearer",
		"Sweet Dreams",
		"Peanut",
		"Troll",
		"Do The Odyssey",
		"Gangnam Style",
		"DIO's Talent",
		"Futsal Shuffle",
		"Nae-Nae",
		"Griddy",
		"Distraction Dance"

	}, function(emote)
		local funny = game:GetService("ReplicatedStorage").ReplicatedModules.KnitPackage.Knit.Services.EmoteService.RF.Play

		funny:InvokeServer(emote)
	end)




--// Farming Page

local manualSection = farmPage:addSection("Manual")

local chestRunning = false
manualSection:addButton("Collect Chests", function()
	if chestRunning then return end
	chestRunning = true
	
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame
		
	for _, Descendant in pairs(workspace.ItemSpawns.Chests:GetDescendants()) do
		if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
			HRP.CFrame = Descendant.Parent.Parent.CFrame
			task.wait(.2)
			fireproximityprompt(Descendant)
			task.wait()
		end
	end
	
	HRP.CFrame = currentPosition
	chestRunning = false
end)

local itemRunning = false
manualSection:addButton("Collect Items", function()
	if itemRunning then return end
	itemRunning = true

	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	for _, Descendant in pairs(workspace.ItemSpawns.StandardItems:GetDescendants()) do
		if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
			HRP.CFrame = Descendant.Parent.Parent.CFrame
			task.wait(.2)
			fireproximityprompt(Descendant)
			task.wait()
		end
	end

	HRP.CFrame = currentPosition
	itemRunning = false
end)

local debrisRunning = false
manualSection:addButton("Collect Debris", function()
	if debrisRunning then return end
	debrisRunning = true

	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	for _, Descendant in pairs(workspace.ItemSpawns["Sand Debris"]:GetDescendants()) do
		if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
			HRP.CFrame = Descendant.Parent.Parent.CFrame
			task.wait(.2)
			fireproximityprompt(Descendant)
			task.wait(4)
		end
	end

	HRP.CFrame = currentPosition
	debrisRunning = false
end)

local meteorRunning = false
manualSection:addButton("Collect Meteors", function()
	if meteorRunning then return end
	meteorRunning = true

	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	for _, Descendant in pairs(workspace.ItemSpawns.Meteors:GetDescendants()) do
		if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
			HRP.CFrame = Descendant.Parent.Parent.CFrame
			task.wait(.2)
			fireproximityprompt(Descendant)
			task.wait()
		end
	end

	HRP.CFrame = currentPosition
	meteorRunning = false
end)



--// Automatic Functions

-- METEOR
local automaticSection = farmPage:addSection("Automatic")
local autoMeteor = false
local autoItem = false
local autoChest = false
local autoDebris= false

automaticSection:addToggle("Auto Loot Chest", false, function(value)
	autoChest = value
end)

automaticSection:addToggle("Auto Collect Items", false, function(value)
	autoItem = value
end)

automaticSection:addToggle("Auto Collect Meteors", false, function(value)
	autoMeteor = value
end)

automaticSection:addToggle("Auto Collect Sand Debris", false, function(value)
	autoDebris = value
end)

-- Chests
workspace.ItemSpawns.Chests.DescendantAdded:Connect(function(Descendant)
	if not autoChest then return end
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		HRP.CFrame = Descendant.Parent.Parent.CFrame
		task.wait(.2)
		fireproximityprompt(Descendant)
		task.wait()
		HRP.CFrame = currentPosition
	end
end)

-- Items
workspace.ItemSpawns.StandardItems.DescendantAdded:Connect(function(Descendant)
	if not autoItem then return end
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		HRP.CFrame = Descendant.Parent.Parent.CFrame
		task.wait(.2)
		fireproximityprompt(Descendant)
		task.wait()
		HRP.CFrame = currentPosition
	end
end)

-- Meteors
workspace.ItemSpawns.Meteors.DescendantAdded:Connect(function(Descendant)
	if not autoMeteor then return end
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		task.wait(2)
		HRP.CFrame = Descendant.Parent.Parent.CFrame
		task.wait(.2)
		fireproximityprompt(Descendant)
		task.wait()
		HRP.CFrame = currentPosition
	end
end)

-- Debris
workspace.ItemSpawns["Sand Debris"].DescendantAdded:Connect(function(Descendant)
	if not autoDebris then return end
	local Character = Player.Character
	local HRP = Character.HumanoidRootPart
	local currentPosition = HRP.CFrame

	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		HRP.CFrame = Descendant.Parent.Parent.CFrame
		task.wait(.2)
		fireproximityprompt(Descendant)
		task.wait()
		HRP.CFrame = currentPosition
	end
end)

--// Teleports

local utilitySection = teleportPage:addSection("Utility")
local userSection = teleportPage:addSection("Players")
local npcSection = teleportPage:addSection("NPCs")
local locationSection = teleportPage:addSection("Locations")

-- Players

function generatePlayerList()
	local list = {}
	for _, player in pairs(Players:GetPlayers()) do
		list[player.Name] = player.Name
	end
	return list
end

function dropdownPressed(playerName)
	pcall(function()
		local Character = Player.Character
		if not workspace.Living:FindFirstChild(playerName) then return end 

		Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame
	end)
end

local playerDropdown = userSection:addDropdown("Player List", generatePlayerList(), dropdownPressed)

function refreshPlayerList()
	userSection:updateDropdown(playerDropdown, generatePlayerList(), dropdownPressed)
end

Players.PlayerAdded:Connect(refreshPlayerList)

Players.PlayerRemoving:Connect(refreshPlayerList)

-- NPCs

function createNPCList()
	local NPCList = {}
	for _, NPC in pairs(workspace.NPCS:GetChildren()) do

		if NPC:FindFirstChild("HumanoidRootPart") then NPCList[NPC.Name] = NPC.Name end

	end
	return NPCList
end

function npcDropdownPress(NPC)
	local Character = Player.Character
	
	Character.HumanoidRootPart.CFrame = workspace.NPCS[NPC].HumanoidRootPart.CFrame
end

local npcListD = npcSection:addDropdown("NPC List", createNPCList(), npcDropdownPress)

utilitySection:addButton("Refresh NPCs", function()
	npcSection:updateDropdown(npcListD, "NPC List", createNPCList(), npcDropdownPress)
end)

-- Locations
function createLocationList()
	local locationList = {}
	for _, Location in pairs(workspace.Map.GateLocations:GetChildren()) do
		wait()
		if Location:IsA("Part") then locationList[Location.Name] = Location.Name end

	end
	return locationList
end

function locationDropdownPress(Location)
	local Character = Player.Character

	Character.HumanoidRootPart.CFrame = workspace.Map.GateLocations[Location].CFrame
end

local locationDrop = locationSection:addDropdown("Location List", createLocationList(), locationDropdownPress)

utilitySection:addButton("Refresh Locations", function()
	npcSection:updateDropdown(locationDrop, "Location List", createLocationList(), locationDropdownPress)
end)

UI:SelectPage(playerPage, true)
