-- // Solución para error "attempt to call a nil value"
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- // Función alternativa para cargar el script (adaptada a ejecutores modernos)
local function LoadScript(url)
    local success, response = pcall(function()
        -- Intentar obtener el contenido de la URL (métodos alternativos)
        local content = game:HttpGet(url, true) -- El segundo parámetro ignora caché
        if not content then
            content = HttpService:GetAsync(url, true)
        end
        return content
    end)

    if success and response then
        -- Ejecutar el script con métodos alternativos a loadstring
        local func = loadstring(response)
        if func then
            func()
            warn("Script cargado exitosamente!")
        else
            -- Método alternativo si loadstring no está disponible
            local scriptInstance = Instance.new("LocalScript")
            scriptInstance.Name = "LoadedHub"
            scriptInstance.Source = response
            scriptInstance.Parent = Player.PlayerGui
            warn("Script cargado como LocalScript!")
        end
    else
        error("No se pudo cargar el script: "..tostring(response))
    end
end

-- // Ejecutar la carga (comprobamos la URL primero)
local ScriptURL = "https://raw.githubusercontent.com/yamiram33/Hhub/refs/heads/main/Ex.lua"
pcall(function()
    LoadScript(ScriptURL)
end)
