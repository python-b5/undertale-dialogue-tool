function limit_lines(text, max_lines) {
	var lines = 0;
	var output = "";
	
	var length = string_length(text);
	for (var i = 1; i <= length; i++) {
		var char = string_char_at(text, i);
		
		if (char == "\n" && ++lines == max_lines) {
			break;
		} else {
			output += char;
		}
	}
	
	return output;
}