local UIlib = {}

function UIlib:Init(GameName)
    -- Find past UI and remove it
    for _, i in pairs(game.CoreGui:GetChildren()) do
        if i.Name == "Dexion-" + GameName then
            i:Destroy()
        end
    end

    -- Create UI

    local DexionUI = Instance.new("ScreenGui")
    local Title = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local BelowTitleBar = Instance.new("Frame")


    DexionUI.Name = "Dexion-" + GameName
    DexionUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    DexionUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Title.Name = "Title"
    Title.Parent = DexionUI
    Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(-0.000513400766, 0, -0.00108361838, 0)
    Title.Size = UDim2.new(0, 145, 0, 47)
    Title.Font = Enum.Font.Unknown
    Title.Text = "Dexion"
    Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    Title.TextScaled = true
    Title.TextSize = 14.000
    Title.TextWrapped = true

    UICorner.Parent = Title

    BelowTitleBar.Name = "BelowTitleBar"
    BelowTitleBar.Parent = Title
    BelowTitleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    BelowTitleBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BelowTitleBar.BorderSizePixel = 0
    BelowTitleBar.Position = UDim2.new(0.0326798148, 0, 1, 0)
    BelowTitleBar.Size = UDim2.new(0, 137, 0, 2)
    
    -- Code Bindings
    
end

return UIlib  
