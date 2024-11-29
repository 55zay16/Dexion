local UIlib = {}

function UIlib:Init(GameName)
    -- Find past UI and remove it
    for _, i in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
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
    local Background = Instance.new("Frame")

    Background.Name = "Background"
    Background.Parent = DexionUI
    Background.Size = UDim2.new(1,0,1,0)
    Background.ZIndex = -10
    Background.BackgroundColor3 = Color3.fromRGB(97, 0, 0)
    Background.BackgroundTransparency = 0.5
    Background.Position = UDim2.new(0, 0, 0, 0)
    
    DexionUI.Name = "Dexion-" .. GameName
    DexionUI.Parent = game.Players.LocalPlayer.PlayerGui
    DexionUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    DexionUI.ResetOnSpawn = false
    DexionUI.IgnoreGuiInset = true

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
            if input.KeyCode == Enum.KeyCode.RightAlt then
                script.Parent.Enabled = not script.Parent.Enabled
                if script.Parent.Enabled then
                    UIS.MouseBehavior = Enum.MouseBehavior.Default
                end
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
    Buttons.AutomaticCanvasSize = Enum.AutomaticSize.Y
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

function UIlib:AddButton(TargetTab,Title,Callback)
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
    Button.Text = Title
    
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

function UIlib:AddPropertiesButton(TargetTab,Title,Callback)
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
    Button.Text = Title
    
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
    
    local PropertiesMenu = Instance.new("Frame")
    local NameForProperty = Instance.new("TextLabel")
    local PropertyLine2 = Instance.new("Frame")
    local PropertyLine1 = Instance.new("Frame")
    local ScrollingFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    PropertiesMenu.Name = Title .. "-PropertiesMenu"
    PropertiesMenu.Parent = TargetTab.Buttons
    PropertiesMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    PropertiesMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PropertiesMenu.BorderSizePixel = 0
    PropertiesMenu.Visible = false
    PropertiesMenu.Position = UDim2.new(0, 0, 0.0929752067, 0)
    PropertiesMenu.Size = UDim2.new(0, 200, 0, 125)

    NameForProperty.Name = "Property"
    NameForProperty.Parent = PropertiesMenu
    NameForProperty.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameForProperty.BackgroundTransparency = 1.000
    NameForProperty.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NameForProperty.BorderSizePixel = 0
    NameForProperty.Position = UDim2.new(0, 0, -0.0163635258, 0)
    NameForProperty.Size = UDim2.new(0, 112, 0, 17)
    NameForProperty.Font = Enum.Font.SourceSansSemibold
    NameForProperty.Text =  Title  .. " Properties"
    NameForProperty.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameForProperty.TextScaled = true
    NameForProperty.TextSize = 14.000
    NameForProperty.TextWrapped = true

    PropertyLine2.Name = "PropertyLine2"
    PropertyLine2.Parent = PropertiesMenu
    PropertyLine2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    PropertyLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PropertyLine2.BorderSizePixel = 0
    PropertyLine2.Position = UDim2.new(0, 0, 0.991999984, 0)
    PropertyLine2.Size = UDim2.new(0, 200, 0, 1)

    PropertyLine1.Name = "PropertyLine1"
    PropertyLine1.Parent = PropertiesMenu
    PropertyLine1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    PropertyLine1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PropertyLine1.BorderSizePixel = 0
    PropertyLine1.Position = UDim2.new(0, 0, 0.122000001, 0)
    PropertyLine1.Size = UDim2.new(0, 200, 0, 1)

    ScrollingFrame.Parent = PropertiesMenu
    ScrollingFrame.Active = true
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.BackgroundTransparency = 1.000
    ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 0.5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar

    ScrollingFrame.Position = UDim2.new(0, 0, 0.129999995, 0)
    ScrollingFrame.Size = UDim2.new(0, 200, 0, 108)
    ScrollingFrame.ScrollBarThickness = 0

    UIListLayout.Parent = ScrollingFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Button.MouseButton1Click:Connect(function()
        if Display.BackgroundColor3 == Color3.fromRGB(255, 0, 0) then
            Display.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            Callback(true) -- enabled
        else
            Display.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            Callback(false) -- not enabled
        end
    end)

    Button.MouseButton2Click:Connect(function()
        if PropertiesMenu.Visible == false then
            PropertiesMenu.Visible = true
        else
            PropertiesMenu.Visible = false
        end
    end)

    return PropertiesMenu
end

