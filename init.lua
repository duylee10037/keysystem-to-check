--// ⚙️ Cấu hình
local scriptName = getgenv().NScript or "Unknown"
local inputKey = getgenv().Key or ""

--// 🧠 Hàm hash đơn giản (tùy chọn)
local function simpleHash(str)
    local result = 0
    for i = 1, #str do
        result += string.byte(str, i) * i
    end
    return tostring(result)
end

--// Nếu bạn có biến android_id, có thể dùng để tạo hwid
-- local hwid = simpleHash(android_id)

--// 🗝️ Tải danh sách key từ GitHub
local success, validKeys = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/duylee10037/keysystem-to-check/main/key.txt")
end)

--// Nếu không tải được key ➜ ngừng
if not success or not validKeys or validKeys == "" then
    warn("[KEY] ❌ Không thể tải key list từ GitHub.")
    game.Players.LocalPlayer:Kick("Không thể kết nối đến server key, vui lòng thử lại sau.")
    return
end

--// 🔍 Kiểm tra key
if not string.find(validKeys, inputKey) then
    game.Players.LocalPlayer:Kick("Sai key! Vui lòng lấy key mới tại trang key system.")
    return
end

--// ✅ Nếu key hợp lệ ➜ load script tương ứng
print("[KEY] ✅ Key hợp lệ, đang tải script: " .. scriptName)

--// MaruHub
if scriptName == "MaruHub" then
    getgenv().Key = "MARU-0HE3E-4F7P-7X992-407P-5E5YM"
    getgenv().id = "1159057801411313694"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()

--// BananaHub
elseif scriptName == "BananaHub" then
    repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer
    getgenv().Key = "9605adcbe6b91566b761b45d"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()

--// Nếu scriptName không xác định
else
    game.Players.LocalPlayer:Kick("🚫 Không xác định script cần chạy. (scriptName = " .. tostring(scriptName) .. ")")
end
