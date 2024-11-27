local UIlib = {}

function UIlib:Init(GameName)
    -- Find past UI and remove it
    for _, i in pairs(game.CoreGui:GetChildren()) do
        if i.Name == "Dexion-" .. GameName then
            i:Destroy()
        end
    end

    local DexionUI = Instance.new("ScreenGui")
    local Title = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local BelowTitleBar = Instance.new("Frame")
    local UIStroke = Instance.new("UIStroke")
    local UIStroke2 = Instance.new("UIStroke")
    
    
    DexionUI.Name = "Dexion-" .. GameName
    DexionUI.Parent = game.CoreGui
    DexionUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Title.Name = "Title"
    Title.Parent = DexionUI
    Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(-0.000513400766, 0, -0.00108361838, 0)
    Title.Size = UDim2.new(0.0801576898, 0, 0.0742496029, 0)
    Title.Font = Enum.Font.SourceSans
    Title.Text = "Dexion-" .. GameName
    Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    Title.TextScaled = true
    Title.TextSize = 14.000
    Title.TextWrapped = true
    
    UICorner.Parent = Title
    UIStroke2.Parent = BelowTitleBar
    UIStroke.Parent = Title
    
    BelowTitleBar.Name = "BelowTitleBar"
    BelowTitleBar.Parent = Title
    BelowTitleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    BelowTitleBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BelowTitleBar.BorderSizePixel = 0
    BelowTitleBar.Position = UDim2.new(0.0326798223, 0, 1, 0)
    BelowTitleBar.Size = UDim2.new(0.967213094, 0, 0.0425531901, 0)
    
    UIStroke.Color = Color3.fromRGB(199, 0, 0)
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    
    UIStroke2.Color = Color3.fromRGB(199, 0, 0)
    UIStroke2.Thickness = 2
    UIStroke2.Transparency = 0
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    

    local function MoveUIBinding()
        local script = Instance.new('Script', Title)
        
        local UIS = game:GetService('UserInputService')
        local frame = script.Parent

        local dragToggle = nil
        local dragSpeed = 0.01
        local dragStart = nil
        local startPos = nil

        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,startPos.Y.Scale, startPos.Y.Offset + delta.Y) 
            game:GetService('TweenService') :Create(frame, TweenInfo.new(dragSpeed), {Position = position}) :Play()
        end

        frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragToggle = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        print('Release')
                        dragToggle = false
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)

    end

    coroutine.wrap(MoveUIBinding)()

    return DexionUI
end

return UIlib  
