-- LocalScript en StarterGui

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Crear Frame (panel movible estilizado)
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 240, 0, 320)
panel.Position = UDim2.new(0, 50, 0, 50)
panel.BackgroundColor3 = Color3.fromRGB(25,25,35)
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Parent = screenGui

-- UICorner para bordes redondeados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = panel

-- Etiqueta de título
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1,0,0,40)
titulo.BackgroundTransparency = 1
titulo.Text = "⚙️ Control Panel"
titulo.TextColor3 = Color3.fromRGB(255,255,255)
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 20
titulo.Parent = panel

-- Función para crear botones estilizados
local function crearBoton(texto, callback, parent, y)
    local boton = Instance.new("TextButton")
    boton.Size = UDim2.new(1, -20, 0, 35)
    boton.Position = UDim2.new(0, 10, 0, y)
    boton.BackgroundColor3 = Color3.fromRGB(45,45,65)
    boton.TextColor3 = Color3.fromRGB(255,255,255)
    boton.Font = Enum.Font.Gotham
    boton.TextSize = 16
    boton.Text = texto
    boton.Parent = parent

    -- Bordes redondeados
    local bcorner = Instance.new("UICorner")
    bcorner.CornerRadius = UDim.new(0,8)
    bcorner.Parent = boton

    -- Animación hover
    boton.MouseEnter:Connect(function()
        boton.BackgroundColor3 = Color3.fromRGB(70,70,120)
    end)
    boton.MouseLeave:Connect(function()
        boton.BackgroundColor3 = Color3.fromRGB(45,45,65)
    end)

    boton.MouseButton1Click:Connect(callback)
    return boton
end

-- Funciones de Admin Panel
local function velocidad() humanoid.WalkSpeed = 50 end
local function superSalto() humanoid.JumpPower = 150 end
local function jugadorCercano()
    local closest, shortestDist = nil, math.huge
    for _, other in pairs(game.Players:GetPlayers()) do
        if other ~= player and other.Character and other.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (character.HumanoidRootPart.Position - other.Character.HumanoidRootPart.Position).Magnitude
            if dist < shortestDist then shortestDist, closest = dist, other end
        end
    end
    if closest then print("Jugador cercano: "..closest.Name) end
end
local function ocultarPersonaje()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
    end
end
local function teleport() character:MoveTo(Vector3.new(0,50,0)) end
local function invisibilidad()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then part.Transparency = 0.5 end
    end
    humanoid.NameDisplayDistance = 0
end
local flying, bodyVelocity = false, nil
local function fly()
    flying = not flying
    if flying then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
        bodyVelocity.Parent = character.HumanoidRootPart
    else
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

-- Botones principales
crearBoton("Optimización", function() print("Optimización ejecutada") end, panel, 50)
crearBoton("Tradeo Simulado", function() print("Tradeo simulado") end, panel, 90)
crearBoton("Actualizaciones", function() print("Actualizaciones disponibles") end, panel, 130)

-- Admin Panel toggle
local adminFrame = Instance.new("Frame")
adminFrame.Size = UDim2.new(1, -20, 0, 200)
adminFrame.Position = UDim2.new(0, 10, 0, 170)
adminFrame.BackgroundColor3 = Color3.fromRGB(35,35,50)
adminFrame.Visible = false
adminFrame.Parent = panel

local acorner = Instance.new("UICorner")
acorner.CornerRadius = UDim.new(0,10)
acorner.Parent = adminFrame

crearBoton("Admin Panel", function()
    adminFrame.Visible = not adminFrame.Visible
end, panel, 210)

-- Botones Admin Panel
crearBoton("Velocidad", velocidad, adminFrame, 10)
crearBoton("Super Salto", superSalto, adminFrame, 50)
crearBoton("Jugador Cercano", jugadorCercano, adminFrame, 90)
crearBoton("Ocultar Personaje", ocultarPersonaje, adminFrame, 130)
crearBoton("Teleport", teleport, adminFrame, 170)
crearBoton("Invisibilidad", invisibilidad, adminFrame, 210)
crearBoton("Fly", fly, adminFrame, 250)
