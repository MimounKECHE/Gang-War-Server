

local screenW, screenH = guiGetScreenSize()-- حجم الشاشة
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)
local txt = "" --النص
local Tuto = "" -- صندوق الشرح
local DrawTuto = false -- اظهار صندوق الشرح

local TxtTimer
local TutoTimer

function InfoText(Ntxt,time)
  killTimer(TxtTimer)
  txt = Ntxt
  TxtTimer = setTimer(txtnill,time,1)
end
addEvent("InfoText", true)
addEventHandler("InfoText", root, InfoText)

function TutoText(Ttxt,time)
  killTimer(TutoTimer)
  Tuto = Ttxt
  DrawTuto = true
  playSFX("genrl", 52, 15, false)
  if time > 0 then
    TutoTimer = setTimer(Tutonill,time,1)
  end
end
addEvent("TutoText", true)
addEventHandler("TutoText", root, TutoText)

function txtnill()
  txt = ""
end

function Tutonill()
  Tuto = ""
  DrawTuto = false
end



addEventHandler("onClientRender", root,function()
  dxDrawText(txt, (screenW * 0.2328) + 1, (screenH * 0.9306) + 1, (screenW * 0.7786) + 1, (screenH * 0.9593) + 1, tocolor(0, 0, 0, 255), size, "arial", "center", "center", false, false, false, false, false)
  dxDrawText(txt, screenW * 0.2328, screenH * 0.9306, screenW * 0.7786, screenH * 0.9593, tocolor(255, 255, 255, 255), size, "arial", "center", "center", false, false, false, false, false)
  
  if DrawTuto == true then     
    dxDrawImage(screenW * 0.0242, screenH * 0.0139, screenW * 0.2852, screenH * 0.1708, "black.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    dxDrawText(Tuto, screenW * 0.0320, screenH * 0.0278, screenW * 0.3016, screenH * 0.1708, tocolor(255, 255, 255, 255), size, "arial", "right", "top", false, true, false, false, false)
  end  
  
  dxDrawText("", (screenW * 0.8781) - 1, (screenH * 0.1944) - 1, (screenW * 0.9891) - 1, (screenH * 0.2463) - 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) + 1, (screenH * 0.1944) - 1, (screenW * 0.9891) + 1, (screenH * 0.2463) - 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) - 1, (screenH * 0.1944) + 1, (screenW * 0.9891) - 1, (screenH * 0.2463) + 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", (screenW * 0.8781) + 1, (screenH * 0.1944) + 1, (screenW * 0.9891) + 1, (screenH * 0.2463) + 1, tocolor(0, 0, 0, 255), size, "pricedown", "center", "center", false, false, false, false, false)
  dxDrawText("", screenW * 0.8781, screenH * 0.1944, screenW * 0.9891, screenH * 0.2463, tocolor(255, 255, 255, 255), size, "pricedown", "center", "center", false, false, false, false, false)
end)

