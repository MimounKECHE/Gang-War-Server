local Sprays = {
  {2057.60,-1835.69,12.5,7,10,5,"Idlewood"},
  {1908.90,-1777.69,12.5,5,2,4,"NoDoor"},
  {2452.19,-1465,22.899,2,8,5,"NoDoor"},
  {483.70,-1746.09,10.20,10,5,5,"SantaMaria"},
  {1022.29,-1024.40,31.2,10,5,5,"Temple"}
} 

for i, v in pairs(Sprays) do
  local Spray = createColCuboid(Sprays[i][1],Sprays[i][2],Sprays[i][3],Sprays[i][4],Sprays[i][5],Sprays[i][6])
  setElementID(Spray,Sprays[i][7])
end

--


function SprayMark(hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == true) then
    local money = getPlayerMoney(hitElement)
      if money >= 100 then
        takePlayerMoney(hitElement,100)
        local ID = getElementID(source)
        triggerClientEvent("SprayStart",hitElement,ID)
        local car = getPedOccupiedVehicle(hitElement)
        setTimer(fixVehicle,3500,1,car)
        if (getElementType( hitElement ) == "player") then
          setTimer(setPlayerWantedLevel,3500,1,hitElement,0)
        end
      else
        triggerClientEvent("SprayNoMonry",hitElement)
      end
  end
end
addEventHandler("onColShapeHit",resourceRoot,SprayMark)





