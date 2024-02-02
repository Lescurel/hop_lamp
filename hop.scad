$fn = 100;
lamp_hole_radius=20;
plywood = 4;

module hjortron_scale(size=120, p=4){
  diag = sqrt(2*pow(size,2));
  difference(){
  offset(r=0.2*size) offset(r=-0.2*size) 
      square(size, true);  
  rotate([0,0,45])
  translate([-diag/2+diag/16,0,0])
  square([diag/4,p], center=true);
  };
};


module attachment(size=120, thickness=4){
   rotate([0,0,-45])
    translate([0,-size/2,0])
   cube([thickness, size/4, 16], center=true);
}

module arm(r=250, w=20){
  offset(r=2,chamfer=true) offset(-2)
  union(){
    difference(){
      circle(r);
      circle(r-w); 
      square(r);
      translate([-r,-r,0]) square(r);
      translate([0,-r,0]) square(r);
    };
    // top plate connection
    translate([-r,0,0])
    rotate([0,0,-50])
    square([w*1.5,w]);
    //bottom plate connection
    translate([sin(-50)*w,r-cos(-50)*w,0])
    rotate([0,0,-50])
    square([w*1.5,w]);
  };
};

//arm();

module 3d_arm(p=4, th=70, s=0.1, t2=-40, st=15){
  
  rotate([0,0, t2]){
  union(){
  linear_extrude(p,center=true) arm();
  for(t=[0:2])
  translate([-cos(th-t*30)*250,sin(th-t*30)*250])
  rotate([90,45,(90-th)+t*30+st])
  linear_extrude(p, center=true) hjortron_scale(115*(1.-s*t));
  
};
  };
};

module 3d_arm_diff(p=4, th=70, s=0.1, t2=-40, st=15){
  difference(){
  rotate([0,0, t2]){
  difference(){
  linear_extrude(p,center=true) arm();
  for(t=[0:2])
  translate([-cos(th-t*30)*250,sin(th-t*30)*250])
  rotate([90,45,(90-th)+t*30+st])
  linear_extrude(p, center=true) hjortron_scale(115*(1.-s*t), p=p);
    };
  };
  top_plate(p=p);
  bottom_plate(p=p);
  };
};

// top plate
module top_plate(size=230, p=4){
    $fn=100;
rotate([0,-90,0])
translate([0,0,size*cos(40)]) linear_extrude(p)
    difference(){
    offset(r=-10)offset(10)
    union(){
    difference(){
        circle(size*sin(40));
        difference(){
            circle(size*sin(40)*3/4);
            circle((size*sin(40)-lamp_hole_radius)/2);
        };

    };
    for(t=[0:3]) {
    rotate([0,0,t*90])
    translate([0,size*sin(40)/2,0])    
    square([30,size*sin(40)-20],center=true);
    };
    };
    circle(lamp_hole_radius);
    for(i=[0:15]) rotate([0,0,i*360/16])translate([size*sin(40),0,0])square([15,p],center=true);
};
};


module bottom_plate(size=230, p=4){
angle=90+40;
rotate([0,-90,0])
translate([0,0,size*cos(angle)-5]) linear_extrude(p)
    difference(){
        circle(size*sin(angle));
        circle(size*sin(angle)-20);
        for(i=[0:15]) rotate([0,0,i*360/16])translate([size*sin(angle),0,0])square([15,plywood],center=true);
    };
};

union(){
top_plate();
// fruit
for(t=[0:8]){
rotate([t*(360/8),0,0])
3d_arm(4, 75, 0.05, -40, 15);
rotate([22.5+t*(360/8),0,0])
3d_arm(4, 90, -0.05, -40, 15);
};
bottom_plate();
};
