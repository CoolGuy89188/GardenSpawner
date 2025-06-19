local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/CoolGuy89188/GardenSpawner/refs/heads/main/Spawner.lua"))()

-- Create UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DarkSpawnerUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 270)
Main.Position = UDim2.new(0.5, -150, 0.5, -135)
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

-- Dropdown for Spawn Type
local TypeDropdown = Instance.new("TextButton", Main)
TypeDropdown.Size = UDim2.new(1, -20, 0, 30)
TypeDropdown.Position = UDim2.new(0, 10, 0, 45)
TypeDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TypeDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
TypeDropdown.Font = Enum.Font.Gotham
TypeDropdown.TextSize = 14
TypeDropdown.Text = "Select Spawn Type"

-- Dropdown for Items (Pets, Seeds, Eggs)
local ItemDropdown = Instance.new("TextButton", Main)
ItemDropdown.Size = UDim2.new(1, -20, 0, 30)
ItemDropdown.Position = UDim2.new(0, 10, 0, 85)
ItemDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ItemDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemDropdown.Font = Enum.Font.Gotham
ItemDropdown.TextSize = 14
ItemDropdown.Text = "Select Item"

-- Weight Box
local WeightBox = Instance.new("TextBox", Main)
WeightBox.PlaceholderText = "KG (e.g. 1)"
WeightBox.Text = ""
WeightBox.Size = UDim2.new(0.45, -5, 0, 30)
WeightBox.Position = UDim2.new(0.05, 0, 0, 125)
WeightBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
WeightBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WeightBox.Font = Enum.Font.Gotham
WeightBox.TextSize = 14

-- Age Box
local AgeBox = Instance.new("TextBox", Main)
AgeBox.PlaceholderText = "Age (e.g. 2)"
AgeBox.Text = ""
AgeBox.Size = UDim2.new(0.45, -5, 0, 30)
AgeBox.Position = UDim2.new(0.5, 5, 0, 125)
AgeBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
AgeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeBox.Font = Enum.Font.Gotham
AgeBox.TextSize = 14

-- Spawn Button
local SpawnBtn = Instance.new("TextButton", Main)
SpawnBtn.Size = UDim2.new(1, -20, 0, 35)
SpawnBtn.Position = UDim2.new(0, 10, 0, 170)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpawnBtn.Text = "Spawn"
SpawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.TextSize = 16

local SpawnUICorner = Instance.new("UICorner", SpawnBtn)
SpawnUICorner.CornerRadius = UDim.new(0, 8)

-- Data lists
local petList = {"Cat", "Dog", "Dragon", "Rabbit", "Fox"}
local seedList = {"Sunflower", "Pumpkin", "Melon", "Tomato"}
local eggList = {"ChickenEgg", "DinosaurEgg", "GoldenEgg"}

local spawnType = nil

-- Helper function to clear dropdown frames
local function clearDropdownFrames(button)
    for _, child in ipairs(button:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
end

-- Update items dropdown based on spawn type
local function updateItems(typeSelected)
    spawnType = typeSelected
    local items = {}
    if typeSelected == "Pet" then
        items = petList
    elseif typeSelected == "Seed" then
        items = seedList
    elseif typeSelected == "Egg" then
        items = eggList
    else
        items = {}
    end

    ItemDropdown.Text = "Select Item"
    clearDropdownFrames(ItemDropdown)

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

    -- Toggle dropdown visibility
    ItemDropdown.MouseButton1Click:Connect(function()
        dropdownFrame.Visible = not dropdownFrame.Visible
    end)
end

-- Spawn Type Dropdown logic
clearDropdownFrames(TypeDropdown)

local typeDropdownFrame = Instance.new("Frame")
typeDropdownFrame.Size = UDim2.new(0, 280, 0, 3 * 25)
typeDropdownFrame.Position = UDim2.new(0, 0, 1, 0)
typeDropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
typeDropdownFrame.BorderSizePixel = 0
typeDropdownFrame.Visible = false
typeDropdownFrame.Parent = TypeDropdown

local corner2 = Instance.new("UICorner", typeDropdownFrame)
corner2.CornerRadius = UDim.new(0, 6)

local spawnTypes = {"Pet", "Seed", "Egg"}
for i, t in ipairs(spawnTypes) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = t
    btn.Parent = typeDropdownFrame

    btn.MouseButton1Click:Connect(function()
        TypeDropdown.Text = t
        typeDropdownFrame.Visible = false
        updateItems(t)
    end)
end

TypeDropdown.MouseButton1Click:Connect(function()
    typeDropdownFrame.Visible = not typeDropdownFrame.Visible
end)

-- Spawn Button Logic
SpawnBtn.MouseButton1Click:Connect(function()
    local selectedItem = ItemDropdown.Text
    local kg = tonumber(WeightBox.Text) or 1
    local age = tonumber(AgeBox.Text) or 1

    if spawnType and selectedItem ~= "Select Item" and selectedItem ~= "" then
        -- Use your Spawner's spawn function
        Spawner.SpawnPet(selectedItem, kg, age)
    else
        warn("Please select a spawn type and an item!")
    end
end)
