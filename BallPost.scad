//A BallJoint - Ball
// by Rod
//v1
//19th April 2019

$fn = 40;

plate=35;
thickness=5;
stalkLength=15;
stalkRadius=3;
x1=(plate/2)*0.7;
y1=x1;
dia=4;

module bodySection(){
    //translate([20,0,0])
    //rotate([0,0,60])
    cube ([plate,plate,thickness],true);
    translate([0,0,thickness+stalkLength/2])
        cylinder(stalkLength,stalkRadius,stalkRadius,true);

    translate([0,0,thickness+stalkLength])
        sphere(7.5,true);
    
    //cone support
    translate([0,0,thickness])
        cylinder(stalkLength*0.25,stalkRadius*4,stalkRadius,true);     
}

module addCornerFixing(x,y,diameter){
    translate([x,y,0])
        //rotate([0,90,0])
            cylinder(thickness, diameter/2,diameter/2,true);
 
    translate([x,y,thickness/4])
        cylinder(thickness/2,diameter/2,diameter,true); 
}

module drillings(){
    addCornerFixing(x1,y1,dia);
    addCornerFixing(-x1,y1,dia);
    addCornerFixing(x1,-y1,dia);
    addCornerFixing(-x1,-y1,dia);    
}

difference(){
    bodySection();
    drillings();
}