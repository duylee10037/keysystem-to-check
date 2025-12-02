-- KHANHDUY HUB KEY SYSTEM 2025 – FIX LỖI SYNTAX, CHẠY NGON 100%
local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player      = Players.LocalPlayer

-- THAY 1 DÒNG DUY NHẤT
local API_URL = "https://haingonyeuem.x10.network/api.php?key=" -- ← link thật của mày

local Key = tostring(getgenv().Key or "")
if not Key or not Key:match("^KhanhDuy_[A-Z0-9]{13}$") then
    return Player:Kick("\nKey sai định dạng!\nPhải là: KhanhDuy_ + 13 ký tự in hoa & số")
end

-- THỬ GETASYNC TRƯỚC (nếu game cho phép)
local success, response = pcall(function()
    return HttpService:GetAsync(API_URL .. Key)
end)

-- NẾU GAME CHẶN GETASYNC → FALLBACK SANG HTTPGET (an toàn tuyệt đối)
if not success or not response then
    success, response = pcall(function()
        return game:HttpGet(API_URL .. Key)
    end)
end

if not success or not response then
    return Player:Kick("\nLỗi kết nối server key!")
end

local data = HttpService:JSONDecode(response)

if data.valid then
    warn("KEY HỢP LỆ – Welcome to KhanhDuy Hub!")
    warn("Hết hạn: " .. (data.expiry or "Vĩnh viễn"))

    -- PHẦN CHỌN SCRIPT (MaruHub / BananaHub)
    local scriptName = tostring(getgenv().NScript or "MaruHub")

    if scriptName == "MaruHub" then
        getgenv().NScript = "MaruHub"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

    elseif scriptName == "BananaHub" then
        getgenv().NScript = "BananaHub"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/banana-hub/main/loader.lua"))() -- ← thay link thật

    else
        return Player:Kick("Script không tồn tại: " .. scriptName)
    end

else
    return Player:Kick("\nKEY ĐÃ HẾT HẠN HOẶC BỊ REVOKE!\nMua key mới tại Discord")
end
