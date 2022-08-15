
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()

local Player = game.Players.LocalPlayer

local UI = library.new("A Heliocentric Time")

local playerPage = UI:addPage("Player", 8950959091)

local characterSection = playerPage:addSection("Character")


game:GetService("UserInputService").InputBegan:Connect(function(Input, Proc)
	if Proc then return end
	if Input.KeyCode == Enum.KeyCode.Insert then
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


local farmPage = UI:addPage("Farming", 10595805195)

local manualSection = farmPage:addSection("Manual")

manualSection:addButton("Collect Chests", function()
	pcall(function()

		local Character = Player.Character

		local oldpos = Character.HumanoidRootPart.Position

		local Chests = game:GetService("Workspace").ItemSpawns.Chests

		for _, Location in pairs(Chests:GetChildren()) do
			if Location:FindFirstChild("Chest") then 
				local Chest = Location.Chest

				local Prompt = Chest.RootPart.ProximityAttachment.Interaction

				Character.HumanoidRootPart.CFrame = Location.CFrame
				wait(0.2)
				fireproximityprompt(Prompt)
				wait()
			end
		end
		Character.HumanoidRootPart.Anchored = true
		Character.HumanoidRootPart.Position = oldpos
		Character.HumanoidRootPart.Anchored = false
	end)
end)

manualSection:addButton("Collect Items", function()

	local Character = Player.Character

	local oldpos = Character.HumanoidRootPart.Position

	local Items = workspace.ItemSpawns.StandardItems:GetDescendants()

	for _, desc in pairs(Items) do
		if desc.Name == "Interaction" and desc.Parent.name == "ProximityAttachment" then
			Character.HumanoidRootPart.CFrame = desc.Parent.Parent.CFrame
			wait(0.2)
			fireproximityprompt(desc)
			wait()
		end 
	end


	Character.HumanoidRootPart.Anchored = true
	Character.HumanoidRootPart.Position = oldpos
	Character.HumanoidRootPart.Anchored = false
end)

manualSection:addButton("Collect Debris", function()
	pcall(function()
	local Character = Player.Character

	local oldpos = Character.HumanoidRootPart.Position

	local Items = workspace.ItemSpawns["Sand Debris"]:GetDescendants()

	for _, desc in pairs(Items) do
		if desc.Name == "Interaction" and desc.Parent.name == "ProximityAttachment" then
			Character.HumanoidRootPart.CFrame = desc.Parent.Parent.CFrame
			wait(0.2)
			fireproximityprompt(desc)
			wait(3.4)
		end 
	end


	Character.HumanoidRootPart.Anchored = true
	Character.HumanoidRootPart.Position = oldpos
		Character.HumanoidRootPart.Anchored = false
	end)
end)

manualSection:addButton("Collect Meteors", function()
	pcall(function()

	local Character = Player.Character

	local oldpos = Character.HumanoidRootPart.Position

	local Items = workspace.ItemSpawns["Meteors"]:GetDescendants()

	for _, desc in pairs(Items) do
		if desc.Name == "Interaction" and desc.Parent.name == "ProximityAttachment" then
			Character.HumanoidRootPart.CFrame = desc.Parent.Parent.CFrame
			wait(0.2)
			fireproximityprompt(desc)
			wait()
		end 
	end


	Character.HumanoidRootPart.Anchored = true
	Character.HumanoidRootPart.Position = oldpos
		Character.HumanoidRootPart.Anchored = false
		end)
end)



--// Automatic Functions

-- METEOR
local automaticSection = farmPage:addSection("Automatic")
local autoMeteor = false
local autoItem = false
local autoChest = false
local autoDebris= false

workspace.ItemSpawns.Meteors.DescendantAdded:Connect(function(Descendant)
	if not autoMeteor then return end
	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		
	print("hilarious meteor")
	local currentPosition = Player.Character.HumanoidRootPart.Position
		
	wait(2)
	Player.Character.HumanoidRootPart.CFrame = Descendant.Parent.Parent.Parent.CFrame
	wait(0.2)
	fireproximityprompt(Descendant)
	wait()

	Player.Character.HumanoidRootPart.Anchored = true
	Player.Character.HumanoidRootPart.Position = currentPosition
	Player.Character.HumanoidRootPart.Anchored = false
	end
end)

automaticSection:addToggle("Auto Collect Meteor", false, function(value)
	autoMeteor = value
end)

-- ITEMS

workspace.ItemSpawns.StandardItems.DescendantAdded:Connect(function(Descendant)
	if not autoItem then return end
	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then

		local currentPosition = Player.Character.HumanoidRootPart.Position

		wait()
		Player.Character.HumanoidRootPart.CFrame = Descendant.Parent.Parent.Parent.CFrame
		wait(0.2)
		fireproximityprompt(Descendant)
		wait()

		Player.Character.HumanoidRootPart.Anchored = true
		Player.Character.HumanoidRootPart.Position = currentPosition
		Player.Character.HumanoidRootPart.Anchored = false
	end
end)

automaticSection:addToggle("Auto Collect Items", false, function(value)
	autoItem = value
end)

-- CHESTS

workspace.ItemSpawns.Chests.DescendantAdded:Connect(function(Descendant)
	if not autoChest then return end
	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then
		print("interaction added ok")
		local currentPosition = Player.Character.HumanoidRootPart.Position

		wait()
		Player.Character.HumanoidRootPart.CFrame = Descendant.Parent.Parent.CFrame
		wait(0.2)
		fireproximityprompt(Descendant)
		wait()

		Player.Character.HumanoidRootPart.Anchored = true
		Player.Character.HumanoidRootPart.Position = currentPosition
		Player.Character.HumanoidRootPart.Anchored = false
	end
end)

automaticSection:addToggle("Auto Loot Chests", false, function(value)
	autoChest = value
end)

-- DEBRIS

workspace.ItemSpawns["Sand Debris"].DescendantAdded:Connect(function(Descendant)
	if not autoDebris then return end
	if Descendant.Name == "Interaction" and Descendant.Parent.Name == "ProximityAttachment" then

		local currentPosition = Player.Character.HumanoidRootPart.Position

		wait()
		Player.Character.HumanoidRootPart.CFrame = Descendant.Parent.Parent.Parent.CFrame
		wait(0.2)
		fireproximityprompt(Descendant)
		wait()

		Player.Character.HumanoidRootPart.Anchored = true
		Player.Character.HumanoidRootPart.Position = currentPosition
		Player.Character.HumanoidRootPart.Anchored = false
	end
end)

automaticSection:addToggle("Auto Collect Debris", false, function(value)
	autoDebris = value
end)







local teleportPage = UI:addPage("Teleports")

local utilitySection = teleportPage:addSection("Utility")

local userSection = teleportPage:addSection("Players")

function npclist()
	local npcList = {}
	for _, npc in pairs(workspace.NPCS:GetChildren()) do
		if npc:FindFirstChild("HumanoidRootPart") then
			npcList[npc.Name] = npc.Name
		end
	end
	return npcList
end

utilitySection:addButton("Load Locations", function()
	local Character = Player.Character
	local oldpos = Character.HumanoidRootPart.CFrame
	local locations = workspace.Map.GateLocations
	for _, location in pairs(locations:GetChildren()) do
		if location:IsA("Part") then
			Character.HumanoidRootPart.CFrame = location.CFrame
			wait(0.1)
		end
	end
	Character.HumanoidRootPart.Anchored = true
	Character.HumanoidRootPart.CFrame = oldpos
	Character.HumanoidRootPart.Anchored = false
end)


local ps = game:GetService("Players")

function generatePlayerList()
	local list = {}
	for _, player in pairs(ps:GetPlayers()) do
		list[player.Name] = player.Name
	end
	return list
end

local playerDropdown = userSection:addDropdown("Player List", generatePlayerList(), function(playerName)
	if not workspace.Living:FindFirstChild(playerName) then return end

	pcall(function()
		Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

		userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
			if not workspace.Living:FindFirstChild(playerName) then return end

			pcall(function()
				Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

				userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
					if not workspace.Living:FindFirstChild(playerName) then return end

					pcall(function()
						Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame
					end)
				end)
			end)
		end)
	end)
