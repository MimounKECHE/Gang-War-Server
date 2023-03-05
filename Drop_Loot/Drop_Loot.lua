
local AllMony = {}

------------ عندما يموت الاعب و يسقط المال و السلاح منه -------------
addEventHandler( "onPlayerWasted", root,function ()
  local money = getPlayerMoney(source)
  local x, y, z = getElementPosition(source)
  if money >= 40 then
    takePlayerMoney(source,40)
    MakeMoney(x, y, z, 2, 20)
  end
  local wp = getPedWeapon(source)
  local med = getPedWeapon(source,10)-- السلاح الذي كان يحمله
  local slot = getSlotFromWeapon(wp)-- مكان السلاح في السلوت
  if slot > 0 and slot < 7 then
    local weapon1 = createPickup(x, y + 2, z,2,wp,50000,30)
    setTimer(destroyElement,30000,1,weapon1)
  end
  if med ~= 0 then
    local medkit = createPickup(x, y + 2.5, z,2,med,50000,1)
    setTimer(destroyElement,30000,1,medkit)
  end
end)

addEventHandler("onPedWasted", getRootElement(),function ()
  local x, y, z = getElementPosition(source)
  MakeMoney(x, y, z, 2, 20)
  local wp = getPedWeapon(source) -- السلاح الذي كان يحمله
  local slot = getSlotFromWeapon(wp) -- مكان السلاح في السلوت
  if slot > 0 and slot < 7 then
  local weapon1 = createPickup(x, y + 2, z,2,wp,50000,30)
  setTimer(destroyElement,30000,1,weapon1)
end 
end)


 ------------ حمل المال ---------------
 
 function MakeMoney(x, y, z, n, c)
  for i = 1, n do
    local random = {0.5,1,-1,-0.5,2,2.5,-2,-2.5}
    local x2 = random [ math.random ( #random ) ]
    local y2 = random [ math.random ( #random ) ]
    local Mony = createPickup(x + x2, y + y2, z - 0.7,3,1212,50000,nil)
    setElementID(Mony,"Mony")
    AllMony[Mony] = c
    setTimer(destroyElement,30000,1,Mony)
  end
end

addEventHandler( "onPickupUse", root,function ( thePlayer )
  local id = getElementID(source)
    if id == "Mony" then
      local Amount = AllMony[source]
      givePlayerMoney ( thePlayer, Amount )
      AllMony[source] = nil
    end
end)






