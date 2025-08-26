extends Node
enum {Punch, Kick, Right, Left, Down}

#Note: This tab needs to be worked on to correctly implement universal moves like "light punch" or dashing

#idk bro
var generalMoves = {
	1 : "Light Punch",
	2 : "Light Kick",
	3 : "Heavy Punch",
	4 : "Heavy Kick",
	5 : "Crouching Punch",
	6 : "Crouching Kick"
}

#Moveset for karate with corresponding sequences
var karateManMoves : Dictionary = {
	"Karate Lunge" : [Down, Right, Punch],
	"Karate Lunge Reversed" : [Down, Left, Punch],
	"Karate Taunt" : [Left, Right, Down, Punch],
	"Karate Dash" : [Right, Right]
	}

#Assigns the moveset to the appropriate scene
var nameDictionary : Dictionary = {
	"Player1" : karateManMoves
	
}
