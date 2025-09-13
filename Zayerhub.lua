local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zayerx Hub",
   Icon = 0, -- ใช้ 0 ถ้าไม่อยากใส่ icon
   LoadingTitle = "ZayerxHub Interface",
   LoadingSubtitle = "by Zayerx",
   ShowText = "Zayerx",
   Theme = "Default",
   ToggleUIKeybind = "K",

   KeySystem = true, -- เปิดระบบ Key
   KeySettings = {
      Title = "Zayerx Hub",
      Subtitle = "Key System",
      Note = "กดปุ่มด้านล่างเพื่อรับคีย์",
      FileName = "ZayerKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"HelloWorld"} -- ใส่ key ที่คุณอยากให้ใช้
   }
})

-- สร้างแท็บสำหรับ Get Key
local KeyTab = Window:CreateTab("🔑 Get Key")

local key_link = "https://example.com" -- เปลี่ยนเป็นลิงก์จริงของคุณ

KeyTab:CreateButton({
   Name = "📋 Get Key (Copy Link)",
   Callback = function()
      if setclipboard then
         setclipboard(key_link)
      else
         warn("setclipboard ไม่รองรับใน executor นี้")
      end
      Rayfield:Notify({
         Title = "Copied!",
         Content = "ลิงก์สำหรับรับคีย์ถูกคัดลอกแล้ว",
         Duration = 5
      })
   end
})
