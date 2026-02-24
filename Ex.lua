-- // SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- // VARIABLES GLOBALES
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- // CONFIGURACIÓN DE FUNCIONES
local Config = {
    Jump = {
        Enabled = false,
        BasePower = 50,
        MaxPower = 200,
        CurrentPower = 50,
        InfiniteJump = false
    },
    Fly = {
        Enabled = false,
        Speed = 60,
        MinSpeed = 10,
        MaxSpeed = 150,
        Mode = "Smooth" -- "Smooth" o "Classic"
    },
    Invisibility = {
        Enabled = false,
        Transparency = 0.9,
        MinTransparency = 0.5,
        MaxTransparency = 1,
        KeepHeadVisible = true
    },
    Keybinds = {
        ToggleHub = Enum.KeyCode.RightShift,
        ToggleFly = Enum.KeyCode.F,
        ToggleInvisibility = Enum.KeyCode.V,
        IncreaseValue = Enum.KeyCode.Equals,
        DecreaseValue = Enum.KeyCode.Minus
    }
}

-- // CREACIÓN DEL HUB
local Hub = Instance.new("ScreenGui")
Hub.Name = "GameEnhancerHub"
Hub.Parent = PlayerGui
Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- // CONTENEDOR PRINCIPAL
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 400, 0, 500)
MainContainer.Position = UDim2.new(0.05, 0, 0.5, -250)
MainContainer.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
MainContainer.BorderSizePixel = 0
MainContainer.CornerRadius = UDim.new(0, 12)
MainContainer.ClipsDescendants = true
MainContainer.Visible = false
MainContainer.Parent = Hub

-- // EFECTOS VISUALES
local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 35, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 18, 25))
}
BackgroundGradient.Rotation = 45
BackgroundGradient.Parent = MainContainer

local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.4
Shadow.ZIndex = 0
Shadow.Parent = MainContainer

-- // BARRA SUPERIOR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainContainer

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ENHANCER HUB - CONFIGURACIÓN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.RobotoMono
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.CornerRadius = UDim.new(1, 0)
CloseBtn.Parent = TopBar

-- // FUNCIÓN PARA CREAR SECCIONES
local function CreateSection(title, yPos)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.9, 0, 0, 120)
    Section.Position = UDim2.new(0.05, 0, 0, yPos)
    Section.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
    Section.BackgroundTransparency = 0.2
    Section.BorderSizePixel = 0
    Section.CornerRadius = UDim.new(0, 8)
    Section.Parent = MainContainer

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(1, 0, 0, 30)
    SectionTitle.Position = UDim2.new(0, 10, 0, 5)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    SectionTitle.TextSize = 14
    SectionTitle.Font = Enum.Font.RobotoMono
    SectionTitle.Parent = Section

    return Section
end

-- // FUNCIÓN PARA CREAR TOGGLES
local function CreateToggle(section, name, displayName, yPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 10, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = section

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = displayName
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.Roboto
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleBtn.BackgroundColor3 = Config[name].Enabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(50, 55, 70)
    ToggleBtn.Text = Config[name].Enabled and "ON" or "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 12
    ToggleBtn.CornerRadius = UDim.new(0, 10)
    ToggleBtn.Parent = ToggleFrame

    ToggleBtn.MouseButton1Click:Connect(function()
        Config[name].Enabled = not Config[name].Enabled
        ToggleBtn.BackgroundColor3 = Config[name].Enabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(50, 55, 70)
        ToggleBtn.Text = Config[name].Enabled and "ON" or "OFF"
        
        if name == "Jump" then UpdateJumpSettings()
        elseif name == "Fly" then UpdateFlySettings()
        elseif name == "Invisibility" then UpdateInvisibilitySettings() end
    end)

    return ToggleFrame
end

-- // FUNCIÓN PARA CREAR SLIDERS
local function CreateSlider(section, name, setting, displayName, yPos)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, 30)
    SliderFrame.Position = UDim2.new(0, 10, 0, yPos)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = section

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = displayName..": "..Config[name][setting]
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 12
    Label.Font = Enum.Font.Roboto
    Label.Parent = SliderFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.4, 0, 0, 4)
    SliderBg.Position = UDim2.new(0.55, 0, 0.5, -2)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
    SliderBg.CornerRadius = UDim.new(1, 0)
    SliderBg.Parent = SliderFrame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(
        (Config[name][setting] - Config[name]["Min"..setting])/(Config[name]["Max"..setting] - Config[name]["Min"..setting]),
        0, 1, 0
    )
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    SliderFill.CornerRadius = UDim.new(1, 0)
    SliderFill.Parent = SliderBg

    local SliderKnob = Instance.new("Frame")
    SliderKnob.Size = UDim2.new(0, 12, 0, 12)
    SliderKnob.Position = UDim2.new(SliderFill.Size.X.Scale, -6, 0.5, -6)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(0, 220, 255)
    SliderKnob.CornerRadius = UDim.new(1, 0)
    SliderKnob.Parent = SliderBg

    -- LÓGICA DEL SLIDER
    local Dragging = false
    local function UpdateSlider(posX)
        local relX = posX - SliderBg.AbsolutePosition.X
        local percent = math.clamp(relX / SliderBg.AbsoluteSize.X, 0, 1)
        local minVal = Config[name]["Min"..setting]
        local maxVal = Config[name]["Max"..setting]
        local value = math.round(minVal + percent * (maxVal - minVal))

        Config[name][setting] = value
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderKnob.Position = UDim2.new(percent, -6, 0.5, -6)
        Label.Text = displayName..": "..value

        if name == "Jump" then UpdateJumpSettings()
        elseif name == "Fly" then UpdateFlySettings()
        elseif name == "Invisibility" then UpdateInvisibilitySettings() end
    end

    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if Dragging then
            UpdateSlider(UserInputService:GetMouseLocation().X)
        end
    end)

    return SliderFrame
