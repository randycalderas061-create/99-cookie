--[[
    REPOSITORY: 99-cookie
    VERSION: 1.9.0 (Console Error Fix)
--]]

-- Standard variables (Using 'wait' instead of 'task' for better emulator support)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- 1. DELETE OLD UI IF IT EXISTS
if pGui:FindFirstChild("99CookieUI") then
    pGui:FindFirstChild("99CookieUI"):Destroy()
end

-- 2. CREATE UI (The "Bare Bones" way to prevent nil errors)
local sg = Instance.new("ScreenGui")
sg.Name = "99CookieUI"
sg.Parent = pGui
sg.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Parent = sg
main.Size = UDim2.new(0, 160, 0, 100)
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 2
main.Active = true
main.Draggable = true

local god = Instance.new("TextButton")
god.Parent = main
god.Size = UDim2.new(0, 140, 0, 35)
god.Position = UDim2.new(0, 10, 0, 10)
god.Text = "GOD: OFF"
god.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
god.TextColor3 = Color3.new(1, 1, 1)

local bring = Instance.new("TextButton")
bring.Parent = main
bring.Size = UDim2.new(0, 140, 0, 35)
bring.Position = UDim2.new(0, 10, 0, 55)
bring.Text = "BRING ITEMS"
bring.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bring.TextColor3 = Color3.new(1, 1, 1)

-- 3. LOGIC (Using old-school 'spawn' for stability)
local active = false

god.MouseButton1Click:Connect(function()
    active = not active
    god.Text = active and "GOD: ON" or "GOD: OFF"
    god.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    spawn(function()
        while active do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 100
            end
            wait(0.5) -- Using standard wait() for Delta stability
        end
    end)
end)

bring.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("BasePart") and not v.Anchored then
                v.CFrame = root.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)

print("99-cookie: Script Fully Loaded!")
