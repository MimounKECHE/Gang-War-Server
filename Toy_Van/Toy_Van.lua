-------------------------متغييرات و تايبل مهمة------------------------------
local RespownTime = 30000  ---- وقت اعادة نشر الشاحنات

local ToyVanInfo = {  --- مركبات التي ستظهر في البداية
  {2741.69,-1851.09,9.69,0,1,"ToyVanCar"},
  {2792.5,-1428.69,40.15,0,3,"ToyVanPlen"},
  {1979.09,-2211.80,13.63,0,2,"ToyVanHel"}
} 
  
local ToyVanCarPosition = {
  {"ToyVanCar",2741.69,-1851.09,9.69,0},
  {"ToyVanCar",1598.5,-1779.5,13.56,0},
  {"ToyVanCar",1913.90,-1414.5,13.64,90}
} 

local ToyVanPlenPosition = {
  {"ToyVanPlen",2792.5,-1428.69,40.15,0},
  {"ToyVanPlen",2260.30,-1103.69,38.04,64},
  {"ToyVanPlen",1659.40,-1695,20.54,360}
} 

local ToyVanHelPosition = {
  {"ToyVanHel",1979.09,-2211.80,13.63,0},
  {"ToyVanHel",1206.69,-978.90,43.56,0},
  {"ToyVanHel",1032.30,-1929.30,13.03,180}
} 

local ToyVans = {ToyVanCarPosition,ToyVanPlenPosition,ToyVanHelPosition}

--------------------------سبون الشاحنات لأول مرة -----------------------------------

  for i, v in pairs(ToyVanInfo) do
    local Van = createVehicle(459,ToyVanInfo[i][1],ToyVanInfo[i][2],ToyVanInfo[i][3],0,0,ToyVanInfo[i][4],"Toy Van")
    
    local Blip = createBlip(ToyVanInfo[i][1],ToyVanInfo[i][2],ToyVanInfo[i][3],0,2,255,0,0,255)
    setElementParent(Blip,Van)

    setVehicleColor(Van,ToyVanInfo[i][5],0,0,0)
    setVehicleDamageProof(Van,true)
    setElementFrozen(Van,true)
    setElementID(Van,ToyVanInfo[i][6])
  end
  
-------------------------اعادة نشر الشاحنات كل فترة----------------------------
function TimerRespawnVehicles()
  setTimer(RespawnVehicles,RespownTime,1)
end
  
function RespawnVehicles()
  for k, v in pairs(ToyVans) do
  local i = math.random(1, #v)
  local Van = getElementByID(v[i][1])
  setElementPosition(Van,v[i][2],v[i][3],v[i][4])
  setElementRotation(Van,0,0,v[i][5])
end
TimerRespawnVehicles()
end

setTimer(RespawnVehicles,RespownTime,1)

----------------------- سبون اللعبة و ادخال اللاعب فيها --------------------------------
function spawn_ToyVanCar(x, y, z,Toy)
  local Car = getPedOccupiedVehicle(source)
  local id = getElementModel(Car)
  local Money = getPlayerMoney(source)
  if id == 459 and Money >= 500 then
    takePlayerMoney(source,500)
    setElementAlpha(source,0)
    local ToyCar = createVehicle(Toy, x, y, z)
    setElementID(ToyCar,"Toy")
    warpPedIntoVehicle(source,ToyCar)
    setVehicleLocked(ToyCar,true)
    setVehicleDamageProof(ToyCar,true)
  end
end
addEvent("spawn_ToyVanCar", true)
addEventHandler("spawn_ToyVanCar", root, spawn_ToyVanCar)


------------------------ امر بتفجير اللعبة و طرد اللاعب ----------------------
function ExplodVehicle(x, y, z)
  local Toy = getPedOccupiedVehicle(source)
  local id = getElementID(Toy)
  if id == "Toy" then
    local xt, yt, zt = getElementPosition(Toy)
    removePedFromVehicle ( source )
      setElementPosition(source,x,y,z + 0.2)
        setElementFrozen(Toy,true)
          setTimer(createExplosion,100,1,xt, yt, zt,0,source)
        setTimer(destroyElement,7000,1,Toy)
      setTimer(setElementAlpha,1000,1,source,255)
  end
end
addEvent("ExplodVehicle", true)
addEventHandler("ExplodVehicle", root, ExplodVehicle)



----------------- منع اللاعب من الخروج أو الدخول الى المركبة --------------------
function exitingVehicle()
  local id = getElementID(source)
  if id == "Toy" then
    cancelEvent()
  end
end
addEventHandler("onVehicleStartEnter", resourceRoot, exitingVehicle)
addEventHandler("onVehicleStartExit", resourceRoot, exitingVehicle)
--------------------------------------------------------------------------