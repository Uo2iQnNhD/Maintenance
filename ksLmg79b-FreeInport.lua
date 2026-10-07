-- ==========================================
-- FREE IMPORT GAMEPASS (SAFE & STABLE MODE)
-- ==========================================

-- Pastikan executor mendukung fungsi hook
if not hookmetamethod or not newcclosure then
    return
end

-- HOOK __NAMECALL (Metode Paling Aman)
-- Menangkap pemanggilan dengan titik dua, contoh: MarketplaceService:UserOwnsGamePassAsync()
local old_namecall
old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    
    -- Cek apakah yang dipanggil adalah fungsi pengecekan gamepass
    if not checkcaller() and method == "UserOwnsGamePassAsync" then
        return true -- Paksa return true (dianggap punya gamepass)
    end
    
    -- Kembalikan fungsi asli untuk pemanggilan lainnya (seperti GetProductInfo untuk Avatar)
    return old_namecall(self, ...)
end))
