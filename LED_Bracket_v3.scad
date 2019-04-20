// A 3D Printed Customisable LED bracket by Rod
//17th April 2019
//v3 with rounded corners on upstand

$fn=40;

plate_thickness=2;
bracket_width=25;
upstand_height=20;

base_thickness=3;
base_width=bracket_width;
base_depth=20;

fillet_radius=3;
fillet_width=2*fillet_radius;

LED_Mount_Height=5;
LED_Diameter=5.1;

diameter_fixing=4;

percentage_x=0.6;
percentage_y=0.6;

LED_mount_thickness=1.5;


bracket_radius=2;

module Bracket(){
translate([0,plate_thickness/2, upstand_height/2])
    cube([bracket_width,plate_thickness,upstand_height],true);
 
translate([0,-base_depth/2, base_thickness/2])
    cube([base_width,base_depth,base_thickness],true);
    
//add the corner fillet as a solid cube
translate([0,-fillet_width/2, (fillet_width/2)+base_thickness])
    cube([base_width,fillet_width,fillet_width],true);
   
}


//make the radiused bit to do the removing with
module Cutter(){
    translate([0,-fillet_width,base_thickness+fillet_width])
        rotate([0,90,0])
            cylinder(bracket_width+10,fillet_radius*2,fillet_radius*2,true);
}

module LED_Mount(){
    translate([0,-LED_Mount_Height/2,upstand_height/2])
        rotate([90,0,0])   
            cylinder(LED_Mount_Height,LED_Diameter/2+LED_mount_thickness*3,LED_Diameter/2+LED_mount_thickness,true);  
}

module LED_Clearance(){
    translate([0,-LED_Mount_Height/2,upstand_height/2])
        rotate([90,0,0])   
            cylinder(LED_Mount_Height*10,LED_Diameter/2,LED_Diameter/2,true);   
}


module Mounting_Holes(){
    translate([-base_width*0.5*percentage_x,-base_depth*percentage_y, 0])
        cylinder(100,diameter_fixing/2, diameter_fixing/2,true);

    translate([base_width*0.5*percentage_x,-base_depth*percentage_y, 0])
        cylinder(100,diameter_fixing/2, diameter_fixing/2,true);    
}

module Countersink(){
    translate([-base_width*0.5*percentage_x,-base_depth*percentage_y,base_thickness-(base_thickness*0.25)])
        cylinder(base_thickness*0.5, diameter_fixing/2,diameter_fixing,true);

    translate([base_width*0.5*percentage_x,-base_depth*percentage_y,base_thickness-(base_thickness*0.25)])
        cylinder(base_thickness*0.5, diameter_fixing/2,diameter_fixing,true);       
}

module bracketCorners(){
        //take the sharp corners off the upright
        translate([bracket_width/2-bracket_radius,0,upstand_height-bracket_radius])
            difference(){
                cube([bracket_radius*2,plate_thickness*10,bracket_radius*2],true);
                    translate([-bracket_radius,0,-bracket_radius])
                    rotate([90,0,0])
                    cylinder(plate_thickness*10, bracket_radius*2,bracket_radius*2,true);
            }

        translate([-bracket_width/2+bracket_radius,0,upstand_height-bracket_radius])   
            difference(){
                cube([bracket_radius*2,plate_thickness*10,bracket_radius*2],true);
                    translate([bracket_radius,0,-bracket_radius])
                    rotate([90,0,0])
                    cylinder(plate_thickness*10, bracket_radius*2,bracket_radius*2,true);
            }           
        
}

difference(){
    union(){
        LED_Mount();
        difference(){
            difference(){
                Bracket();
                bracketCorners(); 
            }
            
            Cutter();
        }
    }
    LED_Clearance();
    Mounting_Holes();
    Countersink();
}