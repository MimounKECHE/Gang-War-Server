--/sfxBrowser.
--setDevelopmentMode(true)
--showCol(true)
------------------العلامة على الخريطة----------------------------
createBlip(2412.39,-1502.09,31.89,14,2,255, 0, 0, 255,0,350) --Cluckin' Bell
createBlip(2105.80,-1806.46,13.80,29,2,255, 0, 0, 255,0,350) -- Pizza
createBlip(801.9,-1617.09,19.5,10,2,255, 0, 0, 255,0,350) -- Burger Shot
-------------------تايبل اصوات الشخصيات--------------------
local PizzVoics = {5, 6, 7, 8, 9, 10, 11, 12, 13}
local CluckinVoics = {4, 5, 7, 8, 9, 10, 11,37}
local BurgerVoics = {3, 4, 5, 6, 7, 8, 9}
------------------------------------------------------



-------------------------أسهم الدخول و الخروح---------------
local Arrow = {
  {2105.39,-1806.5,13.60,0},
  {372.39,-133.5,1001.5,5},
  
  {2420,-1509,24,0},
  {364.89,-11.69,1001.90,9},
  
  {810.5,-1616.30,13.5,0},
  {363,-75.19,1001.5,10}
} 

for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318)
  setElementInterior(Pickup,Arrow[i][4])
end

-------------------------الشخصيات------------------
function SetPedAnim_Anim_Int(Ped,Int,Anim1,Anim2)
setElementInterior(Ped,Int)
setElementFrozen(Ped,true)
setPedAnimation(Ped,Anim1,Anim2, -1, true, false, false, true)
end
--
local CluckinBoy1 = createPed(167,368.20,-4.55,1001.90,180)
SetPedAnim_Anim_Int(CluckinBoy1,9,"shop" ,"shp_serve_idle")

local BurgerBoy1 = createPed(205,376.5,-65.69,1001.5,180)
SetPedAnim_Anim_Int(BurgerBoy1,10,"shop" ,"shp_serve_idle")

local PizzaBoy1 = createPed(155,372.70,-117.30,1001.5,180)
SetPedAnim_Anim_Int(PizzaBoy1,5,"shop" ,"shp_serve_idle")

local PizzaBoy2 = createPed(155,376.70,-117.30,1001.5,180)
SetPedAnim_Anim_Int(PizzaBoy2,5,"shop" ,"shp_serve_idle")

local PizzaBoy3 = createPed(155,375.10,-113.80,1001.5,0)
SetPedAnim_Anim_Int(PizzaBoy3,5,"casino" ,"cards_win")

----------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////////--
----------------------------------------------------------------------------------
---------------متحكم بمن يقوم بالانميشن--------------
local WorkerMeta = {
    ["PizzEat1"]={boy=PizzaBoy1},
    ["PizzEat2"]={boy=PizzaBoy2},
    ["CluckinEat"]={boy=CluckinBoy1},
    ["BurgerEat"]={boy=BurgerBoy1}
}

local VoicsMeta = {
    ["PizzEat1"]={Voics=PizzVoics},
    ["PizzEat2"]={Voics=PizzVoics},
    ["CluckinEat"]={Voics=CluckinVoics},
    ["BurgerEat"]={Voics=BurgerVoics}
}
local VoicFileMeta = {
    ["PizzEat1"]={Files=17},
    ["PizzEat2"]={Files=17},
    ["CluckinEat"]={Files=15},
    ["BurgerEat"]={Files=11}
}


addEvent("PlayerEatInRestaurant", true )
addEventHandler("PlayerEatInRestaurant", root, function (MarkerID)
  Control(false)
  local boy = WorkerMeta[MarkerID].boy
  setPedAnimation(boy,"shop" ,"shp_serve_end", -1, true, false, false, true)
  setTimer(setPedAnimation,6000,1,boy,"shop" ,"shp_serve_idle", -1, true, false, false, true)
  setTimer(setPedAnimation,200,1,localPlayer,"FOOD" ,"EAT_Pizza", -1, true, false, false, true)
  setTimer(setElementFrozen,4000,1,localPlayer,false)
  setTimer(setPedAnimation,4000,1,localPlayer)
  setTimer(Control,4000,1,true)
  Voice(MarkerID)
end)


function Voice(MarkerID)
  local Voics = VoicsMeta[MarkerID].Voics
  local Files = VoicFileMeta[MarkerID].Files
  NewVoic = Voics [ math.random ( #Voics ) ]
  playSFX("spc_fa", Files, NewVoic, false)
  playSFX("script", 151, 0, false)
end

function Control(sit)
  toggleControl("forwards",sit) 
  toggleControl("backwards",sit) 
  toggleControl("left",sit) 
  toggleControl("right",sit) 
end

function pedDamaged()
  cancelEvent() 
end
addEventHandler("onClientPedDamage",resourceRoot, pedDamaged)
