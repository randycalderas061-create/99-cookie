--[[
    99-COOKIE: DIAMOND GRINDER EDITION
--]]

local player = game:GetService("Players").LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

if pGui:FindFirstChild("99CookieUI") then pGui["99CookieUI"]:Destroy() end

local sg = Instance.new("ScreenGui", pGui)
sg.Name = "99CookieUI"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 180, 0, 180) -- Made it taller for the new button
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true

local function createBtn(text, pos, color)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1,1,1)
    return btn
end

local godBtn = createBtn("GOD MODE: OFF", UDim2.new(0, 10, 0, 10), Color3.fromRGB(150, 0, 0))
local bringBtn = createBtn("BRING LOGS/FOOD", UDim2.new(0, 10, 0, 60), Color3.fromRGB(50, 50, 50))
local gemBtn = createBtn("GET DIAMONDS/CHESTS", UDim2.new(0, 10, 0, 110), Color3.fromRGB(0, 100, 200))

-- DIAMOND GRINDER LOGIC
gemBtn.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local found = 0
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Model") then
            local name = v.Name:lower()
            -- Searches for common diamond/reward names in 99 Nights
            if name:find("diamond") or name:find("gem") or name:find("chest") or name:find("reward") then
                -- Teleport the item to the player
                if v:IsA("Model") then
                    v:MoveTo(root.Position + Vector3.new(0, 3, 0))
                else
                    v.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                end
                found = found + 1
            end
        end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Grinder Active",
        Text = "Found " .. found .. " potential rewards!",
        Duration = 3
    })
end)

-- Rest of the logic (God Mode & Logs) remains the same as v2.2.0
