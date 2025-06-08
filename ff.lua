-- إعدادات أولية
local Player = game.Players.LocalPlayer
local Gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Gui.Name = "DrugsHubGUI"
Gui.ResetOnSpawn = false

-- صوت ترحيبي
local welcomeSound = Instance.new("Sound", workspace)
welcomeSound.SoundId = "rbxassetid://106169760792625"
welcomeSound.Volume = 5
welcomeSound:Play()

-- صورة ترحيبية فول سكرين
local splashImage = Instance.new("ImageLabel", Gui)
splashImage.Size = UDim2.new(1, 0, 1, 0)
splashImage.Position = UDim2.new(0, 0, 0, 0)
splashImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
splashImage.Image = "rbxassetid://89402902496003"
splashImage.BackgroundTransparency = 0

-- رسالة ترحيب
local welcomeText = Instance.new("TextLabel", splashImage)
welcomeText.Text = "مرحباً بك في 『ＤＲＵＧＳ ＨＵＢ』"
welcomeText.Font = Enum.Font.GothamBlack
welcomeText.TextSize = 36
welcomeText.TextColor3 = Color3.fromRGB(255, 0, 0)
welcomeText.Size = UDim2.new(1, 0, 0, 100)
welcomeText.Position = UDim2.new(0, 0, 0.8, 0)
welcomeText.BackgroundTransparency = 1

-- حذف الترحيب بعد 7 ثوانٍ
local FloatingButton

delay(7, function()
	welcomeSound:Destroy()
	splashImage:Destroy()
	FloatingButton.Visible = true
end)

-- واجهة رئيسية
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 500, 0, 400)
Main.Position = UDim2.new(0.5, -250, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true

-- إضافة تأثير DropShadow (Glow)
local function addDropShadow(parent)
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "DropShadow"
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://3685369647" -- صورة DropShadow شائعة في Roblox
	shadow.ImageColor3 = Color3.new(0, 0, 0)
	shadow.ImageTransparency = 0.7
	shadow.Size = UDim2.new(1, 12, 1, 12)
	shadow.Position = UDim2.new(0, -6, 0, -6)
	shadow.ZIndex = parent.ZIndex - 1
	shadow.Parent = parent
end

addDropShadow(Main)

-- صورة بجانب الاسم
local Icon = Instance.new("ImageLabel", Main)
Icon.Size = UDim2.new(0, 40, 0, 40)
Icon.Position = UDim2.new(0, 10, 0, 10)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://92031452250258"

-- عنوان الواجهة
local Title = Instance.new("TextLabel", Main)
Title.Text = "『ＤＲＵＧＳ ＨＵＢ』"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(0.7, -100, 0, 40)
Title.Position = UDim2.new(0, 60, 0, 10)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- زر إغلاق
local Close = Instance.new("TextButton", Main)
Close.Text = "✖"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.TextColor3 = Color3.fromRGB(255, 80, 80)
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -45, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Close.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

addDropShadow(Close)

-- زر تصغير
local Min = Instance.new("TextButton", Main)
Min.Text = "━"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 20
Min.TextColor3 = Color3.fromRGB(255, 255, 255)
Min.Size = UDim2.new(0, 40, 0, 40)
Min.Position = UDim2.new(1, -90, 0, 5)
Min.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

local minimized = false

Min.MouseButton1Click:Connect(function()
	minimized = not minimized
	Main.Visible = not minimized
end)

addDropShadow(Min)

-- صوت الضغط على الأزرار
local function playClickSound()
	local clickSound = Instance.new("Sound", workspace)
	clickSound.SoundId = "rbxassetid://1673280232"
	clickSound.Volume = 1
	clickSound:Play()
	game:GetService("Debris"):AddItem(clickSound, 2)
end

-- زر عائم لإعادة الظهور وقابل للسحب
FloatingButton = Instance.new("ImageButton", Gui)
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 20, 1, -80)
FloatingButton.BackgroundTransparency = 1
FloatingButton.Image = "rbxassetid://92031452250258"
FloatingButton.Visible = false
FloatingButton.ZIndex = 10

