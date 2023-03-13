--------------------------------متغييرات مهمة ----------------------------
local x, y, z
local xr, yr, zr
local BatteryTimer -- وقت الانفجار نفسه
local TimerToy = 180000 -- الوقت المحدد للانفجار
local ToyCorona = createMarker(0,0,0,"corona",1,255,255,0,0) -- علامة ظهور اللعبة

local IsToyUse = false -- هل انت تستخدم اللعبة

local ToyMeta = {
    [1]={Toy=441},
    [3]={Toy=464},
    [44]={Toy=564},
    [2]={Toy=501}
}



------------------------ عند دخول الشاحنة و تحديد نوع اللعبة -------------------------------------
function Enter_ToyVanCar(theVehicle, seat, jacked) 
  local id = getElementModel(theVehicle)
  if id == 459 then
    local Money = getPlayerMoney(source)
    if Money >= 500 then
      local color1, color2, color3, color4 = getVehicleColor(theVehicle)
      local Toy = ToyMeta[color1].Toy
      attachElements(ToyCorona,theVehicle,0,-4,-0.5,0,0,0)
      x, y, z = getElementPosition(ToyCorona)
      setElementFrozen(source,true)
      triggerServerEvent("spawn_ToyVanCar",localPlayer,x, y, z,Toy)
      exports ["info_Text"]:InfoText("لتفجير اللعبة / لديك 5 دقائق حتى تنفجر تلقائيا".."(Alt)".."اضغط على",10000)
      exports ["info_Text"]:TutoText("لقد وجدت شاحنة الألعاب المتفجرة هي منتشرة في الخريطة وتظهر بشكل عشوائي. يمكنك استخدامها لمقاتلة اعدائك وازعاجهم بدون التعرض للضرر. ولكن انتبه لأن المركبة المتفجرة ستنفجر تلقائيا بعد اكتمال الوقت.",20000)
      BatteryTimer = setTimer(ExplodVehicle,TimerToy,1)
      exports ["Timer"]:TimerGo(TimerToy/60000)
      Control(false)
    else
      exports ["info_Text"]:InfoText("أنت لا تملك ما يكفي من المال تحتاج الى 500 دولار",10000)
    end
  end
end
addEventHandler ("onClientPlayerVehicleEnter",localPlayer, Enter_ToyVanCar)


--------------------------عند ضغط زر التفجير-------------------------------------
function ExplodVehicle()
  killTimer(BatteryTimer)
  local Car = getPedOccupiedVehicle(localPlayer)
  local Car_id = getElementModel(Car)
  if (Car_id == 441) or (Car_id == 501) or (Car_id == 564) or (Car_id == 464) then
    setCameraTarget (Car)
    triggerServerEvent("ExplodVehicle",localPlayer,x, y, z)
    setTimer(setElementFrozen,3500,1,localPlayer,false)
    setTimer(setCameraTarget,3000,1,localPlayer)
    playSFX("script", 217, 0, false)
    exports ["Timer"]:TimerStop()
    Control(true)
  end
end
bindKey("lalt", "down", ExplodVehicle)
-----------------------------------------------------------------------

-----------------------لا يمكنك قتل اللاعب الذي داخل اللعبة---------------------------------
addEventHandler("onClientPlayerDamage", localPlayer, function ()
  if IsToyUse == true then
    cancelEvent() 
  end
end)

----------------------------------------------------------------------


-------------------------ايقاف التحكم الخاص باللعبة-----------------------
function Control(sit)
  toggleControl("vehicle_secondary_fire",sit)
  toggleControl("enter_exit", sit) 
end

---------------------------------------------------------