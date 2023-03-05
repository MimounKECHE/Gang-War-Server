local PlayerBay = false
local GunOrder = 1
local AmmuStore = ""
local GunSelect = "Colt 45"
local priceTxt = "100"
local AmmuVoics = {9, 10, 11, 12, 13, 14, 11, 12, 13} 
local AmmuVoics2 = {15, 16, 17, 56, 71, 63,65,66} 
local Voise = true


local WeaponModel = createObject(346,308.15,-142.30,999.76,0,0,0,true)
setElementAlpha(WeaponModel,0)

------------------العلامة على الخريطة----------------------------
createBlip(1375.5,-1281,33.5,6,2,255, 0, 0, 255,0,350) -- 2FloorsAmmu
createBlip(2394.80,-1989.30,18.60,6,2,255, 0, 0, 255,0,350) -- GroveAmmu
createBlip(247.80,-177.69,10.10,6,2,255, 0, 0, 255,0,350) -- CountryAmmu
-------------------------أسهم الدخول و الخروح---------------
local Arrow = {
  {1368.80,-1279.80,13.5,0},-- 2FloorsAmmu
  {315.79,-143.39,999.59,7},
  
  {2400.600,-1982.09,13.5,0},-- GroveAmmu
  {296.89,-112.09,1001.5,6},
  
  {243,-178.39,1.60,0},-- CountryAmmu
  {285.79,-86.59,1001.5,4}
} 

for i, v in pairs(Arrow) do
  local Pickup = createPickup(Arrow[i][1],Arrow[i][2],Arrow[i][3],3,1318)
  setElementInterior(Pickup,Arrow[i][4])
end


-----------------البائع------------------
local AmmuMans = {
  {308.29,-143,999.59,0,7,179,"shop" ,"shp_serve_idle"},
  {309.2,-135.5,999.59,180,7,73,"crack" ,"bbalbat_idle_02"},
  {290.20,-111.45,1001.5,0,6,179,"shop" ,"shp_serve_idle"},
  {295.6,-82.59,1001.5,0,4,179,"shop" ,"shp_serve_idle"}
}

for k,v in pairs(AmmuMans) do
  local Ped = createPed(AmmuMans[k][6],AmmuMans[k][1],AmmuMans[k][2],AmmuMans[k][3],AmmuMans[k][4])
  setElementInterior(Ped,AmmuMans[k][5])
  setElementFrozen(Ped,true)
  setPedAnimation(Ped,AmmuMans[k][7] ,AmmuMans[k][8], -1, true, false, false, true)
end



--////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////--
----------------------بداية الشراء ---------------------------


local AmmuBayMeta = {
    ["2FloorsAmmuBay"]={CameraMatrix = {308.299,-141.30,1000.4,308.29,-143,999.59,0},GunList = {"Colt 45","Silenced","Combat","MP5","M4","Sniper"},WeaponLocation = {7,308.15,-142.30,999.76}},
    ["GroveAmmuBay"]={CameraMatrix = {290.20,-109.79,1002.2,290.20,-111.45,1001.5,0},GunList = {"Colt 45","Shotgun","Uzi","Tec-9","AK-47","Sniper"},WeaponLocation = {6,290,-110.69,1001.70}},
    ["CountryAmmuBay"]={CameraMatrix = {295.6,-80.65,1002.2,295.6,-82.59,1001.5,0},GunList = {"Colt 45","Deagle","Sawed-off","Uzi","AK-47","Rifle"},WeaponLocation = {4,295.54,-81.69,1001.650}}
}

addEvent("PlayerBayGun", true)
addEventHandler("PlayerBayGun", localPlayer,function(ID)
    local CameraMatrix = AmmuBayMeta[ID].CameraMatrix
    local WeaponLocation = AmmuBayMeta[ID].WeaponLocation
    AmmuStore = ID
    setCameraMatrix(CameraMatrix[1],CameraMatrix[2],CameraMatrix[3],CameraMatrix[4],CameraMatrix[5],CameraMatrix[6],CameraMatrix[7],90)
    setElementInterior(WeaponModel,WeaponLocation[1],WeaponLocation[2],WeaponLocation[3],WeaponLocation[4])
    setElementAlpha(WeaponModel,255)
    showChat (false) 
    toggleAllControls(false)
    setPlayerHudComponentVisible("radar",false)
    PlayerBay = true
    exports ["info_Text"]:TutoText("استخدم عجلة الفأرة للتبديل بين الأسلحة / للشراء اضغط على سابيس / للخروج اضغط على أكس",0)
    outputChatBox("واجهة الشراء")
end)

---------------------اختيار السلاح---------------------------
local GunPriceModelMeta = {
    ["Colt 45"]={price="100",id=346},
    ["Shotgun"]={price="200",id=349},
    ["Uzi"]={price="300",id=352},
    ["Tec-9"]={price="300",id=372},
    ["AK-47"]={price="500",id=355},
    ["Sniper"]={price="1000",id=358},
    ["Silenced"]={price="100",id=347},
    ["Deagle"]={price="300",id=348},
    ["Combat"]={price="400",id=351},
    ["MP5"]={price="500",id=353},
    ["M4"]={price="600",id=356},
    ["Sawed-off"]={price="400",id=350},
    ["Rifle"]={price="1000",id=357}
}

function NextGun()
  if PlayerBay == true and (GunOrder >= 1 and GunOrder ~= 6) then
    outputChatBox(AmmuStore)
    GunOrder = GunOrder + 1
    local GunList = AmmuBayMeta[AmmuStore].GunList
    GunSelect = GunList[GunOrder]
    outputChatBox(GunSelect)
    priceTxt = GunPriceModelMeta[GunSelect].price
    local id = GunPriceModelMeta[GunSelect].id  
    setElementModel(WeaponModel,id)
    playSFX("genrl", 53, 0, false)
  end
