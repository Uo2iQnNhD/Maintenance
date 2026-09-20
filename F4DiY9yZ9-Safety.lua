local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserId = LocalPlayer.UserId

-- Daftar ID Developer (Tambahkan ID baru di sini dengan format yang sama)
local developerList = {
    10632494357,
    11639113072,
    11656080340,
}

-- Daftar ID Admin (Tambahkan ID baru di sini dengan format yang sama)
local adminList = {
    10897128392,
    11355351989,
}

-- Fungsi untuk mengecek apakah ID pemain ada di dalam daftar developer
local function isDeveloper(id)
    for _, devId in ipairs(developerList) do
        if id == devId then
            return true
        end
    end
    return false
end

-- Fungsi untuk mengecek apakah ID pemain ada di dalam daftar admin
local function isAdmin(id)
    for _, adminId in ipairs(adminList) do
        if id == adminId then
            return true
        end
    end
    return false
end

-- Eksekusi script berdasarkan status pemain (Prioritas: Developer > Admin > Member)
if isDeveloper(UserId) then
    warn("Your Role Is Developer!. Please Wait......")
    wait(1)
    -- Script Khusus Untuk Developer 
    -- (Ganti URL di bawah ini jika Anda memiliki script/loadstring khusus untuk developer)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/S9GMSFTmX-Dev/refs/heads/main/next%20generation.lua"))()

elseif isAdmin(UserId) then
    warn("Your Role Is Admin!. Please Wait......")
    wait(1)
    -- Script Untuk Admin
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/VyMndYB9i-Admin/refs/heads/main/Mainsc.lua"))()

else
    print("Your Role Is Members!. Please wait......")
    wait(1)
    -- Script Biasa (Member)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zeutronxsite/k7XzR3J7N-Basic/refs/heads/main/nahh.lua"))()
end
