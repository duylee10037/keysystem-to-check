-- KHANHDUY HUB KEY SYSTEM – FIX CHUẨN 13 KÝ TỰ (TỔNG 22 KÝ TỰ)
local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player      = Players.LocalPlayer

local API_URL = "https://haingonyeuem.x10.network/api.php?key=" -- ← link thật

local Key = tostring(getgenv().Key or ""):gsub("^%s+", ""):gsub("%s+$", "") -- trim space đầu cuối

-- FIX CHUẨN: KhanhDuy_ + đúng 13 ký tự → tổng 22 ký tự
if not Key:match("^KhanhDuy_[A-Z0-9]{13}$") or #Key ~= 22 then
    return Player:Kick("\nKey sai định dạng!\nPhải là: KhanhDuy_ + đúng 13 ký tự in hoa & số\nVí dụ: KhanhDuy_A1B2C3D4E5F6G")
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

if data.valid then
    warn("KEY HỢP LỆ – Welcome back bro!")
    local scriptName = tostring(getgenv().NScript or "MaruHub")

    if scriptName == "MaruHub" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
    elseif scriptName == "BananaHub" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/banana/main/loader.lua"))() -- thay link thật
    else
        Player:Kick("Script không tồn tại")
    end
else
    Player:Kick("Key đã bị revoke hoặc hết hạn!")
end
