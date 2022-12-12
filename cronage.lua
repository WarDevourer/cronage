local Library = loadstring(
	game:HttpGet('https://raw.githubusercontent.com/finayv2/LinoriaLib/main/Library.lua')
)();

local Cronage = {
	GameList = {};
	BlockersNamecallMethod = {'Kick'; 'kick';};
}

local Variables = {
	LocalPlayer = game.Players.LocalPlayer;
	RunService = game:GetService("RunService");
	HTTPService = game:GetService("HttpService");
	StarterGUI = game:GetService("StarterGui");
	TweenService = game:GetService("TweenService");
	TeleportService = game:GetService("TeleportService");
}

local ThemeManager, SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/ThemeManager.lua'))(), loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/SaveManager.lua'))();

function StringtoCFrame(str)
	return CFrame.new(table.unpack(str:gsub(" ",""):split(",")))
end

function DistanceTime(Distance, Speed)
	return Distance / Speed;
end

function Cronage.AddGame(PlaceID, PlacesName, Callback)
	Cronage.GameList[PlaceID] = Callback
end

function Cronage.Load(Library)
	if Cronage.GameList[game.PlaceId] then
		Cronage.GameList[game.PlaceId]()
		local oldnamecall; oldnamecall = hookmetamethod(game, "__namecall", function(self, ...)
			local method = getnamecallmethod()

			if not checkcaller() then
				if Cronage.BlockersNamecallMethod[method] and self == Variables.LocalPlayer then return wait(9e9) end
			end
			return oldnamecall(self, ...)
		end)
		for i,v in pairs(getconnections(game:service("ScriptContext").Error)) do v:Disable() end


		Library:Notify('Loaded UI!');
	else
		-- Variables.LocalPlayer:Kick("Invalid game")
	end
end


