platform_thickness = 3;
platform_width = 40;

arduino_heigth = 3.5;
arduino_length = 69;

clip_thickness = 2;
clip_width = 5;

hook_length = 3;

offset = (arduino_length+2*clip_thickness-platform_width)/2;

difference()
{
	union()
	{
		cube([	arduino_length+2*clip_thickness,
				arduino_heigth+2*clip_thickness,
				clip_width]);

		translate([offset,
					0-platform_thickness-clip_thickness,
					0])
			cube([	platform_width+2*clip_thickness,
					platform_thickness+clip_thickness,
					clip_width]);
	}

	translate([clip_thickness,clip_thickness,0])
		cube([	arduino_length,
				arduino_heigth,
				clip_width]);

	translate([clip_thickness+hook_length,clip_thickness+arduino_heigth,0])
		cube([	arduino_length-2*hook_length,
				arduino_heigth,
				clip_width]);

	translate([offset+clip_thickness,0-platform_thickness,0])
		cube([	platform_width,
				platform_thickness,
				clip_width]);

	translate([	offset+clip_thickness+hook_length,
				0-platform_thickness-clip_thickness,
				0])
		cube([	platform_width-2*hook_length,
				platform_thickness,
				clip_width]);
}