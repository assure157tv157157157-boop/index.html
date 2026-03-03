--[[
    spectra universal 
]]

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "spectra admin",
    Icon = "rbxassetid://84228153855933",
    Author = "by spectra estúdios",
    Folder = "spectra",
    Size = UDim2.fromOffset(550, 400), -- Aumentei um pouco para caber mais coisas
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 190,
    HasOutline = false,
    HideSearchBar = true,
    ScrollBarEnabled = false,

    Background = "rbxassetid://82282255582538",
    BackgroundImageTransparency = 0.10,

    User = {
        Enabled = true,
        Anonymous = false
    },
})

Window:EditOpenButton({
    Title = "spectra",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(220, 100, 0)
    ),
    Draggable = true
})

-- ========== SERVIÇOS ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ========== CONFIGURAÇÕES GLOBAIS ==========
local AimbotConfig = {
    Enabled = false,
    FOV = 120,
    RecoilControl = 50,
    SmoothingAmount = 0.15,
    LockOnSpeed = 0.5,
    WallhackEnabled = false,
    ShowFOV = true,
    TargetPart = "Head", -- "Head", "Torso", "Legs", "Any"
}

local HitboxConfig = {
    Enabled = false,
    Size = 10,
    Transparency = 0.7,
    ColorIndex = 1,  -- índice da cor atual
    Rainbow = false,
}

