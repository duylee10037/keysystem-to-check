-- Android ID cố định (nếu bạn cần cho việc tạo HWID)
local android_id = "d111cbeff7e3d2fd"
local scriptName = getgenv().NScript or "Unknown"
local function simpleHash(str)
    local result = 0
    for i = 1, #str do
        result = result + string.byte(str, i) * i
    end
    return tostring(result)
end

local hwid = simpleHash(android_id)

-- Nhận Key từ người dùng
local inputKey = getgenv().Key or ""

-- Tải danh sách key từ GitHub
local success, validKeys = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/duylee10037/keysystem-to-check/main/key.txt")
end)

-- Nếu tải key thất bại ➜ ngừng
if not success then
    warn("[KEY] ❌ Không tải được keys.txt.")
    return
end

-- Kiểm tra key
if not string.find(validKeys, inputKey) then
    game.Players.LocalPlayer:Kick("Bạn đã bị kick khỏi trò chơi: Sai key. (Error Code: 267)")
    return
end

-- Nếu key đúng ➜ tiếp tục
-- Nếu hợp lệ, chọn script tương ứng theo NScript
if scriptName == "MaruHub" then
    getgenv().Key = "MARU-0HE3E-4F7P-7X992-407P-5E5YM"
    getgenv().id = "1159057801411313694"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()

elseif scriptName == "BananaHub" then
    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
    getgenv().Key = "9605adcbe6b91566b761b45d"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()

else
    Players.LocalPlayer:Kick("🚫 Không xác định script.")
end
