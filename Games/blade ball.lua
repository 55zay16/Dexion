local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local UIlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/55zay16/Dexion/refs/heads/main/UIlib.lua"))()

Values = {
    ["ballaura"] = false,
    ["balltp"] = false,
    ["targetaura"] = false,

    ["speed"] = false,
    ["flight"] = false,
    ["infinitejump"] = false,

    ["uninject"] = false,
}

local BladeBall = UIlib:Init("Blade_Ball")
local PopupSystem = UIlib:InitPopupSystem(BladeBall)

local CombatTab = UIlib:AddTab(BladeBall,"Combat",0.092,0,0.106,0) 
local MovementTab = UIlib:AddTab(BladeBall,"Movement",0.092 + 0.167,0,0.106,0)
local UtilitysTab = UIlib:AddTab(BladeBall,"Utility",0.092 + (0.167 * 2),0,0.106,0)

UIlib:AddButton(CombatTab,"Ball Aura",function() 
    Values["ballaura"] = not Values["ballaura"]
end)

UIlib:AddButton(CombatTab,"Ball Teleport",function()
    Values["balltp"] = not Values["balltp"]
end)

UIlib:AddButton(CombatTab,"Target Aura",function()
    Values["targetaura"] = not Values["targetaura"]
end)


UIlib:AddButton(MovementTab,"Speed",function()
    Values["speed"] = not Values["speed"]
end)

local TempY = 0

UIlib:AddButton(MovementTab,"Flight",function()
    Values["flight"] = not Values["flight"]

    TempY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
end)

UIlib:AddButton(MovementTab,"Infinite Jump",function()
    Values["infinitejump"] = not Values["infinitejump"]
end)

UIlib:AddButton(UtilitysTab,"Uninject",function()
    Values["uninject"] = not Values["uninject"]
end)

local Running = true


local CombatThread = coroutine.create(function()
    local MaxDistance = 20

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
                if game:GetService("Players").LocalPlayer.Team.Name == "Waiting" then
                else
                    if Values["ballaura"] == true and BladeBall.Enabled == false then
                        -- get nearist ball
                        local Dis = math.huge
                        local Ball = nil
                        local MaxDis = 30

                        for _, i in pairs(game.Workspace.Balls:GetChildren()) do
                            local DisToBall = (i.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if DisToBall < Dis and DisToBall <= MaxDis then
                                Dis = DisToBall
                                Ball = i
                            end
                        end
                        
                        if Ball ~= nil then
                            mouse1click()
                        end
                    end

                    if Values["balltp"] == true and BladeBall.Enabled == false then
                        for _, i in pairs(game.Workspace.Balls:GetChildren()) do
                            mouse1click()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = i.CFrame
                        end
                    end

                    if Values["targetaura"] == true then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
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

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space and Values["infinitejump"] == true then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
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

            if Values["flight"] == true then
                local moveDirection = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                local velocity = Vector3.new(moveDirection.X, 0, moveDirection.Z) * 2
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += velocity

                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,
                TempY, 
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
            end
        end)
    end
end)

local UtilitysThread = coroutine.create(function()
    while Running do
        task.wait()
        if Values["uninject"] == true then
            BladeBall:Destroy()
            for _,i in pairs(Values) do
                i = false
            end
            Running = false
        end
    end
end)


coroutine.resume(CombatThread)
coroutine.resume(MovementThread)
coroutine.resume(UtilitysThread)

PopupSystem:InformationPopup("Dexion Loaded","RALT to toggle menu.",3)