-- Lista de cores para o hitbox (mesma do script original)
local HitboxColors = {
    { name = "Red", color = Color3.fromRGB(255, 0, 0), brickcolor = BrickColor.new("Really red") },
    { name = "Black", color = Color3.fromRGB(0, 0, 0), brickcolor = BrickColor.new("Black") },
    { name = "Orange", color = Color3.fromRGB(255, 120, 0), brickcolor = BrickColor.new("Bright orange") },
    { name = "Yellow", color = Color3.fromRGB(255, 255, 0), brickcolor = BrickColor.new("New Yeller") },
    { name = "Green", color = Color3.fromRGB(0, 255, 0), brickcolor = BrickColor.new("Lime green") },
    { name = "Blue", color = Color3.fromRGB(0, 120, 255), brickcolor = BrickColor.new("Bright blue") },
    { name = "Purple", color = Color3.fromRGB(180, 0, 255), brickcolor = BrickColor.new("Royal purple") },
    { name = "Pink", color = Color3.fromRGB(255, 40, 157), brickcolor = BrickColor.new("Hot pink") },
    { name = "White", color = Color3.fromRGB(255,255,255), brickcolor = BrickColor.new("White") },
    { name = "Light Gray", color = Color3.fromRGB(200,200,200), brickcolor = BrickColor.new("Light stone grey") },
    { name = "Dark Gray", color = Color3.fromRGB(80,80,80), brickcolor = BrickColor.new("Dark stone grey") },
    { name = "Brown", color = Color3.fromRGB(101,67,33), brickcolor = BrickColor.new("Brown") },
    { name = "Dark Brown", color = Color3.fromRGB(60,40,20), brickcolor = BrickColor.new("Reddish brown") },
    { name = "Beige", color = Color3.fromRGB(245,245,220), brickcolor = BrickColor.new("Brick yellow") },
    { name = "Cyan", color = Color3.fromRGB(0,255,255), brickcolor = BrickColor.new("Cyan") },
    { name = "Magenta", color = Color3.fromRGB(255,0,255), brickcolor = BrickColor.new("Magenta") },
    { name = "Teal", color = Color3.fromRGB(0,128,128), brickcolor = BrickColor.new("Teal") },
    { name = "Navy", color = Color3.fromRGB(0,0,128), brickcolor = BrickColor.new("Navy blue") },
    { name = "Maroon", color = Color3.fromRGB(128,0,0), brickcolor = BrickColor.new("Maroon") },
    { name = "Olive", color = Color3.fromRGB(128,128,0), brickcolor = BrickColor.new("Olive") },
    { name = "Mint", color = Color3.fromRGB(152,255,152), brickcolor = BrickColor.new("Mint") },
    { name = "Lavender", color = Color3.fromRGB(230,230,250), brickcolor = BrickColor.new("Lavender") },
    { name = "Turquoise", color = Color3.fromRGB(64,224,208), brickcolor = BrickColor.new("Toothpaste") },
    { name = "Sky Blue", color = Color3.fromRGB(135,206,235), brickcolor = BrickColor.new("Pastel Blue") },
    { name = "Indigo", color = Color3.fromRGB(75,0,130), brickcolor = BrickColor.new("Dark indigo") },
    { name = "Gold", color = Color3.fromRGB(255,215,0), brickcolor = BrickColor.new("Gold") },
    { name = "Silver", color = Color3.fromRGB(192,192,192), brickcolor = BrickColor.new("Silver") },
    { name = "Crimson", color = Color3.fromRGB(220,20,60), brickcolor = BrickColor.new("Crimson") },
    { name = "Coral", color = Color3.fromRGB(255,127,80), brickcolor = BrickColor.new("Salmon") },
    { name = "Salmon", color = Color3.fromRGB(250,128,114), brickcolor = BrickColor.new("Salmon") },
    { name = "Khaki", color = Color3.fromRGB(240,230,140), brickcolor = BrickColor.new("Khaki") },
    { name = "Plum", color = Color3.fromRGB(221,160,221), brickcolor = BrickColor.new("Plum") },
    { name = "Orchid", color = Color3.fromRGB(218,112,214), brickcolor = BrickColor.new("Orchid") },
    { name = "Chocolate", color = Color3.fromRGB(210,105,30), brickcolor = BrickColor.new("Dark orange") },
    { name = "Scarlet", color = Color3.fromRGB(255,36,0), brickcolor = BrickColor.new("Bright red") },
    { name = "Emerald", color = Color3.fromRGB(80,200,120), brickcolor = BrickColor.new("Shamrock") },
    { name = "Lime", color = Color3.fromRGB(191,255,0), brickcolor = BrickColor.new("Lime green") },
    { name = "Amber", color = Color3.fromRGB(255,191,0), brickcolor = BrickColor.new("Bright yellowish orange") },
    { name = "Ivory", color = Color3.fromRGB(255,255,240), brickcolor = BrickColor.new("Institutional white") },
    { name = "Charcoal", color = Color3.fromRGB(54,69,79), brickcolor = BrickColor.new("Dark stone grey") },
    { name = "Aqua", color = Color3.fromRGB(0,255,200), brickcolor = BrickColor.new("Cyan") },
    { name = "Rose", color = Color3.fromRGB(255,102,204), brickcolor = BrickColor.new("Carnation pink") },
    { name = "Fuchsia", color = Color3.fromRGB(255,0,128), brickcolor = BrickColor.new("Deep pink") },
    { name = "Azure", color = Color3.fromRGB(0,127,255), brickcolor = BrickColor.new("Bright blue") },
    { name = "Violet", color = Color3.fromRGB(143,0,255), brickcolor = BrickColor.new("Royal purple") },
    { name = "Copper", color = Color3.fromRGB(184,115,51), brickcolor = BrickColor.new("Copper") },
    { name = "Bronze", color = Color3.fromRGB(205,127,50), brickcolor = BrickColor.new("Bronze") },
    { name = "Sand", color = Color3.fromRGB(194,178,128), brickcolor = BrickColor.new("Sand yellow") },
    { name = "Ice Blue", color = Color3.fromRGB(173,216,230), brickcolor = BrickColor.new("Light blue") },
    { name = "Forest", color = Color3.fromRGB(34,139,34), brickcolor = BrickColor.new("Earth green") },
    { name = "Sea Green", color = Color3.fromRGB(46,139,87), brickcolor = BrickColor.new("Sea green") },
    { name = "Midnight", color = Color3.fromRGB(25,25,112), brickcolor = BrickColor.new("Midnight blue") },
    { name = "Rainbow", color = nil, brickcolor = nil },
}

local TargetedPlayer = nil
local FOVCircle = nil

-- ========== FUNÇÕES DO AIMBOT ==========

local function CreateFOVCircle()
    pcall(function()
        if FOVCircle then
            pcall(function() FOVCircle:Destroy() end)
        end
        
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Visible = false
        FOVCircle.Radius = AimbotConfig.FOV
        FOVCircle.Color = Color3.fromRGB(255, 0, 0)
        FOVCircle.Thickness = 3
        FOVCircle.Transparency = 0.4
        FOVCircle.Filled = false
    end)
