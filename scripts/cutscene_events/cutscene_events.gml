/*
Events follow a simple format, so adding more if necessary should be simple.
Each event is a struct containing the methods initialize() and step(). Both are optional.

initialize() is called when the event is started.

step() is called once per frame while the event is running.
If it returns true, the event will continue on the next frame.
If it returns false, the event will end.
If this function is not present, the event will end immediately after initialization.
*/

// Counts down for a certain amount of frames.
function ev_timer(_frames) constructor {
	frames = _frames;
	
	static step = function() {
		frames--;
		return frames > 0;
	}
}

// Creates a dialogue box.
function ev_dialogue(_side, _pages) constructor {
	side = _side;
	pages = _pages;
	
	static initialize = function() {
		dialogue_box = create_dialogue(side, pages);
	}
	
	static step = function() {
		return instance_exists(dialogue_box);
	}
}

// Sets a variable on an instance.
function ev_set(_instance, _variable, _value) constructor {
	instance = _instance;
	variable = _variable;
	value = _value;
	
	static initialize = function() {
		variable_instance_set(instance, variable, value);
	}
}

// Lerps an instance variable between 2 values.
function ev_lerp_var(_instance, _variable, _start, _stop, _stepamt) constructor {
	instance = _instance;
	variable = _variable;
	initial = _start;
	goal = _stop;
	stepamt = _stepamt;
	
	progress = 0;
	
	static step = function() {
		if (abs(progress) >= 1) {
			return false;	
		}
		progress += stepamt;
		variable_instance_set(instance, variable, lerp(initial, goal, progress));
		return abs(progress) < 1;
	}
}

// Plays a sound a single time.
function ev_sound(_sound, _blocking = false) constructor {
	sound = _sound;
	blocking = _blocking;
	
	static initialize = function() {
		playing_sound = audio_play_sound(sound, 1, false);
	}
	
	static step = function() {
		return blocking && audio_is_playing(playing_sound);
	}
}

// Fades the screen in from or out to a specific color.
function ev_fade(_type, _frames, _color = c_black) constructor {
	type = _type;
	frames = _frames;
	color = _color;
	
	static initialize = function() {
		fade = instance_create_layer(0, 0, "system", obj_fade, {
			type: type,
			frames: frames,
			color: color
		});
	}
	
	static step = function() {
		return instance_exists(fade);
	}
}