end
bindKey("d","down",NextGun)
bindKey("mouse_wheel_down","down",NextGun)

function BackGun()
  if PlayerBay == true and (GunOrder <= 6 and GunOrder ~= 1) then
    outputChatBox(AmmuStore)
    GunOrder = GunOrder - 1
    local GunList = AmmuBayMeta[AmmuStore].GunList
    GunSelect = GunList[GunOrder]
    outputChatBox(GunSelect)
    priceTxt = GunPriceModelMeta[GunSelect].price
    local id = GunPriceModelMeta[GunSelect].id  
    setElementModel(WeaponModel,id)
    playSFX("genrl", 53, 0, false)
  end
end
bindKey("a","down",BackGun)
bindKey("mouse_wheel_up","down",BackGun)

bindKey("space", "down",function()
  if PlayerBay == true then
    local money = getPlayerMoney(localPlayer)
    local price = tonumber(priceTxt)
    local id
    if (money >= price) then
      id = getElementModel(WeaponModel)
      playSFX("genrl", 53, 6, false)
      Voice(AmmuVoics)
      outputChatBox(""..id.."")
      triggerServerEvent("BayGun",localPlayer,id)
    else
      exports ["info_Text"]:InfoText(" أنت لا تملك ما يكفي من المال تحتاج الى ".. priceTxt.." دولار ",10000)
      playSFX("genrl", 53, 2, false)
    end
  end
end)


------------------الخروج من عملية السلاح--------------------
bindKey("f", "down",function()
  if PlayerBay == true then
    PlayerBay = false
    GunOrder = 1
    showChat (true) 
    toggleAllControls(true)
    setCameraTarget(localPlayer,localPlayer)
    setPlayerHudComponentVisible("radar",true)
    exports ["info_Text"]:TutoText("",10)
    setElementAlpha(WeaponModel,0)
    Voice(AmmuVoics2)
  end
end)



--/////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////////////////--
function Voice(VoiceList)
  if Voise == true then
    Voise = false
    AmmuVoic = VoiceList [ math.random ( #VoiceList ) ]
    playSFX("spc_fa", 13, AmmuVoic, false)
    setTimer(VoiseSet,3000,1)
  end
end

function VoiseSet()
  Voise = true
end

function pedDamaged()
    cancelEvent() 
end
addEventHandler("onClientPedDamage",resourceRoot, pedDamaged)

--///////////////////////////////////////////////////////////////////////////////////--
------------------------------النصوص و الصور ---------------------------------------------
--///////////////////////////////////////////////////////////////////////////////////--

local dxfont0_simpo = dxCreateFont("simpo.ttf", 36)
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
      if PlayerBay == true then
        dxDrawImage(screenW * 0.0240, screenH * 0.2435, screenW * 0.2865, screenH * 0.1343, ":data/image/black.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("السعر", (screenW * 0.1672) + 1, (screenH * 0.2759) + 1, (screenW * 0.3104) + 1, (screenH * 0.3167) + 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("السعر", screenW * 0.1672, screenH * 0.2759, screenW * 0.3104, screenH * 0.3167, tocolor(194, 194, 194, 200), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("السلاح", (screenW * 0.0240) + 1, (screenH * 0.2759) + 1, (screenW * 0.1672) + 1, (screenH * 0.3167) + 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("السلاح", screenW * 0.0240, screenH * 0.2759, screenW * 0.1672, screenH * 0.3167, tocolor(194, 194, 194, 200), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("متجر الأسلحة", (screenW * 0.0240) - 1, (screenH * 0.2204) - 1, (screenW * 0.3104) - 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("متجر الأسلحة", (screenW * 0.0240) + 1, (screenH * 0.2204) - 1, (screenW * 0.3104) + 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("متجر الأسلحة", (screenW * 0.0240) - 1, (screenH * 0.2204) + 1, (screenW * 0.3104) - 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("متجر الأسلحة", (screenW * 0.0240) + 1, (screenH * 0.2204) + 1, (screenW * 0.3104) + 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText("متجر الأسلحة", screenW * 0.0240, screenH * 0.2204, screenW * 0.3104, screenH * 0.2667, tocolor(255, 255, 255, 255), 1.00, dxfont0_simpo, "center", "bottom", false, false, false, false, false)
        dxDrawText(priceTxt.."$", (screenW * 0.1672) + 1, (screenH * 0.3167) + 1, (screenW * 0.3104) + 1, (screenH * 0.3583) + 1, tocolor(0, 0, 0, 255), 1.00,    "bankgothic", "center", "top", false, false, false, false, false)
        dxDrawText(priceTxt.."$", screenW * 0.1672, screenH * 0.3167, screenW * 0.3104, screenH * 0.3583, tocolor(150, 167, 187, 200), 1.00, "bankgothic", "center", "top", false, false, false, false, false)
        dxDrawText(GunSelect, (screenW * 0.0240) + 1, (screenH * 0.3167) + 1, (screenW * 0.1672) + 1, (screenH * 0.3583) + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "top", false, false, false, false, false)
        dxDrawText(GunSelect, screenW * 0.0240, screenH * 0.3167, screenW * 0.1672, screenH * 0.3583, tocolor(150, 167, 187, 200), 1.00, "bankgothic", "center", "top", false, false, false, false, false)
      end
    end
)
--////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////--