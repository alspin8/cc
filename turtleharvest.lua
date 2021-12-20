function digUp()
	turtle.digUp()
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
	if turtle.getFuelLevel() < 300 then
		turtle.select(1)
		turtle.refuel(1)
	end
end

function demiTour()
	turtle.turnLeft()
	turtle.turnLeft()
end

function pitStop()
	for slot = 2,16 do
		turtle.select(slot)
		turtle.drop()
	end
	turtle.select(1)
	turtle.suckUp(64-turtle.getItemCount(1))
end

function harvest5x5(sens)
	local cnt = 0
	for i = 0,4 do
		refuel()
		for k = 0,4 do
			forward()
			repeat
				up()
			until not(turtle.detectUp())
			repeat until turtle.down()
			repeat until not(turtle.forward())
		end
		if math.fmod(cnt,2) == sens
			turtle.turnLeft()
			repeat until not(turtle.forward())
			turtle.turnLeft()
		else
			turtle.turnRight()
			repeat until not(turtle.forward())
			turtle.turnRight()
		end
		cnt = cnt + 1
	end
end
	
	
while true do
	local chest = false
	repeat
		demiTour()
		repeat until not(turtle.forward())
		harvest5x5(chest)
		repeat until not(turtle.forward())
		pitStop()
		demiTour()
		sleep(300)
		chest = not(chest)
	until turtle.getFuelLevel() < 100
end
	