function UIlib:AddPropertiesLabel(TargetProperties,Text)
    local TextLabel = Instance.new("TextLabel")
    local PropertyLine1 = Instance.new("Frame")

    TextLabel.Parent = TargetProperties.Parent[TargetProperties.Name].ScrollingFrame
    TextLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0, 0, 0.648148119, 0)
    TextLabel.Size = UDim2.new(1, 0,0.296, 0)
    TextLabel.Font = Enum.Font.SourceSansSemibold
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.Text = Text
    TextLabel.TextWrapped = true

    PropertyLine1.Name = "PropertyLine1"
    PropertyLine1.Parent = TextLabel
    PropertyLine1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    PropertyLine1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PropertyLine1.BorderSizePixel = 0
    PropertyLine1.Position = UDim2.new(0, 0, 0.965750217, 0)
    PropertyLine1.Size = UDim2.new(0, 200, 0, 1)
end

function UIlib:AddPropertiesSubButton(TargetProperties,Title,Callback)
    local Button = Instance.new("TextButton")
    local Line = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    Button.Name = Title
    Button.Parent = TargetProperties.Parent[TargetProperties.Name].ScrollingFrame
    Button.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 200, 0, 45)
    Button.Font = Enum.Font.SourceSansSemibold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 28.000
    Button.Text = Title
    
    Line.Name = "Line"
    Line.Parent = Button
    Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0, 0, 0.98222214, 0)
    Line.Size = UDim2.new(0, 200, 0, 1)
    
    
    UICorner.CornerRadius = UDim.new(2, 0)


    Button.MouseButton1Click:Connect(function()
        Callback()
    end)
end

function UIlib:AddPropertiesToggle(TargetProperties,Title,Callback)
    local Button = Instance.new("TextButton")
    local Line = Instance.new("Frame")
    local Display = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    Button.Name = Title
    Button.Parent = TargetProperties.Parent[TargetProperties.Name].ScrollingFrame
    Button.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 200, 0, 45)
    Button.Font = Enum.Font.SourceSansSemibold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 28.000
    Button.Text = Title
    
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

function UIlib:AddPropertiesTextInput(TargetProperties,Text)
    local TextInput = Instance.new("TextBox")
    local PropertyLine1 = Instance.new("Frame")
    
    
    TextInput.Name = "TextInput"
    TextInput.Parent =TargetProperties.Parent[TargetProperties.Name].ScrollingFrame
    TextInput.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextInput.BorderSizePixel = 0
    TextInput.Size = UDim2.new(0, 200, 0, 35)
    TextInput.Font = Enum.Font.SourceSansSemibold
    TextInput.PlaceholderText = "Bind: None"
    TextInput.Text = Text
    TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextInput.TextSize = 28.000
    TextInput.TextWrapped = true
    
    PropertyLine1.Name = "PropertyLine1"
    PropertyLine1.Parent = TextInput
    PropertyLine1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    PropertyLine1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PropertyLine1.BorderSizePixel = 0
    PropertyLine1.Position = UDim2.new(0, 0, 0.965750217, 0)
    PropertyLine1.Size = UDim2.new(0, 200, 0, 1)
end

