local screenW, screenH = guiGetScreenSize() -- ابعاد الشاشة
local Sx, Sy = (screenW/1920), (screenH/1080)
local size = (Sx + Sy)
local min = 0 --الدقائق
local sec = 0 -- الثواني
local TimerHud = false --اظهار المؤقت على الشاشة
local delay = true  ---  التاخير
local Time  --- الوقت


----------------------------------------- جرافيك -----------------------------
addEventHandler("onClientRender", root,
    function()
      if TimerHud == true then
        dxDrawImage(screenW * 0.8641, screenH * 0.3370, screenW * 0.0849, screenH * 0.0463, "black.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawText( sec, screenW * 0.9115, screenH * 0.3417, screenW * 0.9437, screenH * 0.3796, tocolor(255, 255, 255, 255), size, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(min, screenW * 0.8688, screenH * 0.3417, screenW * 0.9010, screenH * 0.3796, tocolor(255, 255, 255, 255), size, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(":", screenW * 0.9010, screenH * 0.3417, screenW * 0.9115, screenH * 0.3796, tocolor(255, 255, 255, 255), size, "pricedown", "center", "center", false, false, false, false, false)
      end
    end
)

-----------------------------------------------------------------------------

---------------- أوامر لاظهار المؤقت و اقافه من الخارج ---------------------
function TimerGo(Nmin)
  min = Nmin
  TimerHud = true
  delay = true
  killTimer(Time)
  StartTimer()
end
addEvent("TimerGo", true)
addEventHandler("TimerGo", root, TimerGo)

function TimerStop()
  TimerHud = false
  min = 0
  sec = 0
  delay = true
  killTimer(Time)
end
addEvent("TimerStop", true)
addEventHandler("TimerStop", root, TimerStop)
----------------------------------------------------------

------------------------محرك المؤقت ----------------------------
function delayTimer()
  delay = true
  StartTimer()
end

function StartTimer()
    if sec > 0 then
      sec = sec - 1
    elseif sec == 0 and min > 0 then
      min = min - 1
      sec = 59
    elseif sec == 0 and min == 0 then
      TimerHud = false
      killTimer(Time)
    end
    Time = setTimer(delayTimer,1000,1)
end

------------------------------------------------------------