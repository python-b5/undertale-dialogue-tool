draw_set_alpha(type == fade_types.in ? 1 - progress / frames : progress / frames);
draw_set_color(color);
draw_rectangle(0, 0, 639, 479, false);
draw_set_color(c_white);
draw_set_alpha(1);

// This is necessary to make the battle transition look correct.
if (draw_soul) {
	with (obj_soul) {
		event_perform(ev_draw, ev_draw_normal);
	}
}