function UIlib:InitPopupSystem(DexionUI) 
    local NotificationList = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    NotificationList.Name = "NotificationList"
    NotificationList.Parent = DexionUI
    NotificationList.AnchorPoint = Vector2.new(0.5, 0.5)
    NotificationList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotificationList.BackgroundTransparency = 1.000
    NotificationList.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotificationList.BorderSizePixel = 0
    NotificationList.Position = UDim2.new(0.920000017, 0, 0.592000008, 0)
    NotificationList.Size = UDim2.new(0.148000002, 0, 0.760999978, 0)

    UIListLayout.Parent = NotificationList
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.Padding = UDim.new(0, 15)


    local PopupSystem = {}

    function PopupSystem:InformationPopup(TitleText,Text,Duration)
        local InformationNotification = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local Waitbar = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local Description = Instance.new("TextLabel")
        local Selectedinfo = Instance.new("ImageLabel")
        local UIStroke = Instance.new("UIStroke")

        InformationNotification.Name = "InformationNotification"
        InformationNotification.Parent = NotificationList
        InformationNotification.AnchorPoint = Vector2.new(0.5, 0.5)
        InformationNotification.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
        InformationNotification.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InformationNotification.BorderSizePixel = 0
        InformationNotification.Position = UDim2.new(0.501730084, 0, 0.0750825107, 0)
        InformationNotification.Size = UDim2.new(0, 290, 0, 91)

        UIStroke.Color = Color3.fromRGB(255,255,255)
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        UIStroke.Thickness = 2
        UIStroke.Transparency = 0

        UICorner.Parent = InformationNotification
        UIStroke.Parent = InformationNotification

        Title.Name = "Title"
        Title.Parent = InformationNotification
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Title.BorderSizePixel = 0
        Title.Position = UDim2.new(0.118704543, 0, 0.0109890113, 0)
        Title.Size = UDim2.new(0, 260, 0, 29)
        Title.Font = Enum.Font.SourceSansBold
        Title.Text = TitleText
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left

        Waitbar.Name = "Waitbar"
        Waitbar.Parent = InformationNotification
        Waitbar.AnchorPoint = Vector2.new(0.5, 0)
        Waitbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Waitbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Waitbar.BorderSizePixel = 0
        Waitbar.Position = UDim2.new(0.5, 0, 0.896203876, 0)
        Waitbar.Size = UDim2.new(0, 280, 0, 6)

        UICorner_2.CornerRadius = UDim.new(1, 0)
        UICorner_2.Parent = Waitbar

        Description.Name = "Description"
        Description.Parent = InformationNotification
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Description.BorderSizePixel = 0
        Description.Position = UDim2.new(0.0172413792, 0, 0.310190052, 0)
        Description.Size = UDim2.new(0, 285, 0, 17)
        Description.Font = Enum.Font.SourceSansBold
        Description.Text = Text
        Description.TextColor3 = Color3.fromRGB(175, 175, 175)
        Description.TextScaled = true
        Description.TextSize = 14.000
        Description.TextWrapped = true
        Description.TextXAlignment = Enum.TextXAlignment.Left

        Selectedinfo.Name = "Selected: info"
        Selectedinfo.Parent = InformationNotification
        Selectedinfo.BackgroundTransparency = 1.000
        Selectedinfo.Size = UDim2.new(0, 34, 0, 30)
        Selectedinfo.Image = "rbxassetid://2790676563"
        Selectedinfo.ScaleType = Enum.ScaleType.Fit


        local function FadeOut()
            Waitbar:TweenSize(UDim2.new(0, 0, 0, 6), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, Duration, true)
            wait(Duration)
            InformationNotification:Destroy()
        end

        coroutine.wrap(FadeOut)()

    end

    function PopupSystem:WarningPopup(TitleText,Text,Duration)
        local WarningNotification = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local Waitbar = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local Description = Instance.new("TextLabel")
        local Warning = Instance.new("ImageLabel")
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")					
        local UIStroke = Instance.new("UIStroke")

        --Properties:

        WarningNotification.Name = "WarningNotification"
        WarningNotification.Parent = NotificationList
        WarningNotification.AnchorPoint = Vector2.new(0.5, 0.5)
        WarningNotification.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
        WarningNotification.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WarningNotification.BorderSizePixel = 0
        WarningNotification.Position = UDim2.new(0.501730084, 0, 0.0750825107, 0)
        WarningNotification.Size = UDim2.new(0, 290, 0, 91)

        UIStroke.Color = Color3.fromRGB(255,255,0)
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        UIStroke.Thickness = 2
        UIStroke.Transparency = 0

        UICorner.Parent = WarningNotification
        UIStroke.Parent = WarningNotification

        Title.Name = "Title"
        Title.Parent = WarningNotification
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Title.BorderSizePixel = 0
        Title.Position = UDim2.new(0.118704543, 0, 0.0109890113, 0)
        Title.Size = UDim2.new(0, 260, 0, 29)
        Title.Font = Enum.Font.SourceSansBold
        Title.Text = TitleText
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left

        Waitbar.Name = "Waitbar"
        Waitbar.Parent = WarningNotification
        Waitbar.AnchorPoint = Vector2.new(0.5, 0)
        Waitbar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        Waitbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Waitbar.BorderSizePixel = 0
        Waitbar.Position = UDim2.new(0.5, 0, 0.896203876, 0)
        Waitbar.Size = UDim2.new(0, 280, 0, 6)

        UICorner_2.CornerRadius = UDim.new(1, 0)
        UICorner_2.Parent = Waitbar

        Description.Name = "Description"
        Description.Parent = WarningNotification
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Description.BorderSizePixel = 0
        Description.Position = UDim2.new(0.0172413792, 0, 0.310190052, 0)
        Description.Size = UDim2.new(0, 285, 0, 17)
        Description.Font = Enum.Font.SourceSansBold
        Description.Text = Text
        Description.TextColor3 = Color3.fromRGB(175, 175, 175)
        Description.TextScaled = true
        Description.TextSize = 14.000
        Description.TextWrapped = true
        Description.TextXAlignment = Enum.TextXAlignment.Left

        Warning.Name = "Warning"
        Warning.Parent = WarningNotification
        Warning.BackgroundTransparency = 1.000
        Warning.Position = UDim2.new(0.0152558424, 0, 0.0457508788, 0)
        Warning.Size = UDim2.new(0, 24, 0, 24)
        Warning.Image = "rbxassetid://8445470392"
        Warning.ImageColor3 = Color3.fromRGB(255, 255, 0)
        Warning.ImageRectOffset = Vector2.new(104, 704)
        Warning.ImageRectSize = Vector2.new(96, 96)

        UIAspectRatioConstraint.Parent = Warning
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height

        local function FadeOut()
            Waitbar:TweenSize(UDim2.new(0, 0, 0, 6), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, Duration, true)
            wait(Duration)
            WarningNotification:Destroy()
        end

        coroutine.wrap(FadeOut)()

    end

    function PopupSystem:ErrorPopup(TitleText,Text,Duration)
        local ErrorNotification = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local Waitbar = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local Description = Instance.new("TextLabel")
        local Selectednew_releases = Instance.new("ImageLabel")
        local UIStroke = Instance.new("UIStroke")

        ErrorNotification.Name = "ErrorNotification"
        ErrorNotification.Parent = NotificationList
        ErrorNotification.AnchorPoint = Vector2.new(0.5, 0.5)
        ErrorNotification.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
        ErrorNotification.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ErrorNotification.BorderSizePixel = 0
        ErrorNotification.Position = UDim2.new(0.501730084, 0, 0.0750825107, 0)
        ErrorNotification.Size = UDim2.new(0, 290, 0, 91)

        UIStroke.Color = Color3.fromRGB(255,0,0)
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        UIStroke.Thickness = 2
        UIStroke.Transparency = 0

        UICorner.Parent = ErrorNotification
        UIStroke.Parent = ErrorNotification

        Title.Name = "Title"
        Title.Parent = ErrorNotification
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Title.BorderSizePixel = 0
        Title.Position = UDim2.new(0.118704543, 0, 0.0109890113, 0)
        Title.Size = UDim2.new(0, 260, 0, 29)
        Title.Font = Enum.Font.SourceSansBold
        Title.Text = TitleText
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left

        Waitbar.Name = "Waitbar"
        Waitbar.Parent = ErrorNotification
        Waitbar.AnchorPoint = Vector2.new(0.5, 0)
        Waitbar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        Waitbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Waitbar.BorderSizePixel = 0
        Waitbar.Position = UDim2.new(0.5, 0, 0.896203876, 0)
        Waitbar.Size = UDim2.new(0, 280, 0, 6)

        UICorner_2.CornerRadius = UDim.new(1, 0)
        UICorner_2.Parent = Waitbar

        Description.Name = "Description"
        Description.Parent = ErrorNotification
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Description.BorderSizePixel = 0
        Description.Position = UDim2.new(0.0172413792, 0, 0.310190052, 0)
        Description.Size = UDim2.new(0, 285, 0, 17)
        Description.Font = Enum.Font.SourceSansBold
        Description.Text = Text
        Description.TextColor3 = Color3.fromRGB(175, 175, 175)
        Description.TextScaled = true
        Description.TextSize = 14.000
        Description.TextWrapped = true
        Description.TextXAlignment = Enum.TextXAlignment.Left

        Selectednew_releases.Name = "Selected: new_releases"
        Selectednew_releases.Parent = ErrorNotification
        Selectednew_releases.BackgroundTransparency = 1.000
        Selectednew_releases.Size = UDim2.new(0, 28, 0, 30)
        Selectednew_releases.Image = "rbxassetid://2746364987"
        Selectednew_releases.ImageColor3 = Color3.fromRGB(255, 0, 0)
        Selectednew_releases.ScaleType = Enum.ScaleType.Fit

        local function FadeOut()
            Waitbar:TweenSize(UDim2.new(0, 0, 0, 6), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, Duration, true)
            wait(Duration)
            ErrorNotification:Destroy()
        end

        coroutine.wrap(FadeOut)()

    end

    return PopupSystem
end

return UIlib  