end

local function UpdateFOVCircle()
    if not FOVCircle then return end
    pcall(function()
        local ScreenSize = Camera.ViewportSize
        local CenterX = ScreenSize.X / 2
        local CenterY = ScreenSize.Y / 2
        
        FOVCircle.Position = Vector2.new(CenterX, CenterY)
        FOVCircle.Radius = AimbotConfig.FOV
        FOVCircle.Visible = AimbotConfig.ShowFOV and AimbotConfig.Enabled
    end)
end

local function GetAlivePlayers()
    local AlivePlayers = {}
    for _, player in pairs(Players:GetPlayers()) do
        pcall(function()
            if player ~= LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    table.insert(AlivePlayers, player)
                end
            end
        end)
    end
    return AlivePlayers
end

local function GetDistanceToPlayerScreen(player)
    local success, distance = pcall(function()
        if not player.Character or not player.Character:FindFirstChild("Head") then
            return math.huge
        end
        
        local ScreenSize = Camera.ViewportSize
        local CenterX = ScreenSize.X / 2
        local CenterY = ScreenSize.Y / 2
        
        local PlayerPos, OnScreen = Camera:WorldToScreenPoint(player.Character.Head.Position)
        if not OnScreen then return math.huge end
        
        return math.sqrt((PlayerPos.X - CenterX)^2 + (PlayerPos.Y - CenterY)^2)
    end)
    return success and distance or math.huge
end

local function FindNearestPlayerInFOV()
    local ClosestPlayer = nil
    local ClosestDistance = AimbotConfig.FOV
    
    for _, player in pairs(GetAlivePlayers()) do
        local Distance = GetDistanceToPlayerScreen(player)
        if Distance < ClosestDistance then
            ClosestPlayer = player
            ClosestDistance = Distance
        end
    end
    
    return ClosestPlayer
end

-- Retorna a parte do corpo alvo de acordo com a configuração
local function GetTargetPart(character)
    if not character then return nil end
    
    local part = nil
    if AimbotConfig.TargetPart == "Head" then
        part = character:FindFirstChild("Head")
    elseif AimbotConfig.TargetPart == "Torso" then
        part = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    elseif AimbotConfig.TargetPart == "Legs" then
        -- Tenta perna esquerda, senão direita
        part = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftLowerLeg") or 
               character:FindFirstChild("Right Leg") or character:FindFirstChild("RightLowerLeg")
    elseif AimbotConfig.TargetPart == "Any" then
        -- Qualquer parte: pega a cabeça como padrão (ou poderia ser o centro)
        part = character:FindFirstChild("Head")
    end
    return part
end

local function AimAtPlayer(player)
    pcall(function()
        if not player or not player.Character then return end
        
        local targetPart = GetTargetPart(player.Character)
        if not targetPart then return end
        
        local TargetPos = targetPart.Position
        local CurrentCFrame = Camera.CFrame
        local DirectionToTarget = (TargetPos - CurrentCFrame.Position)
        
        local NewCFrame = CFrame.new(CurrentCFrame.Position, TargetPos)
        
        local TotalSmoothing = AimbotConfig.SmoothingAmount + (AimbotConfig.LockOnSpeed * 0.1)
        Camera.CFrame = CurrentCFrame:Lerp(NewCFrame, math.min(TotalSmoothing, 0.5))
    end)
end

local function AimbotLoop()
    if not AimbotConfig.Enabled then
        TargetedPlayer = nil
        return
    end
    
    UpdateFOVCircle()
    
    local NearestPlayer = FindNearestPlayerInFOV()
    if NearestPlayer then
        TargetedPlayer = NearestPlayer
        AimAtPlayer(TargetedPlayer)
    else
        TargetedPlayer = nil
    end
end

local AimbotConnection = RunService.Heartbeat:Connect(AimbotLoop)

-- ========== FUNÇÕES DO HITBOX ==========

-- Reseta o hitbox de um jogador para o tamanho normal
local function ResetPlayerHitbox(player)
    pcall(function()
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 0
                hrp.BrickColor = BrickColor.new("Medium stone grey")
                hrp.Material = Enum.Material.Plastic
                hrp.CanCollide = true
                hrp.Massless = false
            end
        end
    end)
