local MinutesRes = 1  -- مؤقت رسبون المركبة  بعد خروج اللاعب منها
local MinutesExp = 1 -- مؤقت رسبون المركبة بعد الانفجار
local BlipDistance = 200
local CarsId = {602,496,401,518,527,589,419,587,533,526,474,545,517,410,600,436,439,549,491,445,507,585,466,492,546,551,516,467,426,547,405,550,566,540,421,529,581,521,463,461,586,422,482,418,413,543,554,536,575,534,567,576,412,535,402,542,603,475,429,415,565,562,561,560} -- اي دي جميع 
local Timers = {}
local Vehicle_Bips = {}


-----------------------------------  اعطيني مواقع جميع السيارات ثم اعمل رسبون مع العلامة -----------------------
local AllVehicle = getElementsByType("vehicle",resourceRoot)

for i, v in pairs(AllVehicle) do
  local x,y,z = getElementPosition(AllVehicle[i])
  local xr,yr,zr = getElementRotation(AllVehicle[i])
  local CarId = CarsId [ math.random ( #CarsId ) ]
  destroyElement(AllVehicle[i])
  local TheVehicle = createVehicle(CarId,x,y,z,xr,yr,zr)
  local blip = createBlipAttachedTo(TheVehicle,0,1,255,255,255,50,10,BlipDistance)
  Vehicle_Bips[TheVehicle] = blip
end
--------------------------------------------------------------------------------------------------

function isVehicleEmpty( vehicle ) ----- هل المركبة فارغة؟
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
	return not (next(getVehicleOccupants(vehicle)) and true or false)
end


addEventHandler("onVehicleExplode", resourceRoot, -- عند انفجار المركبة اعمل رسبون و أخفي العلامة من الخريطة
function ()
  setTimer(RespawnCars,(60*1000)*MinutesExp, 1, source)
  if Vehicle_Bips[source] ~= nil then
    local blip = Vehicle_Bips[source]
    destroyElement(blip)
    Vehicle_Bips[source] = nil
  end
end)

function IsElemntInCol(TheVehicle,Col)  --- هل هناك شيء في مكان سبون المركبة؟
  local Elements = getElementsWithinColShape(Col)
  if (#Elements) <= 1 then
    outputChatBox("فارغة")
    setElementFrozen(TheVehicle,false)
    setElementCollisionsEnabled(TheVehicle,true)
    setVehicleLocked(TheVehicle,false)
    setElementAlpha(TheVehicle,255)
    destroyElement(Col)
  else
    outputChatBox("هناك شيء")
  end
end

function RespawnCars(source)  ----فنكشن مسؤولة عن رسبون المركبة ثم تصنع تصادم يحدد اذا كان هناك شيء عليها أو لا
  if isElement(source) then
    if isVehicleEmpty(source) then
      local x,y,z = getVehicleRespawnPosition(source)
      local xr,yr,zr = getVehicleRespawnRotation(source)
      setElementData(source, "Wait.Respawn", false)
      destroyElement(source)
      local CarId = CarsId [ math.random ( #CarsId ) ] 
      local TheVehicle = createVehicle(CarId,x,y,z,xr,yr,zr)
      setElementCollisionsEnabled(TheVehicle,false)
      setVehicleLocked(TheVehicle,true)
      setElementFrozen(TheVehicle,true)
      setElementAlpha(TheVehicle,200)
      local blip = createBlipAttachedTo(TheVehicle,0,1,255,255,255,50,10,BlipDistance)
      Vehicle_Bips[TheVehicle] = blip
      local Col = createColSphere(x,y,z,2)
      setElementParent(Col,TheVehicle)
      IsElemntInCol(TheVehicle,Col)
    end
  end
end



addEventHandler("onVehicleEnter", resourceRoot, -- عند دخول اللاعب الى المركبة  عطل مؤقت الرسبون ثم أحذف العلامة من الخريطة
function ()
  if isElement(source) then
    if isTimer(Timers[source]) then
      local TheTimer = Timers[source]
      killTimer(TheTimer)
      Timers[source] = nil
    end
    if Vehicle_Bips[source] ~= nil then
      local blip = Vehicle_Bips[source]
      destroyElement(blip)
      Vehicle_Bips[source] = nil
    end
  end
end)


addEventHandler("onVehicleExit", resourceRoot, -- عند خروج اللاعب من المركبة فعل مؤقت الرسبون
function ()
  if isVehicleEmpty(source) then
    Vehicle = source
    Timers[source] = setTimer(RespawnCars,(60*1000)*MinutesRes, 1,Vehicle)
  end
end)


addEventHandler("onColShapeLeave", resourceRoot, function()  -- عند خروج شيء من مكان سبون المركبة
  local Elements = getElementsWithinColShape(source)
  local TheVehicle = getElementParent(source)
  if (#Elements) <= 1 then
    outputChatBox("فارغة بعد الخروج")
    setElementCollisionsEnabled(TheVehicle,true)
    setElementFrozen(TheVehicle,false)
    setVehicleLocked(TheVehicle,false)
    setElementAlpha(TheVehicle,255)
    destroyElement(source)
  end
end)