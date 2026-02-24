-- // Servicios
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- // Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Gui = Instance.new("ScreenGui")
Gui.Name = "FuturisticAdvancedHub"
Gui.Parent = Player.PlayerGui
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- // Paleta de Colores Futurista
local Colors = {
    Background = Color3.fromRGB(10, 12, 20),
    PanelBg = Color3.fromRGB(18, 20, 30),
    AccentPrimary = Color3.fromRGB(0, 210, 255),
    AccentSecondary = Color3.fromRGB(100, 255, 218),
    AccentTertiary = Color3.fromRGB(255, 85, 255),
    TextMain = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(150, 180, 220),
    ToggleOff = Color3.fromRGB(35, 40, 55),
    ToggleOn = Color3.fromRGB(0, 210, 255),
    SliderBg = Color3.fromRGB(35, 40, 55),
    SliderFill = Color3.fromRGB(100, 255, 218)
}

-- // Configuraciones Avanzadas
local AdvancedSettings = {
    Run = {
        Enabled = false,
        BaseSpeed = 16,
        Multiplier = 3, -- Ajustable 1-10
        Keybind = Enum.KeyCode.LeftShift
    },
    Jump = {
        Enabled = false,
        BasePower = 50,
        Multiplier = 2, -- Ajustable 1-5
        Infinite = false
    },
    Fly = {
        Enabled = false,
        Speed = 60, -- Ajustable 10-150
        Mode = "Smooth", -- Smooth/Classic
        KeybindUp = Enum.KeyCode.Space,
        KeybindDown = Enum.KeyCode.LeftControl
    },
    Invisibility = {
        Enabled = false,
        Transparency = 0.95, -- Ajustable 0.5-1
        IgnoreHead = false,
        ToggleKey = Enum.KeyCode.V
    }
}

-- // Funciones de Modificación (Avanzadas)
local ModFunctions = {
    -- Función Correr
    UpdateRun = function()
        if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then return end
        local Humanoid = Player.Character.Humanoid
        Humanoid.WalkSpeed = AdvancedSettings.Run.Enabled and (AdvancedSettings.Run.BaseSpeed * AdvancedSettings.Run.Multiplier) or AdvancedSettings.Run.BaseSpeed
    end,

    -- Función Saltar
    UpdateJump = function()
        if not Player.Character or not Player.Character:FindFirstChild("Humanoid") then return end
        local Humanoid = Player.Character.Humanoid
        Humanoid.JumpPower = AdvancedSettings.Jump.Enabled and (AdvancedSettings.Jump.BasePower * AdvancedSettings.Jump.Multiplier) or AdvancedSettings.Jump.BasePower
        
        -- Lógica Salto Infinito
        if AdvancedSettings.Jump.Infinite then
            Humanoid:SetAttribute("InfiniteJump", true)
        else
            Humanoid:SetAttribute("InfiniteJump", false)
        end
    end,

    -- Función Vuelo
    FlyLoop = nil,
    UpdateFly = function()
        if AdvancedSettings.Fly.Enabled then
            -- Iniciar bucle de vuelo
            ModFunctions.FlyLoop = RunService.RenderStepped:Connect(function()
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
                local RootPart = Player.Character.HumanoidRootPart
                local Camera = workspace.CurrentCamera
                local Speed = AdvancedSettings.Fly.Speed / 30
                
                -- Movimiento WASD
                local MoveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDir += Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDir -= Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDir -= Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDir += Camera.CFrame.RightVector end
                
                -- Movimiento Arriba/Abajo
                if UserInputService:IsKeyDown(AdvancedSettings.Fly.KeybindUp) then MoveDir += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(AdvancedSettings.Fly.KeybindDown) then MoveDir -= Vector3.new(0, 1, 0) end
                
                -- Aplicar movimiento
                MoveDir = MoveDir.Unit * Speed
                if AdvancedSettings.Fly.Mode == "Smooth" then
                    RootPart.Velocity = MoveDir * 30
                else
                    RootPart.CFrame += MoveDir
                end
            end)
        else
            -- Detener vuelo
            if ModFunctions.FlyLoop then
                ModFunctions.FlyLoop:Disconnect()
                ModFunctions.FlyLoop = nil
            end
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.PlatformStand = false
            end
        end
    end,

    -- Función Invisibilidad
    UpdateInvisibility = function()
        if not Player.Character then return end
        for _, Part in ipairs(Player.Character:GetDescendants()) do
            if Part:IsA("BasePart") or Part:IsA("Decal") then
                if AdvancedSettings.Invisibility.IgnoreHead and Part.Name == "Head" then
                    Part.Transparency = 0
                else
                    Part.Transparency = AdvancedSettings.Invisibility.Enabled and AdvancedSettings.Invisibility.Transparency or 0
                end
            end
        end
    end
}

