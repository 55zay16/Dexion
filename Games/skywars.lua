local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local UIlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/55zay16/Dexion/refs/heads/main/UIlib.lua"))()

Values = {
    ["killaura"] = false,
    ["tpaura"] = false,
    ["anti die"] = false,
    ["autofarm"] = false,

    ["uninject"] = false,
    ["infinitejump"] = false,
    ["no gravity"] = false,
    ["eggtp"] = false,
    ["speed"] = false,
    ["flight"] = false,

    ["esp"] = false,
    ["nametags"] = false,
    ["tracers"] = false,
    ["eggesp"] = false,
    ["itemsteal"] = false,

    ["anti void"] = false,
}

local Skywars = UIlib:Init("Skywars")

local CombatTab = UIlib:AddTab(Skywars,"Combat",0.092,0,0.106,0) 
local MovementTab = UIlib:AddTab(Skywars,"Movement",0.092 + 0.167,0,0.106,0)
local VisualsTab = UIlib:AddTab(Skywars,"Visuals",0.092 + (0.167 * 2),0,0.106,0)
local UtilitysTab = UIlib:AddTab(Skywars,"Utility",0.092 + (0.167 * 3),0,0.106,0)

UIlib:AddButton(UtilitysTab,"Anti Void",function()
    Values["anti void"] = not Values["anti void"]

    pcall(function()
        if Values["anti void"] == true then  
            if not game.Workspace:FindFirstChild("AntiVoid") then 
                local AntiVoidPart = Instance.new("Part")

                AntiVoidPart.Parent = game.Workspace
                AntiVoidPart.Name = "AntiVoid"
                AntiVoidPart.Transparency = 0.5
                AntiVoidPart.CanCollide = true
                AntiVoidPart.Size = Vector3.new(1000, 1, 1000)
                AntiVoidPart.Anchored = true
                AntiVoidPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-20,0) 

                AntiVoidPart.Touched:Connect(function(hit)
                    if hit.Parent.Name == game.Players.LocalPlayer.Name then
                        hit.Parent.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
                    end
                end)
            end
        else
            if game.Workspace:FindFirstChild("AntiVoid") then
                game.Workspace.AntiVoid:Destroy()
            end
        end
    end)
end)

UIlib:AddButton(CombatTab,"Kill Aura",function()
    Values["killaura"] = not Values["killaura"]
end)

UIlib:AddButton(CombatTab,"Teleport Aura",function()
    Values["tpaura"] = not Values["tpaura"]
end)

UIlib:AddButton(CombatTab,"Anti Die",function()
    Values["anti die"] = not Values["anti die"]
end)

UIlib:AddButton(CombatTab,"Auto Farm",function()
    Values["autofarm"] = not Values["autofarm"]
end)

UIlib:AddButton(VisualsTab,"Egg ESP",function()
    Values["eggesp"] = not Values["eggesp"]
end)

local TempY = 0
UIlib:AddButton(MovementTab,"Flight",function()
    Values["flight"] = not Values["flight"]

    TempY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
end)

UIlib:AddButton(UtilitysTab,"No Gravity",function()
    Values["no gravity"] = not Values["no gravity"]
end)

UIlib:AddButton(MovementTab,"Egg TP",function()
    Values["eggtp"] = not Values["eggtp"]
end)

UIlib:AddButton(MovementTab,"Speed",function()
    Values["speed"] = not Values["speed"]
end)

UIlib:AddButton(UtilitysTab,"Uninject",function()
    Values["uninject"] = not Values["uninject"]
end)

UIlib:AddButton(MovementTab,"Infinite Jump",function()
    Values["infinitejump"] = not Values["infinitejump"]
end)

UIlib:AddButton(VisualsTab,"ESP",function()
    Values["esp"] = not Values["esp"]
end)

UIlib:AddButton(VisualsTab,"Nametags",function()
    Values["nametags"] = not Values["nametags"]
end)

UIlib:AddButton(VisualsTab,"Tracers",function()
    Values["tracers"] = not Values["tracers"]
end)

local Running = true

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space and Values["infinitejump"] == true then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)





local MainThread = coroutine.create(function()
    while Running do
        task.wait()

        if Values["uninject"] == true then
            Skywars:Destroy()
            for _,i in pairs(Values) do
                i = false
            end
            Running = false
        end
    end
end)

local TempDisableAura = false
local framecount = 0
local framecount2 = 0

