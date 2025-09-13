--// CONFIG
local KeyLink = "https://yourwebsite.com/getkey" -- ลิงก์หน้า Get Key
local CorrectKey = "MYSECRETKEY123" -- Key ที่ถูกต้อง

--// UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local GetKeyBtn = Instance.new("TextButton")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UICorner.Parent = MainFrame
UIStroke.Parent = MainFrame
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(100, 100, 255)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ZayerxHub Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

KeyBox.Parent = MainFrame
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
Instance.new("UICorner", KeyBox)

SubmitBtn.Parent = MainFrame
SubmitBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.35, 0, 0, 35)
SubmitBtn.Text = "Submit"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 40)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 16
Instance.new("UICorner", SubmitBtn)

GetKeyBtn.Parent = MainFrame
GetKeyBtn.Position = UDim2.new(0.55, 0, 0.55, 0)
GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 35)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 200)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 16
Instance.new("UICorner", GetKeyBtn)

--// Functions
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        MainFrame:Destroy()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Key System",
            Text = "✅ Key correct!",
            Duration = 3
        })
    else
        game.Players.LocalPlayer:Kick("❌ Wrong Key! Please try again.")
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(KeyLink)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Key System",
        Text = "✅ Link copied! Paste in browser.",
        Duration = 3
    })
end)