-- // Crear Contenedor Principal
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 450, 0, 620)
MainContainer.Position = UDim2.new(0.5, -225, 0.5, -310)
MainContainer.BackgroundColor3 = Colors.Background
MainContainer.BorderSizePixel = 0
MainContainer.CornerRadius = UDim.new(0, 16)
MainContainer.ClipsDescendants = true
MainContainer.Parent = Gui

-- // Efecto de Fondo Dinámico
local BackgroundEffect = Instance.new("ImageLabel")
BackgroundEffect.Size = UDim2.new(1, 0, 1, 0)
BackgroundEffect.BackgroundTransparency = 1
BackgroundEffect.Image = "rbxassetid://10403162118"
BackgroundEffect.ImageTransparency = 0.85
BackgroundEffect.ZIndex = 0
BackgroundEffect.Parent = MainContainer

-- // Animación de Fondo
RunService.RenderStepped:Connect(function(dt)
    BackgroundEffect.Rotation += dt * 2
    BackgroundEffect.Position = UDim2.new(0, math.sin(os.clock() * 0.5) * 5, 0, math.cos(os.clock() * 0.5) * 5)
end)

-- // Borde Neon
local BorderGlow = Instance.new("Frame")
BorderGlow.Size = UDim2.new(1, 10, 1, 10)
BorderGlow.Position = UDim2.new(0, -5, 0, -5)
BorderGlow.BackgroundTransparency = 1
BorderGlow.ZIndex = 0
BorderGlow.Parent = MainContainer

local BorderGradient = Instance.new("UIGradient")
BorderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Colors.AccentPrimary),
    ColorSequenceKeypoint.new(0.5, Colors.AccentSecondary),
    ColorSequenceKeypoint.new(1, Colors.AccentPrimary)
}
BorderGradient.Rotation = 0
BorderGradient.Parent = BorderGlow

local BorderStroke = Instance.new("UIStroke")
BorderStroke.Thickness = 2
BorderStroke.Color = Colors.AccentPrimary
BorderStroke.Transparency = 0.7
BorderStroke.Parent = BorderGlow

-- // Barra Superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Colors.PanelBg
TopBar.BackgroundTransparency = 0.2
TopBar.BorderSizePixel = 0
TopBar.Parent = MainContainer

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NEXUS - ADVANCED HUB"
Title.TextColor3 = Colors.TextMain
Title.TextSize = 18
Title.Font = Enum.Font.RobotoMono
Title.Parent = TopBar

-- // Botón Cerrar con Efecto
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Colors.ToggleOff
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.TextMain
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.RobotoMono
CloseBtn.CornerRadius = UDim.new(1, 0)
CloseBtn.Parent = TopBar

-- Efecto Hover Botón Cerrar
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.AccentTertiary}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleOff}):Play()
end)
CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- // Función para Crear Secciones con Encabezado
local function CreateSection(title, yPos)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.92, 0, 0, 135)
    Section.Position = UDim2.new(0.04, 0, 0, yPos)
    Section.BackgroundColor3 = Colors.PanelBg
    Section.BackgroundTransparency = 0.1
    Section.BorderSizePixel = 0
    Section.CornerRadius = UDim.new(0, 12)
    Section.ZIndex = 2
    Section.Parent = MainContainer

    -- Efecto de Brillo en Sección
    local SectionGlow = Instance.new("UIGradient")
    SectionGlow.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(1, Color3.new(1,1,1))
    }
    SectionGlow.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.95),
        NumberSequenceKeypoint.new(0.5, 0.85),
        NumberSequenceKeypoint.new(1, 0.95)
    }
    SectionGlow.Rotation = 45
    SectionGlow.Parent = Section

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(1, 0, 0, 30)
    SectionTitle.Position = UDim2.new(0, 15, 0, 10)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = title
    SectionTitle.TextColor3 = Colors.AccentPrimary
    SectionTitle.TextSize = 16
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.Font = Enum.Font.RobotoMono
    SectionTitle.ZIndex = 3
    SectionTitle.Parent = Section

    return Section
end

