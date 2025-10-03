--// ⚙️ Cấu hình
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local scriptName = tostring(getgenv().NScript or "Unknown")
local inputKey = tostring(getgenv().Key or "")

--// 🗝️ Tải danh sách key từ GitHub
local success, validKeys = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/duylee10037/keysystem-to-check/refs/heads/main/key.txt")
end)

--// Nếu không tải được ➜ dừng
if not success or not validKeys or validKeys == "" then
    warn("[KEY] ❌ Không thể tải danh sách key.")
    LocalPlayer:Kick("Không thể kết nối tới server key, vui lòng thử lại.")
    return
end

--// 🔍 Tìm key trong danh sách (so sánh phần sau dấu :)
local isValid = false
for line in string.gmatch(validKeys, "[^\r\n]+") do
    local discordID, keyValue = string.match(line, "^(.-):(.-)$")
    if keyValue and keyValue == inputKey then
        isValid = true
        break
    end
end

--// Nếu key không tồn tại
if not isValid then
    LocalPlayer:Kick("❌ Sai key hoặc key không tồn tại trong danh sách.")
    return
end

--// ✅ Key đúng ➜ chạy script tương ứng
print("[KEY] ✅ Key hợp lệ! Đang tải script: " .. scriptName)

if scriptName == "MaruHub" then
    getgenv().NScript = "MaruHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "BananaHub" then
    getgenv().NScript = "BananaHubMain"
    getgenv().NewUI = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

else
    LocalPlayer:Kick("🚫 Không xác định script cần chạy. (scriptName = " .. tostring(scriptName) .. ")")
end