end)

ps.PlayerAdded:Connect(function()
	userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
		if not workspace.Living:FindFirstChild(playerName) then return end

		pcall(function()
			Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

			userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
				if not workspace.Living:FindFirstChild(playerName) then return end

				pcall(function()
					Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

					userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
						if not workspace.Living:FindFirstChild(playerName) then return end

						pcall(function()
							Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame
						end)
					end)
				end)
			end)
		end)
	end)
end)

ps.PlayerRemoving:Connect(function()
	userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
		if not workspace.Living:FindFirstChild(playerName) then return end

		pcall(function()
			Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

			userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
				if not workspace.Living:FindFirstChild(playerName) then return end

				pcall(function()
					Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame

					userSection:updateDropdown(playerDropdown, "Player List", generatePlayerList(), function(playerName)
						if not workspace.Living:FindFirstChild(playerName) then return end

						pcall(function()
							Player.Character.HumanoidRootPart.CFrame = workspace.Living[playerName].HumanoidRootPart.CFrame
						end)
					end)
				end)
			end)
		end)
	end)
end)

local npcSection = teleportPage:addSection("NPCs")


local npcdropdown = npcSection:addDropdown("NPC List", npclist(), function(npcName)
	Player.Character.HumanoidRootPart.CFrame = workspace.NPCS[npcName].HumanoidRootPart.CFrame
end)

utilitySection:addButton("Refresh NPCs", function()
	npcSection:updateDropdown(npcdropdown, "NPC List", npclist(), function(npcName)
		Player.Character.HumanoidRootPart.CFrame = workspace.NPCS[npcName].HumanoidRootPart.CFrame
	end)
end)

local locationSection = teleportPage:addSection("Locations")

function locationlist()
	local list = {}
	for _, child in pairs(workspace.Map.GateLocations:GetChildren()) do
		if child:IsA("Part") then
			list[child.Name] = child.Name
		end
	end
	return list
end

locationSection:addDropdown("Locations", locationlist(), function(locationName)
	Player.Character.HumanoidRootPart.CFrame = workspace.Map.GateLocations[locationName].CFrame
end)


UI:SelectPage(playerPage, true)
