--[[
    REPOSITORY: 99-cookie
    VERSION: 2.0.0 (99 Nights in the Forest Edition)
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Cleanup old UI
if pGui:FindFirstChild("99CookieUI") then pGui["99CookieUI"]:Destroy() end

-- UI Setup
local sg = Instance.new("ScreenGui", pGui)
sg.Name = "99CookieUI"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 170, 0, 130)
main.Position = UDim2.new(0.05, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "FOREST HACK"
title.BackgroundColor3 = Color3.fromRGB(34, 139, 34) -- Forest Green
title.TextColor3 = Color3.new(1, 1, 1)

-- 1. GOD MODE BUTTON
local godBtn = Instance.new("TextButton", main)
godBtn.Size = UDim2.new(0, 150, 0, 35)
godBtn.Position = UDim2.new(0, 10, 0, 35)
godBtn.Text = "GOD MODE: OFF"
godBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)

-- 2. BRING LOOT BUTTON
local lootBtn = Instance.new("TextButton", main)
lootBtn.Size = UDim2.new(0, 150, 0, 35)
lootBtn.Position = UDim2.new(0, 10, 0, 80)
lootBtn.Text = "BRING ALL LOGS/FOOD"
lootBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- LOGIC: Optimized for 99 Nights
local godActive = false
godBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    godBtn.Text = godActive and "GOD MODE: ON" or "GOD MODE: OFF"
    godBtn.BackgroundColor3 = godActive and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(80, 0, 0)
    
    spawn(function()
        while godActive do
            pcall(function()
                local char = player.Character
                if char then
                    -- Reset standard health
                    if char:FindFirstChild("Humanoid") then
                        char.Humanoid.Health = char.Humanoid.MaxHealth
                    end
                    -- Attempt to fix custom "Hunger/Thirst" if the game stores them in the character
                    for _, val in pairs(char:GetChildren()) do
                        if val:IsA("NumberValue") or val:IsA("IntValue") then
                            if val.Name:find("Hunger") or val.Name:find("Stats") then
                                val.Value = 100
                            end
                        end
                    end
                end
            end)
            wait(0.5)
        end
    end)
end)

lootBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    -- Specific item names for 99 Nights in the Forest
    local targets = {"Log", "Stick", "Apple", "Berry", "Meat", "Wood"}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            for _, name in pairs(targets) do
                if obj.Name:find(name) and not obj.Anchored then
                    obj.CFrame = root.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end
    end
end)

print("99-cookie: Forest Edition Loaded!")
