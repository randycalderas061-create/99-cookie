--[[
    REPOSITORY: 99-cookie
    VERSION: 2.1.0 (99 Nights in the Forest)
--]]

local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Remove old versions
if pGui:FindFirstChild("99CookieUI") then pGui["99CookieUI"]:Destroy() end

-- UI Design
local sg = Instance.new("ScreenGui", pGui)
sg.Name = "99CookieUI"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 180, 0, 140)
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 40, 20) -- Dark Forest Theme
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "99 NIGHTS HELPER"
title.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
title.TextColor3 = Color3.new(1, 1, 1)

local godBtn = Instance.new("TextButton", main)
godBtn.Size = UDim2.new(0, 160, 0, 40)
godBtn.Position = UDim2.new(0, 10, 0, 40)
godBtn.Text = "GOD/HUNGER: OFF"
godBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)

local lootBtn = Instance.new("TextButton", main)
lootBtn.Size = UDim2.new(0, 160, 0, 40)
lootBtn.Position = UDim2.new(0, 10, 0, 90)
lootBtn.Text = "BRING LOGS/STUFF"
lootBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- LOGIC: 99 Nights Specific
local active = false
godBtn.MouseButton1Click:Connect(function()
    active = not active
    godBtn.Text = active and "GOD/HUNGER: ON" or "GOD/HUNGER: OFF"
    godBtn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 20, 20)
    
    spawn(function()
        while active do
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    -- Standard Health
                    char.Humanoid.Health = char.Humanoid.MaxHealth
                    
                    -- Forest Game Stats (Hunger/Energy)
                    -- Many forest games store stats in a folder named 'Stats' or 'Data'
                    local stats = char:FindFirstChild("Stats") or player:FindFirstChild("Stats") or player:FindFirstChild("leaderstat")
                    if stats then
                        for _, v in pairs(stats:GetChildren()) do
                            if v:IsA("NumberValue") or v:IsA("IntValue") then
                                v.Value = 100 -- Set Hunger/Thirst/Energy to max
                            end
                        end
                    end
                end
            end)
            wait(1)
        end
    end)
end)

lootBtn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Specific item detection for this game
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            local n = obj.Name:lower()
            if n:find("log") or n:find("stick") or n:find("apple") or n:find("meat") or n:find("berry") then
                obj.CFrame = root.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)

print("99-cookie: 99 Nights Version Loaded!")
