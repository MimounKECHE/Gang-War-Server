setGarageOpen(8,true)
setGarageOpen(12,true)
setGarageOpen(11,true)

createBlip(2065.189,-1831.50,12.5,63,2,255, 0, 0, 255,0,350)
createBlip(1911.19,-1776.09,12.40,63,2,255, 0, 0, 255,0,350)
createBlip(2450.80,-1461.09,22.899,63,2,255, 0, 0, 255,0,350)
createBlip(487,-1740.30,10.20,63,2,255, 0, 0, 255,0,350)
createBlip(1025.30,-1023.20,38.29,63,2,255, 0, 0, 255,0,350)

local GarageMeta = {
    ["Idlewood"]={Garage=8},
    ["NoDoor"]={Garage=nil},
    ["SantaMaria"]={Garage=12},
    ["Temple"]={Garage=11}
}


function SprayStart(ID)
  local car = getPedOccupiedVehicle(localPlayer)
  setElementFrozen(car,true)
  local playerX, playerY, playerZ = getElementPosition(localPlayer)
  local SpEfect = createEffect("carwashspray",playerX, playerY, playerZ,0,0,0,0,true)
  setTimer(destroyElement,4000,1,SpEfect)
  setTimer(setElementFrozen,4500,1,car,false)
  setTimer(playSFX,3500,1,"genrl", 52, 9, false)
  playSFX("script", 150, 0, false)
  outputChatBox(ID)
  local Garage = GarageMeta[ID].Garage
  if Garage ~= nil then
    setGarageOpen(Garage,false)
    setTimer(setGarageOpen,4000,1,Garage,true)
  end
end
addEvent("SprayStart", true)
addEventHandler("SprayStart", root, SprayStart)



function SprayNoMonry()
  exports ["info_Text"]:InfoText("أنت لا تملك ما يكفي من المال تحتاج الى 100 دولار",5000)
end
addEvent("SprayNoMonry", true)
addEventHandler("SprayNoMonry", root, SprayNoMonry)