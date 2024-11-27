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
    local function ToggleBinding() 
        local script = Instance.new('Script', DexionUI)
        
        local UIS = game:GetService('UserInputService')
        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Plus then
                script.Parent.Enabled.Value = not script.Parent.Enabled.Value
            end
        end) 
    end

    coroutine.wrap(MoveUIBinding)()
    coroutine.wrap(ToggleBinding)()

    return DexionUI
end

function UIlib:AddTab(DexionUI,Tabtitle,XOFFSET,X,YOFFSET,Y) 
    local Tab = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local Bar = Instance.new("Frame")
    local Buttons = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local Line = Instance.new("Frame")
    local Background = Instance.new("Frame")

    Background.Name = "Background"
    Background.Parent = Tab
    Background.Size = UDim2.new(1,0,1,0)
    Background.ZIndex = -10
    Background.BackgroundColor3 = Color3.fromRGB(190, 0, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    
    Tab.Name = Tabtitle
    Tab.Parent = DexionUI
    Tab.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tab.BorderSizePixel = 0
    Tab.Position = UDim2.new(XOFFSET, X, YOFFSET, Y)
    Tab.Size = UDim2.new(0, 200, 0, 50)
    Tab.Font = Enum.Font.SourceSansSemibold
    Tab.Text = Tabtitle
    Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab.TextSize = 35.000
    
    UICorner.Parent = Tab
    
    Bar.Name = "Bar"
    Bar.Parent = Tab
    Bar.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
    Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Bar.BorderSizePixel = 0
    Bar.Position = UDim2.new(0, 0, 0.839999974, 0)
    Bar.Size = UDim2.new(0, 200, 0, 8)
    
    Buttons.Name = "Buttons"
    Buttons.Parent = Tab
    Buttons.Active = true
    Buttons.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Buttons.BorderSizePixel = 0
    Buttons.Position = UDim2.new(0, 0, 1, 0)
    Buttons.Size = UDim2.new(0, 200, 0, 484)
    Buttons.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    
    UIListLayout.Parent = Buttons
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    Line.Name = "Line"
    Line.Parent = Tab
    Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0, 0, 0.959999979, 0)
    Line.Size = UDim2.new(0, 200, 0, 1)

    local function MoveUIBinding()
        local script = Instance.new('Script', Tab)
        
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


    return Tab
end

function UIlib:AddButton(Title,TargetTab,Callback)
    local Button = Instance.new("TextButton")
    local Line = Instance.new("Frame")
    local Display = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    Button.Name = Title
    Button.Parent = TargetTab.Buttons
    Button.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 200, 0, 45)
    Button.Font = Enum.Font.SourceSansSemibold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 28.000
    
    Line.Name = "Line"
    Line.Parent = Button
    Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0, 0, 0.98222214, 0)
    Line.Size = UDim2.new(0, 200, 0, 1)
    
    Display.Name = "Display"
    Display.Parent = Button
    Display.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Display.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Display.BorderSizePixel = 0
    Display.Position = UDim2.new(0.0500000007, 0, 0.355555564, 0)
    Display.Size = UDim2.new(0, 12, 0, 12)
    
    UICorner.CornerRadius = UDim.new(2, 0)
    UICorner.Parent = Display

    Button.MouseButton1Click:Connect(function()
        if Display.BackgroundColor3 == Color3.fromRGB(255, 0, 0) then
            Display.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            Callback(true) -- enabled
        else
            Display.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            Callback(false) -- not enabled
        end
    end)
end

return UIlib  