-- // Función para Crear Toggle Moderno
local function CreateModernToggle(parent, name, displayName, yPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -30, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 15, 0, yPos)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.ZIndex = 3
    ToggleFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = displayName
    Label.TextColor3 = Colors.TextMain
    Label.TextSize = 14
    Label.Font = Enum.Font.RobotoMono
    Label.ZIndex = 3
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 22)
    ToggleBtn.Position = UDim2.new(1, -55, 0.5, -11)
    ToggleBtn.BackgroundColor3 = AdvancedSettings[name].Enabled and Colors.ToggleOn or Colors.ToggleOff
    ToggleBtn.Text = ""
    ToggleBtn.CornerRadius = UDim.new(1, 0)
    ToggleBtn.ZIndex = 3
    ToggleBtn.Parent = ToggleFrame

    local ToggleKnob = Instance.new("Frame")
    ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
    ToggleKnob.Position = UDim2.new(AdvancedSettings[name].Enabled and 1 or 0, AdvancedSettings[name].Enabled and -23 or 2, 0.5, -9)
    ToggleKnob.BackgroundColor3 = Colors.TextMain
    ToggleKnob.CornerRadius = UDim.new(1, 0)
    ToggleKnob.ZIndex = 4
    ToggleKnob.Parent = ToggleBtn

    -- Animación Toggle
    ToggleBtn.MouseButton1Click:Connect(function()
        AdvancedSettings[name].Enabled = not AdvancedSettings[name].Enabled
        
        -- Actualizar visual
        TweenService:Create(ToggleBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            BackgroundColor3 = AdvancedSettings[name].Enabled and Colors.ToggleOn or Colors.ToggleOff
        }):Play()
        TweenService:Create(ToggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Position = UDim2.new(AdvancedSettings[name].Enabled and 1 or 0, AdvancedSettings[name].Enabled and -23 or 2, 0.5, -9)
        }):Play()

        -- Actualizar función
        if name == "Run" then ModFunctions.UpdateRun()
        elseif name == "Jump" then ModFunctions.UpdateJump()
        elseif name == "Fly" then ModFunctions.UpdateFly()
        elseif name == "Invisibility" then ModFunctions.UpdateInvisibility() end
    end)

    return ToggleFrame
end

-- // Función para Crear Slider Avanzado
local function CreateAdvancedSlider(parent, name, setting, displayName, min, max, default, yPos)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -30, 0, 35)
    SliderFrame.Position = UDim2.new(0, 15, 0, yPos)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.ZIndex = 3
    SliderFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = displayName..": "..default
    Label.TextColor3 = Colors.TextDim
    Label.TextSize = 13
    Label.Font = Enum.Font.RobotoMono
    Label.ZIndex = 3
    Label.Parent = SliderFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.55, 0, 0, 4)
    SliderBg.Position = UDim2.new(0.45, 0, 0.5, -2)
    SliderBg.BackgroundColor3 = Colors.SliderBg
    SliderBg.CornerRadius = UDim.new(1, 0)
    SliderBg.ZIndex = 3
    SliderBg.Parent = SliderFrame

    local SliderFill = Instance.new("Frame")
    Slider
    ,
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)

    -- Slider si es necesario
    if hasSlider then
        local Slider = Instance.new("Frame")
        Slider.Size = UDim2.new(0.5, 0, 0, 25)
        Slider.Position = UDim2.new(0.25, 0, 1, 5)
        Slider.BackgroundTransparency = 1
        Slider.Parent = ToggleFrame

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(0.3, 0, 1, 0)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = "Valor: "..defaultVal
        SliderLabel.TextColor3 = Colors.TextDim
        SliderLabel.TextSize = 12
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.Parent = Slider

        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(0.65, 0, 0, 4)
        SliderBg.Position = UDim2.new(0.35, 0, 0.5, -2)
        SliderBg.BackgroundColor3 = Colors.Secondary
        SliderBg.CornerRadius = UDim.new(1, 0)
        SliderBg.Parent = Slider

        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((defaultVal - sliderMin)/(sliderMax - sliderMin), 0, 1, 0)
        SliderFill.BackgroundColor3 = Colors.Primary
        SliderFill.CornerRadius = UDim.new(1, 0)
        SliderFill.Parent = SliderBg

        local SliderKnob = Instance.new("Frame")
        SliderKnob.Size = UDim2.new(0, 12, 0, 12)
        SliderKnob.Position = UDim2.new((defaultVal - sliderMin)/(sliderMax - sliderMin), -6, 0.5, -6)
        SliderKnob.BackgroundColor3 = Colors.PrimaryActive
        SliderKnob.CornerRadius = UDim.new(1, 0)
        SliderKnob.ZIndex = 2
        SliderKnob.Parent = SliderBg

        -- Lógica del Slider
        local Dragging = false
        local function UpdateSlider(posX)
            local relX = posX - SliderBg.AbsolutePosition.X
            local percent = math.clamp(relX / SliderBg.AbsoluteSize.X, 0, 1)
            local value = math.round(sliderMin + percent * (sliderMax - sliderMin))
            
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderKnob.Position = UDim2.new(percent, -6, 0.5, -6)
            SliderLabel.Text = "Valor: "..value
            
            ModFunctions[name].Value = value
            if ModFunctions[name].Enabled then
                ModFunctions[name].Set(true, value)
            end
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
                UpdateSlider(UserInputService:GetMouseLocation
                        
