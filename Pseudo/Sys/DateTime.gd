extends Node

var time = 0

var timePerTurn = 0.2

var timePerDay = 24.0

var dayPerMonth = 30.0

var monthPerYear = 4.0

func Flow(t):
	time += t

func BattleTurn(turn):
	time += turn*timePerTurn
	
func DayNight():
	return (time-floor(time/timePerDay)*timePerDay)/timePerDay

func DateTime():
	var day = floor(time/timePerDay)
	var month = floor(day/dayPerMonth)
	var year = floor(month/monthPerYear)
	month -= year*monthPerYear
	day -= year*monthPerYear*dayPerMonth
	return {"Y":year,"M":month,"D":day}
