local Rayfield=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window=Rayfield:CreateWindow({
   Name="Zayerx Hub",
   Icon=1,
   LoadingTitle="ZayerxHub Interface, Loading
   LoadingSubtitle="by Zayerx",
   ShowText="Zayerx",
   Theme="Default",
   ToggleUIKeybind="K",
   KeySystem=true
})

local KeyTab=Window:CreateTab("Get Key 🔑")
local key_link="https://example.com"

KeyTab:CreateButton({
   Name="📋 Get Key (Copy Link)",
   Callback=function()
      if setclipboard then setclipboard(key_link) end
      Rayfield:Notify({
         Title="Copied!",
         Content="Get key link",
         Duration=4
      })
   end
})