Cronage.AddGame(5208655184, 'Rogue Lineage', function()
	local MainWindow = Library:CreateWindow({
		Title = 'Cronage',
		Center = true, 
		AutoShow = true,
	})

	local Tabs = {
		Main = MainWindow:AddTab('Main'), 
		Bots = MainWindow:AddTab('Bots'),
		Spoofs = MainWindow:AddTab('Spoofing'),
		['Settings'] = MainWindow:AddTab('Settings'),
	}
	
	local Keys = {W = 0, S = 0, D = 0, A = 0};
	
	local LocalPlayerClient = Tabs.Main:AddLeftGroupbox('LocalPlayer - Client')
	local LocalPlayerCharacter = Tabs.Main:AddRightGroupbox('LocalPlayer - Humanoid')
	
	local FakeItemSpawning = Tabs.Spoofs:AddLeftGroupbox('Fake Item Spawning')
	
	local Pathing = Tabs.Bots:AddLeftGroupbox('Pathing')
	local Bots = Tabs.Bots:AddRightGroupbox('Bots')
	
	local AllIDs = {}
	local foundAnything = ""
	local actualHour = os.date("!*t").hour

	local File = pcall(function()
		AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
	end)

	if not File then
		table.insert(AllIDs, actualHour)
		writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
	end

	local function TPReturner()
		local Site;
		if foundAnything == "" then
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
		else
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
		end

		local ID = ""
		if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
			foundAnything = Site.nextPageCursor
		end

		local num = 0;
		for i,v in pairs(Site.data) do
			local Possible = true
			ID = tostring(v.id)
			if tonumber(v.maxPlayers) > tonumber(v.playing) then
				for _,Existing in pairs(AllIDs) do
					if num ~= 0 then
						if ID == tostring(Existing) then
							Possible = false
						end
					else
						if tonumber(actualHour) ~= tonumber(Existing) then
							local delFile = pcall(function()
								delfile("NotSameServers.json")
								AllIDs = {}
								table.insert(AllIDs, actualHour)
							end)
						end
					end
					num = num + 1
				end
				if Possible == true then
					table.insert(AllIDs, ID)
					wait()
					pcall(function()
						writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
						wait()
						game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, ID, game.Players.LocalPlayer)
					end)
					wait(4)
				end
			end
		end
	end

	local function Teleport()
		while wait() do
			pcall(function()
				TPReturner()
				if foundAnything ~= "" then
					TPReturner()
				end
			end)
		end
	end
	
	
	
	local Trinkets = {
		Artifacts = {
			"Lannis Amulet";
			"Spider Cloak";
			"Philosopher's Stone";
			"Howler Friend";
			"Amulet of the White King";
			"Fairfrozen";
			"Scroom Key";
			"Night Stone";
			"Rift Gem";
			"Mysterious Artifact";
			"Azael Horns";

			"Phoenix Down";
			"???";
			"Ice Essence";
		};
		
		TrinketList = {
			"Old Amulet",
			"Amulet",
			"Old Ring",
			"Ring",
			"Goblet",
			"Idol Forgotten",
			"Opal",
			"Sapphire",
			"Emerald",
			"Ruby",
			"Diamond",
			"Scrolls"
		};
		
		
		
		-------------------- Philo and Night stone properties --------------------
		sizeList = {
			Vector3.new(0.265, 0.05, 0.265), Vector3.new(0.331, 0.331, 0.331),Vector3.new(0.265, 0.05, 0.265),Vector3.new(0.265, 0.05, 0.265),
			Vector3.new(0.265, 0.05, 0.265),Vector3.new(0.265, 0.05, 0.265),Vector3.new(0.265, 0.05, 0.265)
		};
		
		posList = {
			CFrame.new(0,0,0)*CFrame.Angles(0,math.rad(180),math.rad(180)),CFrame.new(0, -0.190, 0)*CFrame.Angles(math.rad(-90), 0, 0),CFrame.new(-0.190, -0.190, 0)*CFrame.Angles(0, math.rad(180), math.rad(90)),
			CFrame.new(0.190, -0.190, 0)*CFrame.Angles(0, math.rad(180), math.rad(-90)),CFrame.new(0, -0.190, 0.190)*CFrame.Angles(0, math.rad(-90), math.rad(90)),
			CFrame.new(0, -0.190, -0.190)*CFrame.Angles(math.rad(-90), 0, 0),CFrame.new(0, -0.380, 0)*CFrame.Angles(0, math.rad(180), 0)
		};

		-------------------- Lannis and White King's amulet properties --------------------
		sizeList2 = {
			Vector3.new(0.178, 0.64, 0.551), Vector3.new(0.339, 0.092, 0.155),Vector3.new(0.339, 0.092, 0.155),Vector3.new(0.339, 0.092, 0.155),Vector3.new(0.339, 0.092, 0.155),
			Vector3.new(0.339, 0.092, 0.155),Vector3.new(0.339, 0.092, 0.155),Vector3.new(0.197, 0.412, 0.363),Vector3.new(0.092, 0.133, 0.155),Vector3.new(0.092, 0.138, 0.155),
			Vector3.new(0.092, 0.133, 0.155),Vector3.new(0.092, 0.138, 0.155),Vector3.new(0.092, 0.142, 0.155),Vector3.new(0.092, 0.138, 0.155),Vector3.new(0.092, 0.167, 0.155),
			Vector3.new(0.092, 0.157, 0.155),Vector3.new(0.092, 0.133, 0.155),Vector3.new(0.092, 0.152, 0.155),Vector3.new(0.092, 0.142, 0.155)
		};
		
		posList2 = {
			CFrame.new(0,0,0)*CFrame.Angles(0, math.rad(90), 0), CFrame.new(-0.307, 0.245, -0.002)*CFrame.Angles(0, 0, math.rad(120)),CFrame.new(-0.471, 0.862, -0.002)*CFrame.Angles(0,0, math.rad(90)),
			CFrame.new(0.475, 0.862, -0.002)*CFrame.Angles(0, 0, math.rad(90)),CFrame.new(0.31, 0.245, -0.002)*CFrame.Angles(0, 0, math.rad(60)),CFrame.new(-0.43, 0.543, -0.002)*CFrame.Angles(0, 0, math.rad(105)),
			CFrame.new(0.433, 0.542, -0.002)*CFrame.Angles(0, 0, math.rad(75)),CFrame.new(0, -0, 0.003)*CFrame.Angles(0, math.rad(90), 0),CFrame.new(-0.456, 1.075, -0.005)*CFrame.Angles(0, 0, math.rad(-15)),
			CFrame.new(0.415, 1.18, -0.006)*CFrame.Angles(0, math.rad(180), math.rad(-30)),CFrame.new(0.459, 1.075, -0.005)*CFrame.Angles(0, math.rad(180), math.rad(-15)),CFrame.new(-0.413, 1.18, -0.006)*CFrame.Angles(0, 0, math.rad(-30)),
			CFrame.new(-0.34, 1.276, -0.005)*CFrame.Angles(0, 0, math.rad(-45)),CFrame.new(-0.242, 1.353, -0.006)*CFrame.Angles(0, 0, math.rad(-60)),CFrame.new(-0.122, 1.403, -0.005)*CFrame.Angles(0, 0, math.rad(-75)),
			CFrame.new(-0.001, 1.421, -0.005)*CFrame.Angles(0, math.rad(180), math.rad(-90)),CFrame.new(0.127, 1.403, -0.005)*CFrame.Angles(0, math.rad(180), math.rad(-75)),
			CFrame.new(0.242, 1.354, -0.006)*CFrame.Angles(0, math.rad(180), math.rad(-60)),CFrame.new(0.342, 1.276, -0.005)*CFrame.Angles(0, math.rad(180), math.rad(-45))
		};
	}

	local CurrentSavedPoints = {}
	
	local TableFunctions = {
		["Add Point"] = function()
			table.insert(CurrentSavedPoints, tostring(Variables.LocalPlayer.Character.HumanoidRootPart.CFrame))
		end;

		["Add Wait"] = function()
			table.insert(CurrentSavedPoints, tostring(Variables.LocalPlayer.Character.HumanoidRootPart.CFrame).."|".."Wait|"..Options.WaitTime.Value)
		end;

		["Remove Last Point"] = function()
			local Number = #CurrentSavedPoints
			local Difference = Number - 1

			table.remove(CurrentSavedPoints, Difference)
		end;

		["Preview All Points"] = function()		
			for i, v in ipairs(game.Workspace.Paths:GetChildren()) do
				v:Destroy()
			end
			
			for i, v in ipairs(CurrentSavedPoints) do
				if string.find(tostring(v), "|") then
					local String = string.split(tostring(v), "|")
					local Coords, Type, Value = String[1], String[2], String[3]

					if Type == "Wait" then
						local Part = Instance.new("Part")
						Part.Parent = game.Workspace.Paths
						Part.Shape = Enum.PartType.Ball
						Part.Name = i
						Part.Anchored = true
						Part.CFrame = StringtoCFrame(Coords)
						Part.Color = Color3.new(1, 0, 0)

						local Billboard = Instance.new("BillboardGui")
						Billboard.Parent = Part
						local TextLabel = Instance.new("TextLabel")
						TextLabel.Parent = Billboard
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextScaled = true
						TextLabel.Text = Value
					end
				else
					local Part = Instance.new("Part")
					Part.Parent = game.Workspace.Paths
					Part.Shape = Enum.PartType.Ball
					Part.Name = i
					Part.Anchored = true
					Part.CFrame = StringtoCFrame(tostring(v))
				end
			end
		end;
		
		["Delete All Points"] = function()		
			for i, v in ipairs(CurrentSavedPoints) do
				table.remove(CurrentSavedPoints, i)
			end
		end;
		
		["Save Bot"] = function()
			if Options.BotName.Value == "" then return end

			writefile("Cronage/Paths/"..Options.BotName.Value..".txt", Variables.HTTPService:JSONEncode(CurrentSavedPoints))
			Variables.StarterGUI:SetCore("SendNotification", {
				Title = "File Saved!";
				Text = "Saved File "..Options.BotName.Value.." to file location workspace/Cronage/Paths.";
				Duration = 5;
			})
		end;

		["Load Bot"] = function()
			if isfile("Cronage/Paths/"..Options.BotName.Value..".txt") then
				local Paths = Variables.HTTPService:JSONDecode(readfile("Cronage/Paths/"..Options.BotName.Value..".txt"))

				CurrentSavedPoints = {}

				for i, v in ipairs(Paths) do
					table.insert(CurrentSavedPoints, v)
				end
				Variables.StarterGUI:SetCore("SendNotification", {
					Title = "File Loaded!";
					Text = "Loaded File "..Options.BotName.Value..". File has a total of "..#CurrentSavedPoints.." points.";
					Duration = 5;
				})
			end
		end;
		
		["Start Bot"] = function()
			local function CalculatePlayerDistance()
				for i, v in ipairs(game.Players:GetPlayers()) do
					if v.Character ~= Variables.LocalPlayer.Character then
						local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.Position).magnitude
						if Distance <= Options.PlayerRange.Value then
							return true
						else
							return false
						end
					end
				end
			end
			
			local function CalculatePlayerDistance()
				for i, v in ipairs(game.Players:GetPlayers()) do
					if v.Character ~= Variables.LocalPlayer.Character then
						local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.Position).magnitude
						if Distance <= Options.PlayerRange.Value then
							return true
						else
							return false
						end
					end
				end
			end
			
			if #CurrentSavedPoints <= 1 then
				Variables.StarterGUI:SetCore("SendNotification", {
					Title = "Error!";
					Text = "This path has less than one point, making it impossible to farm!";
					Duration = 5;
				})
				return end

			local FirstPoint = CurrentSavedPoints[1]

			local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - StringtoCFrame(FirstPoint).Position).magnitude
			
			if Distance > 20 then
				Variables.StarterGUI:SetCore("SendNotification", {
					Title = "Error!";
					Text = "You are too far from your first point, please get closer!";
					Duration = 5;
				})
				return end
			
			
			
			for i, v in ipairs(CurrentSavedPoints) do
				if string.find(tostring(v), "|") then
					local String = string.split(tostring(v), "|")
					local Coords, Type, Value = String[1], String[2], String[3]
					
					if Type == "Wait" then
						local Bool = CalculatePlayerDistance(); if Bool then return end				

						local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - StringtoCFrame(Coords).Position).magnitude
						local Time = DistanceTime(Distance, Options.BotSpeed.Value);
						local TW = TweenInfo.new(Time, Enum.EasingStyle.Linear);
						local Tween = Variables.TweenService:Create(Variables.LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = StringtoCFrame(Coords) });
						Tween:Play()
						Tween.Completed:Wait()
						
						task.wait(Value)
					end

					local Bool = CalculatePlayerDistance(); if Bool then return end
				else
					local Bool = CalculatePlayerDistance(); if Bool then return end				

					local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - StringtoCFrame(v).Position).magnitude
					local Time = DistanceTime(Distance, Options.BotSpeed.Value);
					local TW = TweenInfo.new(Time, Enum.EasingStyle.Linear);
					local Tween = Variables.TweenService:Create(Variables.LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = StringtoCFrame(v) });
					Tween:Play()
					Tween.Completed:Wait()

					local Bool = CalculatePlayerDistance(); if Bool then return end
				end
			end		
			
			for i = #CurrentSavedPoints, 1, -1 do
				local Bool = CalculatePlayerDistance(); if Bool then return end	
				
				local v = CurrentSavedPoints[i]
				
				if string.find(tostring(v), "|") then
					local String = string.split(tostring(v), "|")
					local Coords, Type, Value = String[1], String[2], String[3]
					
					local Bool = CalculatePlayerDistance(); if Bool then return end				

					local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - StringtoCFrame(Coords).Position).magnitude
					local Time = DistanceTime(Distance, Options.BotSpeed.Value);
					local TW = TweenInfo.new(Time, Enum.EasingStyle.Linear);
					local Tween = Variables.TweenService:Create(Variables.LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = StringtoCFrame(Coords) });
					Tween:Play()
					Tween.Completed:Wait()

					local Bool = CalculatePlayerDistance(); if Bool then return end
				else
					local Bool = CalculatePlayerDistance(); if Bool then return end				

					local Distance = (Variables.LocalPlayer.Character.HumanoidRootPart.Position - StringtoCFrame(v).Position).magnitude
					local Time = DistanceTime(Distance, Options.BotSpeed.Value);
					local TW = TweenInfo.new(Time, Enum.EasingStyle.Linear);
					local Tween = Variables.TweenService:Create(Variables.LocalPlayer.Character.HumanoidRootPart, TW, { CFrame = StringtoCFrame(v) });
					Tween:Play()
					Tween.Completed:Wait()

					local Bool = CalculatePlayerDistance(); if Bool then return end
				end
			end
			
			if Toggles.AutoRejoin.Value then
				Teleport()
			end
			
			Library:Notify("Done")
		end;
		
		["giveLannis"] = function()
			local f = Instance.new("Tool")
			f.Name = "Lannis's Amulet"
			f.GripPos = Vector3.new(-0.05,1.3,0)
			f.GripRight = Vector3.new(0,0,1)
			f.GripForward = Vector3.new(1,0,0)
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			for i = 1,19 do
				local t = Instance.new("Part")
				t.BrickColor = BrickColor.new("Really black")
				t.Material = "SmoothPlastic"
				if i == 1 then
					t.Name = "Handle"
					t.Shape = "Cylinder"
					t.CFrame = Trinkets.posList2[i]
				elseif i == 8 then
					t.Shape = "Cylinder"
					t.Color = Color3.fromRGB(127, 43, 166)
					t.Material = Enum.Material.Neon
				else
					t.Name = "otherPart"
				end
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				if f:FindFirstChild("Handle") ~= nil then
					t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList2[i]
				end
				t.Size = Trinkets.sizeList2[i]
				t.Parent = f
				local weld = Instance.new("Weld")
				weld.Part0 = f:FindFirstChild("Handle")
				weld.Part1 = t
				weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
				weld.C1 = t.CFrame:inverse()
				weld.Parent = f:FindFirstChild("Handle")
			end
		end;
		
		["GiveFF"] = function()
			local f = Instance.new("Tool")
			f.Name = "Night Stone"
			f.GripPos = Vector3.new(0,0.2,0)
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			for i = 1,7 do
				local t = Instance.new("Part")
				if i == 2 then
					t.Name = "otherPart"
					local pl = Instance.new("PointLight")
					pl.Parent = t
					pl.Brightness = 9
					pl.Color = Color3.fromRGB(97, 45, 118)
					pl.Enabled = true
					pl.Range = 4
					pl.Shadows = false
				elseif i == 1 then
					t.Name = "Handle"
					t.CFrame = Trinkets.posList[i]
				else
					t.Name = "otherPart"
				end
				t.BrickColor = BrickColor.new("Really black")
				t.Material = "SmoothPlastic"
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				if f:FindFirstChild("Handle") ~= nil then
					t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList[i]
				end
				t.Size = Trinkets.sizeList[i]
				t.Parent = f

				local weld = Instance.new("Weld")
				weld.Part0 = f:FindFirstChild("Handle")
				weld.Part1 = t
				weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
				weld.C1 = t.CFrame:inverse()
				weld.Parent = f:FindFirstChild("Handle")
			end
		end;
		
		["GiveNS"] = function()
			local f = Instance.new("Tool")
			f.Name = "Fairfrozen"
			f.GripPos = Vector3.new(0, 0, -0.04)
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			local t = Instance.new("Part")
			t.Name = "Handle"
			t.Color = Color3.fromRGB(134, 171, 173)
			t.Material = "Neon"
			t.Anchored = false
			t.Archivable = true
			t.CanCollide = false
			t.Locked = false
			t.Massless = false
			t.Shape = "Ball"
			t.Size = Vector3.new(0.77, 0.77, 0.77)
			t.Parent = f
		end;
		
		["GivePhilo"] = function()
			local f = Instance.new("Tool")
			f.Name = "Philosopher's Stone"
			f.GripPos = Vector3.new(0,0.2,0)
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			for i = 1,7 do
				local t = Instance.new("Part")
				if i == 2 then
					t.Name = "otherPart"
					local pl = Instance.new("PointLight")
					pl.Parent = t
					pl.Brightness = 8
					pl.Color = Color3.fromRGB(197, 82, 72)
					pl.Enabled = true
					pl.Range = 4
					pl.Shadows = false
				elseif i == 1 then
					t.Name = "Handle"
					t.CFrame = Trinkets.posList[i]
				else
					t.Name = "otherPart"
				end
				t.BrickColor = BrickColor.new("Tr. Red")
				t.Material = "Neon"
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				if f:FindFirstChild("Handle") ~= nil then
					t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList[i]
				end
				t.Size = Trinkets.sizeList[i]
				t.Parent = f

				local weld = Instance.new("Weld")
				weld.Part0 = f:FindFirstChild("Handle")
				weld.Part1 = t
				weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
				weld.C1 = t.CFrame:inverse()
				weld.Parent = f:FindFirstChild("Handle")
			end
		end;
		
		["GiveRift"] = function()
			local f = Instance.new("Tool")
			f.Name = "Rift Gem"
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			local t = Instance.new("Part")
			t.Name = "Handle"
			t.BrickColor = BrickColor.new("Hot pink")
			t.Material = "Glass"
			t.Reflectance = 0.15
			t.Anchored = false
			t.Archivable = true
			t.CanCollide = false
			t.Locked = false
			t.Massless = false
			t.Shape = "Block"
			t.Size = Vector3.new(0.491, 0.491, 0.491)
			t.Parent = f

			local mesh = Instance.new("SpecialMesh")
			mesh.MeshId = "http://www.roblox.com/asset?id=160003363"
			mesh.MeshType = Enum.MeshType.FileMesh
			mesh.Name = "GemMesh"
			mesh.Scale = Vector3.new(1.508, 1.2, 1.508)
			mesh.Archivable = true
			mesh.Parent = t

			local numberKeypoints = {
				NumberSequenceKeypoint.new(0, 0.1);
				NumberSequenceKeypoint.new(0.5, 0.4);
				NumberSequenceKeypoint.new(1, 0.1);
			}

			local prtcl = Instance.new("ParticleEmitter")
			prtcl.Color = ColorSequence.new(Color3.fromRGB(255, 51, 245))
			prtcl.LightInfluence = 0
			prtcl.Texture = "rbxasset://textures/particles/sparkles_main.dds"
			prtcl.Size = NumberSequence.new(numberKeypoints)
			prtcl.Archivable = true
			prtcl.Acceleration = Vector3.new(0,0,0)
			prtcl.Lifetime = NumberRange.new(2,2)
			prtcl.Rate = 4
			prtcl.Speed = NumberRange.new(0.05,0.05)
			prtcl.SpreadAngle = Vector2.new(-360,360)
			prtcl.Parent = t
		end;
		
		["GiveWKA"] = function()
			local f = Instance.new("Tool")
			f.Name = "Amulet of the White King"
			f.GripPos = Vector3.new(-0.05,1.3,0)
			f.GripRight = Vector3.new(0,0,1)
			f.GripForward = Vector3.new(1,0,0)
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			for i = 1,19 do
				local t = Instance.new("Part")
				t.BrickColor = BrickColor.new("Medium stone grey")
				t.Material = Enum.Material.Neon
				if i == 1 then
					t.Name = "Handle"
					t.Shape = "Cylinder"
					t.CFrame = Trinkets.posList2[i]
				elseif i == 8 then
					t.Shape = "Cylinder"
					t.Color = Color3.fromRGB(165,165,165)
					t.Material = Enum.Material.Neon
				else
					t.Name = "otherPart"
				end
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				if f:FindFirstChild("Handle") ~= nil then
					t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList2[i]
				end
				t.Size = Trinkets.sizeList2[i]
				t.Parent = f

				local weld = Instance.new("Weld")
				weld.Part0 = f:FindFirstChild("Handle")
				weld.Part1 = t
				weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
				weld.C1 = t.CFrame:inverse()
				weld.Parent = f:FindFirstChild("Handle")
			end
		end;
		
		["GiveScroll"] = function()
			local f = Instance.new("Tool")
			f.Name = "Scroll of Fimbulvetr"
			f.CanBeDropped = true
			f.Parent = game.Players.LocalPlayer.Backpack

			local t = Instance.new("Part")
			t.Name = "Handle"
			t.BrickColor = BrickColor.new("Hot pink")
			t.Anchored = false
			t.Archivable = true
			t.CanCollide = false
			t.Locked = false
			t.Massless = false
			t.Size = Vector3.new(0.681, 0.311, 0.711)
			t.Parent = f

			local mesh = Instance.new("SpecialMesh")
			mesh.MeshId = "http://www.roblox.com/asset/?id=60791940"
			mesh.TextureId = "http://www.roblox.com/asset/?id=60791957"
			mesh.MeshType = Enum.MeshType.FileMesh
			mesh.Name = "ScrollMesh"
			mesh.Scale = Vector3.new(0.4, 0.4, 0.4)
			mesh.Archivable = true
			mesh.Parent = t
		end;
		
		["UpdateFlight"] = function()
			if (Variables.LocalPlayer.Character and Variables.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')) then 
				local Dir = (game.Workspace.CurrentCamera.CFrame.RightVector * (Keys.D - Keys.A) + game.Workspace.CurrentCamera.CFrame.LookVector * (Keys.W - Keys.S));
				Variables.LocalPlayer.Character.HumanoidRootPart.Velocity = (Dir * Options.FlightSpeed.Value);
			end
		end;
	}

	local InitializeFunctions = {
		["InitializeFiles"] = function()
			if not isfolder("Cronage") then
				makefolder("Cronage")
			end

			if not isfolder("Cronage/Paths") then
				makefolder("Cronage/Paths")
			end

			if not isfile("Cronage/BotLocations.txt") then
				writefile("Cronage/BotLocations.txt", "Test")
			end
			
			if not game.Workspace:FindFirstChild("Paths") then
				local Folder = Instance.new("Folder")
				Folder.Name = "Paths"
				Folder.Parent = game.Workspace
				
			end
		end;

		["InitializeFunctions"] = function()
			Bots:AddSlider('PlayerRange', {Text = 'Player Range Check', Default = 200, Min = 0, Max = 1000, Rounding = 1, Compact = false})
			Bots:AddSlider('BotSpeed', {Text = 'Bot Speed', Default = 100, Min = 10, Max = 1000, Rounding = 1, Compact = false})
			Bots:AddToggle('AutoRejoin', { Text = 'Automatically Rejoin', Default = true,})

			Pathing:AddButton("Start Bot", function()
				TableFunctions["Start Bot"]()
			end)
			Pathing:AddButton("Add Point", function()
				TableFunctions["Add Point"]()
			end)

			Pathing:AddButton("Add Wait", function()
				TableFunctions["Add Wait"]()
			end)
			Pathing:AddSlider('WaitTime', {Text = 'Wait Amount', Default = 1, Min = 1, Max = 5, Rounding = 1, Compact = false})

			Pathing:AddButton("Remove Last Point", function()
				TableFunctions["Remove Last Point"]()
			end)
			Pathing:AddButton("Preview All Points", function()
				TableFunctions["Preview All Points"]()
			end)
			Pathing:AddButton("Delete All Points", function()
				TableFunctions["Delete All Points"]()
			end)
			
			Pathing:AddButton("Save Bot", function()
				TableFunctions["Save Bot"]()
			end)

			Pathing:AddButton("Load Bot", function()
				TableFunctions["Load Bot"]()
			end)


			Pathing:AddInput('BotName', {Default = '', Numeric = false, Finished = true, Text = '', Placeholder = 'Bot Name'})
			
			LocalPlayerCharacter:AddToggle('Speed', { Text = 'Walk Speed' }):AddKeyPicker('Speed', { Text = 'Speed', Default = '*', SyncToggleState = true }):OnChanged(function()
				if Toggles.Speed.Value then
					Variables.LocalPlayer.Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
				end
			end)

			LocalPlayerCharacter:AddSlider('Walkspeed', {Text = 'Walkspeed', Default = 20, Min = 20, Max = 200, Rounding = 0, Compact = true}):OnChanged(function()
				if Toggles.Speed.Value then
					Variables.LocalPlayer.Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
				end
			end)

			LocalPlayerCharacter:AddToggle('Flight', { Text = 'Flight' }):AddKeyPicker('Flight', { Text = 'Flight', Default = 'T', SyncToggleState = true })
			LocalPlayerCharacter:AddSlider('FlightSpeed', {Text = 'Flight Speed', Default = 0, Min = 0, Max = 500, Rounding = 1, Compact = true});

			LocalPlayerCharacter:AddToggle('AnchorTorso', { Text = 'Anchor Torso' }):OnChanged(function()
				if Toggles.AnchorTorso.Value then
					Variables.LocalPlayer.Character.Torso.Anchored = true
				else
					Variables.LocalPlayer.Character.Torso.Anchored = false
				end
			end)

			LocalPlayerCharacter:AddButton('Respawn', function()
				Variables.LocalPlayer.Character.Humanoid.Health = 0
				Variables.LocalPlayer.Character:BreakJoints()
			end):AddButton('Knock', function()
				
			end)

			LocalPlayerCharacter:AddToggle('NoFall', { Text = 'No Fall' })
			LocalPlayerClient:AddToggle('ChatLogger', { Text = 'Chat Logger' }):OnChanged(function()
				if Toggles.ChatLogger.Value then
					local Chat = Variables.LocalPlayer.PlayerGui:FindFirstChild("Chat")
					Chat.Frame.ChatChannelParentFrame.Visible = true
					Chat.Frame.ChatChannelParentFrame.Size = UDim2.new(1, 0, 1, -46)
					Chat.Frame.ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, 2)
					Chat.Frame.ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -42)
				else
					local Chat = Variables.LocalPlayer.PlayerGui:FindFirstChild("Chat")
					Chat.Frame.ChatChannelParentFrame.Visible = false
				end
			end)
			
			LocalPlayerClient:AddToggle('NoKillBricks', { Text = 'No Kill Bricks' }):OnChanged(function()
				for i,v in pairs(game:GetService("Workspace").Map:GetChildren()) do
					if v.Name == "KillBrick" or v.Name == "Lava" or v.Name == "ArdorianKillbrick" or v.Name == "PitKillBrick" then
						if v:FindFirstChild("TouchInterest") then
							v:FindFirstChild("TouchInterest"):Destroy()
						end
					end
				end
			end)

			LocalPlayerClient:AddButton('Get All Passives', function()
				Instance.new("Folder", Variables.LocalPlayer.Backpack).Name = "SpearDash"
				Instance.new("Folder", Variables.LocalPlayer.Backpack).Name = "MercenaryCarry"
			end):AddButton('Fix Injuries', function()
				game:GetService("CollectionService"):RemoveTag(Variables.LocalPlayer.Character, "BrokenLeg")
				game:GetService("CollectionService"):RemoveTag(Variables.LocalPlayer.Character, "BrokenArm")
				game:GetService("CollectionService"):RemoveTag(Variables.LocalPlayer.Character, "Armless")
			end)

			LocalPlayerClient:AddButton('Server Hop', function()
				game:GetService("TeleportService"):Teleport(5208655184, Variables.LocalPlayer)
			end)
			
			
			FakeItemSpawning:AddButton('Spawn Fake Lannis Amulet', function()
				local f = Instance.new("Tool")
				f.Name = "Lannis's Amulet"
				f.GripPos = Vector3.new(-0.05,1.3,0)
				f.GripRight = Vector3.new(0,0,1)
				f.GripForward = Vector3.new(1,0,0)
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				for i = 1,19 do
					local t = Instance.new("Part")
					t.BrickColor = BrickColor.new("Really black")
					t.Material = "SmoothPlastic"
					if i == 1 then
						t.Name = "Handle"
						t.Shape = "Cylinder"
						t.CFrame = Trinkets.posList2[i]
					elseif i == 8 then
						t.Shape = "Cylinder"
						t.Color = Color3.fromRGB(127, 43, 166)
						t.Material = Enum.Material.Neon
					else
						t.Name = "otherPart"
					end
					t.Anchored = false
					t.Archivable = true
					t.CanCollide = false
					t.Locked = false
					t.Massless = false
					if f:FindFirstChild("Handle") ~= nil then
						t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList2[i]
					end
					t.Size = Trinkets.sizeList2[i]
					t.Parent = f
					local weld = Instance.new("Weld")
					weld.Part0 = f:FindFirstChild("Handle")
					weld.Part1 = t
					weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
					weld.C1 = t.CFrame:inverse()
					weld.Parent = f:FindFirstChild("Handle")
				end
			end)
			FakeItemSpawning:AddButton('Spawn Fake Nightstone', function()
				local f = Instance.new("Tool")
				f.Name = "Night Stone"
				f.GripPos = Vector3.new(0,0.2,0)
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				for i = 1,7 do
					local t = Instance.new("Part")
					if i == 2 then
						t.Name = "otherPart"
						local pl = Instance.new("PointLight")
						pl.Parent = t
						pl.Brightness = 9
						pl.Color = Color3.fromRGB(97, 45, 118)
						pl.Enabled = true
						pl.Range = 4
						pl.Shadows = false
					elseif i == 1 then
						t.Name = "Handle"
						t.CFrame = Trinkets.posList[i]
					else
						t.Name = "otherPart"
					end
					t.BrickColor = BrickColor.new("Really black")
					t.Material = "SmoothPlastic"
					t.Anchored = false
					t.Archivable = true
					t.CanCollide = false
					t.Locked = false
					t.Massless = false
					if f:FindFirstChild("Handle") ~= nil then
						t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList[i]
					end
					t.Size = Trinkets.sizeList[i]
					t.Parent = f

					local weld = Instance.new("Weld")
					weld.Part0 = f:FindFirstChild("Handle")
					weld.Part1 = t
					weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
					weld.C1 = t.CFrame:inverse()
					weld.Parent = f:FindFirstChild("Handle")
				end
			end)
			FakeItemSpawning:AddButton('Spawn Fake FairFrozen', function()
				local f = Instance.new("Tool")
				f.Name = "Fairfrozen"
				f.GripPos = Vector3.new(0, 0, -0.04)
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				local t = Instance.new("Part")
				t.Name = "Handle"
				t.Color = Color3.fromRGB(134, 171, 173)
				t.Material = "Neon"
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				t.Shape = "Ball"
				t.Size = Vector3.new(0.77, 0.77, 0.77)
				t.Parent = f
			end)
			FakeItemSpawning:AddButton("Spawn Fake Philosopher's Stone", function()
				local f = Instance.new("Tool")
				f.Name = "Philosopher's Stone"
				f.GripPos = Vector3.new(0,0.2,0)
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				for i = 1,7 do
					local t = Instance.new("Part")
					if i == 2 then
						t.Name = "otherPart"
						local pl = Instance.new("PointLight")
						pl.Parent = t
						pl.Brightness = 8
						pl.Color = Color3.fromRGB(197, 82, 72)
						pl.Enabled = true
						pl.Range = 4
						pl.Shadows = false
					elseif i == 1 then
						t.Name = "Handle"
						t.CFrame = Trinkets.posList[i]
					else
						t.Name = "otherPart"
					end
					t.BrickColor = BrickColor.new("Tr. Red")
					t.Material = "Neon"
					t.Anchored = false
					t.Archivable = true
					t.CanCollide = false
					t.Locked = false
					t.Massless = false
					if f:FindFirstChild("Handle") ~= nil then
						t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList[i]
					end
					t.Size = Trinkets.sizeList[i]
					t.Parent = f

					local weld = Instance.new("Weld")
					weld.Part0 = f:FindFirstChild("Handle")
					weld.Part1 = t
					weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
					weld.C1 = t.CFrame:inverse()
					weld.Parent = f:FindFirstChild("Handle")
				end
			end)
			FakeItemSpawning:AddButton('Spawn Fake Rift Gem', function()
				local f = Instance.new("Tool")
				f.Name = "Rift Gem"
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				local t = Instance.new("Part")
				t.Name = "Handle"
				t.BrickColor = BrickColor.new("Hot pink")
				t.Material = "Glass"
				t.Reflectance = 0.15
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				t.Shape = "Block"
				t.Size = Vector3.new(0.491, 0.491, 0.491)
				t.Parent = f

				local mesh = Instance.new("SpecialMesh")
				mesh.MeshId = "http://www.roblox.com/asset?id=160003363"
				mesh.MeshType = Enum.MeshType.FileMesh
				mesh.Name = "GemMesh"
				mesh.Scale = Vector3.new(1.508, 1.2, 1.508)
				mesh.Archivable = true
				mesh.Parent = t

				local numberKeypoints = {
					NumberSequenceKeypoint.new(0, 0.1);
					NumberSequenceKeypoint.new(0.5, 0.4);
					NumberSequenceKeypoint.new(1, 0.1);
				}

				local prtcl = Instance.new("ParticleEmitter")
				prtcl.Color = ColorSequence.new(Color3.fromRGB(255, 51, 245))
				prtcl.LightInfluence = 0
				prtcl.Texture = "rbxasset://textures/particles/sparkles_main.dds"
				prtcl.Size = NumberSequence.new(numberKeypoints)
				prtcl.Archivable = true
				prtcl.Acceleration = Vector3.new(0,0,0)
				prtcl.Lifetime = NumberRange.new(2,2)
				prtcl.Rate = 4
				prtcl.Speed = NumberRange.new(0.05,0.05)
				prtcl.SpreadAngle = Vector2.new(-360,360)
				prtcl.Parent = t
			end)
			FakeItemSpawning:AddButton('Spawn Fake White Kings Amulet', function()
				local f = Instance.new("Tool")
				f.Name = "Amulet of the White King"
				f.GripPos = Vector3.new(-0.05,1.3,0)
				f.GripRight = Vector3.new(0,0,1)
				f.GripForward = Vector3.new(1,0,0)
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				for i = 1,19 do
					local t = Instance.new("Part")
					t.BrickColor = BrickColor.new("Medium stone grey")
					t.Material = Enum.Material.Neon
					if i == 1 then
						t.Name = "Handle"
						t.Shape = "Cylinder"
						t.CFrame = Trinkets.posList2[i]
					elseif i == 8 then
						t.Shape = "Cylinder"
						t.Color = Color3.fromRGB(165,165,165)
						t.Material = Enum.Material.Neon
					else
						t.Name = "otherPart"
					end
					t.Anchored = false
					t.Archivable = true
					t.CanCollide = false
					t.Locked = false
					t.Massless = false
					if f:FindFirstChild("Handle") ~= nil then
						t.CFrame = CFrame.new(f:FindFirstChild("Handle").Position) * Trinkets.posList2[i]
					end
					t.Size = Trinkets.sizeList2[i]
					t.Parent = f

					local weld = Instance.new("Weld")
					weld.Part0 = f:FindFirstChild("Handle")
					weld.Part1 = t
					weld.C0 = f:FindFirstChild("Handle").CFrame:inverse()
					weld.C1 = t.CFrame:inverse()
					weld.Parent = f:FindFirstChild("Handle")
				end
			end)
			FakeItemSpawning:AddButton('Spawn Fake Scroll', function()
				local f = Instance.new("Tool")
				f.Name = Options.FakeScrollName.Value
				f.CanBeDropped = true
				f.Parent = game.Players.LocalPlayer.Backpack

				local t = Instance.new("Part")
				t.Name = "Handle"
				t.BrickColor = BrickColor.new("Hot pink")
				t.Anchored = false
				t.Archivable = true
				t.CanCollide = false
				t.Locked = false
				t.Massless = false
				t.Size = Vector3.new(0.681, 0.311, 0.711)
				t.Parent = f

				local mesh = Instance.new("SpecialMesh")
				mesh.MeshId = "http://www.roblox.com/asset/?id=60791940"
				mesh.TextureId = "http://www.roblox.com/asset/?id=60791957"
				mesh.MeshType = Enum.MeshType.FileMesh
				mesh.Name = "ScrollMesh"
				mesh.Scale = Vector3.new(0.4, 0.4, 0.4)
				mesh.Archivable = true
				mesh.Parent = t
			end)
			FakeItemSpawning:AddInput('FakeScrollName', {Default = '', Numeric = false, Finished = true, Text = 'Scroll Name', Placeholder = 'Type the name of the Fake Scroll!'})
			
			FakeItemSpawning:AddButton('Spawn Fake Bag', function()
				local dupeItemBag = Instance.new("Part")
				dupeItemBag.Name = "FakeArtifactItem"
				dupeItemBag.Orientation = Vector3.new(0, -0.04, 0)
				dupeItemBag.Anchored = false
				dupeItemBag.CanCollide = true
				dupeItemBag.Transparency = 1
				dupeItemBag.Size = Vector3.new(1, 0.81, 1)

				local mesh = Instance.new("SpecialMesh")
				mesh.MeshId = "http://www.roblox.com/asset/?id=16657069"
				mesh.MeshType = Enum.MeshType.FileMesh
				mesh.Scale = Vector3.new(0.25, 0.3, 0.25)
				mesh.Parent = dupeItemBag

				local dec = Instance.new("Decal")
				dec.Color3 = Color3.fromRGB(148, 148, 148)
				dec.Texture = "rbxassetid://4904930640"
				dec.Parent = dupeItemBag
				spawn(function()
					dec.Transparency = 0.5
					wait(4.3)
					dec.Transparency = 0
				end)
				spawn(function()
					local dGui = game.Players.LocalPlayer.PlayerGui.DangerGui
					dGui.TextLabel.Text = "IN DANGER\nYour life is at risk!"
					dGui.TextLabel.Visible = true
					for i = 1,50 do
						if game.Players.LocalPlayer.Character ~= nil then
							wait(0.1)
							dGui.TextLabel.Visible = true
							dGui.TextLabel.Text = "IN DANGER\nYour life is at risk!"
						end
					end
					dGui.TextLabel.Visible = false
				end)

				local bbgui = Instance.new("BillboardGui")
				bbgui.AlwaysOnTop = false
				bbgui.ExtentsOffsetWorldSpace = Vector3.new(0,5,0)
				bbgui.LightInfluence = 0
				bbgui.MaxDistance = 50
				bbgui.Size = UDim2.new(2, 0,1.8, 0)
				bbgui.Parent = dupeItemBag

				local frame = Instance.new("Frame")
				frame.BackgroundTransparency = 1
				frame.Size = UDim2.new(1,0,1,0)
				frame.Visible = true
				frame.Parent = bbgui

				local textbox = Instance.new("TextBox")
				textbox.BackgroundTransparency = 1
				textbox.Size = UDim2.new(1,0,1,0)
				textbox.Font = Enum.Font.Arial
				textbox.Text = Options.FakeBagName.Value
				textbox.TextColor3 = Color3.fromRGB(255, 254, 244)
				textbox.TextScaled = true
				textbox.TextSize = 35
				textbox.TextStrokeColor3 = Color3.fromRGB(56, 56, 31)
				textbox.TextStrokeTransparency = 0
				textbox.TextWrapped = true
				textbox.Parent = frame

				dupeItemBag.Parent = workspace.Thrown
				local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
				dupeItemBag.CFrame = hrp.CFrame*CFrame.new(2.5,-3,-5.5)
				spawn(function()
					dupeItemBag.Touched:Connect(function(part)
						if part.Parent:FindFirstChild("Humanoid") and dupeItemBag:FindFirstChild("Decal").Transparency == 0 then
							dupeItemBag:Destroy()
							if Options.FakeBagName.Value == "Scroll of Fimbulvetr" then
								TableFunctions.GiveScroll()
							elseif Options.FakeBagName.Value == "Amulet of the White King" then
								TableFunctions.GiveWKA()
							elseif Options.FakeBagName.Value == "Rift Gem" then
								TableFunctions.GiveRift()
							elseif Options.FakeBagName.Value == "Philosopher's Stone" then
								TableFunctions.GivePhilo()
							elseif Options.FakeBagName.Value == "Night Stone" then
								TableFunctions.GiveNS()
							elseif Options.FakeBagName.Value == "Lannis's Amulet" then
								TableFunctions.giveLannis()
							elseif Options.FakeBagName.Value == "Fairfrozen" then
								TableFunctions.GiveFF()
							end
						end
					end)
				end)
			end)
			
			FakeItemSpawning:AddInput('FakeBagName', {Default = '', Numeric = false, Finished = true, Text = 'Bag Name', Placeholder = 'Type the name of the Fake Bag!'})
			
			

			game:GetService("UserInputService").InputBegan:Connect(function(inp)
				if (inp.KeyCode == Enum.KeyCode.W) then 
					Keys.W = 1;
				end;
				if (inp.KeyCode == Enum.KeyCode.A) then 
					Keys.A = 1;
				end;
				if (inp.KeyCode == Enum.KeyCode.S) then 
					Keys.S = 1;
				end;
				if (inp.KeyCode == Enum.KeyCode.D) then 
					Keys.D = 1;
				end;
			end)

			game:GetService("UserInputService").InputEnded:Connect(function(inp)
				if (inp.KeyCode == Enum.KeyCode.W) then 
					Keys.W = 0;
				end;
				if (inp.KeyCode == Enum.KeyCode.A) then 
					Keys.A = 0;
				end;
				if (inp.KeyCode == Enum.KeyCode.S) then 
					Keys.S = 0;
				end;
				if (inp.KeyCode == Enum.KeyCode.D) then 
					Keys.D = 0;
				end;
			end)
		end;

		["InitializeBypasses"] = function()
			for i, v in next, getconnections(game:GetService("ScriptContext").Error) do
				v:Disable();    
			end;

			-------------------- Remote Event Detection --------------------
			local requiredRemote = ""
			local enabled = {
				RemoteEvent = true,
			}

			local metatable = assert(getrawmetatable, "needs access to function 'getrawmetatable'")(game)
			if setreadonly then
				setreadonly(metatable, false)
			end

			local function CountTable(t)
				local count, key = 0
				repeat
					key = next(t, key)
					if key ~= nil then
						count = count + 1
					end
				until key == nil
				return count
			end

			local PrintTable
			local function ParseObject(object, spacing, scope, checkedTables)
				local objectType = type(object)
				if objectType == "string" then
					return spacing .. string.format("%q", object)
				elseif objectType == "nil" then
					return spacing .. "nil"
				elseif objectType == "table" then
					if checkedTables[object] then
						return spacing .. tostring(object) .. " [recursive table]"
					else
						checkedTables[object] = true
						return spacing .. PrintTable(object, scope + 1, checkedTables)
					end
				else
					return spacing .. tostring(object)
				end
			end
			function PrintTable(t, scope, checkedTables)
				checkedTables = checkedTables or {}
				scope = scope or 1
				local result = (checkedTables and "{" or "") .. "\n"
				local spacing = string.rep("\t", scope)
				local function parse(index, value)
					result = result .. ParseObject(index, spacing, scope, checkedTables) .. " : " .. ParseObject(value, "", scope, checkedTables) .. "\n"
				end
				if CountTable(t) ~= #t then
					table.foreach(t, parse)
				else
					for index = 1, select("#", unpack(t)) do
						parse(index, t[index])
					end
				end
				return result .. string.sub(spacing, 1, #spacing - 1) .. (checkedTables and "}" or "")
			end

			local methods = {
				RemoteEvent = "FireServer",
			}

			local __namecall = __namecall or metatable.__namecall
			local __index = __index or metatable.__index
			if getgenv then
				if removeSpy then
					removeSpy()
				end
				getgenv().__namecall = __namecall
				getgenv().__index = __index
				getgenv().removeSpy = function()
					getgenv().removeSpy = nil
					metatable.__namecall = __namecall
					metatable.__index = __index
				end
			end

			local function RemoteCallback(self, ...)
				if typeof(self) ~= "Instance" then
					return error(select(2, pcall(__index, self)))
				end
				local arguments = {...}
				local result = {methods[self.ClassName](self, ...)}
				local callerScript = rawget(getfenv(0), "script")
				callerScript = typeof(callerScript) == "Instance" and callerScript or nil
				local requiredString = string.sub(string.format("Path: %s",(not self.Parent and "[NIL]: " or "") .. self:GetFullName()), 34)
				if string.len(requiredString) == 36 and string.sub(requiredString,9,9) == "-" then
					for q,r in pairs(game.Workspace:GetChildren()) do
						if r.ClassName == "Folder" and r.Name == "NPCs" then
							for g,h in pairs(r:GetChildren()) do
								if h.Name == "Monk" then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - h.Head.Position).Magnitude <= 13 then
										if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed == 0 then
											requiredRemote = requiredString
										end
									end
								end
							end
						end
					end
				end
				return unpack(result)
			end
			RemoteCallback = newcclosure(RemoteCallback)
			methods.RemoteEvent = hookfunc(Instance.new("RemoteEvent").FireServer, RemoteCallback)

			local function IsAuthorized(self, index)
				return (index == "Fire" or index == "Invoke" or index == "FireServer" or index == "InvokeServer") and (enabled[self.ClassName])
			end

			function metatable:__namecall(...)
				local arguments = {...}
				local index = table.remove(arguments)
				if IsAuthorized(self, index) then
					return RemoteCallback(self, unpack(arguments))
				end
				return __namecall(self, ...)
			end
			metatable.__namecall = newcclosure(metatable.__namecall)
			
			local oldnewindex; oldnewindex = hookmetamethod(game, "__newindex", function(t,k,v)
				if t == Variables.LocalPlayer.Character.Humanoid and k == "WalkSpeed" and not checkcaller() then
					if v == 16 or v == 0 then
						return
					end
				end

				return oldnewindex(t,k,v)
			end)
			
			local oldfire; oldfire = hookfunction(Instance.new'RemoteEvent'.FireServer, function(self, ...)
				local args = {...}

				if self.Name == "ApplyFallDamage" and Toggles.NoFall.Value then 
					return wait(9e9)
				end

				return oldfire(self, unpack(args))
			end)
		end;
	}
	
	Variables.RunService.Stepped:Connect(function()
		if Toggles then
			if (Toggles.Flight.Value and Variables.LocalPlayer.Character and Variables.LocalPlayer.Character:FindFirstChild('Torso') and Variables.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')) then 
				TableFunctions.UpdateFlight();
			end;
			
		end
	end)
	
	local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/ThemeManager.lua'))();
	local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/SaveManager.lua'))();

	InitializeFunctions["InitializeFiles"]()
	InitializeFunctions["InitializeFunctions"]()
	InitializeFunctions["InitializeBypasses"]()
	Library:SetWatermarkVisibility(true)
	Library:OnUnload(function()
		Library.Unloaded = true
	end)

	local MenuGroup = Tabs['Settings']:AddRightGroupbox('Menu')
	MenuGroup:AddButton('Unload', function() Library:Unload() end)

	local ThemeGroup = Tabs['Settings']:AddLeftGroupbox('Theme')
	ThemeManager:SetLibrary(Library)
	ThemeManager:CreateThemeManager(ThemeGroup)

	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings() 
	SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
	SaveManager:BuildConfigSection(Tabs['Settings']) 
	SaveManager:LoadAutoloadConfig()
end)

Cronage.Load(Library)
