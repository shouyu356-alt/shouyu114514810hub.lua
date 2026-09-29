--[[
    ShouyuHub Launcher v1.2
--]]

local BASE = "https://raw.githubusercontent.com/shouyu356-alt/shouyu.script/main/"

local T = {
    Primary = Color3.fromRGB(88, 101, 242),
    PrimaryLight = Color3.fromRGB(130, 145, 255),
    Bg = Color3.fromRGB(18, 18, 28),
    BgAlt = Color3.fromRGB(26, 26, 40),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(150, 150, 175),
    TextAccent = Color3.fromRGB(130, 180, 255),
    Error = Color3.fromRGB(255, 90, 100),
    Border = Color3.fromRGB(45, 45, 65),
}
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local function New(c, p)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    return i
end
local function Corner(p, r)
    return New("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = p })
end
local function Stroke(p, c, t)
    return New("UIStroke", { Color = c or T.Border, Thickness = t or 1, Parent = p })
end

local gui = New("ScreenGui", {
    Name = "ShouyuHub", ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 9999, IgnoreGuiInset = true,
    Parent = game:GetService("CoreGui"),
})

local main = New("Frame", {
    Size = UDim2.new(0, 680, 0, 500),
    Position = UDim2.new(0.5, -340, 0.5, -250),
    BackgroundColor3 = T.Bg, BorderSizePixel = 0, Parent = gui,
})
Corner(main, 14)
Stroke(main, T.PrimaryLight, 1.5)
New("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, T.Primary),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 100, 200)),
        ColorSequenceKeypoint.new(1, T.Primary),
    }),
    Rotation = 45, Parent = main,
})

local stars = New("Frame", {
    Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1,
    ZIndex = -5, ClipsDescendants = true, Parent = main,
})
for i = 1, 30 do
    local s = New("Frame", {
        Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3)),
        Position = UDim2.new(math.random(), 0, math.random(), 0),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = math.random(30, 70) / 100,
        BorderSizePixel = 0, Parent = stars,
    })
    Corner(s, 2)
    task.spawn(function()
        while s.Parent do
            s.BackgroundTransparency = 0.3 + math.abs(math.sin(tick() * math.random(1, 3))) * 0.5
            task.wait(0.08)
        end
    end)
end

local title = New("Frame", {
    Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = T.BgAlt,
    BorderSizePixel = 0, Parent = main,
})
Corner(title, 14)

New("TextLabel", {
    Size = UDim2.new(0, 300, 1, 0), Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1, Text = "🍣 ShouyuHub  Launcher",
    TextColor3 = T.Text, TextSize = 17, Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = title,
})

New("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0), Position = UDim2.new(1, -280, 0, 0),
    BackgroundTransparency = 1,
    Text = "👤 " .. Players.LocalPlayer.DisplayName,
    TextColor3 = T.TextAccent, TextSize = 12, Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Right, Parent = title,
})

local closeBtn = New("TextButton", {
    Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -38, 0.5, -14),
    BackgroundColor3 = T.Error, BorderSizePixel = 0, Text = "✕",
    TextColor3 = T.Text, TextSize = 14, Font = Enum.Font.GothamBold, Parent = title,
})
Corner(closeBtn, 6)

local sidebar = New("Frame", {
    Size = UDim2.new(0, 160, 1, -54), Position = UDim2.new(0, 8, 0, 46),
    BackgroundColor3 = T.BgAlt, BorderSizePixel = 0, Parent = main,
})
Corner(sidebar, 10)
Stroke(sidebar, T.Border, 1)

local tabScroll = New("ScrollingFrame", {
    Size = UDim2.new(1, -12, 1, -12), Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = T.Primary,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = sidebar,
})
New("UIListLayout", { Padding = UDim.new(0, 4), Parent = tabScroll })

local content = New("Frame", {
    Size = UDim2.new(1, -184, 1, -54), Position = UDim2.new(0, 176, 0, 46),
    BackgroundColor3 = T.Bg, BorderSizePixel = 0, Parent = main,
})
Corner(content, 10)
Stroke(content, T.Border, 1)

