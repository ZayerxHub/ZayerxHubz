--// Roblox Key UI Script

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyUI"
screenGui.Parent = playerGui

-- สร้าง Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 220)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- เพิ่มมุมโค้ง
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- TextBox สำหรับกรอก Key
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 300, 0, 50)
keyBox.Position = UDim2.new(0.5, -150, 0.25, 0)
keyBox.PlaceholderText = "Enter your key"
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.BorderSizePixel = 0
keyBox.TextScaled = true
keyBox.Parent = mainFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyBox

-- ปุ่ม Check Key
local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(0, 140, 0, 50)
checkButton.Position = UDim2.new(0.1, 0, 0.7, 0)
checkButton.Text = "Check Key"
checkButton.BackgroundColor3 = Color3.fromRGB(70,130,180)
checkButton.TextColor3 = Color3.fromRGB(255,255,255)
checkButton.BorderSizePixel = 0
checkButton.TextScaled = true
checkButton.Parent = mainFrame

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 12)
checkCorner.Parent = checkButton

-- ปุ่ม Get Key
local getButton = Instance.new("TextButton")
getButton.Size = UDim2.new(0, 140, 0, 50)
getButton.Position = UDim2.new(0.6, 0, 0.7, 0)
getButton.Text = "Get Key"
getButton.BackgroundColor3 = Color3.fromRGB(50,205,50)
getButton.TextColor3 = Color3.fromRGB(255,255,255)
getButton.BorderSizePixel = 0
getButton.TextScaled = true
getButton.Parent = mainFrame

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 12)
getCorner.Parent = getButton

-- Key ที่กำหนด
local validKey = "MYSECRETKEY"  -- แก้เป็น key ของคุณ
local getLink = "https://yourlink.com"  -- แก้เป็นลิ้งค์ที่ต้องการ

-- ฟังก์ชัน Notification
local function showNotification(text, color)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 50)
    notif.Position = UDim2.new(0.5, -150, 0.1, 0)
    notif.BackgroundColor3 = color
    notif.BorderSizePixel = 0
    notif.Parent = screenGui

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notif

    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1,0,1,0)
    notifText.Text = text
    notifText.TextColor3 = Color3.fromRGB(255,255,255)
    notifText.BackgroundTransparency = 1
    notifText.TextScaled = true
    notifText.Parent = notif

    -- Animation เลื่อนขึ้น
    local tweenUp = TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0.05, 0)})
    tweenUp:Play()

    -- รอ 1.5 วินาที แล้วเลื่อนออก
    tweenUp.Completed:Connect(function()
        wait(1.5)
        local tweenOut = TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, -0.1, 0), BackgroundTransparency = 1, })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notif:Destroy()
        end)
    end)
end

-- ปุ่ม Check Key
checkButton.MouseButton1Click:Connect(function()
    if keyBox.Text == validKey then
        showNotification("Key Valid ✅", Color3.fromRGB(0,128,255))
        screenGui:Destroy()
    else
        showNotification("Wrong Key ❌", Color3.fromRGB(255,69,0))
    end
end)

-- ปุ่ม Get Key
getButton.MouseButton1Click:Connect(function()
    setclipboard(getLink)
    showNotification("Link Copied 📋", Color3.fromRGB(0,200,0))
end)