local CombatThread = coroutine.create(function()
    local MaxDistance = 50

    while Running do

        framecount = framecount + 1
        pcall(function()
            task.wait()

            local Distance = math.huge
            local Target = nil
        
            pcall(function()
                for _, i in pairs(game.Players:GetPlayers()) do
                    if i.Name ~= game.Players.LocalPlayer.Name then
                        local DistanceToPlayer = (i.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        if DistanceToPlayer < Distance and DistanceToPlayer <= MaxDistance then

                            Distance = DistanceToPlayer
                            Target = i
                            
                        end
                    end
                end
            end)


            pcall(function()
                
                if Values["autofarm"] == true then  -- teleport to random player that isent a teammate and set them as the target
                    local RandomPlayer = game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RandomPlayer.Character.HumanoidRootPart.CFrame
                    
                    if framecount > 30 then
                        framecount = 0
                        Target = RandomPlayer
                    end
                end

                if Values["killaura"] == true and Target.Character.Humanoid.Health > 0 then
                    task.wait(0.05)
                    -- look at target

                    local targetPosition = Target.Character.HumanoidRootPart.Position 
                    local characterPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position 
                    local directionToTarget = (targetPosition - characterPosition).Unit 
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(characterPosition, targetPosition) 
                    if Skywars.Enabled == false then    
                        mouse1click()
                    end
                end

                if Values["tpaura"] == true and TempDisableAura == false and Target.Character.Humanoid.Health > 0 then
                    task.wait(0.05)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame - (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 2.5)
                    
                    if Skywars.Enabled == false then
                        mouse1click()
                    end
                end

                if Values["anti die"] == true and Values["tpaura"] == true and game.Players.LocalPlayer.Character.Humanoid.Health <= 40 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0,MaxDistance * 1.3,0)
                    game.Workspace.Gravity = 0
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

                    TempDisableAura = true
                else
                    if Values["anti die"] == true and Values["tpaura"] == true and game.Players.LocalPlayer.Character.Humanoid.Health > 60 then
                        TempDisableAura = false
                        if Values["flight"] == false then
                            game.Workspace.Gravity = 196.2
                        end
                    elseif Values["tpaura"] == true and Values["anti die"] == true and game.Players.LocalPlayer.Character.Humanoid.Health <= 60 then
                        game.Workspace.Gravity = 0
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0,MaxDistance * 1.5,0)
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space and Values["flight"] == true then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        TempY += 10
    end
    if input.KeyCode == Enum.KeyCode.LeftShift and Values["flight"] == true then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        TempY -= 10
    end
end)

local MovementThread = coroutine.create(function()
    while Running do
        pcall(function()
            task.wait()
            framecount2 = framecount2 + 1

            if Values["no gravity"] == true then
                game.Workspace.Gravity = 0
            else
                game.Workspace.Gravity = 196.2
            end

            if Values["speed"] == true then
                local moveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                local velocity = Vector3.new(moveDirection.X, moveDirection.Y, moveDirection.Z) * 2
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += velocity
            end

            if Values["flight"] == true then
                local moveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                local velocity = Vector3.new(moveDirection.X, 0, moveDirection.Z) * 2
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += velocity

                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                TempY, 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
            end

            if Values["eggtp"] == true then -- teleport to random egg
                if framecount2 > 1000 then
                    local RandomEgg = game.Workspace.Eggs:GetChildren()[math.random(1,#game.Workspace.Eggs:GetChildren())]
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RandomEgg.RootPart.CFrame
                end
            end
        end)
    end
end)

local VisualsThread = coroutine.create(function()
    while Running do
        pcall(function()
            task.wait()
            pcall(function()
                if Values["esp"] then
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("Highlight") then else
                            if i == game.Players.LocalPlayer then continue end

                            local highlight = Instance.new("Highlight")
                            highlight.Parent = i.Character
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                            highlight.FillTransparency = 0.5
                            highlight.Name = "Highlight"
                        end
                    end
                else
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("Highlight") then
                            i.Character.Highlight:Destroy()
                        end
                    end
                end

                if Values["nametags"] then
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("NameTag") then else
                            if i == game.Players.LocalPlayer then continue end

                            local nametag = Instance.new("BillboardGui")
                            nametag.Name = "NameTag"
                            nametag.Parent = i.Character
                            nametag.Adornee = i.Character.Head
                            nametag.Size = UDim2.new(0, 50, 0, 50)
                            nametag.StudsOffset = Vector3.new(0, 2, 0)
                            nametag.AlwaysOnTop = true
                            nametag.Enabled = true

                            local nametext = Instance.new("TextLabel")
                            nametext.Parent = nametag
                            nametext.Size = UDim2.new(1, 0, 1, 0)    
                            nametext.BackgroundTransparency = 1
                            nametext.Text = i.Name
                            nametext.TextColor3 = Color3.fromRGB(255, 255, 255)
                            nametext.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            nametext.TextStrokeTransparency = 0
                            nametext.TextScaled = true
                            nametext.TextWrapped = true
                        end
                    end
                else
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("NameTag") then
                            i.Character.NameTag:Destroy()
                        end
                    end
                end

                if Values["tracers"] then
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("Tracer") then else
                            if i == game.Players.LocalPlayer then continue end

                            local Tracer = Instance.new("Beam")
                            Tracer.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
                            Tracer.Parent = i.Character
                            Tracer.Name = "Tracer"
                            Tracer.Width0 = 0.5
                            Tracer.Width1 = 0.5
                            Tracer.Attachment0 = i.Character.HumanoidRootPart.RootAttachment
                            Tracer.Attachment1 = game.Players.LocalPlayer.Character.HumanoidRootPart.RootAttachment
                        end
                    end
                else
                    for _, i in pairs(game.Players:GetPlayers()) do
                        if i.Character:FindFirstChild("Tracer") then
                            i.Character.Tracer:Destroy()
                        end
                    end
                end

                if Values["eggesp"] then
                    for _, i in pairs(game.Workspace.Eggs:GetChildren()) do
                        if i.Name == "Egg" then
                            if i:FindFirstChild("Highlight") then else
                                local highlight = Instance.new("Highlight")
                                highlight.Parent = i
                                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                                highlight.FillTransparency = 0.5
                                highlight.Name = "Highlight"
                            end
                        end
                    end
                else
                    for _, i in pairs(game.Workspace.Eggs:GetChildren()) do
                        if i.Name == "Egg" then
                            if i:FindFirstChild("Highlight") then
                                i.Highlight:Destroy()
                            end
                        end
                    end
                end
            end)
        end)
    end
end)

local UtilitysThread = coroutine.create(function()
    while Running do
        task.wait()

        if Values["no gravity"] == true then
            game.Workspace.Gravity = 0
        else
            game.Workspace.Gravity = 196.2
        end
    end
end)


coroutine.resume(CombatThread)
coroutine.resume(MovementThread)
coroutine.resume(MainThread)
coroutine.resume(VisualsThread)
coroutine.resume(UtilitysThread)