end

-- Aplica as configurações de hitbox em um jogador
local function ApplyHitboxToPlayer(player)
    pcall(function()
        if not player.Character then return end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local size = HitboxConfig.Size
        hrp.Size = Vector3.new(size * 1.35, size * 1.9, size * 1.35)
        hrp.Transparency = HitboxConfig.Transparency
        hrp.CanCollide = false
        hrp.Massless = true
        
        if HitboxConfig.Rainbow then
            local t = tick()
            local r = math.abs(math.sin(t*1))
            local g = math.abs(math.sin(t*1 + math.pi/3))
            local b = math.abs(math.sin(t*1 + 2*math.pi/3))
            hrp.Color = Color3.new(r, g, b)
            hrp.Material = Enum.Material.Neon
        else
            local colorData = HitboxColors[HitboxConfig.ColorIndex]
            if colorData and colorData.brickcolor then
                hrp.BrickColor = colorData.brickcolor
                hrp.Color = colorData.color
                hrp.Material = Enum.Material.Neon
            end
        end
    end)
end

-- Atualiza todos os jogadores com o hitbox ativo
local function UpdateHitboxes()
    if not HitboxConfig.Enabled then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ApplyHitboxToPlayer(player)
        end
    end
end

-- Reseta todos os jogadores (quando desativa)
local function ResetAllHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ResetPlayerHitbox(player)
        end
    end
end

-- Conexão para aplicar hitbox continuamente (para rainbow e atualizações)
local HitboxConnection = RunService.RenderStepped:Connect(UpdateHitboxes)

-- Gerenciar entrada/saída de jogadores e respawn
local function OnPlayerAdded(player)
    if player == LocalPlayer then return end
    -- Se o hitbox estiver ativo ao entrar, aplica
    if HitboxConfig.Enabled then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            ApplyHitboxToPlayer(player)
        end)
    end
end

local function OnPlayerRemoving(player)
    -- Não precisa fazer nada, o hitbox some junto
end

Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- Aplica hitbox em jogadores já existentes
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        OnPlayerAdded(player)
    end
end


-- ========== INTERFACE GRÁFICA (WindUI) ==========

-- Aba Tiro (Aimbot)
local TiroTab = Window:Tab({
    Title = "jogo de Tiro",
    Icon = "crosshair",
})

TiroTab:Section({
    Title = "|-- Aimbot Features --|",
    TextXAlignment = "Center",
    TextSize = 28,
})

local ToggleAimbot = TiroTab:Toggle({
    Title = "Enable Aimbot",
    Desc = "Ativa o aimbot para visar inimigos",
    Value = false,
    Callback = function(Value)
        AimbotConfig.Enabled = Value
        if not FOVCircle then CreateFOVCircle() end
        if Value then
            Window:Notify({ Title = "Aimbot", Content = "Aimbot ativado!", Icon = "check", Duration = 2 })
        else
            if FOVCircle then FOVCircle.Visible = false end
            Window:Notify({ Title = "Aimbot", Content = "Aimbot desativado!", Icon = "x", Duration = 2 })
        end
    end,
})

local SliderFOV = TiroTab:Slider({
    Title = "FOV Circle Size",
    Desc = "Tamanho do círculo de detecção",
    Step = 10,
    Value = { Min = 30, Max = 500, Default = 120 },
    Callback = function(Value)
        AimbotConfig.FOV = Value
        if FOVCircle then FOVCircle.Radius = Value end
    end,
})

local SliderSmoothing = TiroTab:Slider({
    Title = "Aim Smoothing",
    Desc = "0% = SNAP RÁPIDO | 100% = SUPER SUAVE",
    Step = 5,
    Value = { Min = 0, Max = 100, Default = 15 },
    Callback = function(Value)
        AimbotConfig.SmoothingAmount = Value / 100
    end,
})

local SliderLockSpeed = TiroTab:Slider({
    Title = "Lock-On Speed",
    Desc = "0% = INSTANTÂNEO | 100% = MUITO LENTO",
    Step = 5,
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(Value)
        AimbotConfig.LockOnSpeed = Value / 100
    end,
})

local SliderRecoil = TiroTab:Slider({
    Title = "Recoil Control",
    Desc = "Compensação de recuo (0-100%)",
    Step = 5,
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(Value)
        AimbotConfig.RecoilControl = Value
    end,
})