end

-- // ACTUALIZADORES DE FUNCIONES
function UpdateJumpSettings()
    Humanoid.JumpPower = Config.Jump.Enabled and Config.Jump.CurrentPower or Config.Jump.BasePower
    
    -- LÓGICA DE SALTO INFINITO
    if Config.Jump.InfiniteJump then
        Humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed then
                Humanoid.Jump = true
            end
        end)
    else
        Humanoid.StateChanged:DisconnectAll()
    end
end

function UpdateFlySettings()
    if Config.Fly.Enabled then
        Humanoid.PlatformStand = true
        Humanoid.WalkSpeed = 0
        Humanoid.JumpPower = 0

        -- BUCLE DE VUELO
        local FlyLoop = RunService.RenderStepped:Connect(function()
            if not Character or not HumanoidRootPart or not Config.Fly.Enabled then
                FlyLoop:Disconnect()
                return
            end

            local Camera = workspace.CurrentCamera
            local MoveDir = Vector3.new()
            local Speed = Config.Fly.Speed / 30

            -- MOVIMIENTO WASD
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDir += Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDir -= Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDir -= Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDir += Camera.CFrame.RightVector end

            -- MOVIMIENTO ARRIBA/ABAJO
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDir += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDir -= Vector3.new(0, 1, 0) end

            -- APLICAR MOVIMIENTO
            MoveDir = MoveDir.Unit * Speed
            if Config.Fly.Mode == "Smooth" then
                HumanoidRootPart.Velocity = MoveDir * 30
            else
                HumanoidRootPart.CFrame += MoveDir
            end
        end)
    else
        Humanoid.PlatformStand = false
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = Config.Jump.Enabled and Config.Jump.CurrentPower or Config.Jump.BasePower
    end
end

function UpdateInvisibilitySettings()
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if Config.Invisibility.KeepHeadVisible and part.Name == "Head" then
                part.Transparency = 0
            else
                part.Transparency = Config.Invisibility.Enabled and Config.Invisibility.Transparency or 0
            end
        end
    end
end

-- // CREACIÓN DE SECCIONES Y CONTROLES
local JumpSection = CreateSection("AJUSTES DE SALTO", 50)
CreateToggle(JumpSection, "Jump", "Activar Mejoras", 35)
CreateSlider(JumpSection, "Jump", "CurrentPower", "Potencia de Salto", 70)

local FlySection = CreateSection("AJUSTES DE VUELO", 180)
CreateToggle(FlySection, "Fly", "Activar Vuelo", 35)
CreateSlider(FlySection, "Fly", "Speed", "Velocidad de Vuelo", 70)

local InvisibilitySection = CreateSection("AJUSTES DE INVISIBILIDAD", 310)
CreateToggle(InvisibilitySection, "Invisibility", "Activar Invisibilidad", 35)
CreateSlider(InvisibilitySection, "Invisibility", "Transparency", "Nivel de Transparencia", 70)

-- // BOTÓN DE ACTIVACIÓN/Desactivación DEL HUB
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.Keybinds.ToggleHub then
        MainContainer.Visible = not MainContainer.Visible
        -- ANIMACIÓN DE APARECIÓN/DESAPARECIÓN
        TweenService:Create(MainContainer, TweenInfo.new(0.2), {
            Position = MainContainer.Visible and UDim2.new(0.05, 0, 0.5, -250) or UDim2.new(-0.5, 0, 0.5, -250)
        }):Play()
            
