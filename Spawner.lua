-- Spawner.lua

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/refs/heads/main/Spawner.lua"))()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkSpawnerUI"
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 260)
Main.Position = UDim2.new(0.5, -150, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Dark Spawner"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Dropdown function
local function createDropdown(parent, position, width, items, defaultText)
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, width, 0, 30)
    dropdown.Position = position
    dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.Text = defaultText or "Select"
    dropdown.Parent = parent

    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(0, width, 0, #items * 25)
    dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Visible = false
    dropdownFrame.Parent = dropdown

    local corner1 = Instance.new("UICorner", dropdown)
    corner1.CornerRadius = UDim.new(0, 6)

    local corner2 = Instance.new("UICorner", dropdownFrame)
    corner2.CornerRadius = UDim.new(0, 6)

    for i, item in ipairs(items) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.Text = item
        btn.Parent = dropdownFrame

        btn.MouseButton1Click:Connect(function()
            dropdown.Text = item
            dropdownFrame.Visible = false
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        dropdownFrame.Visible = not dropdownFrame.Visible
    end)

    return dropdown
end

local spawnTypes = {"Pet", "Seed", "Egg"}

local petList = {"Dog", "Cat", "Dragon"}
local seedList = {"Sunflower", "Rose", "Cactus"}
local eggList = {"Chicken Egg", "Dragon Egg", "Mystery Egg"}

local TypeDropdown = createDropdown(Main, UDim2.new(0, 10, 0, 50), 280, spawnTypes, "Select Type")
local ItemDropdown = createDropdown(Main, UDim2.new(0, 10, 0, 90), 280, {}, "Select Item")

local function updateItems(spawnType)
    local items = {}
    if spawnType == "Pet" then
        items = petList
    elseif spawnType == "Seed" then
        items = seedList
    elseif spawnType == "Egg" then
        items = eggList
    else
        items = {}
    end

    -- Clear current dropdown items and recreate
    ItemDropdown.Text = "Select Item"

    -- Remove old dropdownFrame children (except dropdown button)
    for _, child in ipairs(ItemDropdown:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(0, 280, 0, #items * 25)
    dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Visible = false
    dropdownFrame.Parent = ItemDropdown

    local corner = Instance.new("UICorner", dropdownFrame)
    corner.CornerRadius = UDim.new(0, 6)

    for i, item in ipairs(items) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.Text = item
        btn.Parent = dropdownFrame

        btn.MouseButton1Click:Connect(function()
            ItemDropdown.Text = item
            dropdownFrame.Visible = false
        end)
    end

    ItemDropdown.MouseButton1Click:Connect(function()
        dropdownFrame.Visible = not dropdownFrame.Visible
    end)
end

TypeDropdown.MouseButton1Click:Connect(function()
    local spawnType = TypeDropdown.Text
    updateItems(spawnType)
end)

-- Input Boxes
local function createTextBox(parent, position, width, placeholder)
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(0, width, 0, 30)
    tb.Position = position
    tb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 14
    tb.PlaceholderText = placeholder
    tb.Parent = parent
    return tb
end

local WeightBox = createTextBox(Main, UDim2.new(0, 10, 0, 130), 130, "Weight (KG)")
local AgeBox = createTextBox(Main, UDim2.new(0, 160, 0, 130), 130, "Age")

-- Spawn Button
local SpawnBtn = Instance.new("TextButton", Main)
SpawnBtn.Size = UDim2.new(0, 280, 0, 35)
SpawnBtn.Position = UDim2.new(0, 10, 0, 180)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpawnBtn.Text = "Spawn"
SpawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.TextSize = 16

local SpawnUICorner = Instance.new("UICorner", SpawnBtn)
SpawnUICorner.CornerRadius = UDim.new(0, 8)

SpawnBtn.MouseButton1Click:Connect(function()
    local spawnType = TypeDropdown.Text
    local item = ItemDropdown.Text
    local weight = tonumber(WeightBox.Text) or 1
    local age = tonumber(AgeBox.Text) or 1

    if spawnType == "Select Type" then
        warn("Please select a spawn type!")
        return
    end
    if item == "Select Item" then
        warn("Please select an item!")
        return
    end
    if weight <= 0 then
        warn("Weight must be greater than 0!")
        return
    end
    if age < 0 then
        warn("Age cannot be negative!")
        return
    end

    if spawnType == "Pet" then
        Spawner.SpawnPet(item, weight, age)
    elseif spawnType == "Seed" then
        if Spawner.SpawnSeed then
            Spawner.SpawnSeed(item, weight, age)
        else
            warn("Spawner.SpawnSeed function not found!")
        end
    elseif spawnType == "Egg" then
        if Spawner.SpawnEgg then
            Spawner.SpawnEgg(item, weight, age)
        else
            warn("Spawner.SpawnEgg function not found!")
        end
    else
        warn("Unknown spawn type!")
    end
end)
