-- BẢN CUỐI – FIX TRIỆT ĐỂ DẤU GẠCH DƯỚI TRONG REGEX
local Players     = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player      = Players.LocalPlayer

local API_URL = "https://haingondainhan.x10.network/api.php?key=" -- link mày

local Key = tostring(getgenv().Key or ""):gsub("%s+", "")



local success, response = pcall(function()
    return HttpService:GetAsync(API_URL .. HttpService:UrlEncode(Key))
end)
if not success then
    success, response = pcall(function() return game:HttpGet(API_URL .. HttpService:UrlEncode(Key)) end)
end
if not success then return Player:Kick("Lỗi mạng") end

local data = HttpService:JSONDecode(response)
if data.valid then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
else
    Player:Kick("Key chết")
end
