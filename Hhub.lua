local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables iniciales
local flying = false
local flySpeed = 50
local jumpPower = humanoid.JumpPower
local walkSpeed = humanoid.WalkSpeed

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PowerControlHub"

-- Crear botones
local function createButton(name, position, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = UDim2.new(0,150,0,50)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50,50,50)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Parent = screenGui
    return button
end

-- Crear sliders
local function createSlider(name, position, min, max, default)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0,150,0,50)
    sliderFrame.Position = position
    sliderFrame.BackgroundColor3 = Color3.fromRGB(70,70,70)
    sliderFrame.Parent = screenGui

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0,20,1,0)
    slider.Position = UDim2.new(default/max,0,0,0)
    slider.BackgroundColor3 = Color3.fromRGB(150,150,150)
    slider.Text = ""
    slider.Parent = sliderFrame

    return slider
end

-- Botones principales
local flyButton = createButton("FlyButton", UDim2.new(0,10,0,10), "Volar: OFF")
local resetButton = createButton("ResetButton", UDim2.new(0,10,0,70), "Reset Poderes")

-- Sliders
local speedSlider = createSlider("SpeedSlider", UDim2.new(0,10,0,130), 16, 100, humanoid.WalkSpeed)
local jumpSlider = createSlider("JumpSlider", UDim2.new(0,10,0,190), 50, 300, humanoid.JumpPower)

-- Funciones
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    flyButton.Text = "Volar: "..(flying and "ON" or "OFF")
    if flying then
        humanoid.PlatformStand = true
        -- Control simple de vuelo
        while flying do
            wait(0.03)
            local moveVector = Vector3.new()
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0,1,0) end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then moveVector = moveVector - Vector3.new(0,1,0) end
            character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + moveVector.Unit*flySpeed*0.1)
        end
    else
        humanoid.PlatformStand = false
    end
end)

-- Sliders dinámicos
speedSlider.MouseButton1Down:Connect(function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local connection
    connection = mouse.Move:Connect(function()
        local pos = math.clamp(mouse.X - speedSlider.AbsolutePosition.X, 0, speedSlider.AbsoluteSize.X)
        speedSlider.Position = UDim2.new(pos/speedSlider.AbsoluteSize.X,0,0,0)
        humanoid.WalkSpeed = 16 + ((100-16)*(pos/speedSlider.AbsoluteSize.X))
    end)
    mouse.Button1Up:Wait()
    connection:Disconnect()
end)

jumpSlider.MouseButton1Down:Connect(function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local connection
    connection = mouse.Move:Connect(function()
        local pos = math.clamp(mouse.X - jumpSlider.AbsolutePosition.X, 0, jumpSlider.AbsoluteSize.X)
        jumpSlider.Position = UDim2.new(pos/jumpSlider.AbsoluteSize.X,0,0,0)
        humanoid.JumpPower = 50 + ((300-50)*(pos/jumpSlider.AbsoluteSize.X))
    end)
    mouse.Button1Up:Wait()
    connection:Disconnect()
end)

-- Reset poderes
resetButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    flying = false
    flyButton.Text = "Volar: OFF"
    humanoid.PlatformStand = false
end)
