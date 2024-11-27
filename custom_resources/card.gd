class_name Card
extends Resource

enum Number {ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING}
enum Suit {SPADE, HEART, DIAMOND, CLUB}
enum Colour {BLACK, RED}

@export_group("Card Attributes")
@export var id: String
@export var art: Texture
@export var number: Number
@export var suit: Suit
@export var colour: Colour

#@export_group("Card Visuals") # TODO: ehkä niputtaa vaan samaan
#@export var art: Texture


#func is_single_targeted() -> bool:
	#return target == Target.SINGLE_ENEMY
