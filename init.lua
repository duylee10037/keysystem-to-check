local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player      = Players.LocalPlayer

local API_URL = "https://haingonyeuem.x10.network/api.php?key=" -- ← link thật

local RawKey = tostring(getgenv().Key or ""):gsub("%s", "") -- key gốc mày dán

-- FIX CUỐI: UrlEncode key trước khi gửi (đảm bảo _ không bị %5F)
local Key = HttpService:UrlEncode(RawKey)

if not RawKey:match("^KhanhDuy_[A-Za-z0-9]{13}$") or #RawKey ~= 22 then
    -- Giữ nguyên thông báo kick, nhưng bên trong code đã linh hoạt hơn
    return Player:Kick("\nKey sai định dạng!\nPhải đúng 22 ký tự: KhanhDuy_ + 13 chữ/số\nVí dụ: KhanhDuy_A1B2C3D4E5F6G7H")
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
    return Player:Kick("Lỗi mạng bro")
end

local data = HttpService:JSONDecode(response)

if data.valid then
    warn("KEY HỢP LỆ – Welcome back KhanhDuy Hub!")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
else
    Player:Kick("Key chết hoặc bị revoke rồi bro")
end
