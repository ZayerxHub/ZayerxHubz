

-- CONFIG ----------
local VALID_KEY = "examplekey123@#β"
local KEY_LINK  = "https://your-key-link.example.com"
local NOTIFY_TIME = 3.5
-------------------

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer

-- Utility: create instances easily
local function create(instanceType, props, children)
	local obj = Instance.new(instanceType)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	for _, child in ipairs(children or {}) do
		child.Parent = obj
	end
	return obj
end

-- Colors
local color = {
	DeepBlue = Color3.fromRGB(10, 24, 61),
	Blue     = Color3.fromRGB(22, 96, 255),
	LtBlue   = Color3.fromRGB(28, 143, 255),
	Navy     = Color3.fromRGB(7, 12, 24),
	Green    = Color3.fromRGB(21, 196, 84),
	Red      = Color3.fromRGB(220, 69, 69),
	White    = Color3.fromRGB(255,255,255),
	GrayL    = Color3.fromRGB(200, 209, 220),
	GrayD    = Color3.fromRGB(30, 38, 55),
}

-- ScreenGui
local screen = create("ScreenGui", {
	Name = "ZayerxHubUI",
	IgnoreGuiInset = false,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, {})

-- Notification area (bottom-left)
local notifyArea = create("Frame", {
	Name = "NotifyArea",
	AnchorPoint = Vector2.new(0,1),
	Position = UDim2.new(0, 24, 1, -24),
	Size = UDim2.new(0, 520, 0, 400),
	BackgroundTransparency = 1,
}, {
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Padding = UDim.new(0, 12),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, {})
})
notifyArea.Parent = screen

-- Notification factory
local function notify(kind, titleText, bodyText, duration)
	duration = duration or NOTIFY_TIME
	local baseColor = color.GrayD
	local accent = color.LtBlue
	if kind == "success" then accent = color.Green end
	if kind == "error"   then accent = color.Red   end

	local frame = create("Frame", {
		Name = "Notification",
		Size = UDim2.new(0, 520, 0, 86),
		BackgroundColor3 = baseColor,
		BackgroundTransparency = 0.8, -- 80% transparent as requested
		ClipsDescendants = true,
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 14) }, {}),
		create("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(30, 80, 160),
			Thickness = 1.3,
			Transparency = 0.35,
		}, {}),
	})
	frame.Parent = notifyArea

	-- left accent bar
	create("Frame", {
		Parent = frame,
		Size = UDim2.new(0, 6, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundColor3 = accent,
		BackgroundTransparency = 0.15,
	}, { create("UICorner", { CornerRadius = UDim.new(0, 14) }, {}) })

	local header = create("TextLabel", {
		Parent = frame,
		Position = UDim2.new(0, 16, 0, 8),
		Size = UDim2.new(1, -100, 0, 28),
		Text = "ZayerxHub notification",
		Font = Enum.Font.FredokaOne,
		TextColor3 = color.White,
		TextSize = 26,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
	}, {})

	local body = create("TextLabel", {
		Parent = frame,
		Position = UDim2.new(0, 16, 0, 42),
		Size = UDim2.new(1, -100, 0, 30),
		Text = (titleText or "") .. ((bodyText and ("  " .. bodyText)) or ""),
		Font = Enum.Font.GothamSemibold,
		TextColor3 = Color3.fromRGB(210, 240, 220),
		TextSize = 20,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		RichText = true,
	}, {})

	-- Right "Z" badge
	local zBadge = create("TextLabel", {
		Parent = frame,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.new(0, 36, 0, 36),
		Text = "Z",
		Font = Enum.Font.FredokaOne,
		TextSize = 24,
		TextColor3 = color.White,
		BackgroundColor3 = accent,
		BackgroundTransparency = 0,
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 8) }, {})
	})

	-- appear
	frame.Size = UDim2.new(0, 520, 0, 0)
	tweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, 520, 0, 86)
	}):Play()

	-- auto-remove
	task.delay(duration, function()
		if not frame or not frame.Parent then return end
		local tween = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 520, 0, 0)
		})
		tween:Play()
		tween.Completed:Wait()
		if frame then frame:Destroy() end
	end)
end

-- Main dialog
local main = create("Frame", {
	Name = "KeyDialog",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(0, 720, 0, 360),
	BackgroundColor3 = color.DeepBlue,
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 20) }, {}),
	create("UIStroke", {
		Color = Color3.fromRGB(40, 90, 200),
		Transparency = 0.35,
		Thickness = 1.5,
	}, {}),
	create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 27, 64)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 117, 252)),
		}),
		Rotation = 10
	}, {})
})

