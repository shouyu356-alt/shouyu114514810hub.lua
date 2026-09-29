-- ShouyuHub Launcher - Delta Mobile Edition
print("========================================")
print("[ShouyuHub] Starting...")
print("========================================")

local BASE = "https://raw.githubusercontent.com/shouyu356-alt/shouyu114514810hub.lua/main/"

-- サービス
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CoreGui を安全に取得（Delta は gethui が必要な場合あり）
local function getUIParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then
            print("[ShouyuHub] gethui OK")
            return hui
        end
    end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then
        print("[ShouyuHub] CoreGui OK")
        return cg
    end
    print("[ShouyuHub] PlayerGui fallback")
    return LocalPlayer:WaitForChild("PlayerGui")
end

local parent = getUIParent()

-- 既存削除
pcall(function()
    local old = parent:FindFirstChild("ShouyuHub")
    if old then old:Destroy() end
end)

-- テーマ
local T = {
    Primary = Color3.fromRGB(88, 101, 242),
    PrimaryLight = Color3.fromRGB(130, 145, 255),
    Bg = Color3.fromRGB(18, 18, 28),
    BgAlt = Color3.fromRGB(26, 26, 40),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(150, 150, 175),
    Error = Color3.fromRGB(255, 90, 100),
    Border = Color3.fromRGB(45, 45, 65),
}

local function New(c, p)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    return i
end

local function addCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
end

-- ScreenGui
local gui = New("ScreenGui", {
    Name = "ShouyuHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 9999,
    IgnoreGuiInset = true,
    Parent = parent,
})
print("[ShouyuHub] ScreenGui created")

-- メインフレーム
local main = New("Frame", {
    Size = UDim2.new(0, 640, 0, 460),
    Position = UDim2.new(0.5, -320, 0.5, -230),
    BackgroundColor3 = T.Bg,
    BorderSizePixel = 0,
    Parent = gui,
})
addCorner(main, 14)

-- タイトルバー
local title = New("Frame", {
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundColor3 = T.BgAlt,
    BorderSizePixel = 0,
    Parent = main,
})
addCorner(title, 14)

New("TextLabel", {
    Size = UDim2.new(0, 300, 1, 0),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Text = "ShouyuHub",
    TextColor3 = T.Text,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = title,
})

-- 閉じるボタン
local closeBtn = New("TextButton", {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -38, 0.5, -15),
    BackgroundColor3 = T.Error,
    BorderSizePixel = 0,
    Text = "X",
    TextColor3 = T.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Parent = title,
})
addCorner(closeBtn, 6)

-- サイドバー
local sidebar = New("Frame", {
    Size = UDim2.new(0, 160, 1, -54),
    Position = UDim2.new(0, 8, 0, 46),
    BackgroundColor3 = T.BgAlt,
    BorderSizePixel = 0,
    Parent = main,
})
addCorner(sidebar, 10)

local tabScroll = New("ScrollingFrame", {
    Size = UDim2.new(1, -12, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = T.Primary,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent = sidebar,
})

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = tabScroll

-- コンテンツ
local content = New("Frame", {
    Size = UDim2.new(1, -184, 1, -54),
    Position = UDim2.new(0, 176, 0, 46),
    BackgroundColor3 = T.Bg,
    BorderSizePixel = 0,
    Parent = main,
})
addCorner(content, 10)

-- スクリプト一覧
local SCRIPTS = {
    { name = "Kill All",       file = "Kill all (1).txt" },
    { name = "Drift Kick",     file = "Driftキック-3.txt" },
    { name = "Aki Hub",        file = "Akihub最強2.2-5.txt" },
    { name = "XOCO",           file = "XOCO Script crack-3.txt" },
    { name = "Blitz Hub",      file = "Blitz.txt" },
    { name = "Imo Hub",        file = "いもはぶプライベート-1-2.txt" },
    { name = "Aura",           file = "なんかのオーラ-1.txt" },
    { name = "Barrier",        file = "バリア破壊.txt" },
    { name = "Kick Template",  file = "キックテンプレ.txt" },
}

local activeTab = nil

local function urlEncode(str)
    return (str:gsub("([^%w%-%._~/])", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

local function selectTab(tc, tb, tl)
    if activeTab then
        activeTab.c.Visible = false
        activeTab.b.BackgroundTransparency = 0.7
        activeTab.b.BackgroundColor3 = T.Bg
        activeTab.l.TextColor3 = T.TextDim
    end
    activeTab = { c = tc, b = tb, l = tl }
    tc.Visible = true
    tb.BackgroundTransparency = 0
    tb.BackgroundColor3 = T.Primary
    tl.TextColor3 = T.Text
end

for _, data in ipairs(SCRIPTS) do
    -- タブボタン
    local btn = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = T.Bg,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Text = data.name,
        TextColor3 = T.TextDim,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        Parent = tabScroll,
    })
    addCorner(btn, 6)

    -- タブコンテンツ
    local tabContent = New("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = T.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = content,
    })
    local tcl = Instance.new("UIListLayout")
    tcl.Padding = UDim.new(0, 10)
    tcl.Parent = tabContent

    -- 起動ボタン
    local launch = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 44),
        BackgroundColor3 = T.Primary,
        BorderSizePixel = 0,
        Text = "LAUNCH " .. data.name,
        TextColor3 = T.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        Parent = tabContent,
    })
    addCorner(launch, 8)

    launch.MouseButton1Click:Connect(function()
        local url = BASE .. urlEncode(data.file)
        print("[ShouyuHub] Loading: " .. url)
        launch.Text = "Loading..."
        task.spawn(function()
            local ok, err = pcall(function()
                local src = game:HttpGet(url)
                print("[ShouyuHub] Got " .. tostring(#src) .. " bytes")
                if #src < 100 then
                    error("Empty response: " .. src)
                end
                loadstring(src)()
            end)
            if ok then
                launch.Text = "SUCCESS!"
                task.wait(2)
            else
                launch.Text = "FAILED"
                warn("[ShouyuHub] Error: " .. tostring(err))
                task.wait(3)
            end
            launch.Text = "LAUNCH " .. data.name
        end)
    end)

    -- 説明
    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "File: " .. data.file,
        TextColor3 = T.TextDim,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = tabContent,
    })

    btn.MouseButton1Click:Connect(function() selectTab(tabContent, btn, btn) end)
    if not activeTab then selectTab(tabContent, btn, btn) end
end

print("[ShouyuHub] Tabs created")

-- 開閉
local isOpen = true

closeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    TweenService:Create(main, TweenInfo.new(0.2), { Size = UDim2.new(0, 0, 0, 0) }):Play()
    task.delay(0.2, function() main.Visible = false end)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        isOpen = not isOpen
        if isOpen then
            main.Visible = true
            main.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Back),
                { Size = UDim2.new(0, 640, 0, 460) }):Play()
        else
            TweenService:Create(main, TweenInfo.new(0.15),
                { Size = UDim2.new(0, 0, 0, 0) }):Play()
            task.delay(0.15, function() if not isOpen then main.Visible = false end end)
        end
    end
end)

-- ドラッグ
local dragging, dragStart, startPos = false, nil, nil
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
       or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                   startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- 起動時にUIを開いた状態で表示
main.Visible = true

print("[ShouyuHub] READY - RightShift to toggle")
