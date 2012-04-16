
platform_length = 90;
platform_width = 40;
platform_thickness = 3;

frame_length = 35;
frame_heigth = 25;
frame_thickness = 7;
frame_spacing = 17;
frame_offset_x = 5;
motor_holes_radius = 2;
motor_holes_spacing = 17;
motor_holes_offset = 8;
battery_holder_offset = 1;
filler_heigth = 4; // Gessing ...

front_skate_radius = 9;
front_skate_length = 22;
front_skate_offset = 5;
bearing_thickness = 8;
bearing_radius = 4;

offset = 0.01;

// M3 nut 
nut_m3_radius = 3.5; //mm
nut_m3_thickness = 2.5; //mm

module m3_nut()
{
	rotate(a=90,v=[1,0,0])
		rotate(a=30,v=[0,0,1])
			cylinder(r=nut_m3_radius, h=nut_m3_thickness+offset, $fn=6);
}

module frame_side(right)
{
	difference()
	{
		union()
		{
			// Base
			translate([0,frame_thickness/-2,0])
				cube([frame_length,frame_thickness,frame_heigth]);

			// Top filler
			translate([0,frame_thickness/-2,frame_heigth])
				cube([frame_length,frame_thickness,filler_heigth]);

			// Top battery holder	
			if(!right)
				translate([0,frame_thickness/4,frame_heigth+battery_holder_offset])
					rotate(a=90,v=[0,1,0])
						cylinder(r=frame_thickness/2, h=frame_length, $fn=5);
			else
				translate([0,frame_thickness/-4,frame_heigth+battery_holder_offset])
					rotate(a=90,v=[0,1,0])
						cylinder(r=frame_thickness/2, h=frame_length, $fn=5);
		}
	
		// Bottom hole 
		translate([	motor_holes_offset,
					frame_thickness+frame_thickness/-2+offset/2,
					(frame_heigth-motor_holes_spacing)/2])
			rotate(a=90,v=[1,0,0])
				cylinder(r=motor_holes_radius, h=frame_thickness+offset, $fn=36);	

		// Bottom hole hex nut		
		if(right)
			translate([	motor_holes_offset,
						frame_thickness/-2+nut_m3_thickness-offset/2,
						(frame_heigth-motor_holes_spacing)/2])
				m3_nut();
		else
			translate([	motor_holes_offset,
						frame_thickness+frame_thickness/-2+offset/2,
						(frame_heigth-motor_holes_spacing)/2])
				m3_nut();			
		
		// Top hole 
		translate([	motor_holes_offset,
					frame_thickness+frame_thickness/-2+offset/2,
					(frame_heigth-motor_holes_spacing)/2+motor_holes_spacing])
			rotate(a=90,v=[1,0,0])
				cylinder(r=motor_holes_radius, h=frame_thickness+offset, $fn=36);	

		// Top hole hex nut		
		if(right == true)
			translate([	motor_holes_offset,
						frame_thickness/-2+nut_m3_thickness-offset/2,
						(frame_heigth-motor_holes_spacing)/2+motor_holes_spacing])
				m3_nut();
		else
			translate([	motor_holes_offset,
						frame_thickness+frame_thickness/-2+offset/2,
						(frame_heigth-motor_holes_spacing)/2+motor_holes_spacing])
				m3_nut();				
	}
}

module skate()
{
	difference()
	{
		union()
		{
			// Skate Leg
			translate([0,frame_thickness/-2,0])
				cube([2*front_skate_radius,frame_thickness,front_skate_length]);

			// Skate
			translate([front_skate_radius,frame_thickness/2,front_skate_length])
				rotate(a=90,v=[1,0,0])
					cylinder(r=front_skate_radius, h=frame_thickness);
		}

		// Skate hole
		translate([front_skate_radius,frame_thickness/2+offset/2,front_skate_length])
			rotate(a=90,v=[1,0,0])
				cylinder(r=bearing_radius, h=frame_thickness+offset);

		// Skate Top hole
		translate([front_skate_radius,frame_thickness/2+offset/2,front_skate_length/2])
			rotate(a=90,v=[1,0,0])
				cylinder(r=0.6*front_skate_radius, h=frame_thickness+offset);
	}
}

module all()
{
	union()
	{
		// Top Plate
		translate([platform_length/-2.0,platform_width/-2.0,0])
			cube([platform_length,platform_width,platform_thickness]);

		// Right frame
		translate([0-frame_offset_x,frame_thickness/2+frame_spacing/2,platform_thickness])
			frame_side(true);

		// Left frame
		translate([0-frame_offset_x,frame_thickness/-2+frame_spacing/-2,platform_thickness])
			frame_side(false);

		translate([	platform_length/-2+front_skate_offset,
					frame_thickness/2 + bearing_thickness/2,
					platform_thickness])
			skate();

		translate([	platform_length/-2+front_skate_offset,
					frame_thickness/-2 + bearing_thickness/-2,
					platform_thickness])
			skate();
	}
}

module shaft()
{
	translate([0,platform_width/2+bearing_radius+3,0])
		cylinder(r=0.95*bearing_radius,h=bearing_thickness+2*frame_thickness, $fn=36);
}

shaft();
all();

