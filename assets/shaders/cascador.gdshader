shader_type canvas_item;

void vertex() {
	UV.x += TIME * .35 ;
	UV.y += TIME * .1 ;
	// Called for every vertex the material is visible on.
}
