local TweenService = game:GetService("TweenService")

-- Función para aplicar borde neón animado
local function addNeonBorder(slot)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Transparency = 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = slot

    -- Animación de rotación de color
    local colors = {
        Color3.fromRGB(0, 255, 255), -- Cian
        Color3.fromRGB(255, 0, 255), -- Magenta
        Color3.fromRGB(0, 255, 150), -- Verde neón
        Color3.fromRGB(255, 255, 0)  -- Amarillo eléctrico
    }

    task.spawn(function()
        while true do
            for _, col in ipairs(colors) do
                TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Color = col
                }):Play()
                task.wait(1)
            end
        end
    end)
end

-- Aplicar a los slots de ítems
addNeonBorder(myItem)
addNeonBorder(otherItem)
