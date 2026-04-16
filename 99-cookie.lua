--[[
    REPOSITORY: 99-cookie
    VERSION: 2.2.0 (Universal Forest Fix)
--]]

local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Cleanup
if pGui:FindFirstChild("99CookieUI") then pGui["99CookieUI"]:Destroy() end

local sg = Instance.new("ScreenGui", pGui)
sg.Name = "99CookieUI"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 180, 0, 140)
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Active = true 
main.Draggable = true

local godBtn = Instance.new("TextButton", main)
godBtn.Size = UDim2.new(0, 160, 0, 45)
godBtn.Position = UDim2.new(0, 10, 0, 10)
godBtn.Text = "GOD MODE: OFF"
godBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)

local bringBtn = Instance.new("TextButton", main)
bringBtn.Size = UDim2.new(0, 160, 0, 45)
bringBtn.Position = UDim2.new(0, 10, 0, 65)
bringBtn.Text = "BRING EVERYTHING"
bringBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)

-- LOGIC
local active = false
godBtn.MouseButton1Click:Connect(function()
    active = not active
    godBtn.Text = active and "GOD MODE: ON" or "GOD MODE: OFF"
    godBtn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 20, 20)
    
    spawn(function()
        while active do
            pcall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.Health = 100
                end
            end)
            wait(0.1) -- Faster check for God Mode
        end
    end)
end)

bringBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    -- BRUTE FORCE: Grab every unanchored part in the entire game
    -- This ignores names and just looks for "Physical" items
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored == false and not v:IsDescendantOf(char) then
            -- Make sure it's not a giant part like a house
            if v.Size.Magnitude < 20 then 
                v.CFrame = root.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)