TiroTab:Toggle({
    Title = "Show FOV Circle",
    Desc = "Mostrar o círculo vermelho na tela",
    Value = true,
    Callback = function(Value)
        AimbotConfig.ShowFOV = Value
        if FOVCircle then FOVCircle.Visible = Value and AimbotConfig.Enabled end
    end,
})

-- NOVO: Seletor de parte do corpo
TiroTab:Dropdown({
    Title = "Body Part",
    Desc = "Escolha a parte do corpo para mirar",
    Values = { "Head", "Torso", "Legs", "Any" },
    Default = 1, -- Head
    Callback = function(Value)
        AimbotConfig.TargetPart = Value
        Window:Notify({ Title = "Target Part", Content = "Agora mirando: " .. Value, Duration = 2 })
    end,
})

TiroTab:Button({
    Title = "Reset All Settings",
    Desc = "Resetar todas as configurações do aimbot",
    Callback = function()
        ToggleAimbot:Set(false)
        SliderFOV:Set(120)
        SliderSmoothing:Set(15)
        SliderLockSpeed:Set(50)
        SliderRecoil:Set(50)
        ToggleWallhack:Set(false)
        -- O dropdown não tem set, mas pode ser ajustado manualmente
        AimbotConfig.TargetPart = "Head"
        Window:Notify({ Title = "Reset", Content = "Configurações do aimbot resetadas!", Icon = "refresh-cw", Duration = 2 })
    end,
})

-- ========== ABA HITBOX ==========
local HitboxTab = Window:Tab({
    Title = "Hitbox",
    Icon = "box",
})

HitboxTab:Section({
    Title = "|-- Hitbox Expander --|",
    TextXAlignment = "Center",
    TextSize = 28,
})

local ToggleHitbox = HitboxTab:Toggle({
    Title = "Enable Hitbox",
    Desc = "Aumenta o hitbox dos inimigos",
    Value = false,
    Callback = function(Value)
        HitboxConfig.Enabled = Value
        if Value then
            UpdateHitboxes() -- aplica imediatamente
            Window:Notify({ Title = "Hitbox", Content = "Hitbox ativado!", Icon = "check", Duration = 2 })
        else
            ResetAllHitboxes()
            Window:Notify({ Title = "Hitbox", Content = "Hitbox desativado!", Icon = "x", Duration = 2 })
        end
    end,
})

local SliderHitboxSize = HitboxTab:Slider({
    Title = "Hitbox Size",
    Desc = "Tamanho do hitbox (valor base)",
    Step = 1,
    Value = { Min = 1, Max = 1500, Default = 10 },
    Callback = function(Value)
        HitboxConfig.Size = Value
        if HitboxConfig.Enabled then UpdateHitboxes() end
    end,
})

local SliderHitboxTransparency = HitboxTab:Slider({
    Title = "Transparency",
    Desc = "Transparência do hitbox (0 a 1)",
    Step = 0.05,
    Value = { Min = 0, Max = 1, Default = 0.7 },
    Callback = function(Value)
        HitboxConfig.Transparency = Value
        if HitboxConfig.Enabled then UpdateHitboxes() end
    end,
})

-- Botão para alternar cores (cíclico)
local ColorButton = nil
local ColorLabel = HitboxColors[1].name
ColorButton = HitboxTab:Button({
    Title = "Color: " .. ColorLabel,
    Desc = "Clique para mudar a cor do hitbox",
    Callback = function()
        HitboxConfig.ColorIndex = HitboxConfig.ColorIndex + 1
        if HitboxConfig.ColorIndex > #HitboxColors then HitboxConfig.ColorIndex = 1 end
        
        local data = HitboxColors[HitboxConfig.ColorIndex]
        if data.name == "Rainbow" then
            HitboxConfig.Rainbow = true
        else
            HitboxConfig.Rainbow = false
        end
        ColorButton:SetTitle("Color: " .. data.name)
        if HitboxConfig.Enabled then UpdateHitboxes() end
    end,
})

-- Opção extra: toggle para rainbow (já incluso no ciclo, mas podemos adicionar um toggle separado se quiser)
-- Vou manter apenas o ciclo como no script original.

