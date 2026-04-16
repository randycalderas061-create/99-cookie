--[[
    99-COOKIE: ULTIMATE GRINDER
    Target: 99 Nights in the Forest
--]]

local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Safety Cleanup
if pGui:FindFirstChild("99CookieUI") then pGui["99CookieUI"]:Destroy() end

-- UI Construction
local sg = Instance.new("ScreenGui", pGui)
sg.Name = "99CookieUI"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 180, 0, 180)
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Stylish Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 25)
header.BackgroundColor3 = Color3.fromRGB(0, 150, 255)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "99-COOKIE GRINDER"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold

-- Button Helper
local function makeBtn(text, pos, color)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    return btn
end

local godBtn = makeBtn("GOD MODE: OFF", UDim2.new(0, 10, 0, 35), Color3.fromRGB(150, 0, 0))
local bringBtn = makeBtn("BRING LOGS", UDim2.new(0, 10, 0, 80), Color3.fromRGB(60, 60, 60))
local magnetBtn = makeBtn("DIAMOND MAGNET: OFF", UDim2.new(0, 10, 0, 125), Color3.fromRGB(0, 80, 150))

-- LOGIC
local godActive = false
local magnetActive = false

godBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    godBtn.Text = godActive and "GOD MODE: ON" or "GOD MODE: OFF"
    godBtn.BackgroundColor3 = godActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    spawn(function()
        while godActive do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 100
            end
            wait(0.5)
        end
    end)
end)

bringBtn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored == false and (v.Name:lower():find("log") or v.Name:lower():find("wood")) then
            v.CFrame = root.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

magnetBtn.MouseButton1Click:Connect(function()
    magnetActive = not magnetActive
    magnetBtn.Text = magnetActive and "MAGNET: ON" or "MAGNET: OFF"
    magnetBtn.BackgroundColor3 = magnetActive and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(0, 80, 150)
    
    spawn(function()
        while magnetActive do
            pcall(function()
                local root = player.Character.HumanoidRootPart
                for _, v in pairs(workspace:GetDescendants()) do
                    -- Looking for Diamonds, Gems, or Chests
                    if v:IsA("BasePart") and not v.Anchored then
                        local name = v.Name:lower()
                        if name:find("diamond") or name:find("gem") or name:find("chest") then
                            v.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                end
            end)
            wait(2) -- Scans every 2 seconds to prevent lag
        end
    end)
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "99-Cookie",
    Text = "Grinder Loaded!",
    Duration = 5
})
