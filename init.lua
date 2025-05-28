
-- Đợi game load
repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local key = getgenv().Key or ""
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local scriptName = getgenv().NScript or "Unknown"

-- Tải danh sách key từ GitHub
local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/duylee10037/keysystem-to-check/main/key.txt")
end)

if not success then
    Players.LocalPlayer:Kick("⚠ Không thể kiểm tra key. Vui lòng thử lại sau.")
    return
end

-- Kiểm tra định dạng: hwid:key
local fullKey = hwid .. ":" .. key
if not string.find(response, fullKey) then
    Players.LocalPlayer:Kick("🚫 Key không hợp lệ hoặc không khớp với thiết bị của bạn.")
    return
end

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
