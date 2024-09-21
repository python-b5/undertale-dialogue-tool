global.time++;

if (keyboard_check(vk_alt)) {
	var window_size_old = window_size;
	
	if (keyboard_check_pressed(vk_up) && !keyboard_check_pressed(vk_down) && window_size < window_size_max) {
		window_size++;
	}
	
	if (keyboard_check_pressed(vk_down) && !keyboard_check_pressed(vk_up) && window_size > 1) {
		window_size--;
	}
	
	if (window_size != window_size_old) {
		window_set_size(window_size * 640, window_size * 480);
		window_center();
	}
}

if (instance_exists(obj_cutscene)) {
	exit;
}

if (keyboard_check_pressed(vk_enter)) {
	keyboard_string += "\n";
}

if (keyboard_check(vk_control)) {
	if (keyboard_check_pressed(ord("C"))) {
		clipboard_set_text(keyboard_string);
	}
	
	if (keyboard_check_pressed(ord("V"))) {
		keyboard_string = clipboard_get_text();
	}
}

if (keyboard_check_pressed(vk_delete)) {
	keyboard_string = "";
}

if (keyboard_check_pressed(vk_f1)) {
	face = !face;
}

text = keyboard_string;

if (keyboard_check_pressed(vk_f2)) {
	var filename = get_open_filename(".wav files|*.wav", "");
	
	if (file_exists(filename)) {
		var file = buffer_load(filename);
		var size = buffer_get_size(file);
		
		buffer = buffer_create(size, buffer_fixed, 1);
		buffer_copy(file, 0, size, buffer, 0);
		buffer_delete(file);
		buffer_seek(buffer, buffer_seek_start, 12);
		
		var chunk_size, channels, sample_rate, audio_bits, offset;
		while (true) {
			var chunk_name = buffer_read(buffer, buffer_u32);
			chunk_size = buffer_read(buffer, buffer_u32);
			
			// GameMaker doesn't allow loading a fixed-length string, so it's easiest to just check against a
			// straight hex value.
			if (chunk_name == 0x20746d66) {  // "fmt" chunk
				buffer_seek(buffer, buffer_seek_relative, 2);
				channels = buffer_read(buffer, buffer_u16);
				sample_rate = buffer_read(buffer, buffer_u32);
				buffer_seek(buffer, buffer_seek_relative, 6);
				audio_bits = buffer_read(buffer, buffer_u16);
			} else if (chunk_name == 0x61746164) {  // "data" chunk
				offset = buffer_tell(buffer);
				break;
			} else {
				// Irrelevant chunk, skip past it
				buffer_seek(buffer, buffer_seek_relative, chunk_size);
			}
		}
		
		buffer_seek(buffer, buffer_seek_start, 0);
		blip = audio_create_buffer_sound(
			buffer,
			buffer_s16,
			sample_rate,
			offset,
			chunk_size * 8 div audio_bits,
			channels == 2 ? audio_stereo : audio_mono
		);
		
		cutscene_init()
			.add(new ev_lerp_var(id, "overlay_alpha", 0, 1, 0.1))
			.add(new ev_dialogue(directions.down, [{
				face: face ? {sprite: spr_bnuuy, talk_sprite: noone, image: 0} : undefined,
				blip: blip,
				speaker: noone,
				text: text
			}]))
			.add(new ev_lerp_var(id, "overlay_alpha", 1, 0, 0.1))
			.add({initialize: function() {
				keyboard_string = obj_dialogue_tool.text;
				audio_free_buffer_sound(obj_dialogue_tool.blip);
				buffer_delete(obj_dialogue_tool.buffer);
			}})
			.start();
	} else {
		keyboard_string = text;
	}
}