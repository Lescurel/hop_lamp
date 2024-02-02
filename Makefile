%.dxf: %.scad
	openscad -m make -o $@ $<
%.svg : %.scad
	openscad -m make -o $@ $<
%.stl: %.scad
	openscad -m make -o $@ $<
2d_arm_0.dxf:
	openscad -m make -o $@ 2d_arm.scad
2d_arm_1.dxf:
	openscad -m make -o $@ -D 'plywood=3.6' -D 'petal_base_angle=90' -D 'petal_scaling_factor=-0.05' -D 'arm_rotation=-40' -D 'petal_rotation_factor=15' 2d_arm.scad

hop_petal_00.dxf:
	openscad -m make -o $@ -D 's=0.05' -D 't=0' hop_petal.scad
hop_petal_01.dxf:
	openscad -m make -o $@ -D 's=0.05' -D 't=1' hop_petal.scad
hop_petal_02.dxf:
	openscad -m make -o $@ -D 's=0.05' -D 't=2' hop_petal.scad
hop_petal_12.dxf:
	openscad -m make -o $@ -D 's=-0.05' -D 't=0' hop_petal.scad
hop_petal_11.dxf:
	openscad -m make -o $@ -D 's=-0.05' -D 't=1' hop_petal.scad
hop_petal_10.dxf:
	openscad -m make -o $@ -D 's=-0.05' -D 't=2' hop_petal.scad

release: top_plate.dxf
release: bottom_plate.dxf
# default for arm 0
release: 2d_arm_0.dxf
# custom rule for arm 1
release: 2d_arm_1.dxf
# rules for petals that goes with the arm 0
release: hop_petal_00.dxf
release: hop_petal_01.dxf
release: hop_petal_02.dxf
# rules for petals that goes with the arm 1
release: hop_petal_10.dxf
release: hop_petal_11.dxf
release: hop_petal_12.dxf
# making the main STL
release: hop.stl
clean: $(PHONY)
	rm *.dxf *.stl
