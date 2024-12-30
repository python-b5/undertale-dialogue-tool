draw_box(box_margin_w, rect_y, 639 - box_margin_w, rect_y + box_height - 1);
draw_formatted_text(face ? text_x_with_face : text_x, text_y, format_basic, limit_lines(wrap_formatted_text(text, face ? 25 : 32, true), 3));

if (face) {
	draw_sprite_ext(spr_bnuuy, 0, box_margin_w + face_offset_w, rect_y + face_offset_h, 2, 2, 0, c_white, 1);
}

draw_formatted_text(box_margin_w, rect_y + box_height + 2, format_bubble, "(F1 to toggle face, F2 to test with blip)");

draw_bubble(x_big, 259, pixel_width_big, pixel_height_big);
draw_formatted_text(x_big + 7, 271, format_bubble, "{c,bk}" + limit_lines(wrap_formatted_text(text, width_big, false), 4));
draw_formatted_text(x_big, pixel_height_big + 261, format_bubble, "Large bubble\n(for bosses)");

draw_bubble(x_small + 58, 259, pixel_width_small, pixel_height_small);
draw_formatted_text(x_small + 65, 271, format_bubble, "{c,bk}" + limit_lines(wrap_formatted_text(text, width_small, false), 4));
draw_formatted_text(x_small, pixel_height_small + 261, format_bubble, "Small bubble\n(for random encounters)");

draw_set_color(c_gray);
draw_set_font(fnt_small);
draw_set_halign(fa_center);
draw_text(320, 458, "UNDERTALE DIALOGUE TOOL v1.04 (C) PYTHON-B5 2024");
draw_set_halign(fa_left);
draw_set_color(c_white);

if (overlay_alpha > 0) {
	draw_set_alpha(overlay_alpha * 0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, 639, 479, false);
	draw_set_color(c_white);
	draw_set_alpha(1);
}