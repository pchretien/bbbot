
platform_length = 80;
platform_width = 55;
platform_thickness = 3;

frame_length = 35;
frame_heigth = 25;
frame_thickness = 3;
frame_spacing = 10;
frame_offset = 7;

front_skate_radius = 10;
front_skate_length = 45;

motor_holes_radius = 2;
motor_holes_spacing = 17;

offset = 1;

module frame()
{
	
}

module frame_base()
{
	union()
	{
		// Top Plate
		translate([platform_length/-2.0,platform_width/-2.0,0])
			cube([platform_length,platform_width,platform_thickness]);

		// Frame side 1
		translate([-1*frame_offset,frame_spacing-frame_thickness,-1*frame_heigth])
			cube([frame_length,frame_thickness,frame_heigth]);

		// Frame side 2
		translate([-1*frame_offset,-1*frame_spacing,-1*frame_heigth])
			cube([frame_length,frame_thickness,frame_heigth]);

		// Skate Leg
		translate([platform_length/-2,frame_thickness/-2,0-front_skate_length+front_skate_radius])
			cube([2*front_skate_radius,frame_thickness,front_skate_length-front_skate_radius]);

		// Skate
		translate([0-platform_length/2+front_skate_radius,frame_thickness/2,0-front_skate_length+front_skate_radius])
			rotate(a=90,v=[1,0,0])
				cylinder(r=front_skate_radius, h=frame_thickness);
	}
}

difference()
{
	frame_base();

	translate([0,(frame_spacing+(2*frame_thickness))/2+offset/2, (frame_heigth-motor_holes_spacing)/-2])
		rotate(a=90,v=[1,0,0])
			cylinder(r=motor_holes_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	translate([0,(frame_spacing+(2*frame_thickness))/2+offset/2, (frame_heigth-motor_holes_spacing)/-2-motor_holes_spacing])
		rotate(a=90,v=[1,0,0])
			cylinder(r=motor_holes_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	translate([frame_length/2-frame_offset/2,(frame_spacing+(2*frame_thickness))/2+offset/2,frame_heigth/-2])
		rotate(a=90,v=[1,0,0])
			cylinder(r=0.75*front_skate_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	translate([0-platform_length/2+front_skate_radius,frame_thickness/2+offset/2,0-front_skate_length/2+front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=0.75*front_skate_radius, h=frame_thickness+offset);

	translate([0-platform_length/2+front_skate_radius,frame_thickness/2+offset/2,0-front_skate_length+front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=0.75*front_skate_radius, h=frame_thickness+offset);
}