-- ====== スクリプト一覧（全ファイル対応） ======
local SCRIPT_FILES = {
    { name = "Kill All",       icon = "💀", file = "Kill all (1).txt" },
    { name = "Drift Kick",     icon = "🌀", file = "Driftキック-3.txt" },
    { name = "Aki Hub",        icon = "🌸", file = "Akihub最強2.2-5.txt" },
    { name = "XOCO",           icon = "⚔",  file = "XOCO Script crack-3.txt" },
    { name = "Blitz Hub",      icon = "⚡", file = "Blitz.txt" },
    { name = "Imo Hub",        icon = "🍠", file = "いもはぶプライベート-1-2.txt" },
    { name = "Aura",           icon = "✨", file = "なんかのオーラ-1.txt" },
    { name = "バリア破壊",      icon = "🧱", file = "バリア破壊.txt" },
    { name = "キックテンプレ",   icon = "👊", file = "キックテンプレ.txt" },
}

local activeTab = nil

local function selectTab(tabContent, tabBtn, tabLabel)
    if activeTab then
        activeTab.container.Visible = false
        activeTab.btn.BackgroundTransparency = 0.7
        activeTab.btn.BackgroundColor3 = T.Bg
        activeTab.label.TextColor3 = T.TextDim
    end
    activeTab = { container = tabContent, btn = tabBtn, label = tabLabel }
    tabContent.Visible = true
    tabBtn.BackgroundTransparency = 0
    tabBtn.BackgroundColor3 = T.Primary
    tabLabel.TextColor3 = T.Text
end

local function urlEncode(str)
    return (str:gsub("([^%w%-%._~/])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

for _, data in ipairs(SCRIPT_FILES) do
    local btn = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = T.Bg,
        BackgroundTransparency = 0.7, BorderSizePixel = 0,
        Text = "", Parent = tabScroll,
    })
    Corner(btn, 6)
    New("TextLabel", {
        Size = UDim2.new(0, 28, 1, 0), Position = UDim2.new(0, 6, 0, 0),
        BackgroundTransparency = 1, Text = data.icon, TextSize = 15, Parent = btn,
    })
    local lbl = New("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1, Text = data.name,
        TextColor3 = T.TextDim, TextSize = 12, Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left, Parent = btn,
    })
    local tabContent = New("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -20), Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = T.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false, Parent = content,
    })
    New("UIListLayout", { Padding = UDim.new(0, 10), Parent = tabContent })

    local launch = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = T.Primary,
        BorderSizePixel = 0, Text = "🚀 " .. data.name .. " を起動",
        TextColor3 = T.Text, TextSize = 14, Font = Enum.Font.GothamBold,
        AutoButtonColor = false, Parent = tabContent,
    })
    Corner(launch, 8)
    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.Primary),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 200)),
        }),
        Rotation = 90, Parent = launch,
    })
    launch.MouseEnter:Connect(function()
        TS:Create(launch, TweenInfo.new(0.15), { BackgroundColor3 = T.PrimaryLight }):Play()
    end)
    launch.MouseLeave:Connect(function()
        TS:Create(launch, TweenInfo.new(0.15), { BackgroundColor3 = T.Primary }):Play()
    end)
    launch.MouseButton1Click:Connect(function()
        local url = BASE .. urlEncode(data.file)
        print("[ShouyuHub] " .. url)
        launch.Text = "⏳ 読み込み中..."
        task.spawn(function()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if ok then
                launch.Text = "✅ 起動しました"
                task.wait(2)
            else
                launch.Text = "❌ 失敗"
                warn("[ShouyuHub] " .. tostring(err))
                task.wait(3)
            end
            launch.Text = "🚀 " .. data.name .. " を起動"
        end)
    end)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1,
        Text = "元の " .. data.name .. " を読み込んで実行します。\nファイル: " .. data.file,
        TextColor3 = T.TextDim, TextSize = 11, Font = Enum.Font.Gotham,
        TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y, Parent = tabContent,
    })

    btn.MouseButton1Click:Connect(function() selectTab(tabContent, btn, lbl) end)
    if not activeTab then selectTab(tabContent, btn, lbl) end
end

local isOpen = true
closeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    TS:Create(main, TweenInfo.new(0.2), { Size = UDim2.new(0, 0, 0, 0) }):Play()
    task.delay(0.2, function() main.Visible = false end)
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        isOpen = not isOpen
        if isOpen then
            main.Visible = true
            main.Size = UDim2.new(0, 0, 0, 0)
            TS:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back),
                { Size = UDim2.new(0, 680, 0, 500) }):Play()
        else
            TS:Create(main, TweenInfo.new(0.15), { Size = UDim2.new(0, 0, 0, 0) }):Play()
            task.delay(0.15, function() if not isOpen then main.Visible = false end end)
        end
    end
end)

local dragging, dragStart, startPos = false, nil, nil
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
       or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                   startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("[ShouyuHub] 起動完了 - RightShift で開閉")