-- دالة سحب بالماوس للزر العائم
local dragging, dragInput, dragStart, startPos

FloatingButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = FloatingButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

FloatingButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		local newPos = UDim2.new(
			math.clamp(startPos.X.Scale, 0, 1),
			math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - FloatingButton.AbsoluteSize.X),
			math.clamp(startPos.Y.Scale, 0, 1),
			math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - FloatingButton.AbsoluteSize.Y)
		)
		FloatingButton.Position = newPos
	end
end)

FloatingButton.MouseButton1Click:Connect(function()
	playClickSound()
	Main.Visible = not Main.Visible
end)

-- دالة إنشاء زر مع تأثير ومؤثر صوتي
local function MakeButton(text, posY, callback)
	local Btn = Instance.new("TextButton", Main)
	Btn.Size = UDim2.new(0.9, 0, 0, 45)
	Btn.Position = UDim2.new(0.05, 0, 0, posY)
	Btn.Text = text
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 20
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
	Btn.BorderSizePixel = 0
	Btn.AutoButtonColor = false

	addDropShadow(Btn)

	Btn.MouseButton1Click:Connect(function()
		playClickSound()
		callback()
	end)
end

-- زر تحديث سكربتات
MakeButton("🔄 تحديث سكربتات", 385, function()
	-- هنا يمكنك وضع كود التحديث أو إعادة تحميل السكربتات حسب الحاجة
	print("تم تحديث السكربتات")
end)

-- الأزرار الرئيسية مع الروابط
MakeButton("🎭 انيق طي--زك 🥵", 60, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/tptub/fuke/refs/heads/main/almon7arf"))()
end)

MakeButton("🚨 RD4", 115, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script"))()
end)

MakeButton("📜 أكواد", 170, function()
	local CodesFrame = Instance.new("Frame", Gui)
	CodesFrame.Size = UDim2.new(0, 350, 0, 300)
	CodesFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
	CodesFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	CodesFrame.BorderSizePixel = 0
	CodesFrame.Active = true
	CodesFrame.Draggable = true

	local codes = {
		"98509241790002",
		"106169760792625",
		"118074256196452",
		"8701632845",
		"6713993281",
		"6989727632",
		"4776398821",
		"16190784875"
	}

	for i, code in ipairs(codes) do
		local codeText = Instance.new("TextLabel", CodesFrame)
		codeText.Size = UDim2.new(0.7, 0, 0, 25)
		codeText.Position = UDim2.new(0.05, 0, 0, (i - 1) * 30)
		codeText.Text = code
		codeText.TextColor3 = Color3.fromRGB(255, 255, 255)
		codeText.Font = Enum.Font.Gotham
		codeText.TextSize = 16
		codeText.BackgroundTransparency = 1
		codeText.TextXAlignment = Enum.TextXAlignment.Left

		local copyBtn = Instance.new("TextButton", CodesFrame)
		copyBtn.Size = UDim2.new(0.2, 0, 0, 25)
		copyBtn.Position = UDim2.new(0.75, 0, 0, (i - 1) * 30)
		copyBtn.Text = "نسخ"
		copyBtn.Font = Enum.Font.GothamBold
		copyBtn.TextSize = 14
		copyBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
		copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		copyBtn.MouseButton1Click:Connect(function()
			setclipboard(code)
			playClickSound()
		end)
	end
end)

MakeButton("✈️ طيران نسخة المنحرف", 225, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/cZHh2grR"))()
end)

MakeButton("🔧 ESP كشف اماكن", 280, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/tptub/ESP/refs/heads/main/ESP.lua"))()
end)

MakeButton("🥵 انيق وجهك", 335, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/tptub/-/refs/heads/main/bang-face.lua"))()
end)
MakeButton("🛠️ جاري الإصلاح", 440, function()
	playClickSound()
	game.StarterGui:SetCore("SendNotification", {
		Title = "إصلاح",
		Text = "جاري تنفيذ الإصلاحات...",
		Duration = 3
	})
end)
