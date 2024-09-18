function draw_box(x1, y1, x2, y2) {
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_color(c_black);
	draw_rectangle(x1 + 6, y1 + 6, x2 - 6, y2 - 6, false);
	draw_set_color(c_white);
}