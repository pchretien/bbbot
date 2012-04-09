/*   	Parametric airless tire
		by Travis Howse <tjhowse@gmail.com>
		2012.   License, GPL v2 or later
**************************************************/

dia_in = 5.75;
dia_out = 40;
spoke_count = 8;
spoke_thickness = 1;
tread_thickness = 1;
hub_thickness = 3;
height = 10;
$fn = 30;
spoke_dia = (dia_in/2) + hub_thickness + (dia_out/2) - tread_thickness+spoke_thickness;
grip_density = 0.1; // Set to 0 for no grip.
grip_height = 1.5;
grip_depth = 1;
pi = 3.14159;
zff = 0.001;

hub_extra_height = 3;
flat_hub_width = 4; // Use a value > dia_in to get a round hub

//Set to 1 for a double spiral.
// Note: single-wall spokes probably won't work with double spirals, as the
// first layer of the upper spiral would bridge in a straight line, rather
// than a curve. Successive layers probably wouldn't recover.
double_spiral = 1;

module wheel()
{
	difference()
	{
		cylinder(r=dia_out/2,h=height);
		cylinder(r=(dia_out/2)-tread_thickness,h=height);	
	}

	difference()
	{
		cylinder(r=(dia_in/2)+hub_thickness,h=height+hub_extra_height);
		intersection()
		{
			cylinder(r=dia_in/2,h=height+hub_extra_height);	
			translate([0,0,(height+hub_extra_height)/2])
				cube([flat_hub_width,2*(flat_hub_width),height+hub_extra_height], center=true);
		}
	}
	

	for (i = [0:spoke_count-1])
	{
		if (double_spiral)
		{
			rotate([0,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,(height/2)+zff]) spoke();
			rotate([180,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,-height/2]) spoke();			
		} else {
			rotate([0,0,i * (360/spoke_count)]) translate([(spoke_dia/2)-(dia_in/2)-hub_thickness,0,0]) spoke();
		}
	}
	
	if (grip_density != 0)
	{
		for (i = [0:(360*grip_density)])
		{
			rotate([0,0,i*(360/(360*grip_density))]) translate([dia_out/2-grip_height/2,0,0]) cube([grip_height,grip_depth,height]);
		}
	}
}

module spoke()
{
	intersection()
	{
		difference()
		{
			cylinder(r=spoke_dia/2,h=height);
			cylinder(r=(spoke_dia/2)-spoke_thickness,h=height);	
		}
		if (double_spiral)
		{
			translate([-spoke_dia/2,-spoke_dia,0]) cube([spoke_dia,spoke_dia,height/2]);
		} else {
			translate([-spoke_dia/2,-spoke_dia,0]) cube([spoke_dia,spoke_dia,height]);
		}
	}
}

translate([0,22,0])
	wheel();

translate([0,-22,0])
	wheel();
