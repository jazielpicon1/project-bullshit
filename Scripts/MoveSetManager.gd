extends Node
enum {Punch, Kick, Right, Left, Down}

var generalMoves = {
	1 : "Light Punch",
	2 : "Light Kick",
	3 : "Heavy Punch",
	4 : "Heavy Kick",
	5 : "Crouching Punch",
	6 : "Crouching Kick"
}


var karateManMoves : Dictionary = {
	"Karate Lunge" : [Down, Right, Punch],
	}


var nameDictionary : Dictionary = {
	"Player1" : karateManMoves
	
}
