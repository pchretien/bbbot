
platform_length = 90;
platform_width = 55;
platform_thickness = 3;

frame_length = 40;
frame_heigth = 25;
frame_thickness = 5;
frame_spacing = 12;
frame_offset = 0;

front_skate_radius = 7;
front_skate_length = 30;

motor_holes_radius = 2;
motor_holes_spacing = 17;

offset = 1;
bearing_thickness = 8;
bearing_radius = 4;

// M3 nut 
nut_m3_radius = 3.5; //mm
nut_m3_thickness = 2.5; //mm

motor_offset = 5;

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
		translate([-1*frame_offset,frame_spacing/2,-1*frame_heigth])
			cube([frame_length,frame_thickness,frame_heigth]);

		// Frame side 2
		translate([-1*frame_offset,frame_spacing/-2-frame_thickness,-1*frame_heigth])
			cube([frame_length,frame_thickness,frame_heigth]);

		// Skate Leg
		translate([platform_length/-2,bearing_thickness/2,0-front_skate_length+front_skate_radius])
			cube([2*front_skate_radius,frame_thickness,front_skate_length-front_skate_radius]);

		// Skate
		translate([0-platform_length/2+front_skate_radius,bearing_thickness/2+frame_thickness,0-front_skate_length+front_skate_radius])
			rotate(a=90,v=[1,0,0])
				cylinder(r=front_skate_radius, h=frame_thickness);		

		// Skate Leg
		translate([platform_length/-2,bearing_thickness/-2-frame_thickness,0-front_skate_length+front_skate_radius])
			cube([2*front_skate_radius,frame_thickness,front_skate_length-front_skate_radius]);

		// Skate
		translate([0-platform_length/2+front_skate_radius,bearing_thickness/-2,0-front_skate_length+front_skate_radius])
			rotate(a=90,v=[1,0,0])
				cylinder(r=front_skate_radius, h=frame_thickness);			
	}
}

module bbbot()
{
difference()
{
	frame_base();

	// Frame Top Hole
	translate([-1*(frame_offset-motor_offset),(frame_spacing+(2*frame_thickness))/2+offset/2, (frame_heigth-motor_holes_spacing)/-2])
		rotate(a=90,v=[1,0,0])
			cylinder(r=motor_holes_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	translate([-1*(frame_offset-motor_offset),frame_spacing/-2+0.01, (frame_heigth-motor_holes_spacing)/-2])
		rotate(a=90,v=[1,0,0])
			rotate(a=30,v=[0,0,1])
				cylinder(r=nut_m3_radius, h=nut_m3_thickness, $fn=6);

	translate([-1*(frame_offset-motor_offset),frame_spacing/2+nut_m3_thickness-0.01, (frame_heigth-motor_holes_spacing)/-2])
		rotate(a=90,v=[1,0,0])
			rotate(a=30,v=[0,0,1])
				cylinder(r=nut_m3_radius, h=nut_m3_thickness, $fn=6);

	// Frame Bottom Hole
	translate([-1*(frame_offset-motor_offset),(frame_spacing+(2*frame_thickness))/2+offset/2, (frame_heigth-motor_holes_spacing)/-2-motor_holes_spacing])
		rotate(a=90,v=[1,0,0])
			cylinder(r=motor_holes_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	translate([-1*(frame_offset-motor_offset),frame_spacing/-2+0.01, (frame_heigth-motor_holes_spacing)/-2-motor_holes_spacing])
		rotate(a=90,v=[1,0,0])
			rotate(a=30,v=[0,0,1])
				cylinder(r=nut_m3_radius, h=nut_m3_thickness, $fn=6);

	translate([-1*(frame_offset-motor_offset),frame_spacing/2+nut_m3_thickness-0.01, (frame_heigth-motor_holes_spacing)/-2-motor_holes_spacing])
		rotate(a=90,v=[1,0,0])
			rotate(a=30,v=[0,0,1])
				cylinder(r=nut_m3_radius, h=nut_m3_thickness, $fn=6);

	// Frame big hole
	translate([frame_length/2-frame_offset/2,(frame_spacing+(2*frame_thickness))/2+offset/2,frame_heigth/-2])
		rotate(a=90,v=[1,0,0])
			cylinder(r=1.5*front_skate_radius, h=frame_spacing+(2*frame_thickness)+offset, $fn=36);

	// Skate hole
	translate([0-platform_length/2+front_skate_radius,bearing_thickness/2+frame_thickness+offset/2,0-front_skate_length+front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=bearing_radius, h=frame_thickness+offset);

	// Skate Top hole
	translate([0-platform_length/2+front_skate_radius,bearing_thickness/2+frame_thickness+offset/2,0-front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=0.75*front_skate_radius, h=frame_thickness+offset);

	// Skate hole
	translate([0-platform_length/2+front_skate_radius,bearing_thickness/-2+offset/2,0-front_skate_length+front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=bearing_radius, h=frame_thickness+offset);

	// Skate Top hole
	translate([0-platform_length/2+front_skate_radius,bearing_thickness/-2+offset/2,0-front_skate_radius])
		rotate(a=90,v=[1,0,0])
			cylinder(r=0.75*front_skate_radius, h=frame_thickness+offset);

	// Top Side Holes
	translate([0,1.25*platform_width,0])
		cylinder(r=platform_width, h=platform_thickness);
	translate([0,-1.25*platform_width,0])
		cylinder(r=platform_width, h=platform_thickness);

}
}

rotate(a=180,v=[1,0,0])
union()
{
	translate([0,platform_width/2,platform_thickness])
			rotate(a=180, v=[1,0,0])
				cylinder(r=0.95*bearing_radius,h=bearing_thickness+2*frame_thickness, $fn=36);

	bbbot();
}