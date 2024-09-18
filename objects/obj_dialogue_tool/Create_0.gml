overlay_alpha = 0;

horizontal_margin = 28;
vertical_margin = 21;
face_text_offset = 116;

box_height = 152;
box_margin_w = 32;
box_margin_h = 10;

face = false;

// The "div 4 * 2"s ensure we keep to the double pixel grid used in the overworld
face_offset_w = 6 + (horizontal_margin + face_text_offset - 6) div 4 * 2;
face_offset_h = box_height div 4 * 2 - 1;  // -1 to stay on the double pixel grid

// Get position of the top of the box
rect_y = 10;

// Get positions to create typewriters at
text_x = box_margin_w + horizontal_margin;
text_x_with_face = box_margin_w + horizontal_margin + face_text_offset;
text_y = rect_y + vertical_margin;

x_big = 77;
x_small = 359;

width_big = 21;
height_big = 4;
width_small = 8;
height_small = 4;

pixel_width_big = 9 * width_big + 15;
pixel_height_big = 20 * height_big + 24;
pixel_width_small = 9 * width_small + 15;
pixel_height_small = 20 * height_small + 24;

function draw_bubble(_x, _y, pixel_width, pixel_height) {
	draw_sprite(spr_dialogue_bubble_corner, 0, _x + 1, _y + 1);
	draw_sprite_ext(spr_dialogue_bubble_corner, 0, _x + 1, _y + pixel_height - 1, 1, 1, 90, c_white, 1);
	draw_sprite_ext(spr_dialogue_bubble_corner, 0, _x + pixel_width - 1, _y + pixel_height - 1, 1, 1, 180, c_white, 1);
	draw_sprite_ext(spr_dialogue_bubble_corner, 0, _x + pixel_width - 1, _y + 1, 1, 1, 270, c_white, 1);
	
	draw_rectangle(_x, _y + 14, _x + pixel_width - 1, _y + pixel_height - 15, false);
	draw_rectangle(_x + 14, _y, _x + pixel_width - 15, _y + pixel_height - 1, false);
}