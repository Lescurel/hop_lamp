use <hop.scad>

plywood=4*0.9;
petal_base_angle=75;
petal_scaling_factor=0.05;
arm_rotation=-40;
petal_rotation_factor=15;

projection() 3d_arm_diff(plywood, petal_base_angle, petal_scaling_factor, arm_rotation, petal_rotation_factor);
