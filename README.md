# Undertale Dialogue Tool

This is a small tool that allows checking whether dialogue fits in Undertale's
textboxes. It visually shows the text as you type it, making it more direct than
using a textbox generator. There is also an option to preview the text with a
voice blip, which is useful for trying new sounds out (voice blips must be in
`.wav` format!).

This tool attempts to match Undertale's metrics as closely as possible, and so
may not be useful for fangames that deviate heavily from the original's UI or
that are not fully accurate.

Text formatting tags can be used in this tool, using the format used for
Undertale Wildfire. Documentation can be found
[here](https://gist.github.com/python-b5/d6f18f25b404325203cc290ddbd6262f).

This tool was originally created to aid Undertale Wildfire's development, but I
decided to release it publicly as it may be useful for other fangame and mod
developers. The strange way this project is structured is a consequence of it
essentially being a copy of Undertale Wildfire with all non-Dialogue Tool
material stripped out.

The vast majority of code in this tool was written by me. `ev_lerp_var` was
written by [BenjaminUrquhart](https://github.com/BenjaminUrquhart/).