-- ========== ATALHO DE TECLADO ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightAlt and ToggleAimbot then
        ToggleAimbot:Set(not AimbotConfig.Enabled)
    end
end)

-- ========== LIMPEZA AO FECHAR ==========
game:GetService("CoreGui").DescendantRemoving:Connect(function(descendant)
    if descendant == Window.UIElements.Main then
        if AimbotConnection then AimbotConnection:Disconnect() end
        if HitboxConnection then HitboxConnection:Disconnect() end
        if FOVCircle then pcall(function() FOVCircle:Destroy() end) end
        ResetAllHitboxes() -- Restaura hitboxes originais
    end
end)


-- Aba Main
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "zap",
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Variáveis
local SpeedValue = 16
local JumpValue = 50
local GravityValue = 196.2
local SpinSpeed = 0
local Spinning = false
local Noclip = false

-- Função pegar character
local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- SPEED (estilo hacker)
MainTab:Slider({
    Title = "Speed Hacker",
    Min = 16,
    Max = 1000,
    Default = 16,
    Callback = function(Value)
        SpeedValue = Value
    end
})

-- Aplica speed estilo hack (movimentação forçada)
RunService.RenderStepped:Connect(function()
    local Char = GetCharacter()
    local Humanoid = Char:FindFirstChildOfClass("Humanoid")
    local HRP = Char:FindFirstChild("HumanoidRootPart")

    if Humanoid and HRP then
        Humanoid.WalkSpeed = 16 -- mantém normal

        if SpeedValue > 16 then
            local MoveDir = Humanoid.MoveDirection
            HRP.Velocity = Vector3.new(
                MoveDir.X * SpeedValue,
                HRP.Velocity.Y,
                MoveDir.Z * SpeedValue
            )
        end
    end
end)

-- JUMP POWER
MainTab:Slider({
    Title = "Jump Power",
    Min = 50,
    Max = 1000,
    Default = 50,
    Callback = function(Value)
        JumpValue = Value
        local Humanoid = GetCharacter():FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.JumpPower = JumpValue
        end
    end
})

-- GRAVIDADE
MainTab:Slider({
    Title = "Gravity",
    Min = 0,
    Max = 1000,
    Default = 196,
    Callback = function(Value)
        GravityValue = Value
        workspace.Gravity = GravityValue
    end
})

-- NOCLIP
MainTab:Toggle({
    Title = "Atravessar Paredes",
    Default = false,
    Callback = function(Value)
        Noclip = Value
    end
})

RunService.Stepped:Connect(function()
    if Noclip then
        for _, part in pairs(GetCharacter():GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- DPI / Tela mais lisa
MainTab:Slider({
    Title = "DPI Boost",
    Min = 0,
    Max = 1000,
    Default = 0,
    Callback = function(Value)
        -- simula "dpi" alterando FOV
        workspace.CurrentCamera.FieldOfView = 70 + (Value / 20)
    end
})

-- SPINBOT TOGGLE
MainTab:Toggle({
    Title = "Spinbot",
    Default = false,
    Callback = function(Value)
        Spinning = Value
    end
})

-- SPIN SPEED
MainTab:Slider({
    Title = "Spin Speed",
    Min = 0,
    Max = 5000,
    Default = 0,
    Callback = function(Value)
        SpinSpeed = Value
    end
})

-- Aplicar Spin
RunService.RenderStepped:Connect(function()
    if Spinning and SpinSpeed > 0 then
        local HRP = GetCharacter():FindFirstChild("HumanoidRootPart")
        if HRP then
            HRP.CFrame = HRP.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
        end
    end
end)

-- EXTRA 1: Super Zoom
MainTab:Slider({
    Title = "Super Zoom",
    Min = 10,
    Max = 120,
    Default = 70,
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end
})

-- EXTRA 2: Infinite Jump
local InfiniteJump = false

MainTab:Toggle({
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJump = Value
    end
})

UserInputService.JumpRequest:Connect(function()
    if InfiniteJump then
        local Humanoid = GetCharacter():FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)




print("✅ Script completo carregado!")
print("🎮 Alt Direito = Ativar/Desativar Aimbot")
print("🎯 Agora você pode escolher a parte do corpo no menu Tiro")
print("📦 Hitbox configurável na aba Hitbox")
