local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local UIlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/55zay16/Dexion/refs/heads/main/UIlib.lua"))()

Values = {
    ["killaura"] = false,
    ["tpaura"] = false,

    ["uninject"] = false,
    ["speed"] = false,

    ["esp"] = false,
    ["nametags"] = false,
    ["tracers"] = false,
}

local CombatWarriors = UIlib:Init("Combat Warriors")

local CombatTab = UIlib:AddTab(CombatWarriors,"Combat",0.092,0,0.106,0) 
local MovementTab = UIlib:AddTab(CombatWarriors,"Movement",0.092 + 0.167,0,0.106,0)
local VisualsTab = UIlib:AddTab(CombatWarriors,"Visuals",0.092 + (0.167 * 2),0,0.106,0)
local UtilitysTab = UIlib:AddTab(CombatWarriors,"Utility",0.092 + (0.167 * 3),0,0.106,0)

UIlib:AddButton(CombatTab,"Kill Aura",function()
    Values["killaura"] = not Values["killaura"]
end)

UIlib:AddButton(CombatTab,"Teleport Aura",function()
    Values["tpaura"] = not Values["tpaura"]
end)


UIlib:AddButton(MovementTab,"Speed",function()
    Values["speed"] = not Values["speed"]
end)

UIlib:AddButton(UtilitysTab,"Uninject",function()
    Values["uninject"] = not Values["uninject"]
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

local CombatThread = coroutine.create(function()
    local MaxDistance = 50

    while Running do

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
                

                if Values["killaura"] == true and Target.Character.Humanoid.Health > 0 then
                    task.wait(0.05)
                    -- look at target

                    local targetPosition = Target.Character.HumanoidRootPart.Position 
                    local characterPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position 
                    local directionToTarget = (targetPosition - characterPosition).Unit 
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(characterPosition, targetPosition) 
                    if CombatWarriors.Enabled == false then    
                        mouse1click()
                    end
                end

                if Values["tpaura"] == true and TempDisableAura == false and Target.Character.Humanoid.Health > 0 and game.Players.LocalPlayer.Character.Humanoid.Health < 40 then
                    task.wait(0.05)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame - (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 2.5)
                    
                    if CombatWarriors.Enabled == false then
                        mouse1click()
                    end
                end
            end)
        end)
    end
end)


local MovementThread = coroutine.create(function()
    while Running do
        pcall(function()
            task.wait()
            if Values["speed"] == true then
                local moveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                local velocity = Vector3.new(moveDirection.X, moveDirection.Y, moveDirection.Z) * 2
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += velocity
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
            end)
        end)
    end
end)

local UtilitysThread = coroutine.create(function()
    while Running do
        task.wait()
    end
end)


coroutine.resume(CombatThread)
coroutine.resume(MovementThread)
coroutine.resume(MainThread)
coroutine.resume(VisualsThread)
coroutine.resume(UtilitysThread)
