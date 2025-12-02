-- KHANHDUY HUB KEY SYSTEM – BẢN CHUẨN NHẤT, CHẠY DÙ BACKEND CÓ "message" HAY KHÔNG
local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player      = Players.LocalPlayer

local API_URL = "https://haingonyeuem.x10.network/api.php?key=" -- ← link thật

local Key = tostring(getgenv().Key or ""):gsub("%s", "") -- xóa hết space

if not Key:match("^KhanhDuy_[A-Z0-9]{13}$") then
    return Player:Kick("Key sai định dạng!")
end

local success, response = pcall(function()
    return HttpService:GetAsync(API_URL .. Key)
end)

if not success then
    success, response = pcall(function()
        return game:HttpGet(API_URL .. Key)
    end)
end

if not success then
    return Player:Kick("Lỗi kết nối server key!")
end

local data = HttpService:JSONDecode(response)

-- FIX CHÍNH Ở ĐÂY: chỉ cần data.valid (dù là true, "true", 1 gì cũng đéo quan tâm)
if data.valid then
    warn("KEY HỢP LỆ – Welcome KhanhDuy Hub!")
    warn("Hết hạn: " .. (data.expiry or "Vĩnh viễn"))

    local scriptName = tostring(getgenv().NScript or "MaruHub")
    if scriptName == "MaruHub" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
    elseif scriptName == "BananaHub" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/banana/main/loader.lua"))() -- thay link
    else
        Player:Kick("Script không tồn tại")
    end
else
    Player:Kick("Key đã bị revoke hoặc hết hạn!")
end