local closeBtn = create("TextButton", {
	Parent = main,
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -12, 0, 10),
	Size = UDim2.new(0, 36, 0, 36),
	Text = "✕",
	Font = Enum.Font.FredokaOne,
	TextColor3 = color.Red,
	TextSize = 26,
	BackgroundTransparency = 1,
	AutoButtonColor = false,
}, {})

local title1 = create("TextLabel", {
	Parent = main,
	Position = UDim2.new(0, 26, 0, 24),
	Size = UDim2.new(1, -52, 0, 36),
	Text = "Welcome To The,",
	Font = Enum.Font.FredokaOne,
	TextColor3 = color.White,
	TextTransparency = 0.15,
	TextSize = 32,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
}, {})

local title2 = create("TextLabel", {
	Parent = main,
	Position = UDim2.new(0, 26, 0, 64),
	Size = UDim2.new(1, -52, 0, 44),
	Text = "ZayerxHub Key System",
	Font = Enum.Font.FredokaOne,
	TextColor3 = color.LtBlue,
	TextSize = 38,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
}, {})

create("TextLabel", {
	Parent = main,
	Position = UDim2.new(0, 26, 0, 110),
	Size = UDim2.new(1, -52, 0, 24),
	Text = "Have a Problem?  Discord",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 210, 255),
	TextTransparency = 0.2,
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
}, {})

create("TextLabel", {
	Parent = main,
	Position = UDim2.new(0, 26, 0, 160),
	Size = UDim2.new(0, 80, 0, 22),
	Text = "Key",
	Font = Enum.Font.GothamSemibold,
	TextColor3 = color.White,
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
}, {})

local keyBox = create("TextBox", {
	Parent = main,
	Position = UDim2.new(0, 26, 0, 188),
	Size = UDim2.new(0, 420, 0, 44),
	Text = "",
	PlaceholderText = "examplekey123@#β",
	Font = Enum.Font.Gotham,
	TextSize = 20,
	TextColor3 = color.White,
	PlaceholderColor3 = color.GrayL,
	ClearTextOnFocus = false,
	BackgroundColor3 = color.Blue,
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 10) }, {}),
	create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 88, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 143, 255)),
		})
	}, {})
})

local checkBtn = create("TextButton", {
	Parent = main,
	Position = UDim2.new(0, 460, 0, 188),
	Size = UDim2.new(0, 120, 0, 44),
	Text = "Cheak Key", -- matching screenshot label
	Font = Enum.Font.GothamSemibold,
	TextSize = 20,
	TextColor3 = color.White,
	AutoButtonColor = false,
	BackgroundColor3 = color.Green,
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 10) }, {}),
})

local getBtn = create("TextButton", {
	Parent = main,
	Position = UDim2.new(0, 590, 0, 188),
	Size = UDim2.new(0, 100, 0, 44),
	Text = "Get key",
	Font = Enum.Font.GothamSemibold,
	TextSize = 20,
	TextColor3 = color.White,
	AutoButtonColor = false,
	BackgroundColor3 = color.Red,
}, {
	create("UICorner", { CornerRadius = UDim.new(0, 10) }, {}),
})

-- Mount to PlayerGui
screen.Parent = localPlayer:WaitForChild("PlayerGui")
main.Parent = screen

-- Behavior
local function closeUI()
	if screen then
		screen:Destroy()
	end
end

closeBtn.MouseButton1Click:Connect(closeUI)

checkBtn.MouseButton1Click:Connect(function()
	local input = string.gsub(keyBox.Text or "", "^%s*(.-)%s*$", "%1")
	if input == "" then
		notify("error", "✖ Wrong key, please try again", nil, NOTIFY_TIME)
		return
	end

	if input == VALID_KEY then
		notify("success", "✔ Key valid", "  ⬤ Loading Script...", 2.2)
		-- small delay so the user can see the toast before closing
		task.delay(0.25, closeUI)
	else
		notify("error", "✖ Wrong key, please try again", nil, NOTIFY_TIME)
	end
end)

getBtn.MouseButton1Click:Connect(function()
	local ok = pcall(function()
		if setclipboard then
			setclipboard(KEY_LINK)
		else
			error("setclipboard not available")
		end
	end)

	if ok then
		notify("success", "✔ Copy the key link to your clipboard.", nil, NOTIFY_TIME)
	else
		notify("error", "✖ Unable to copy automatically.", "  "..KEY_LINK, 6)
	end
end)
