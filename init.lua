--// ⚙️ Cấu hình
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local scriptName = tostring(getgenv().NScript or "Unknown")
local inputKey = tostring(getgenv().Key or "")

--// 🌐 Địa chỉ API (thay IP của bạn vào đây)
local API_URL = "http://160.30.192.188:8080/verify?key=" .. inputKey

--// 🗝️ Gửi yêu cầu xác minh key qua API
local success, response = pcall(function()
    return game:HttpGet(API_URL)
end)

--// Kiểm tra kết nối
if not success or not response or response == "" then
    warn("[KEY] ❌ Không thể kết nối đến API key.")
    LocalPlayer:Kick("Không thể kết nối tới server xác minh key. Vui lòng thử lại.")
    return
end

--// Giải mã JSON trả về
local data
local decodeSuccess, decodeErr = pcall(function()
    data = HttpService:JSONDecode(response)
end)

if not decodeSuccess or not data then
    warn("[KEY] ❌ Lỗi khi đọc phản hồi từ API:", decodeErr)
    LocalPlayer:Kick("Server key trả về dữ liệu lỗi. Thử lại sau.")
    return
end

--// 🔍 Kiểm tra phản hồi từ API
if not data.success then
    LocalPlayer:Kick("❌ " .. (data.message or "Sai key hoặc key không tồn tại."))
    return
end

--// ✅ Key hợp lệ
print("[KEY] ✅ Key hợp lệ! Discord ID:", data.discord_id or "Không rõ")
print("[KEY] 🔄 Đang tải script:", scriptName)

--// 🚀 Chạy script tương ứng
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
