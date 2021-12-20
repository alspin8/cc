local distanceParcourue = 0
local startingFuel = 0

function digUp()
	repeat
		turtle.digUp()
		sleep(0.5)
	until not(turtle.detectUp())
end

function digDown()
	turtle.digDown()
end
	
function dig()
	turtle.dig()
end
	
function forward()
	repeat
		dig()
	until turtle.forward()
end
	
function up()
	repeat
		digUp()
	until turtle.up()
end
	
function down()
	repeat
		digDown()
	until turtle.down()
end

function refuel()
	if turtle.getFuelLevel() < 100 then
		turtle.select(1)
		turtle.refuel(1)
	end
end

function poserTorch()
	if math.fmod(distanceParcourue,5) == 0 then
		turtle.turnLeft()
		turtle.select(2)
		turtle.place()
		turtle.turnRight()
	end
end

function demiTour()
	turtle.turnLeft()
	turtle.turnLeft()
end

function mine5x5()
	forward()
	up()
	digUp()
	turtle.turnLeft()
	for i = 0,3 do
		forward()
		digUp()
		digDown()
	end
	demiTour()
	up()
	for i = 0,3 do
		forward()
		digUp()
	end
	for i = 0,3 do
		down()
	end
end

function doitRetournerAuCoffre()
	if turtle.getItemCount(16) > 0 then
		return true
	elseif turtle.getItemCount(2) < 2 then
		return true
	elseif (turtle.getFuelLevel() + turtle.getItemCount(1)*80) < (startingFuel/2) then
		return true
	else 
		return false
	end
end

function avancerCertaineDistance(distance)
	local cnt = 0
	repeat
		forward()
		cnt = cnt + 1
	until cnt == distance
end

function fairePlein()
	for slot = 3,16 do
		turtle.select(slot)
		turtle.drop()
	end
	turtle.select(1)
	turtle.suckUp(64-turtle.getItemCount(1))
	turtle.select(2)
	turtle.suckDown(64-turtle.getItemCount(2))
end

function allerAuCoffre()
	demiTour()
	avancerCertaineDistance(distanceParcourue)
	fairePlein()
end

fairePlein()

while true do
	startingFuel = (turtle.getFuelLevel() + turtle.getItemCount(1)*80)
	while not(doitRetournerAuCoffre()) do
		mine5x5()
		poserTorch()
		refuel()
		distanceParcourue = distanceParcourue + 1
	end
	allerAuCoffre()
end
		