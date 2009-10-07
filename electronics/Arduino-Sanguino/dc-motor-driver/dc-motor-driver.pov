//POVRay-File created by 3d41.ulp v1.05
///home/hoeken/Desktop/reprap/trunk/users/hoeken/arduino/electronics/dc-motor-driver/dc-motor-driver.brd
// 1/06/2008 11:21:48 

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 250;
#local cam_z = -134;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 19;
#local lgt1_pos_y = 33;
#local lgt1_pos_z = 30;
#local lgt1_intense = 0.743348;
#local lgt2_pos_x = -19;
#local lgt2_pos_y = 33;
#local lgt2_pos_z = 30;
#local lgt2_intense = 0.743348;
#local lgt3_pos_x = 19;
#local lgt3_pos_y = 33;
#local lgt3_pos_z = -20;
#local lgt3_intense = 0.743348;
#local lgt4_pos_x = -19;
#local lgt4_pos_y = 33;
#local lgt4_pos_z = -20;
#local lgt4_intense = 0.743348;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 52.053000;
#declare pcb_y_size = 58.293000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(33);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-26.026500,0,-29.146500>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro DC_MOTOR_DRIVER(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<20.972000,-50.165000><20.972000,8.128000>
<20.972000,8.128000><73.025000,8.128000>
<73.025000,8.128000><73.025000,-50.165000>
<73.025000,-50.165000><20.972000,-50.165000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
cylinder{<24.909000,1,-45.974000><24.909000,-5,-45.974000>1.500000 texture{col_hls}}
cylinder{<68.834000,1,-45.974000><68.834000,-5,-45.974000>1.500000 texture{col_hls}}
cylinder{<68.834000,1,3.810000><68.834000,-5,3.810000>1.500000 texture{col_hls}}
cylinder{<25.146000,1,3.810000><25.146000,-5,3.810000>1.500000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<40.386000,-0.000000,-19.050000>}#end		//ceramic disc capacitator C1 100nF C050-035X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<40.386000,-0.000000,-13.716000>}#end		//ceramic disc capacitator C2 100nF C050-035X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<40.386000,-0.000000,-3.175000>}#end		//ceramic disc capacitator C3 100nF C050-035X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<40.386000,-0.000000,-8.509000>}#end		//ceramic disc capacitator C4 100nF C050-035X075
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<46.482000,-0.000000,-38.608000>}#end		//ceramic disc capacitator C5 100nF C050-035X075
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<36.322000,-0.000000,-38.608000>}#end		//ceramic disc capacitator C6 100nF C050-035X075
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_DIS_ELKO_3MM5_8MM("100uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<36.322000,-0.000000,-31.496000>}#end		//Elko 3,5mm Pitch, 8mm  Diameter, 11,5mm High C7 100uF E3,5-8
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_DIS_ELKO_3MM5_8MM("100uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<45.085000,-0.000000,-31.242000>}#end		//Elko 3,5mm Pitch, 8mm  Diameter, 11,5mm High C8 100uF E3,5-8
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP14("74HC00N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<57.658000,-0.000000,-20.066000>translate<0,3.000000,0> }#end		//DIP14 IC2 74HC00N DIL14
#ifndef(pack_IC2) object{SOCKET_DIP14()rotate<0,-0.000000,0> rotate<0,0,0> translate<57.658000,-0.000000,-20.066000>}#end					//IC-Sockel 14Pin IC2 74HC00N
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {TR_TO92_G("78L05Z",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<37.084000,-0.000000,-25.146000>}#end		//TO92 bend vertical IC3 78L05Z TO92
#ifndef(pack_INPUT) #declare global_pack_INPUT=yes; object {PH_1X5()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<63.500000,-0.000000,-33.655000>}#end		//Header 2,54mm Grid 5Pin 1Row (jumper.lib) INPUT  1X05
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<59.182000,-0.000000,-47.244000>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<34.544000,-0.000000,5.080000>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<59.436000,-0.000000,4.318000>}#end		//Diskrete 5MM LED LED3  LED5MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<24.384000,-0.000000,-26.924000>}#end		//Diskrete 5MM LED LED4  LED5MM
#ifndef(pack_LED5) #declare global_pack_LED5=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<24.130000,-0.000000,-38.100000>}#end		//Diskrete 5MM LED LED5  LED5MM
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Yellow}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.388000,-0.000000,-30.480000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 100K 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Yellow}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.388000,-0.000000,-33.274000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 100K 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Yellow}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.388000,-0.000000,-27.686000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 100K 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Yellow}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.388000,-0.000000,-36.068000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 100K 0207/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<59.436000,-0.000000,-42.418000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R5 560 0207/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<29.718000,-0.000000,-28.448000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R6 560 0207/7
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<40.640000,-0.000000,0.254000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R7 560 0207/7
#ifndef(pack_X2) #declare global_pack_X2=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<29.718000,-0.000000,-16.764000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X2 MST2V MSTBV2
#ifndef(pack_X3) #declare global_pack_X3=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<29.718000,-0.000000,-6.604000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X3 MST2V MSTBV2
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<37.846000,0,-19.050000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<42.926000,0,-19.050000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<37.846000,0,-13.716000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<42.926000,0,-13.716000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<37.846000,0,-3.175000> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<42.926000,0,-3.175000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<37.846000,0,-8.509000> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<42.926000,0,-8.509000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<49.022000,0,-38.608000> texture{col_thl}}
#ifndef(global_pack_C5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<43.942000,0,-38.608000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<33.782000,0,-38.608000> texture{col_thl}}
#ifndef(global_pack_C6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<38.862000,0,-38.608000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<34.544000,0,-31.496000> texture{col_thl}}
#ifndef(global_pack_C7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<38.100000,0,-31.496000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<46.863000,0,-31.242000> texture{col_thl}}
#ifndef(global_pack_C8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<43.307000,0,-31.242000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.514000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<51.054000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.594000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<56.134000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.674000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<61.214000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.754000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.294000,0,-10.541000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<66.294000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<63.754000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<61.214000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<58.674000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<56.134000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<53.594000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<51.054000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<48.514000,0,-2.921000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.038000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.578000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.118000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.658000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.198000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.738000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<65.278000,0,-23.876000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<65.278000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.738000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<60.198000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.658000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<55.118000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.578000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<50.038000,0,-16.256000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.814000,0,-25.146000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<37.084000,0,-23.241000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<38.354000,0,-25.146000> texture{col_thl}}
#ifndef(global_pack_INPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.500000,0,-38.735000> texture{col_thl}}
#ifndef(global_pack_INPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.500000,0,-36.195000> texture{col_thl}}
#ifndef(global_pack_INPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.500000,0,-33.655000> texture{col_thl}}
#ifndef(global_pack_INPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.500000,0,-31.115000> texture{col_thl}}
#ifndef(global_pack_INPUT) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<63.500000,0,-28.575000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.182000,0,-45.974000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.182000,0,-48.514000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<34.544000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<34.544000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.436000,0,5.588000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<59.436000,0,3.048000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<23.114000,0,-26.924000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<25.654000,0,-26.924000> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<25.400000,0,-38.100000> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<22.860000,0,-38.100000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<33.799000,0,-45.720000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<38.879000,0,-45.720000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<43.959000,0,-45.720000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.039000,0,-45.720000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.198000,0,-30.480000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<52.578000,0,-30.480000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.198000,0,-33.274000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<52.578000,0,-33.274000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.198000,0,-27.686000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<52.578000,0,-27.686000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<60.198000,0,-36.068000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<52.578000,0,-36.068000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<63.246000,0,-42.418000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<55.626000,0,-42.418000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.718000,0,-24.638000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<29.718000,0,-32.258000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<36.830000,0,0.254000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<44.450000,0,0.254000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.718000,0,-14.224000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.718000,0,-19.304000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.718000,0,-4.064000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.718000,0,-9.144000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<63.246000,0,-20.066000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<44.450000,0,-27.178000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<34.036000,0,-27.178000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<50.038000,0,-8.128000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<48.514000,0,-27.686000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<69.088000,0,-25.908000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<42.926000,0,-25.400000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-0.000000,-27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-0.000000,-38.100000>}
box{<0,0,-0.254000><10.668000,0.035000,0.254000> rotate<0,-90.000000,0> translate<22.860000,-0.000000,-38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<22.860000,-0.000000,-27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.114000,-0.000000,-26.924000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,-63.430762,0> translate<22.860000,-0.000000,-27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.114000,-0.000000,-26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.368000,-0.000000,-26.416000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,-63.430762,0> translate<23.114000,-0.000000,-26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.368000,-0.000000,-26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.368000,-0.000000,-20.320000>}
box{<0,0,-0.254000><6.096000,0.035000,0.254000> rotate<0,90.000000,0> translate<23.368000,-0.000000,-20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.400000,-0.000000,-38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654000,-0.000000,-37.592000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-63.430762,0> translate<25.400000,-0.000000,-38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654000,-0.000000,-36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654000,-0.000000,-37.592000>}
box{<0,0,-0.203200><1.016000,0.035000,0.203200> rotate<0,-90.000000,0> translate<25.654000,-0.000000,-37.592000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.908000,-0.000000,-27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.908000,-0.000000,-36.068000>}
box{<0,0,-0.203200><8.636000,0.035000,0.203200> rotate<0,-90.000000,0> translate<25.908000,-0.000000,-36.068000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654000,-0.000000,-26.924000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.908000,-0.000000,-27.432000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,63.430762,0> translate<25.654000,-0.000000,-26.924000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.654000,-0.000000,-36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-0.000000,-36.195000>}
box{<0,0,-0.203200><0.538815,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.654000,-0.000000,-36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.908000,-0.000000,-36.068000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-0.000000,-36.195000>}
box{<0,0,-0.203200><0.179605,0.035000,0.203200> rotate<0,44.997030,0> translate<25.908000,-0.000000,-36.068000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<23.368000,-0.000000,-20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<28.448000,-0.000000,-15.240000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,-44.997030,0> translate<23.368000,-0.000000,-20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.035000,-0.000000,-36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.464000,-0.000000,-32.766000>}
box{<0,0,-0.203200><4.849338,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.035000,-0.000000,-36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.464000,-0.000000,-32.766000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.718000,-0.000000,-32.258000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-63.430762,0> translate<29.464000,-0.000000,-32.766000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-24.638000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-19.304000>}
box{<0,0,-0.254000><5.334000,0.035000,0.254000> rotate<0,90.000000,0> translate<29.718000,-0.000000,-19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<28.448000,-0.000000,-15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-14.224000>}
box{<0,0,-0.254000><1.626394,0.035000,0.254000> rotate<0,-38.657257,0> translate<28.448000,-0.000000,-15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.496000,-0.000000,-3.556000>}
box{<0,0,-0.254000><1.849148,0.035000,0.254000> rotate<0,-15.944344,0> translate<29.718000,-0.000000,-4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-19.050000>}
box{<0,0,-0.254000><2.047813,0.035000,0.254000> rotate<0,-7.124546,0> translate<29.718000,-0.000000,-19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-13.970000>}
box{<0,0,-0.254000><2.047813,0.035000,0.254000> rotate<0,-7.124546,0> translate<29.718000,-0.000000,-14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.718000,-0.000000,-9.144000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-8.890000>}
box{<0,0,-0.254000><2.047813,0.035000,0.254000> rotate<0,-7.124546,0> translate<29.718000,-0.000000,-9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.782000,-0.000000,-38.608000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-38.100000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-63.430762,0> translate<33.782000,-0.000000,-38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-32.004000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-38.100000>}
box{<0,0,-0.203200><6.096000,0.035000,0.203200> rotate<0,-90.000000,0> translate<34.036000,-0.000000,-38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-23.876000>}
box{<0,0,-0.203200><3.302000,0.035000,0.203200> rotate<0,90.000000,0> translate<34.036000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-32.004000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.544000,-0.000000,-31.496000>}
box{<0,0,-0.203200><0.718420,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.036000,-0.000000,-32.004000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.496000,-0.000000,-3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.544000,-0.000000,-3.556000>}
box{<0,0,-0.254000><3.048000,0.035000,0.254000> rotate<0,0.000000,0> translate<31.496000,-0.000000,-3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.544000,-0.000000,-3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.544000,-0.000000,3.810000>}
box{<0,0,-0.254000><7.366000,0.035000,0.254000> rotate<0,90.000000,0> translate<34.544000,-0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.544000,-0.000000,-31.496000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,-30.734000>}
box{<0,0,-0.203200><0.803219,0.035000,0.203200> rotate<0,-71.560328,0> translate<34.544000,-0.000000,-31.496000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.544000,-0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.798000,-0.000000,3.302000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,63.430762,0> translate<34.544000,-0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.052000,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.052000,-1.535000,5.588000>}
box{<0,0,-0.203200><0.508000,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.052000,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.544000,-1.535000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.052000,-1.535000,6.096000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,26.563298,0> translate<34.544000,-1.535000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.798000,-0.000000,-30.734000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-0.000000,-29.972000>}
box{<0,0,-0.203200><1.077631,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.798000,-0.000000,-30.734000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-0.000000,-29.972000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-0.000000,-25.654000>}
box{<0,0,-0.203200><4.318000,0.035000,0.203200> rotate<0,90.000000,0> translate<35.560000,-0.000000,-25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,-27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.814000,-1.535000,-28.956000>}
box{<0,0,-0.203200><2.514472,0.035000,0.203200> rotate<0,44.997030,0> translate<34.036000,-1.535000,-27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-0.000000,-25.654000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.814000,-0.000000,-25.146000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-63.430762,0> translate<35.560000,-0.000000,-25.654000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.322000,-1.535000,-25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.322000,-1.535000,-27.686000>}
box{<0,0,-0.203200><2.286000,0.035000,0.203200> rotate<0,-90.000000,0> translate<36.322000,-1.535000,-27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.814000,-1.535000,-25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.322000,-1.535000,-25.400000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,26.563298,0> translate<35.814000,-1.535000,-25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.052000,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.084000,-1.535000,5.588000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.052000,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-0.000000,-23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.338000,-0.000000,-20.574000>}
box{<0,0,-0.203200><4.669733,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.036000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-13.970000>}
box{<0,0,-0.254000><5.588000,0.035000,0.254000> rotate<0,0.000000,0> translate<31.750000,-0.000000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-8.890000>}
box{<0,0,-0.254000><5.588000,0.035000,0.254000> rotate<0,0.000000,0> translate<31.750000,-0.000000,-8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.544000,-0.000000,-3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-3.556000>}
box{<0,0,-0.254000><2.794000,0.035000,0.254000> rotate<0,0.000000,0> translate<34.544000,-0.000000,-3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<36.830000,-0.000000,0.254000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,0.000000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,26.563298,0> translate<36.830000,-0.000000,0.254000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-0.000000,-19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-19.050000>}
box{<0,0,-0.254000><6.096000,0.035000,0.254000> rotate<0,0.000000,0> translate<31.750000,-0.000000,-19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-13.716000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,-26.563298,0> translate<37.338000,-0.000000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-8.509000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,-36.867464,0> translate<37.338000,-0.000000,-8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,-3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-3.175000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,-36.867464,0> translate<37.338000,-0.000000,-3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-8.509000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-0.000000,-7.874000>}
box{<0,0,-0.254000><0.683916,0.035000,0.254000> rotate<0,-68.194090,0> translate<37.846000,-0.000000,-8.509000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.354000,-0.000000,-18.796000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,-26.563298,0> translate<37.846000,-0.000000,-19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.846000,-0.000000,-13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.354000,-0.000000,-13.462000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,-26.563298,0> translate<37.846000,-0.000000,-13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.354000,-0.000000,-25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.862000,-0.000000,-25.400000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,26.563298,0> translate<38.354000,-0.000000,-25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.338000,-0.000000,-20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.116000,-0.000000,-20.574000>}
box{<0,0,-0.203200><1.778000,0.035000,0.203200> rotate<0,0.000000,0> translate<37.338000,-0.000000,-20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.100000,-0.000000,-7.874000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-6.350000>}
box{<0,0,-0.254000><2.155261,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.100000,-0.000000,-7.874000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-5.334000>}
box{<0,0,-0.254000><1.016000,0.035000,0.254000> rotate<0,90.000000,0> translate<39.624000,-0.000000,-5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.338000,-0.000000,0.000000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-2.286000>}
box{<0,0,-0.254000><3.232892,0.035000,0.254000> rotate<0,44.997030,0> translate<37.338000,-0.000000,0.000000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-2.286000>}
box{<0,0,-0.254000><3.048000,0.035000,0.254000> rotate<0,90.000000,0> translate<39.624000,-0.000000,-2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.354000,-0.000000,-13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.386000,-0.000000,-13.462000>}
box{<0,0,-0.254000><2.032000,0.035000,0.254000> rotate<0,0.000000,0> translate<38.354000,-0.000000,-13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.322000,-1.535000,-27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-27.686000>}
box{<0,0,-0.203200><4.318000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.322000,-1.535000,-27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.862000,-0.000000,-25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-0.000000,-25.400000>}
box{<0,0,-0.254000><1.778000,0.035000,0.254000> rotate<0,0.000000,0> translate<38.862000,-0.000000,-25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-12.700000>}
box{<0,0,-0.203200><10.414000,0.035000,0.203200> rotate<0,90.000000,0> translate<40.640000,-1.535000,-12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-0.000000,-25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.767000,-0.000000,-25.527000>}
box{<0,0,-0.254000><0.179605,0.035000,0.254000> rotate<0,44.997030,0> translate<40.640000,-0.000000,-25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<38.354000,-0.000000,-18.796000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.402000,-0.000000,-15.748000>}
box{<0,0,-0.254000><4.310523,0.035000,0.254000> rotate<0,-44.997030,0> translate<38.354000,-0.000000,-18.796000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.084000,-1.535000,5.588000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.529000,-1.535000,1.143000>}
box{<0,0,-0.203200><6.286179,0.035000,0.203200> rotate<0,44.997030,0> translate<37.084000,-1.535000,5.588000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,-11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<40.640000,-1.535000,-12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.529000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,0.762000>}
box{<0,0,-0.203200><0.538815,0.035000,0.203200> rotate<0,44.997030,0> translate<41.529000,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.814000,-1.535000,-28.956000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.672000,-1.535000,-28.956000>}
box{<0,0,-0.203200><6.858000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.814000,-1.535000,-28.956000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.116000,-0.000000,-20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.672000,-0.000000,-17.018000>}
box{<0,0,-0.203200><5.028943,0.035000,0.203200> rotate<0,-44.997030,0> translate<39.116000,-0.000000,-20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.926000,-1.535000,-25.400000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,-44.997030,0> translate<40.640000,-1.535000,-27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.640000,-1.535000,-23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.926000,-1.535000,-25.400000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,44.997030,0> translate<40.640000,-1.535000,-23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.402000,-0.000000,-15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-0.000000,-15.748000>}
box{<0,0,-0.254000><1.778000,0.035000,0.254000> rotate<0,0.000000,0> translate<41.402000,-0.000000,-15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.180000,-1.535000,-11.430000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.910000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.910000,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.196000,-1.535000,0.762000>}
box{<0,0,-0.203200><2.286000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.910000,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.672000,-1.535000,-28.956000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.450000,-1.535000,-27.178000>}
box{<0,0,-0.203200><2.514472,0.035000,0.203200> rotate<0,-44.997030,0> translate<42.672000,-1.535000,-28.956000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.672000,-0.000000,-17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.450000,-0.000000,-17.018000>}
box{<0,0,-0.203200><1.778000,0.035000,0.203200> rotate<0,0.000000,0> translate<42.672000,-0.000000,-17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.196000,-1.535000,0.762000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.450000,-1.535000,0.254000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,63.430762,0> translate<44.196000,-1.535000,0.762000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.767000,-0.000000,-25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-21.590000>}
box{<0,0,-0.254000><5.567759,0.035000,0.254000> rotate<0,-44.997030,0> translate<40.767000,-0.000000,-25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-18.542000>}
box{<0,0,-0.254000><3.048000,0.035000,0.254000> rotate<0,90.000000,0> translate<44.704000,-0.000000,-18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<43.180000,-0.000000,-15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-14.224000>}
box{<0,0,-0.254000><2.155261,0.035000,0.254000> rotate<0,-44.997030,0> translate<43.180000,-0.000000,-15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-11.430000>}
box{<0,0,-0.254000><2.794000,0.035000,0.254000> rotate<0,90.000000,0> translate<44.704000,-0.000000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.450000,-0.000000,-27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.466000,-0.000000,-26.162000>}
box{<0,0,-0.203200><1.436841,0.035000,0.203200> rotate<0,-44.997030,0> translate<44.450000,-0.000000,-27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.529000,-1.535000,1.143000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,5.334000>}
box{<0,0,-0.203200><5.926969,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.529000,-1.535000,1.143000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.974000,-1.535000,-25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.974000,-1.535000,-11.430000>}
box{<0,0,-0.203200><13.716000,0.035000,0.203200> rotate<0,90.000000,0> translate<45.974000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.767000,-0.000000,-25.527000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.228000,-0.000000,-30.988000>}
box{<0,0,-0.254000><7.723020,0.035000,0.254000> rotate<0,44.997030,0> translate<40.767000,-0.000000,-25.527000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.228000,-0.000000,-30.988000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.863000,-0.000000,-31.242000>}
box{<0,0,-0.254000><0.683916,0.035000,0.254000> rotate<0,21.799971,0> translate<46.228000,-0.000000,-30.988000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.863000,-0.000000,-31.242000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.990000,-0.000000,-32.004000>}
box{<0,0,-0.254000><0.772511,0.035000,0.254000> rotate<0,80.532363,0> translate<46.863000,-0.000000,-31.242000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.386000,-0.000000,-13.462000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.244000,-0.000000,-6.604000>}
box{<0,0,-0.254000><9.698677,0.035000,0.254000> rotate<0,-44.997030,0> translate<40.386000,-0.000000,-13.462000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.498000,-1.535000,-18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.498000,-1.535000,-14.478000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<47.498000,-1.535000,-14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.498000,-1.535000,-14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-13.970000>}
box{<0,0,-0.203200><0.718420,0.035000,0.203200> rotate<0,-44.997030,0> translate<47.498000,-1.535000,-14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.974000,-1.535000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-11.430000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.974000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.006000,-0.000000,-8.128000>}
box{<0,0,-0.254000><4.669733,0.035000,0.254000> rotate<0,-44.997030,0> translate<44.704000,-0.000000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.180000,-1.535000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-6.604000>}
box{<0,0,-0.203200><6.824995,0.035000,0.203200> rotate<0,-44.997030,0> translate<43.180000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-3.810000>}
box{<0,0,-0.203200><2.794000,0.035000,0.203200> rotate<0,90.000000,0> translate<48.006000,-1.535000,-3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.974000,-1.535000,-25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-1.535000,-27.686000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<45.974000,-1.535000,-25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-0.000000,-31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-0.000000,-27.686000>}
box{<0,0,-0.203200><4.064000,0.035000,0.203200> rotate<0,90.000000,0> translate<48.514000,-0.000000,-27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-1.535000,-10.541000>}
box{<0,0,-0.203200><1.023907,0.035000,0.203200> rotate<0,-60.251142,0> translate<48.006000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-1.535000,-2.921000>}
box{<0,0,-0.203200><1.023907,0.035000,0.203200> rotate<0,-60.251142,0> translate<48.006000,-1.535000,-3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.990000,-0.000000,-32.004000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.768000,-0.000000,-33.782000>}
box{<0,0,-0.254000><2.514472,0.035000,0.254000> rotate<0,44.997030,0> translate<46.990000,-0.000000,-32.004000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.768000,-0.000000,-38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.768000,-0.000000,-33.782000>}
box{<0,0,-0.254000><4.318000,0.035000,0.254000> rotate<0,90.000000,0> translate<48.768000,-0.000000,-33.782000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.450000,-0.000000,-17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.768000,-0.000000,-12.700000>}
box{<0,0,-0.203200><6.106574,0.035000,0.203200> rotate<0,-44.997030,0> translate<44.450000,-0.000000,-17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-42.418000>}
box{<0,0,-0.254000><0.762000,0.035000,0.254000> rotate<0,90.000000,0> translate<49.022000,-0.000000,-42.418000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.768000,-0.000000,-38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-38.608000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,63.430762,0> translate<48.768000,-0.000000,-38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-42.418000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-38.608000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,90.000000,0> translate<49.022000,-0.000000,-38.608000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.039000,-0.000000,-45.720000>}
box{<0,0,-0.254000><2.540057,0.035000,0.254000> rotate<0,89.610616,0> translate<49.022000,-0.000000,-43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.704000,-0.000000,-18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.276000,-0.000000,-13.970000>}
box{<0,0,-0.254000><6.465784,0.035000,0.254000> rotate<0,-44.997030,0> translate<44.704000,-0.000000,-18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.498000,-1.535000,-18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-1.535000,-20.574000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,44.997030,0> translate<47.498000,-1.535000,-18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-1.535000,-22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-1.535000,-20.574000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,90.000000,0> translate<49.784000,-1.535000,-20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.926000,-0.000000,-25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-0.000000,-18.542000>}
box{<0,0,-0.203200><9.698677,0.035000,0.203200> rotate<0,-44.997030,0> translate<42.926000,-0.000000,-25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-0.000000,-18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-0.000000,-17.526000>}
box{<0,0,-0.203200><1.016000,0.035000,0.203200> rotate<0,90.000000,0> translate<49.784000,-0.000000,-17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-1.535000,-22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.038000,-1.535000,-23.876000>}
box{<0,0,-0.203200><1.295151,0.035000,0.203200> rotate<0,78.684874,0> translate<49.784000,-1.535000,-22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.784000,-0.000000,-17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.038000,-0.000000,-16.256000>}
box{<0,0,-0.203200><1.295151,0.035000,0.203200> rotate<0,-78.684874,0> translate<49.784000,-0.000000,-17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.006000,-0.000000,-8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.038000,-0.000000,-8.128000>}
box{<0,0,-0.254000><2.032000,0.035000,0.254000> rotate<0,0.000000,0> translate<48.006000,-0.000000,-8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.038000,-1.535000,-8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.038000,-1.535000,-7.366000>}
box{<0,0,-0.254000><0.762000,0.035000,0.254000> rotate<0,90.000000,0> translate<50.038000,-1.535000,-7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.038000,-1.535000,-7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.292000,-1.535000,-7.112000>}
box{<0,0,-0.254000><0.359210,0.035000,0.254000> rotate<0,-44.997030,0> translate<50.038000,-1.535000,-7.366000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.006000,-1.535000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.546000,-1.535000,-13.970000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.006000,-1.535000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.546000,-1.535000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.546000,-1.535000,-11.430000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,90.000000,0> translate<50.546000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.244000,-0.000000,-6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.546000,-0.000000,-6.604000>}
box{<0,0,-0.254000><3.302000,0.035000,0.254000> rotate<0,0.000000,0> translate<47.244000,-0.000000,-6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.514000,-0.000000,-31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-0.000000,-34.290000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<48.514000,-0.000000,-31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-0.000000,-36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-0.000000,-34.290000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,90.000000,0> translate<51.054000,-0.000000,-34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.546000,-1.535000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-1.535000,-10.541000>}
box{<0,0,-0.203200><1.023907,0.035000,0.203200> rotate<0,-60.251142,0> translate<50.546000,-1.535000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.624000,-0.000000,-5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<51.562000,-0.000000,-5.334000>}
box{<0,0,-0.254000><11.938000,0.035000,0.254000> rotate<0,0.000000,0> translate<39.624000,-0.000000,-5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-1.535000,-2.921000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-1.535000,-3.810000>}
box{<0,0,-0.203200><1.023907,0.035000,0.203200> rotate<0,60.251142,0> translate<51.054000,-1.535000,-2.921000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-1.535000,-5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-1.535000,-3.810000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,90.000000,0> translate<51.562000,-1.535000,-3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.038000,-0.000000,-23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.578000,-0.000000,-23.876000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<50.038000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.578000,-0.000000,-23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.086000,-0.000000,-22.860000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,-63.430762,0> translate<52.578000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<51.562000,-0.000000,-5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.086000,-0.000000,-3.810000>}
box{<0,0,-0.254000><2.155261,0.035000,0.254000> rotate<0,-44.997030,0> translate<51.562000,-0.000000,-5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.466000,-0.000000,-26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.340000,-0.000000,-26.162000>}
box{<0,0,-0.203200><7.874000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.466000,-0.000000,-26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.546000,-0.000000,-6.604000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-0.000000,-9.398000>}
box{<0,0,-0.254000><3.951313,0.035000,0.254000> rotate<0,44.997030,0> translate<50.546000,-0.000000,-6.604000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,-0.000000,-9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.594000,-0.000000,-10.541000>}
box{<0,0,-0.254000><1.170882,0.035000,0.254000> rotate<0,77.466079,0> translate<53.340000,-0.000000,-9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.086000,-0.000000,-3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.594000,-0.000000,-2.921000>}
box{<0,0,-0.254000><1.023907,0.035000,0.254000> rotate<0,-60.251142,0> translate<53.086000,-0.000000,-3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.086000,-0.000000,-22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.356000,-0.000000,-21.590000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.086000,-0.000000,-22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.054000,-0.000000,-36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,-0.000000,-40.386000>}
box{<0,0,-0.203200><5.028943,0.035000,0.203200> rotate<0,44.997030,0> translate<51.054000,-0.000000,-36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.340000,-0.000000,-26.162000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,-0.000000,-24.892000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.340000,-0.000000,-26.162000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,-0.000000,-24.892000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.118000,-0.000000,-23.876000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,-63.430762,0> translate<54.610000,-0.000000,-24.892000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.578000,-0.000000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.118000,-0.000000,-16.256000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<52.578000,-0.000000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.022000,-0.000000,-42.418000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<55.626000,-0.000000,-42.418000>}
box{<0,0,-0.254000><6.604000,0.035000,0.254000> rotate<0,0.000000,0> translate<49.022000,-0.000000,-42.418000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.118000,-0.000000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.626000,-0.000000,-17.272000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,63.430762,0> translate<55.118000,-0.000000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-0.000000,-10.541000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-0.000000,-10.668000>}
box{<0,0,-0.203200><0.127000,0.035000,0.203200> rotate<0,-90.000000,0> translate<56.134000,-0.000000,-10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-0.000000,-10.541000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-0.000000,-2.921000>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,90.000000,0> translate<56.134000,-0.000000,-2.921000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.626000,-0.000000,-17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.896000,-0.000000,-18.542000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<55.626000,-0.000000,-17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-0.000000,-23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-0.000000,-25.146000>}
box{<0,0,-0.203200><1.295151,0.035000,0.203200> rotate<0,78.684874,0> translate<57.658000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-0.000000,-33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-0.000000,-25.146000>}
box{<0,0,-0.203200><8.382000,0.035000,0.203200> rotate<0,90.000000,0> translate<57.912000,-0.000000,-25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-1.535000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.166000,-1.535000,-15.240000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,-63.430762,0> translate<57.658000,-1.535000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.166000,-1.535000,-15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.166000,-1.535000,-13.970000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,90.000000,0> translate<58.166000,-1.535000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.798000,-0.000000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.928000,-0.000000,3.302000>}
box{<0,0,-0.254000><24.130000,0.035000,0.254000> rotate<0,0.000000,0> translate<34.798000,-0.000000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.720000,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.928000,-1.535000,5.334000>}
box{<0,0,-0.203200><13.208000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.720000,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<58.928000,-0.000000,3.302000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.436000,-0.000000,3.048000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,26.563298,0> translate<58.928000,-0.000000,3.302000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.928000,-1.535000,5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.436000,-1.535000,5.588000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-26.563298,0> translate<58.928000,-1.535000,5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.182000,-0.000000,-45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-0.000000,-45.720000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-26.563298,0> translate<59.182000,-0.000000,-45.974000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.436000,-0.000000,3.048000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-0.000000,2.540000>}
box{<0,0,-0.254000><0.567961,0.035000,0.254000> rotate<0,63.430762,0> translate<59.436000,-0.000000,3.048000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.912000,-0.000000,-33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.944000,-0.000000,-35.560000>}
box{<0,0,-0.203200><2.873682,0.035000,0.203200> rotate<0,44.997030,0> translate<57.912000,-0.000000,-33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.944000,-0.000000,-35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-36.068000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,63.430762,0> translate<59.944000,-0.000000,-35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.658000,-0.000000,-23.876000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-23.876000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<57.658000,-0.000000,-23.876000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.292000,-1.535000,-7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.452000,-1.535000,-7.112000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,0.000000,0> translate<50.292000,-1.535000,-7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.706000,-0.000000,-30.734000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,26.563298,0> translate<60.198000,-0.000000,-30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-27.686000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.706000,-0.000000,-27.940000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,26.563298,0> translate<60.198000,-0.000000,-27.686000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.706000,-1.535000,-7.366000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.706000,-1.535000,-9.652000>}
box{<0,0,-0.254000><2.286000,0.035000,0.254000> rotate<0,-90.000000,0> translate<60.706000,-1.535000,-9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.452000,-1.535000,-7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.706000,-1.535000,-7.366000>}
box{<0,0,-0.254000><0.359210,0.035000,0.254000> rotate<0,44.997030,0> translate<60.452000,-1.535000,-7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.356000,-0.000000,-21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-0.000000,-21.590000>}
box{<0,0,-0.203200><6.604000,0.035000,0.203200> rotate<0,0.000000,0> translate<54.356000,-0.000000,-21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-0.000000,-1.778000>}
box{<0,0,-0.254000><3.048000,0.035000,0.254000> rotate<0,-90.000000,0> translate<60.960000,-0.000000,-1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.690000,-0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-0.000000,1.270000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<59.690000,-0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.706000,-1.535000,-9.652000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.214000,-1.535000,-10.541000>}
box{<0,0,-0.254000><1.023907,0.035000,0.254000> rotate<0,60.251142,0> translate<60.706000,-1.535000,-9.652000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<60.960000,-0.000000,-1.778000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.214000,-0.000000,-2.921000>}
box{<0,0,-0.254000><1.170882,0.035000,0.254000> rotate<0,77.466079,0> translate<60.960000,-0.000000,-1.778000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.562000,-1.535000,-5.842000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.468000,-1.535000,-5.842000>}
box{<0,0,-0.203200><9.906000,0.035000,0.203200> rotate<0,0.000000,0> translate<51.562000,-1.535000,-5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.468000,-1.535000,-6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.468000,-1.535000,-5.842000>}
box{<0,0,-0.203200><0.254000,0.035000,0.203200> rotate<0,90.000000,0> translate<61.468000,-1.535000,-5.842000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.468000,-1.535000,-6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.722000,-1.535000,-6.350000>}
box{<0,0,-0.203200><0.359210,0.035000,0.203200> rotate<0,44.997030,0> translate<61.468000,-1.535000,-6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.768000,-0.000000,-12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.976000,-0.000000,-12.700000>}
box{<0,0,-0.203200><13.208000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.768000,-0.000000,-12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-36.068000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-36.068000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.198000,-0.000000,-36.068000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-33.274000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-33.274000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.198000,-0.000000,-33.274000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.706000,-0.000000,-30.734000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-30.734000>}
box{<0,0,-0.203200><1.524000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.706000,-0.000000,-30.734000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.960000,-0.000000,-21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-22.860000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<60.960000,-0.000000,-21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.706000,-0.000000,-27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.484000,-0.000000,-27.940000>}
box{<0,0,-0.203200><1.778000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.706000,-0.000000,-27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<59.690000,-0.000000,-45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,-42.672000>}
box{<0,0,-0.203200><4.310523,0.035000,0.203200> rotate<0,-44.997030,0> translate<59.690000,-0.000000,-45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,-23.876000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,63.430762,0> translate<62.230000,-0.000000,-22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<60.198000,-0.000000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,-16.256000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<60.198000,-0.000000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-0.000000,-42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-0.000000,-42.418000>}
box{<0,0,-0.203200><0.567961,0.035000,0.203200> rotate<0,-26.563298,0> translate<62.738000,-0.000000,-42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.738000,-1.535000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-1.535000,-17.272000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,63.430762,0> translate<62.738000,-1.535000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-1.535000,-20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-1.535000,-17.272000>}
box{<0,0,-0.203200><2.794000,0.035000,0.203200> rotate<0,90.000000,0> translate<63.246000,-1.535000,-17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<49.276000,-0.000000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.246000,-0.000000,-13.970000>}
box{<0,0,-0.254000><13.970000,0.035000,0.254000> rotate<0,0.000000,0> translate<49.276000,-0.000000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.976000,-0.000000,-12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-0.000000,-11.430000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<61.976000,-0.000000,-12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-36.068000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-36.195000>}
box{<0,0,-0.203200><1.276334,0.035000,0.203200> rotate<0,5.710216,0> translate<62.230000,-0.000000,-36.068000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-33.274000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-33.655000>}
box{<0,0,-0.203200><1.325919,0.035000,0.203200> rotate<0,16.698142,0> translate<62.230000,-0.000000,-33.274000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.230000,-0.000000,-30.734000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-31.115000>}
box{<0,0,-0.203200><1.325919,0.035000,0.203200> rotate<0,16.698142,0> translate<62.230000,-0.000000,-30.734000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.484000,-0.000000,-27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-28.575000>}
box{<0,0,-0.203200><1.198116,0.035000,0.203200> rotate<0,32.003271,0> translate<62.484000,-0.000000,-27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.896000,-0.000000,-18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-18.542000>}
box{<0,0,-0.203200><6.604000,0.035000,0.203200> rotate<0,0.000000,0> translate<56.896000,-0.000000,-18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-0.000000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,-10.541000>}
box{<0,0,-0.203200><1.023907,0.035000,0.203200> rotate<0,-60.251142,0> translate<63.246000,-0.000000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.754000,-0.000000,-2.921000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.008000,-0.000000,-4.064000>}
box{<0,0,-0.203200><1.170882,0.035000,0.203200> rotate<0,77.466079,0> translate<63.754000,-0.000000,-2.921000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.008000,-0.000000,-5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.008000,-0.000000,-4.064000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,90.000000,0> translate<64.008000,-0.000000,-4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.246000,-0.000000,-20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.516000,-0.000000,-20.066000>}
box{<0,0,-0.203200><1.270000,0.035000,0.203200> rotate<0,0.000000,0> translate<63.246000,-0.000000,-20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-34.036000>}
box{<0,0,-0.203200><1.325919,0.035000,0.203200> rotate<0,16.698142,0> translate<63.500000,-0.000000,-33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-30.734000>}
box{<0,0,-0.203200><1.325919,0.035000,0.203200> rotate<0,-16.698142,0> translate<63.500000,-0.000000,-31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-1.535000,-28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-1.535000,-28.194000>}
box{<0,0,-0.203200><1.325919,0.035000,0.203200> rotate<0,-16.698142,0> translate<63.500000,-1.535000,-28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<63.500000,-0.000000,-18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-17.272000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<63.500000,-0.000000,-18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,-0.000000,-40.386000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.278000,-0.000000,-40.386000>}
box{<0,0,-0.203200><10.668000,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,-0.000000,-40.386000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.278000,-0.000000,-16.256000>}
box{<0,0,-0.203200><1.135923,0.035000,0.203200> rotate<0,-63.430762,0> translate<64.770000,-0.000000,-17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.278000,-0.000000,-16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.532000,-0.000000,-14.986000>}
box{<0,0,-0.203200><1.295151,0.035000,0.203200> rotate<0,-78.684874,0> translate<65.278000,-0.000000,-16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<63.246000,-0.000000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<65.786000,-0.000000,-11.430000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<63.246000,-0.000000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.278000,-0.000000,-40.386000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.040000,-0.000000,-39.624000>}
box{<0,0,-0.203200><1.077631,0.035000,0.203200> rotate<0,-44.997030,0> translate<65.278000,-0.000000,-40.386000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-34.036000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.040000,-0.000000,-35.306000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<64.770000,-0.000000,-34.036000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.040000,-0.000000,-39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.040000,-0.000000,-35.306000>}
box{<0,0,-0.203200><4.318000,0.035000,0.203200> rotate<0,90.000000,0> translate<66.040000,-0.000000,-35.306000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<65.786000,-0.000000,-11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<66.294000,-0.000000,-10.541000>}
box{<0,0,-0.254000><1.023907,0.035000,0.254000> rotate<0,-60.251142,0> translate<65.786000,-0.000000,-11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<61.722000,-1.535000,-6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-1.535000,-6.350000>}
box{<0,0,-0.203200><4.826000,0.035000,0.203200> rotate<0,0.000000,0> translate<61.722000,-1.535000,-6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.294000,-0.000000,-2.921000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-0.000000,-4.064000>}
box{<0,0,-0.203200><1.170882,0.035000,0.203200> rotate<0,77.466079,0> translate<66.294000,-0.000000,-2.921000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-0.000000,-6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-0.000000,-4.064000>}
box{<0,0,-0.203200><2.286000,0.035000,0.203200> rotate<0,90.000000,0> translate<66.548000,-0.000000,-4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-0.000000,-30.734000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-0.000000,-28.702000>}
box{<0,0,-0.203200><2.873682,0.035000,0.203200> rotate<0,-44.997030,0> translate<64.770000,-0.000000,-30.734000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.770000,-1.535000,-28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-1.535000,-28.194000>}
box{<0,0,-0.203200><2.032000,0.035000,0.203200> rotate<0,0.000000,0> translate<64.770000,-1.535000,-28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.516000,-0.000000,-20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-0.000000,-22.352000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,44.997030,0> translate<64.516000,-0.000000,-20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-0.000000,-28.702000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-0.000000,-22.352000>}
box{<0,0,-0.203200><6.350000,0.035000,0.203200> rotate<0,90.000000,0> translate<66.802000,-0.000000,-22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<58.166000,-1.535000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.310000,-1.535000,-13.970000>}
box{<0,0,-0.203200><9.144000,0.035000,0.203200> rotate<0,0.000000,0> translate<58.166000,-1.535000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<65.532000,-0.000000,-14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.818000,-0.000000,-12.700000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,-44.997030,0> translate<65.532000,-0.000000,-14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.008000,-0.000000,-5.334000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.818000,-0.000000,-9.144000>}
box{<0,0,-0.203200><5.388154,0.035000,0.203200> rotate<0,44.997030,0> translate<64.008000,-0.000000,-5.334000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.818000,-0.000000,-12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.818000,-0.000000,-9.144000>}
box{<0,0,-0.203200><3.556000,0.035000,0.203200> rotate<0,90.000000,0> translate<67.818000,-0.000000,-9.144000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.310000,-1.535000,-13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.834000,-1.535000,-12.446000>}
box{<0,0,-0.203200><2.155261,0.035000,0.203200> rotate<0,-44.997030,0> translate<67.310000,-1.535000,-13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-1.535000,-6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.834000,-1.535000,-8.636000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,44.997030,0> translate<66.548000,-1.535000,-6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.834000,-1.535000,-12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.834000,-1.535000,-8.636000>}
box{<0,0,-0.203200><3.810000,0.035000,0.203200> rotate<0,90.000000,0> translate<68.834000,-1.535000,-8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.802000,-1.535000,-28.194000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.088000,-1.535000,-25.908000>}
box{<0,0,-0.203200><3.232892,0.035000,0.203200> rotate<0,-44.997030,0> translate<66.802000,-1.535000,-28.194000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<66.548000,-0.000000,-6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.088000,-0.000000,-8.890000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<66.548000,-0.000000,-6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.088000,-0.000000,-25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.088000,-0.000000,-8.890000>}
box{<0,0,-0.203200><17.018000,0.035000,0.203200> rotate<0,90.000000,0> translate<69.088000,-0.000000,-8.890000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,-51.054000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,8.890000>}
box{<0,0,-0.203200><59.944000,0.035000,0.203200> rotate<0,90.000000,0> translate<20.320000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,-51.054000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.914000,-1.535000,-51.054000>}
box{<0,0,-0.203200><53.594000,0.035000,0.203200> rotate<0,0.000000,0> translate<20.320000,-1.535000,-51.054000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.320000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.914000,-1.535000,8.890000>}
box{<0,0,-0.203200><53.594000,0.035000,0.203200> rotate<0,0.000000,0> translate<20.320000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.914000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<73.914000,-1.535000,-51.054000>}
box{<0,0,-0.203200><59.944000,0.035000,0.203200> rotate<0,-90.000000,0> translate<73.914000,-1.535000,-51.054000> }
texture{col_pol}
}
#end
union{
cylinder{<37.846000,0.038000,-19.050000><37.846000,-1.538000,-19.050000>0.406400}
cylinder{<42.926000,0.038000,-19.050000><42.926000,-1.538000,-19.050000>0.406400}
cylinder{<37.846000,0.038000,-13.716000><37.846000,-1.538000,-13.716000>0.406400}
cylinder{<42.926000,0.038000,-13.716000><42.926000,-1.538000,-13.716000>0.406400}
cylinder{<37.846000,0.038000,-3.175000><37.846000,-1.538000,-3.175000>0.406400}
cylinder{<42.926000,0.038000,-3.175000><42.926000,-1.538000,-3.175000>0.406400}
cylinder{<37.846000,0.038000,-8.509000><37.846000,-1.538000,-8.509000>0.406400}
cylinder{<42.926000,0.038000,-8.509000><42.926000,-1.538000,-8.509000>0.406400}
cylinder{<49.022000,0.038000,-38.608000><49.022000,-1.538000,-38.608000>0.406400}
cylinder{<43.942000,0.038000,-38.608000><43.942000,-1.538000,-38.608000>0.406400}
cylinder{<33.782000,0.038000,-38.608000><33.782000,-1.538000,-38.608000>0.406400}
cylinder{<38.862000,0.038000,-38.608000><38.862000,-1.538000,-38.608000>0.406400}
cylinder{<34.544000,0.038000,-31.496000><34.544000,-1.538000,-31.496000>0.406400}
cylinder{<38.100000,0.038000,-31.496000><38.100000,-1.538000,-31.496000>0.406400}
cylinder{<46.863000,0.038000,-31.242000><46.863000,-1.538000,-31.242000>0.406400}
cylinder{<43.307000,0.038000,-31.242000><43.307000,-1.538000,-31.242000>0.406400}
cylinder{<48.514000,0.038000,-10.541000><48.514000,-1.538000,-10.541000>0.406400}
cylinder{<51.054000,0.038000,-10.541000><51.054000,-1.538000,-10.541000>0.406400}
cylinder{<53.594000,0.038000,-10.541000><53.594000,-1.538000,-10.541000>0.406400}
cylinder{<56.134000,0.038000,-10.541000><56.134000,-1.538000,-10.541000>0.406400}
cylinder{<58.674000,0.038000,-10.541000><58.674000,-1.538000,-10.541000>0.406400}
cylinder{<61.214000,0.038000,-10.541000><61.214000,-1.538000,-10.541000>0.406400}
cylinder{<63.754000,0.038000,-10.541000><63.754000,-1.538000,-10.541000>0.406400}
cylinder{<66.294000,0.038000,-10.541000><66.294000,-1.538000,-10.541000>0.406400}
cylinder{<66.294000,0.038000,-2.921000><66.294000,-1.538000,-2.921000>0.406400}
cylinder{<63.754000,0.038000,-2.921000><63.754000,-1.538000,-2.921000>0.406400}
cylinder{<61.214000,0.038000,-2.921000><61.214000,-1.538000,-2.921000>0.406400}
cylinder{<58.674000,0.038000,-2.921000><58.674000,-1.538000,-2.921000>0.406400}
cylinder{<56.134000,0.038000,-2.921000><56.134000,-1.538000,-2.921000>0.406400}
cylinder{<53.594000,0.038000,-2.921000><53.594000,-1.538000,-2.921000>0.406400}
cylinder{<51.054000,0.038000,-2.921000><51.054000,-1.538000,-2.921000>0.406400}
cylinder{<48.514000,0.038000,-2.921000><48.514000,-1.538000,-2.921000>0.406400}
cylinder{<50.038000,0.038000,-23.876000><50.038000,-1.538000,-23.876000>0.406400}
cylinder{<52.578000,0.038000,-23.876000><52.578000,-1.538000,-23.876000>0.406400}
cylinder{<55.118000,0.038000,-23.876000><55.118000,-1.538000,-23.876000>0.406400}
cylinder{<57.658000,0.038000,-23.876000><57.658000,-1.538000,-23.876000>0.406400}
cylinder{<60.198000,0.038000,-23.876000><60.198000,-1.538000,-23.876000>0.406400}
cylinder{<62.738000,0.038000,-23.876000><62.738000,-1.538000,-23.876000>0.406400}
cylinder{<65.278000,0.038000,-23.876000><65.278000,-1.538000,-23.876000>0.406400}
cylinder{<65.278000,0.038000,-16.256000><65.278000,-1.538000,-16.256000>0.406400}
cylinder{<62.738000,0.038000,-16.256000><62.738000,-1.538000,-16.256000>0.406400}
cylinder{<60.198000,0.038000,-16.256000><60.198000,-1.538000,-16.256000>0.406400}
cylinder{<57.658000,0.038000,-16.256000><57.658000,-1.538000,-16.256000>0.406400}
cylinder{<55.118000,0.038000,-16.256000><55.118000,-1.538000,-16.256000>0.406400}
cylinder{<52.578000,0.038000,-16.256000><52.578000,-1.538000,-16.256000>0.406400}
cylinder{<50.038000,0.038000,-16.256000><50.038000,-1.538000,-16.256000>0.406400}
cylinder{<35.814000,0.038000,-25.146000><35.814000,-1.538000,-25.146000>0.406400}
cylinder{<37.084000,0.038000,-23.241000><37.084000,-1.538000,-23.241000>0.406400}
cylinder{<38.354000,0.038000,-25.146000><38.354000,-1.538000,-25.146000>0.406400}
cylinder{<63.500000,0.038000,-38.735000><63.500000,-1.538000,-38.735000>0.508000}
cylinder{<63.500000,0.038000,-36.195000><63.500000,-1.538000,-36.195000>0.508000}
cylinder{<63.500000,0.038000,-33.655000><63.500000,-1.538000,-33.655000>0.508000}
cylinder{<63.500000,0.038000,-31.115000><63.500000,-1.538000,-31.115000>0.508000}
cylinder{<63.500000,0.038000,-28.575000><63.500000,-1.538000,-28.575000>0.508000}
cylinder{<59.182000,0.038000,-45.974000><59.182000,-1.538000,-45.974000>0.406400}
cylinder{<59.182000,0.038000,-48.514000><59.182000,-1.538000,-48.514000>0.406400}
cylinder{<34.544000,0.038000,3.810000><34.544000,-1.538000,3.810000>0.406400}
cylinder{<34.544000,0.038000,6.350000><34.544000,-1.538000,6.350000>0.406400}
cylinder{<59.436000,0.038000,5.588000><59.436000,-1.538000,5.588000>0.406400}
cylinder{<59.436000,0.038000,3.048000><59.436000,-1.538000,3.048000>0.406400}
cylinder{<23.114000,0.038000,-26.924000><23.114000,-1.538000,-26.924000>0.406400}
cylinder{<25.654000,0.038000,-26.924000><25.654000,-1.538000,-26.924000>0.406400}
cylinder{<25.400000,0.038000,-38.100000><25.400000,-1.538000,-38.100000>0.406400}
cylinder{<22.860000,0.038000,-38.100000><22.860000,-1.538000,-38.100000>0.406400}
cylinder{<33.799000,0.038000,-45.720000><33.799000,-1.538000,-45.720000>0.800000}
cylinder{<38.879000,0.038000,-45.720000><38.879000,-1.538000,-45.720000>0.800000}
cylinder{<43.959000,0.038000,-45.720000><43.959000,-1.538000,-45.720000>0.800000}
cylinder{<49.039000,0.038000,-45.720000><49.039000,-1.538000,-45.720000>0.800000}
cylinder{<60.198000,0.038000,-30.480000><60.198000,-1.538000,-30.480000>0.406400}
cylinder{<52.578000,0.038000,-30.480000><52.578000,-1.538000,-30.480000>0.406400}
cylinder{<60.198000,0.038000,-33.274000><60.198000,-1.538000,-33.274000>0.406400}
cylinder{<52.578000,0.038000,-33.274000><52.578000,-1.538000,-33.274000>0.406400}
cylinder{<60.198000,0.038000,-27.686000><60.198000,-1.538000,-27.686000>0.406400}
cylinder{<52.578000,0.038000,-27.686000><52.578000,-1.538000,-27.686000>0.406400}
cylinder{<60.198000,0.038000,-36.068000><60.198000,-1.538000,-36.068000>0.406400}
cylinder{<52.578000,0.038000,-36.068000><52.578000,-1.538000,-36.068000>0.406400}
cylinder{<63.246000,0.038000,-42.418000><63.246000,-1.538000,-42.418000>0.406400}
cylinder{<55.626000,0.038000,-42.418000><55.626000,-1.538000,-42.418000>0.406400}
cylinder{<29.718000,0.038000,-24.638000><29.718000,-1.538000,-24.638000>0.406400}
cylinder{<29.718000,0.038000,-32.258000><29.718000,-1.538000,-32.258000>0.406400}
cylinder{<36.830000,0.038000,0.254000><36.830000,-1.538000,0.254000>0.406400}
cylinder{<44.450000,0.038000,0.254000><44.450000,-1.538000,0.254000>0.406400}
cylinder{<29.718000,0.038000,-14.224000><29.718000,-1.538000,-14.224000>0.698500}
cylinder{<29.718000,0.038000,-19.304000><29.718000,-1.538000,-19.304000>0.698500}
cylinder{<29.718000,0.038000,-4.064000><29.718000,-1.538000,-4.064000>0.698500}
cylinder{<29.718000,0.038000,-9.144000><29.718000,-1.538000,-9.144000>0.698500}
//Holes(fast)/Vias
cylinder{<63.246000,0.038000,-20.066000><63.246000,-1.538000,-20.066000>0.304800 }
cylinder{<44.450000,0.038000,-27.178000><44.450000,-1.538000,-27.178000>0.304800 }
cylinder{<34.036000,0.038000,-27.178000><34.036000,-1.538000,-27.178000>0.304800 }
cylinder{<50.038000,0.038000,-8.128000><50.038000,-1.538000,-8.128000>0.304800 }
cylinder{<48.514000,0.038000,-27.686000><48.514000,-1.538000,-27.686000>0.304800 }
cylinder{<69.088000,0.038000,-25.908000><69.088000,-1.538000,-25.908000>0.304800 }
cylinder{<42.926000,0.038000,-25.400000><42.926000,-1.538000,-25.400000>0.304800 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-23.166100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-23.166100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-23.166100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-23.166100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-22.581500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-22.581500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-22.581500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-22.386600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<69.985400,0.000000,-22.386600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-22.386600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-22.386600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<69.205800,0.000000,-22.386600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-22.386600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-22.581500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.010900,0.000000,-22.581500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-22.581500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-23.166100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.010900,0.000000,-23.166100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-21.217300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-21.412200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.010900,0.000000,-21.412200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-21.412200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-21.802000>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.010900,0.000000,-21.802000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-21.802000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-21.996800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<69.010900,0.000000,-21.802000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-21.996800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-21.996800>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<69.205800,0.000000,-21.996800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-21.996800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-21.802000>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.985400,0.000000,-21.996800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-21.802000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-21.412200>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-21.412200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-21.412200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-21.217300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<69.985400,0.000000,-21.217300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-19.658200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-19.658200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-19.658200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-19.658200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-19.268500>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-44.989680,0> translate<69.010900,0.000000,-19.658200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-19.268500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-18.878700>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,44.997030,0> translate<69.010900,0.000000,-18.878700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-18.878700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-18.878700>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-18.878700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-18.294100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-17.904300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-17.904300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-17.904300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-17.709400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<69.985400,0.000000,-17.709400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-17.709400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-17.709400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-17.709400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-17.709400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-17.904300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.400700,0.000000,-17.904300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-17.904300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-18.294100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.400700,0.000000,-18.294100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-18.294100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-18.488900>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<69.400700,0.000000,-18.294100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-18.488900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-18.488900>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-18.488900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-18.488900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-18.294100>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.985400,0.000000,-18.488900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-17.124800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-17.124800>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<69.205800,0.000000,-17.124800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-17.124800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-16.929900>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<69.985400,0.000000,-17.124800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-17.319600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-16.929900>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-16.929900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-16.345300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-15.955500>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-15.955500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-15.955500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-15.760600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<69.985400,0.000000,-15.760600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-15.760600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-15.760600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-15.760600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-15.760600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-15.955500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.400700,0.000000,-15.955500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-15.955500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-16.345300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.400700,0.000000,-16.345300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-16.345300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-16.540100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<69.400700,0.000000,-16.345300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-16.540100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-16.540100>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-16.540100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-16.540100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-16.345300>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.985400,0.000000,-16.540100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-15.370800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-15.370800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.400700,0.000000,-15.370800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-15.370800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-14.981100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<69.400700,0.000000,-14.981100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-14.981100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-14.786200>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-14.786200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-13.227100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-13.227100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-13.227100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-13.227100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-12.642500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-12.642500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-12.642500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-12.447600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<69.985400,0.000000,-12.447600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-12.447600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-12.447600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,0.000000,0> translate<69.205800,0.000000,-12.447600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.205800,0.000000,-12.447600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-12.642500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.010900,0.000000,-12.642500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-12.642500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-13.227100>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.010900,0.000000,-13.227100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-12.057800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-12.057800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.400700,0.000000,-12.057800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-12.057800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-11.668100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<69.400700,0.000000,-11.668100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-11.668100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-11.473200>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-11.473200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-11.083400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-10.888600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-10.888600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-10.888600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-10.888600>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.400700,0.000000,-10.888600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-11.083400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-10.693700>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-10.693700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.816000,0.000000,-10.888600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-10.888600>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<68.816000,0.000000,-10.888600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-10.303900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-9.914200>}
box{<0,0,-0.050800><0.871485,0.036000,0.050800> rotate<0,-26.560358,0> translate<69.400700,0.000000,-10.303900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-9.914200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-9.524400>}
box{<0,0,-0.050800><0.871530,0.036000,0.050800> rotate<0,26.566238,0> translate<69.400700,0.000000,-9.524400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-8.550000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-8.939800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<70.180200,0.000000,-8.939800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-8.939800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-9.134600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.985400,0.000000,-9.134600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-9.134600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-9.134600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-9.134600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-9.134600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-8.939800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<69.400700,0.000000,-8.939800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-8.939800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-8.550000>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-8.550000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-8.550000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-8.355100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<69.400700,0.000000,-8.550000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.595600,0.000000,-8.355100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-8.355100>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<69.595600,0.000000,-8.355100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-8.355100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-9.134600>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.790500,0.000000,-9.134600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-7.965300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-7.965300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.400700,0.000000,-7.965300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.790500,0.000000,-7.965300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-7.575600>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<69.400700,0.000000,-7.575600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-7.575600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-7.380700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<69.400700,0.000000,-7.380700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-5.821600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-5.431900>}
box{<0,0,-0.050800><0.871485,0.036000,0.050800> rotate<0,-26.560358,0> translate<69.400700,0.000000,-5.821600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-5.431900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-5.042100>}
box{<0,0,-0.050800><0.871530,0.036000,0.050800> rotate<0,26.566238,0> translate<69.400700,0.000000,-5.042100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-4.652300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-4.262600>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<69.010900,0.000000,-4.262600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-4.262600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-4.262600>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-4.262600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-4.652300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-3.872800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-3.872800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-3.483000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-3.483000>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.985400,0.000000,-3.483000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-3.483000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-3.288200>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<69.985400,0.000000,-3.288200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.985400,0.000000,-3.288200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-3.288200>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<69.985400,0.000000,-3.288200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-3.288200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-3.483000>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<70.180200,0.000000,-3.483000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.400700,0.000000,-2.898400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-2.508700>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<69.010900,0.000000,-2.508700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.010900,0.000000,-2.508700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-2.508700>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<69.010900,0.000000,-2.508700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-2.898400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.180200,0.000000,-2.118900>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<70.180200,0.000000,-2.118900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-38.344800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-38.149900>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<66.675400,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-38.149900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.285600,0.000000,-38.149900>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<66.285600,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.285600,0.000000,-38.149900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-38.344800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<66.090800,0.000000,-38.344800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-38.344800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-39.124400>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.090800,0.000000,-39.124400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-39.124400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.285600,0.000000,-39.319200>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<66.090800,0.000000,-39.124400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.285600,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-39.319200>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<66.285600,0.000000,-39.319200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-39.124400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<66.675400,0.000000,-39.319200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-39.124400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-38.734600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<66.870300,0.000000,-38.734600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-38.734600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.480500,0.000000,-38.734600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<66.480500,0.000000,-38.734600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-38.149900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<67.260100,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-38.149900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-39.319200>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,56.307347,0> translate<67.260100,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-38.149900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.039600,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-38.149900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-39.319200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<68.429400,0.000000,-39.319200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.014000,0.000000,-39.319200>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.429400,0.000000,-39.319200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.014000,0.000000,-39.319200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-39.124400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<69.014000,0.000000,-39.319200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-39.124400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-38.344800>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<69.208900,0.000000,-38.344800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-38.344800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.014000,0.000000,-38.149900>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<69.014000,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.014000,0.000000,-38.149900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-38.149900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.429400,0.000000,-38.149900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-36.779200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.090800,0.000000,-36.779200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-36.779200>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-36.779200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-36.584400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<66.675400,0.000000,-36.779200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-36.584400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-35.804800>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<66.870300,0.000000,-35.804800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-35.804800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-35.609900>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<66.675400,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-35.609900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-36.779200>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<67.260100,0.000000,-36.779200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.454900,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.454900,0.000000,-35.609900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<67.454900,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-35.609900>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<67.260100,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-35.609900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.039600,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-35.609900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.039600,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-35.804800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<68.624200,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-35.804800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-36.194600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<68.819100,0.000000,-36.194600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-36.194600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-36.389500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<68.624200,0.000000,-36.389500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-36.389500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-36.389500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.039600,0.000000,-36.389500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429300,0.000000,-36.389500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-36.779200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<68.429300,0.000000,-36.389500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-36.974000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.988400,0.000000,-36.974000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.208900,0.000000,-36.974000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-36.779200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-35.999700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<70.378200,0.000000,-35.999700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-35.999700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.767900,0.000000,-35.609900>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<70.378200,0.000000,-35.999700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.767900,0.000000,-35.609900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-35.999700>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,44.997030,0> translate<70.767900,0.000000,-35.609900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-35.999700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-36.779200>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.157700,0.000000,-36.779200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-36.194600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-36.194600>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<70.378200,0.000000,-36.194600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-34.239200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-33.069900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<66.090800,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-33.069900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-33.264800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<66.675400,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-33.264800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-33.654600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.870300,0.000000,-33.654600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-33.654600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-33.849500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<66.675400,0.000000,-33.849500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-33.849500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-33.849500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-33.849500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-34.239200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<67.260100,0.000000,-34.239200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-34.239200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-33.849500>}
box{<0,0,-0.050800><0.551119,0.036000,0.050800> rotate<0,-44.997030,0> translate<67.260100,0.000000,-34.239200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-33.849500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-34.239200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<67.649800,0.000000,-33.849500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-34.239200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-33.069900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.039600,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-34.239200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-33.069900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.429400,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-33.459700>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,45.004380,0> translate<68.429400,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-33.459700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-33.069900>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,-44.997030,0> translate<68.819100,0.000000,-33.459700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-34.239200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.208900,0.000000,-34.239200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.598700,0.000000,-34.434000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-34.434000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.598700,0.000000,-34.434000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-34.239200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-33.459700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<70.768000,0.000000,-33.459700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-33.459700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-33.069900>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<70.768000,0.000000,-33.459700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-33.069900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-33.459700>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,44.997030,0> translate<71.157700,0.000000,-33.069900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-33.459700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-34.239200>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.547500,0.000000,-34.239200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-33.654600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-33.654600>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<70.768000,0.000000,-33.654600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-31.699200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.090800,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-31.699200>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-31.504400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<66.675400,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-31.504400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-30.724800>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,90.000000,0> translate<66.870300,0.000000,-30.724800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-30.724800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-30.529900>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<66.675400,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-30.529900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-31.699200>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<67.260100,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.454900,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.454900,0.000000,-30.529900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<67.454900,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-30.529900>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<67.260100,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-30.529900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.039600,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-30.529900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.039600,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-30.724800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<68.624200,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-30.724800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-31.114600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<68.819100,0.000000,-31.114600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-31.114600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-31.309500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<68.624200,0.000000,-31.309500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.624200,0.000000,-31.309500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-31.309500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<68.039600,0.000000,-31.309500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429300,0.000000,-31.309500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-31.699200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<68.429300,0.000000,-31.309500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-31.894000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.988400,0.000000,-31.894000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.208900,0.000000,-31.894000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-30.529900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<70.378200,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-30.529900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.378200,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-30.529900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-30.724800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<70.962800,0.000000,-30.529900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-30.724800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-30.919700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.157700,0.000000,-30.919700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-30.919700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-31.114600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<70.962800,0.000000,-31.114600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-31.114600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-31.309500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<70.962800,0.000000,-31.114600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-31.309500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-31.504400>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.157700,0.000000,-31.504400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.157700,0.000000,-31.504400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-31.699200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<70.962800,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-31.699200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-31.699200>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.378200,0.000000,-31.699200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-31.114600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.962800,0.000000,-31.114600>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.378200,0.000000,-31.114600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-27.989900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<66.090800,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-27.989900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-28.184800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<66.675400,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-28.184800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-28.574600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<66.870300,0.000000,-28.574600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.870300,0.000000,-28.574600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-28.769500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<66.675400,0.000000,-28.769500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.675400,0.000000,-28.769500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<66.090800,0.000000,-28.769500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<66.090800,0.000000,-28.769500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-29.159200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<67.260100,0.000000,-29.159200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.260100,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-28.769500>}
box{<0,0,-0.050800><0.551119,0.036000,0.050800> rotate<0,-44.997030,0> translate<67.260100,0.000000,-29.159200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<67.649800,0.000000,-28.769500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-29.159200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<67.649800,0.000000,-28.769500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.039600,0.000000,-27.989900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.039600,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-27.989900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<68.429400,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.429400,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-28.379700>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,45.004380,0> translate<68.429400,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.819100,0.000000,-28.379700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-27.989900>}
box{<0,0,-0.050800><0.551260,0.036000,0.050800> rotate<0,-44.997030,0> translate<68.819100,0.000000,-28.379700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.208900,0.000000,-29.159200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<69.208900,0.000000,-29.159200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<69.598700,0.000000,-29.354000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.378200,0.000000,-29.354000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<69.598700,0.000000,-29.354000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-27.989900>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<70.768000,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-27.989900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.768000,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-27.989900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.184800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<71.352600,0.000000,-27.989900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.184800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.379700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.547500,0.000000,-28.379700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.379700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-28.574600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.352600,0.000000,-28.574600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-28.574600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.769500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<71.352600,0.000000,-28.574600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.769500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.964400>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.547500,0.000000,-28.964400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.547500,0.000000,-28.964400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-29.159200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<71.352600,0.000000,-29.159200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-29.159200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-29.159200>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.768000,0.000000,-29.159200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.768000,0.000000,-28.574600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.352600,0.000000,-28.574600>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<70.768000,0.000000,-28.574600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-24.333200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-24.333200>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-24.333200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-24.333200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-24.138400>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-24.138400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-24.138400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-23.943500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-24.138400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-23.943500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-23.943500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-23.943500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-23.943500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-23.748600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<71.305700,0.000000,-23.748600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-23.748600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-23.553700>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-23.748600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-23.553700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-23.553700>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-23.553700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-22.969100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-22.579300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-22.579300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-22.579300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-22.384400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-22.579300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-22.384400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-22.384400>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-22.384400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-22.384400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-22.969100>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-22.969100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-22.969100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-23.163900>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-23.163900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-23.163900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-22.969100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.695500,0.000000,-22.969100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-22.969100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-22.384400>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<71.695500,0.000000,-22.384400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-21.994600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-21.994600>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<70.915900,0.000000,-21.994600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-21.410000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-21.994600>}
box{<0,0,-0.050800><0.702583,0.036000,0.050800> rotate<0,-56.308478,0> translate<71.695500,0.000000,-21.994600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-21.994600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-21.410000>}
box{<0,0,-0.050800><0.702639,0.036000,0.050800> rotate<0,56.301693,0> translate<71.305700,0.000000,-21.410000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-20.435600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-20.825400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-20.825400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-20.825400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-21.020200>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-21.020200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-21.020200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-21.020200>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-21.020200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-21.020200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-20.825400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-20.825400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-20.825400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-20.435600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-20.435600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-20.435600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-20.240700>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-20.435600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-20.240700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-20.240700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-20.240700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-20.240700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-21.020200>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.695500,0.000000,-21.020200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-19.850900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-19.850900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-19.850900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-19.850900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-19.656100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.890400,0.000000,-19.656100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-19.656100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-19.656100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-19.656100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-19.656100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-19.850900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-19.850900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-19.266300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-19.266300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-19.266300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-19.266300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-18.876600>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<71.305700,0.000000,-18.876600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-18.876600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-18.681700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-18.681700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-18.291900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-18.291900>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-18.291900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-18.291900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-17.902200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<71.305700,0.000000,-17.902200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-17.902200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-17.707300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-17.707300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-17.317500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-17.317500>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-17.317500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-17.317500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-16.927800>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<71.305700,0.000000,-16.927800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-16.927800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-16.732900>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-16.732900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-16.148300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.110800,0.000000,-16.148300>}
box{<0,0,-0.050800><0.974400,0.036000,0.050800> rotate<0,0.000000,0> translate<71.110800,0.000000,-16.148300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.110800,0.000000,-16.148300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-15.953400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<70.915900,0.000000,-15.953400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-16.343100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-15.953400>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,90.000000,0> translate<71.500600,0.000000,-15.953400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-15.563600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-15.563600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-15.563600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-15.563600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-15.368800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.890400,0.000000,-15.368800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-15.368800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-15.368800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-15.368800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-15.368800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-15.563600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-15.563600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-14.784200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-14.394400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<72.085200,0.000000,-14.394400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-14.394400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-14.199500>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<71.890400,0.000000,-14.199500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-14.199500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-14.199500>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-14.199500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-14.199500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-14.394400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-14.394400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-14.394400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-14.784200>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.305700,0.000000,-14.784200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-14.784200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-14.979000>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-14.784200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-14.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-14.979000>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-14.979000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-14.979000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-14.784200>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-14.979000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-13.809700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-13.809700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-13.809700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.695500,0.000000,-13.809700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-13.420000>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<71.305700,0.000000,-13.420000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-13.420000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-13.225100>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-13.225100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.474900,0.000000,-12.445600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.474900,0.000000,-12.250700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<72.474900,0.000000,-12.250700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.474900,0.000000,-12.250700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.280000,0.000000,-12.055800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<72.280000,0.000000,-12.055800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.280000,0.000000,-12.055800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-12.055800>}
box{<0,0,-0.050800><0.974300,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-12.055800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-12.055800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-12.640500>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.305700,0.000000,-12.640500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-12.640500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-12.835300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-12.640500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-12.835300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-12.835300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-12.835300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-12.835300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-12.640500>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-12.835300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-12.640500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-12.055800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<72.085200,0.000000,-12.055800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-11.666000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-10.886500>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,33.686713,0> translate<70.915900,0.000000,-10.886500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-9.717200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-9.717200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<70.915900,0.000000,-9.717200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-9.717200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-10.301900>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-10.301900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-10.301900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-10.496700>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-10.496700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-10.496700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-10.496700>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-10.496700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-10.496700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-10.301900>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-10.301900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-10.301900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-9.717200>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-9.717200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-8.547900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-9.132600>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<71.305700,0.000000,-9.132600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-9.132600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-9.327400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-9.132600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-9.327400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-9.327400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-9.327400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-9.327400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-9.132600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-9.327400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-9.132600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-8.547900>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<72.085200,0.000000,-8.547900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-8.158100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-8.158100>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<71.305700,0.000000,-8.158100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-8.158100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-7.963300>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-7.963300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-7.963300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-7.768400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-7.963300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-7.768400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-7.768400>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-7.768400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-7.768400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-7.573500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<71.305700,0.000000,-7.573500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-7.573500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-7.378600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.305700,0.000000,-7.573500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-7.378600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-7.378600>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-7.378600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-6.209300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-6.209300>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<70.915900,0.000000,-6.209300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-6.209300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-6.794000>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-6.794000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-6.794000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-6.988800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<71.890400,0.000000,-6.988800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-6.988800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-6.988800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.500600,0.000000,-6.988800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-6.988800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-6.794000>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<71.305700,0.000000,-6.794000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-6.794000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-6.209300>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<71.305700,0.000000,-6.209300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-5.819500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.500600,0.000000,-5.040000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<71.500600,0.000000,-5.040000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-4.650200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-4.260500>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<70.915900,0.000000,-4.260500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-4.260500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-4.260500>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<70.915900,0.000000,-4.260500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-4.650200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-3.870700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<72.085200,0.000000,-3.870700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-3.480900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-3.480900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-3.480900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-3.480900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-3.286100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<71.890400,0.000000,-3.286100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.890400,0.000000,-3.286100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-3.286100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<71.890400,0.000000,-3.286100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-3.286100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-3.480900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<72.085200,0.000000,-3.480900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<71.305700,0.000000,-2.896300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-2.506600>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<70.915900,0.000000,-2.506600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.915900,0.000000,-2.506600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-2.506600>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<70.915900,0.000000,-2.506600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-2.896300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<72.085200,0.000000,-2.116800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<72.085200,0.000000,-2.116800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.201900,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.045200,0.000000,-12.991300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<49.045200,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.045200,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.731600,0.000000,-12.991300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<48.731600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.731600,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.574900,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<48.574900,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.574900,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.574900,0.000000,-13.775200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.574900,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.574900,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.731600,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<48.574900,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.731600,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.045200,0.000000,-13.931900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<48.731600,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.045200,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.201900,0.000000,-13.775200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<49.045200,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.667100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.980700,0.000000,-13.931900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<49.667100,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.980700,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.137400,0.000000,-13.775200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<49.980700,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.137400,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.137400,0.000000,-13.461600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<50.137400,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.137400,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.980700,0.000000,-13.304900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<49.980700,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.980700,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.667100,0.000000,-13.304900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<49.667100,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.667100,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.510400,0.000000,-13.461600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<49.510400,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.510400,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.510400,0.000000,-13.775200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<49.510400,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.510400,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.667100,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<49.510400,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.445900,0.000000,-14.245400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.445900,0.000000,-13.304900>}
box{<0,0,-0.038100><0.940500,0.036000,0.038100> rotate<0,90.000000,0> translate<50.445900,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.445900,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.916200,0.000000,-13.304900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<50.445900,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.916200,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.072900,0.000000,-13.461600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<50.916200,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.072900,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.072900,0.000000,-13.775200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<51.072900,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.072900,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.916200,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<50.916200,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.916200,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.445900,0.000000,-13.931900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<50.445900,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.381400,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.381400,0.000000,-13.775200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<51.381400,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.381400,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.538100,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<51.381400,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.538100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.008400,0.000000,-13.931900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<51.538100,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.008400,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.008400,0.000000,-14.088600>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,-90.000000,0> translate<52.008400,0.000000,-14.088600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.008400,0.000000,-14.088600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.851700,0.000000,-14.245400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<51.851700,0.000000,-14.245400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.851700,0.000000,-14.245400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.694900,0.000000,-14.245400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<51.694900,0.000000,-14.245400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.316900,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.316900,0.000000,-13.304900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<52.316900,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.316900,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.630400,0.000000,-13.304900>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,-44.997030,0> translate<52.316900,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.630400,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.787200,0.000000,-13.304900>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<52.630400,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.096400,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.253100,0.000000,-13.304900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<53.096400,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.253100,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.253100,0.000000,-13.931900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<53.253100,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.096400,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.409900,0.000000,-13.931900>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<53.096400,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.253100,0.000000,-12.834600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.253100,0.000000,-12.991300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<53.253100,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.033500,0.000000,-14.245400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.190300,0.000000,-14.245400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<54.033500,0.000000,-14.245400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.190300,0.000000,-14.245400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.347000,0.000000,-14.088600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<54.190300,0.000000,-14.245400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.347000,0.000000,-14.088600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.347000,0.000000,-13.304900>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,90.000000,0> translate<54.347000,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.347000,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.876700,0.000000,-13.304900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<53.876700,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.876700,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.720000,0.000000,-13.461600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<53.720000,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.720000,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.720000,0.000000,-13.775200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<53.720000,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.720000,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.876700,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<53.720000,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.876700,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.347000,0.000000,-13.931900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<53.876700,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.655500,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.655500,0.000000,-13.931900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,-90.000000,0> translate<54.655500,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.655500,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.812200,0.000000,-13.304900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<54.655500,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.812200,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.125800,0.000000,-13.304900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<54.812200,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.125800,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.282500,0.000000,-13.461600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<55.125800,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.282500,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.282500,0.000000,-13.931900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<55.282500,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.747700,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.747700,0.000000,-13.775200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<55.747700,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.747700,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.904500,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<55.747700,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.591000,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.904500,0.000000,-13.304900>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<55.591000,0.000000,-13.304900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.777100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.150100,0.000000,-13.931900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<57.150100,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.150100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.777100,0.000000,-13.304900>}
box{<0,0,-0.038100><0.886712,0.036000,0.038100> rotate<0,-44.997030,0> translate<57.150100,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.777100,0.000000,-13.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.777100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<57.777100,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.777100,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.620400,0.000000,-12.991300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<57.620400,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.620400,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.306800,0.000000,-12.991300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<57.306800,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.306800,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.150100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<57.150100,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.085600,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.085600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,90.000000,0> translate<58.085600,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.085600,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.242300,0.000000,-12.991300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<58.085600,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.242300,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.555900,0.000000,-12.991300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<58.242300,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.555900,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.712600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<58.555900,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.712600,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.712600,0.000000,-13.775200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<58.712600,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.712600,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.555900,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<58.555900,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.555900,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.242300,0.000000,-13.931900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<58.242300,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.242300,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.085600,0.000000,-13.775200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<58.085600,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.085600,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.712600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,-45.001599,0> translate<58.085600,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.021100,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.021100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,90.000000,0> translate<59.021100,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.021100,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.177800,0.000000,-12.991300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<59.021100,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.177800,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.491400,0.000000,-12.991300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<59.177800,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.491400,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.648100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<59.491400,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.648100,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.648100,0.000000,-13.775200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<59.648100,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.648100,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.491400,0.000000,-13.931900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<59.491400,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.491400,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.177800,0.000000,-13.931900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<59.177800,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.177800,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.021100,0.000000,-13.775200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<59.021100,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.021100,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.648100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,-45.001599,0> translate<59.021100,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.956600,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.583600,0.000000,-12.991300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<59.956600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.583600,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.583600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<60.583600,0.000000,-13.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.583600,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.956600,0.000000,-13.775200>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,-45.001599,0> translate<59.956600,0.000000,-13.775200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.956600,0.000000,-13.775200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<59.956600,0.000000,-13.931900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<59.956600,0.000000,-13.931900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.827600,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.827600,0.000000,-12.991300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<61.827600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.827600,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.297900,0.000000,-12.991300>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<61.827600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.297900,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.454600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<62.297900,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.454600,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.454600,0.000000,-13.461600>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<62.454600,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.454600,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.297900,0.000000,-13.618400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<62.297900,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.297900,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.827600,0.000000,-13.618400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<61.827600,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.141100,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.454600,0.000000,-13.931900>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<62.141100,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.763100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.763100,0.000000,-12.991300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<62.763100,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.763100,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.233400,0.000000,-12.991300>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<62.763100,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.233400,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.390100,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<63.233400,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.390100,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.390100,0.000000,-13.461600>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<63.390100,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.390100,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.233400,0.000000,-13.618400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<63.233400,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.233400,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.763100,0.000000,-13.618400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<62.763100,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.076600,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.390100,0.000000,-13.931900>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<63.076600,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.698600,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.698600,0.000000,-12.991300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<63.698600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.698600,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.168900,0.000000,-12.991300>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<63.698600,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.168900,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.325600,0.000000,-13.148100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<64.168900,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.325600,0.000000,-13.148100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.325600,0.000000,-13.461600>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<64.325600,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.325600,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.168900,0.000000,-13.618400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<64.168900,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.168900,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<63.698600,0.000000,-13.618400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<63.698600,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.012100,0.000000,-13.618400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.325600,0.000000,-13.931900>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<64.012100,0.000000,-13.618400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.634100,0.000000,-13.931900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.634100,0.000000,-12.991300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<64.634100,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.634100,0.000000,-12.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<65.261100,0.000000,-12.991300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<64.634100,0.000000,-12.991300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.634100,0.000000,-13.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<64.947600,0.000000,-13.461600>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<64.634100,0.000000,-13.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.095400,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.095400,0.000000,-0.342900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,-90.000000,0> translate<49.095400,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.095400,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.722400,0.000000,-0.342900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<49.095400,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.030900,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.187600,0.000000,0.284100>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<50.030900,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.187600,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.187600,0.000000,-0.342900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<50.187600,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.030900,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.344400,0.000000,-0.342900>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<50.030900,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.187600,0.000000,0.754400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.187600,0.000000,0.597700>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<50.187600,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.281500,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.811200,0.000000,0.284100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<50.811200,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.811200,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.654500,0.000000,0.127400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<50.654500,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.654500,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.654500,0.000000,-0.186200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<50.654500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.654500,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.811200,0.000000,-0.342900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<50.654500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.811200,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.281500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<50.811200,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.060300,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.746700,0.000000,-0.342900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<51.746700,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.746700,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.590000,0.000000,-0.186200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<51.590000,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.590000,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.590000,0.000000,0.127400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<51.590000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.590000,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.746700,0.000000,0.284100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<51.590000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.746700,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.060300,0.000000,0.284100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<51.746700,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.060300,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.217000,0.000000,0.127400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<52.060300,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.217000,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.217000,0.000000,-0.029400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<52.217000,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.217000,0.000000,-0.029400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<51.590000,0.000000,-0.029400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<51.590000,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.525500,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.525500,0.000000,0.284100>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<52.525500,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.525500,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.995800,0.000000,0.284100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<52.525500,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<52.995800,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.152500,0.000000,0.127400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<52.995800,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.152500,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.152500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<53.152500,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.461000,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.931300,0.000000,-0.342900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<53.461000,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.931300,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.088000,0.000000,-0.186200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<53.931300,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.088000,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.931300,0.000000,-0.029400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<53.931300,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.931300,0.000000,-0.029400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.617700,0.000000,-0.029400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<53.617700,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.617700,0.000000,-0.029400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.461000,0.000000,0.127400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<53.461000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.461000,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.617700,0.000000,0.284100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<53.461000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<53.617700,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.088000,0.000000,0.284100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<53.617700,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.866800,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.553200,0.000000,-0.342900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<54.553200,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.553200,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.396500,0.000000,-0.186200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<54.396500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.396500,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.396500,0.000000,0.127400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<54.396500,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.396500,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.553200,0.000000,0.284100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<54.396500,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.553200,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.866800,0.000000,0.284100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<54.553200,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.866800,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.023500,0.000000,0.127400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<54.866800,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.023500,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.023500,0.000000,-0.029400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<55.023500,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<55.023500,0.000000,-0.029400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<54.396500,0.000000,-0.029400>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<54.396500,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.894500,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.737800,0.000000,0.597700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<56.737800,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.737800,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.424200,0.000000,0.597700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<56.424200,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.424200,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.267500,0.000000,0.440900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<56.267500,0.000000,0.440900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.267500,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.267500,0.000000,-0.186200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<56.267500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.267500,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.424200,0.000000,-0.342900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<56.267500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.424200,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.737800,0.000000,-0.342900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<56.424200,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.737800,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.894500,0.000000,-0.186200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<56.737800,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.894500,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.894500,0.000000,0.127400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<56.894500,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.894500,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<56.581000,0.000000,0.127400>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<56.581000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.203000,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.203000,0.000000,0.597700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,90.000000,0> translate<57.203000,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.203000,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.673300,0.000000,0.597700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<57.203000,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.673300,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.830000,0.000000,0.440900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<57.673300,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.830000,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.830000,0.000000,0.127400>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<57.830000,0.000000,0.127400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.830000,0.000000,0.127400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.673300,0.000000,-0.029400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<57.673300,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.673300,0.000000,-0.029400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<57.203000,0.000000,-0.029400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<57.203000,0.000000,-0.029400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.138500,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.138500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,-90.000000,0> translate<58.138500,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.138500,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<58.765500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<58.138500,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.009500,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.323000,0.000000,-0.342900>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,63.430762,0> translate<60.009500,0.000000,0.284100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.323000,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.636500,0.000000,0.284100>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,-63.430762,0> translate<60.323000,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.572000,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.945000,0.000000,-0.342900>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<60.945000,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.945000,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.572000,0.000000,0.284100>}
box{<0,0,-0.038100><0.886712,0.036000,0.038100> rotate<0,-44.997030,0> translate<60.945000,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.572000,0.000000,0.284100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.572000,0.000000,0.440900>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<61.572000,0.000000,0.440900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.572000,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.415300,0.000000,0.597700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<61.415300,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.415300,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.101700,0.000000,0.597700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<61.101700,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.101700,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<60.945000,0.000000,0.440900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<60.945000,0.000000,0.440900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.880500,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.880500,0.000000,-0.186200>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<61.880500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.880500,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.037200,0.000000,-0.186200>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<61.880500,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.037200,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.037200,0.000000,-0.342900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<62.037200,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.037200,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<61.880500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<61.880500,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.348200,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.348200,0.000000,0.440900>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,90.000000,0> translate<62.348200,0.000000,0.440900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.348200,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.504900,0.000000,0.597700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<62.348200,0.000000,0.440900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.504900,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.818500,0.000000,0.597700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<62.504900,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.818500,0.000000,0.597700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.975200,0.000000,0.440900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,45.015305,0> translate<62.818500,0.000000,0.597700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.975200,0.000000,0.440900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.975200,0.000000,-0.186200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,-90.000000,0> translate<62.975200,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.975200,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.818500,0.000000,-0.342900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<62.818500,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.818500,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.504900,0.000000,-0.342900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<62.504900,0.000000,-0.342900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.504900,0.000000,-0.342900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.348200,0.000000,-0.186200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<62.348200,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.348200,0.000000,-0.186200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<62.975200,0.000000,0.440900>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,-45.001599,0> translate<62.348200,0.000000,-0.186200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.428200,0.000000,-3.936400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.512800,0.000000,-3.936400>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<22.428200,0.000000,-3.936400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.970500,0.000000,-3.394000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.970500,0.000000,-4.478700>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.970500,0.000000,-4.478700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.428200,0.000000,-14.096400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.512800,0.000000,-14.096400>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<22.428200,0.000000,-14.096400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.970500,0.000000,-13.554000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.970500,0.000000,-14.638700>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.970500,0.000000,-14.638700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.240400,0.000000,-19.989800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.240400,0.000000,-18.905200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<23.240400,0.000000,-18.905200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-9.575800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-8.491200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<22.986400,0.000000,-8.491200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.545800,0.000000,-17.562900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.461200,0.000000,-17.562900>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<22.461200,0.000000,-17.562900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.461200,0.000000,-17.562900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.918900,0.000000,-17.020600>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<21.918900,0.000000,-17.020600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.918900,0.000000,-17.020600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.461200,0.000000,-16.478300>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<21.918900,0.000000,-17.020600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.461200,0.000000,-16.478300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.545800,0.000000,-16.478300>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<22.461200,0.000000,-16.478300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.732400,0.000000,-17.562900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.732400,0.000000,-16.478300>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<22.732400,0.000000,-16.478300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.799800,0.000000,-7.148900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.172900,0.000000,-7.148900>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,0.000000,0> translate<22.172900,0.000000,-7.148900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.172900,0.000000,-7.148900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.172900,0.000000,-6.335500>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,90.000000,0> translate<22.172900,0.000000,-6.335500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.172900,0.000000,-6.335500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.444000,0.000000,-6.064300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<22.172900,0.000000,-6.335500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.444000,0.000000,-6.064300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.715200,0.000000,-6.064300>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,0.000000,0> translate<22.444000,0.000000,-6.064300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.715200,0.000000,-6.064300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-6.335500>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<22.715200,0.000000,-6.064300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-6.335500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.257500,0.000000,-6.064300>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<22.986400,0.000000,-6.335500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.257500,0.000000,-6.064300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.528700,0.000000,-6.064300>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,0.000000,0> translate<23.257500,0.000000,-6.064300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.528700,0.000000,-6.064300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.799800,0.000000,-6.335500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,45.007595,0> translate<23.528700,0.000000,-6.064300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.799800,0.000000,-6.335500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.799800,0.000000,-7.148900>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.799800,0.000000,-7.148900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-7.148900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.986400,0.000000,-6.335500>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,90.000000,0> translate<22.986400,0.000000,-6.335500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.858100,0.000000,4.165600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.858100,0.000000,6.504300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<38.858100,0.000000,6.504300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.858100,0.000000,6.504300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,6.504300>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<38.858100,0.000000,6.504300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,6.504300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,6.114500>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,44.997030,0> translate<40.027400,0.000000,6.504300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,6.114500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,5.724700>}
box{<0,0,-0.101600><0.389800,0.036000,0.101600> rotate<0,-90.000000,0> translate<40.417200,0.000000,5.724700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,5.724700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,5.334900>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,-44.997030,0> translate<40.027400,0.000000,5.334900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,5.334900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,4.945100>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,44.997030,0> translate<40.027400,0.000000,5.334900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,4.945100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,4.555300>}
box{<0,0,-0.101600><0.389800,0.036000,0.101600> rotate<0,-90.000000,0> translate<40.417200,0.000000,4.555300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.417200,0.000000,4.555300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,4.165600>}
box{<0,0,-0.101600><0.551190,0.036000,0.101600> rotate<0,-44.989680,0> translate<40.027400,0.000000,4.165600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,4.165600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.858100,0.000000,4.165600>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<38.858100,0.000000,4.165600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<38.858100,0.000000,5.334900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<40.027400,0.000000,5.334900>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<38.858100,0.000000,5.334900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.196800,0.000000,5.334900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<42.755900,0.000000,5.334900>}
box{<0,0,-0.101600><1.559100,0.036000,0.101600> rotate<0,0.000000,0> translate<41.196800,0.000000,5.334900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.976300,0.000000,6.114500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.976300,0.000000,4.555300>}
box{<0,0,-0.101600><1.559200,0.036000,0.101600> rotate<0,-90.000000,0> translate<41.976300,0.000000,4.555300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.304100,0.000000,3.911600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.304100,0.000000,6.250300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<51.304100,0.000000,6.250300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.304100,0.000000,6.250300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,6.250300>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<51.304100,0.000000,6.250300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,6.250300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,5.860500>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,44.997030,0> translate<52.473400,0.000000,6.250300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,5.860500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,5.470700>}
box{<0,0,-0.101600><0.389800,0.036000,0.101600> rotate<0,-90.000000,0> translate<52.863200,0.000000,5.470700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,5.470700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,5.080900>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,-44.997030,0> translate<52.473400,0.000000,5.080900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,5.080900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,4.691100>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,44.997030,0> translate<52.473400,0.000000,5.080900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,4.691100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,4.301300>}
box{<0,0,-0.101600><0.389800,0.036000,0.101600> rotate<0,-90.000000,0> translate<52.863200,0.000000,4.301300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.863200,0.000000,4.301300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,3.911600>}
box{<0,0,-0.101600><0.551190,0.036000,0.101600> rotate<0,-44.989680,0> translate<52.473400,0.000000,3.911600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,3.911600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.304100,0.000000,3.911600>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<51.304100,0.000000,3.911600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.304100,0.000000,5.080900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.473400,0.000000,5.080900>}
box{<0,0,-0.101600><1.169300,0.036000,0.101600> rotate<0,0.000000,0> translate<51.304100,0.000000,5.080900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.642800,0.000000,5.080900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.201900,0.000000,5.080900>}
box{<0,0,-0.101600><1.559100,0.036000,0.101600> rotate<0,0.000000,0> translate<53.642800,0.000000,5.080900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-31.940500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-30.906700>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,90.000000,0> translate<22.923500,0.000000,-30.906700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-30.906700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.440400,0.000000,-30.389800>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,-44.997030,0> translate<22.923500,0.000000,-30.906700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.440400,0.000000,-30.389800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-30.906700>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<23.440400,0.000000,-30.389800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-30.906700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-31.940500>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,-90.000000,0> translate<23.957300,0.000000,-31.940500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-31.165200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-31.165200>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<22.923500,0.000000,-31.165200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.467100,0.000000,-31.165200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.500900,0.000000,-31.165200>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<24.467100,0.000000,-31.165200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.984000,0.000000,-30.648300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.984000,0.000000,-31.682100>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,-90.000000,0> translate<24.984000,0.000000,-31.682100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-34.480500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-33.446700>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,90.000000,0> translate<22.923500,0.000000,-33.446700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-33.446700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.440400,0.000000,-32.929800>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,-44.997030,0> translate<22.923500,0.000000,-33.446700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.440400,0.000000,-32.929800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-33.446700>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<23.440400,0.000000,-32.929800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-33.446700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-34.480500>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,-90.000000,0> translate<23.957300,0.000000,-34.480500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<22.923500,0.000000,-33.705200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<23.957300,0.000000,-33.705200>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<22.923500,0.000000,-33.705200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<24.467100,0.000000,-33.705200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.500900,0.000000,-33.705200>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<24.467100,0.000000,-33.705200> }
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-19.050000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-19.685000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.081200,0.000000,-19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,-19.050000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,-19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-19.050000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-19.685000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.716200,0.000000,-19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,-19.050000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<40.716200,0.000000,-19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-20.574000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.703000,0.000000,-20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-20.828000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-20.828000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-20.828000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-20.574000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-17.526000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.069000,0.000000,-17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-17.272000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-17.272000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-17.272000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<43.815000,0.000000,-17.526000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<43.815000,0.000000,-20.574000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.957000,0.000000,-20.574000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.957000,0.000000,-17.526000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-13.716000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-14.351000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.081200,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,-13.716000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-13.716000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-14.351000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-14.351000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.716200,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,-13.716000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<40.716200,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-12.192000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-15.240000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.703000,0.000000,-15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-15.494000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-12.192000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.069000,0.000000,-12.192000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-11.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-11.938000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-11.938000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<43.815000,0.000000,-12.192000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<43.815000,0.000000,-15.240000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.957000,0.000000,-15.240000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.957000,0.000000,-12.192000>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-3.175000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-3.810000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.081200,0.000000,-3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,-3.175000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,-3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-3.175000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-3.810000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.716200,0.000000,-3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,-3.175000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<40.716200,0.000000,-3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-4.699000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.703000,0.000000,-4.699000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-4.953000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-4.953000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-4.953000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-1.651000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.069000,0.000000,-1.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-1.397000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-1.397000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-1.397000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<43.815000,0.000000,-1.651000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<43.815000,0.000000,-4.699000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.957000,0.000000,-4.699000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.957000,0.000000,-1.651000>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-8.509000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.081200,0.000000,-9.144000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.081200,0.000000,-9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.081200,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.862000,0.000000,-8.509000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<38.862000,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-7.874000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-8.509000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<40.716200,0.000000,-9.144000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<40.716200,0.000000,-9.144000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.716200,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,-8.509000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<40.716200,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,-10.033000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.703000,0.000000,-10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-10.287000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.069000,0.000000,-6.985000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.069000,0.000000,-6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-6.731000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-6.731000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<43.815000,0.000000,-6.985000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<43.815000,0.000000,-10.033000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.957000,0.000000,-10.033000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.957000,0.000000,-6.985000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.786800,0.000000,-39.243000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.786800,0.000000,-38.608000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<46.786800,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.786800,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.786800,0.000000,-37.973000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<46.786800,0.000000,-37.973000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.786800,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.006000,0.000000,-38.608000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<46.786800,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.151800,0.000000,-39.243000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.151800,0.000000,-38.608000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<46.151800,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.151800,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<46.151800,0.000000,-37.973000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<46.151800,0.000000,-37.973000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.151800,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,-38.608000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,-40.132000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,-37.084000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,-37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,-36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,-36.830000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.053000,0.000000,-36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,-37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.799000,0.000000,-40.132000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<42.799000,0.000000,-40.132000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,-40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.911000,0.000000,-40.386000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.053000,0.000000,-40.386000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<43.053000,0.000000,-40.132000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<43.053000,0.000000,-37.084000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<49.911000,0.000000,-37.084000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<49.911000,0.000000,-40.132000>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.017200,0.000000,-37.973000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.017200,0.000000,-38.608000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<36.017200,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.017200,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.017200,0.000000,-39.243000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<36.017200,0.000000,-39.243000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.017200,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,-38.608000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.652200,0.000000,-37.973000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.652200,0.000000,-38.608000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<36.652200,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.652200,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.652200,0.000000,-39.243000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<36.652200,0.000000,-39.243000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.652200,0.000000,-38.608000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,-38.608000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<36.652200,0.000000,-38.608000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,-37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.639000,0.000000,-40.132000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.639000,0.000000,-40.132000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,-40.386000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.751000,0.000000,-40.386000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.893000,0.000000,-40.386000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,-40.132000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,-37.084000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,-37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.751000,0.000000,-36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,-36.830000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.893000,0.000000,-36.830000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<39.751000,0.000000,-37.084000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<39.751000,0.000000,-40.132000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<32.893000,0.000000,-40.132000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<32.893000,0.000000,-37.084000>}
//C7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.893000,0.000000,-30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,-30.353000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.893000,0.000000,-30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,-30.734000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.274000,0.000000,-29.972000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<33.274000,0.000000,-29.972000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.671000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-31.496000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.671000,0.000000,-31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-32.766000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.560000,0.000000,-32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,-32.766000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.560000,0.000000,-32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,-32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,-30.226000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.068000,0.000000,-30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,-30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-30.226000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.560000,0.000000,-30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.560000,0.000000,-31.496000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.560000,0.000000,-31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,-31.496000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.957000,0.000000,-31.496000> }
difference{
cylinder{<36.322000,0,-31.496000><36.322000,0.036000,-31.496000>4.140200 translate<0,0.000000,0>}
cylinder{<36.322000,-0.1,-31.496000><36.322000,0.135000,-31.496000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<36.830000,0.000000,-31.496000>}
//C8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.514000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,-32.385000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.752000,0.000000,-32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,-32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.133000,0.000000,-32.766000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.133000,0.000000,-32.766000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,-31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-31.242000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.847000,0.000000,-31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-29.972000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.847000,0.000000,-29.972000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-29.972000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,-29.972000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,-29.972000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,-29.972000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,-32.512000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.339000,0.000000,-32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.339000,0.000000,-32.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-32.512000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.339000,0.000000,-32.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-32.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.847000,0.000000,-31.242000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.847000,0.000000,-31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,-31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.434000,0.000000,-31.242000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.434000,0.000000,-31.242000> }
difference{
cylinder{<45.085000,0,-31.242000><45.085000,0.036000,-31.242000>4.140200 translate<0,0.000000,0>}
cylinder{<45.085000,-0.1,-31.242000><45.085000,0.135000,-31.242000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-180.000000,0> translate<44.577000,0.000000,-31.242000>}
//H1 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<24.909000,0.000000,-45.974000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<24.909000,0.000000,-45.974000>}
difference{
cylinder{<24.909000,0,-45.974000><24.909000,0.036000,-45.974000>3.505200 translate<0,0.000000,0>}
cylinder{<24.909000,-0.1,-45.974000><24.909000,0.135000,-45.974000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<24.909000,0,-45.974000><24.909000,0.036000,-45.974000>0.990600 translate<0,0.000000,0>}
cylinder{<24.909000,-0.1,-45.974000><24.909000,0.135000,-45.974000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<24.909000,0,-45.974000><24.909000,0.036000,-45.974000>1.701600 translate<0,0.000000,0>}
cylinder{<24.909000,-0.1,-45.974000><24.909000,0.135000,-45.974000>1.498400 translate<0,0.000000,0>}}
//H2 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<68.834000,0.000000,-45.974000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<68.834000,0.000000,-45.974000>}
difference{
cylinder{<68.834000,0,-45.974000><68.834000,0.036000,-45.974000>3.505200 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,-45.974000><68.834000,0.135000,-45.974000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<68.834000,0,-45.974000><68.834000,0.036000,-45.974000>0.990600 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,-45.974000><68.834000,0.135000,-45.974000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<68.834000,0,-45.974000><68.834000,0.036000,-45.974000>1.701600 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,-45.974000><68.834000,0.135000,-45.974000>1.498400 translate<0,0.000000,0>}}
//H3 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<68.834000,0.000000,3.810000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<68.834000,0.000000,3.810000>}
difference{
cylinder{<68.834000,0,3.810000><68.834000,0.036000,3.810000>3.505200 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,3.810000><68.834000,0.135000,3.810000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<68.834000,0,3.810000><68.834000,0.036000,3.810000>0.990600 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,3.810000><68.834000,0.135000,3.810000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<68.834000,0,3.810000><68.834000,0.036000,3.810000>1.701600 translate<0,0.000000,0>}
cylinder{<68.834000,-0.1,3.810000><68.834000,0.135000,3.810000>1.498400 translate<0,0.000000,0>}}
//H4 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<25.146000,0.000000,3.810000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<25.146000,0.000000,3.810000>}
difference{
cylinder{<25.146000,0,3.810000><25.146000,0.036000,3.810000>3.505200 translate<0,0.000000,0>}
cylinder{<25.146000,-0.1,3.810000><25.146000,0.135000,3.810000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<25.146000,0,3.810000><25.146000,0.036000,3.810000>0.990600 translate<0,0.000000,0>}
cylinder{<25.146000,-0.1,3.810000><25.146000,0.135000,3.810000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<25.146000,0,3.810000><25.146000,0.036000,3.810000>1.701600 translate<0,0.000000,0>}
cylinder{<25.146000,-0.1,3.810000><25.146000,0.135000,3.810000>1.498400 translate<0,0.000000,0>}}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-1.651000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.244000,0.000000,-1.651000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-11.811000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.244000,0.000000,-11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-4.191000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,-4.191000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-1.651000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-4.191000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.244000,0.000000,-4.191000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-9.271000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.244000,0.000000,-9.271000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<47.244000,0.000000,-6.731000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-4.191000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.244000,0.000000,-4.191000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-5.715000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.244000,0.000000,-5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-4.191000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-9.271000>}
box{<0,0,-0.076200><5.080000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,-9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-9.271000>}
box{<0,0,-0.076200><20.320000,0.036000,0.076200> rotate<0,0.000000,0> translate<47.244000,0.000000,-9.271000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.244000,0.000000,-7.747000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.244000,0.000000,-7.747000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-9.271000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.564000,0.000000,-11.811000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.564000,0.000000,-11.811000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.548000,0.000000,-17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-17.145000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.768000,0.000000,-17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.548000,0.000000,-22.987000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.768000,0.000000,-22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.548000,0.000000,-17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.548000,0.000000,-22.987000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.548000,0.000000,-22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-19.050000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.768000,0.000000,-19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-22.987000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,-21.082000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,90.000000,0> translate<48.768000,0.000000,-21.082000> }
object{ARC(1.016000,0.152400,270.000000,450.000000,0.036000) translate<48.768000,0.000000,-20.066000>}
//IC3 silk screen
object{ARC(2.667000,0.152400,107.149482,218.247121,0.036000) translate<37.083500,0.000000,-25.146000>}
object{ARC(2.667000,0.152400,321.752879,432.850518,0.036000) translate<37.084500,0.000000,-25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.989000,0.000000,-26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.179000,0.000000,-26.797000>}
box{<0,0,-0.076200><4.190000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.989000,0.000000,-26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.830000,0.000000,-25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.798000,0.000000,-25.400000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.830000,0.000000,-25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.429000,0.000000,-25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.830000,0.000000,-25.400000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.429000,0.000000,-25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.798000,0.000000,-25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.370000,0.000000,-25.400000>}
box{<0,0,-0.076200><0.572000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.798000,0.000000,-25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.338000,0.000000,-25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.739000,0.000000,-25.400000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,0.000000,0> translate<39.338000,0.000000,-25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.370000,0.000000,-25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.338000,0.000000,-25.400000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.370000,0.000000,-25.400000> }
object{ARC(2.667000,0.152400,72.850518,107.149482,0.036000) translate<37.084000,0.000000,-25.146000>}
//INPUT silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-30.480000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.230000,0.000000,-30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-29.845000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,-30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-30.480000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,-29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-34.290000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,-34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-33.020000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.230000,0.000000,-33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-32.385000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,-33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-32.385000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-33.020000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,-32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-34.290000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,-34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-32.385000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,-31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-31.750000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,-32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-31.750000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,-31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-38.100000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.230000,0.000000,-38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-37.465000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,-38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-37.465000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-38.100000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,-37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-36.830000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,-36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-35.560000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.230000,0.000000,-35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,-35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-34.925000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-35.560000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-36.830000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,-36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-37.465000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,-37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-40.005000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,-39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-39.370000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,-40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,-39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<62.230000,0.000000,-27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<62.230000,0.000000,-27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,-27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<64.135000,0.000000,-27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.230000,0.000000,-29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,-29.845000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<62.230000,0.000000,-29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.135000,0.000000,-29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-29.210000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<64.135000,0.000000,-29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.770000,0.000000,-29.210000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.770000,0.000000,-29.210000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<63.500000,0.000000,-31.115000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<63.500000,0.000000,-33.655000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<63.500000,0.000000,-36.195000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<63.500000,0.000000,-38.735000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<63.500000,0.000000,-28.575000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.277000,0.000000,-49.784000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<61.087000,0.000000,-49.784000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<57.277000,0.000000,-49.784000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<59.182000,0.000000,-47.244000>}
difference{
cylinder{<59.182000,0,-47.244000><59.182000,0.036000,-47.244000>2.616200 translate<0,0.000000,0>}
cylinder{<59.182000,-0.1,-47.244000><59.182000,0.135000,-47.244000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<36.449000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<32.639000,0.000000,7.620000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<32.639000,0.000000,7.620000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<34.544000,0.000000,5.080000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<34.544000,0.000000,5.080000>}
difference{
cylinder{<34.544000,0,5.080000><34.544000,0.036000,5.080000>2.616200 translate<0,0.000000,0>}
cylinder{<34.544000,-0.1,5.080000><34.544000,0.135000,5.080000>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.531000,0.000000,1.778000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<61.341000,0.000000,1.778000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<57.531000,0.000000,1.778000> }
object{ARC(3.175000,0.254000,306.869898,593.130102,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<59.436000,0.000000,4.318000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<59.436000,0.000000,4.318000>}
difference{
cylinder{<59.436000,0,4.318000><59.436000,0.036000,4.318000>2.616200 translate<0,0.000000,0>}
cylinder{<59.436000,-0.1,4.318000><59.436000,0.135000,4.318000>2.463800 translate<0,0.000000,0>}}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.924000,0.000000,-28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<26.924000,0.000000,-25.019000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<26.924000,0.000000,-25.019000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<24.384000,0.000000,-26.924000>}
difference{
cylinder{<24.384000,0,-26.924000><24.384000,0.036000,-26.924000>2.616200 translate<0,0.000000,0>}
cylinder{<24.384000,-0.1,-26.924000><24.384000,0.135000,-26.924000>2.463800 translate<0,0.000000,0>}}
//LED5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.590000,0.000000,-36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<21.590000,0.000000,-40.005000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<21.590000,0.000000,-40.005000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<24.130000,0.000000,-38.100000>}
difference{
cylinder{<24.130000,0,-38.100000><24.130000,0.036000,-38.100000>2.616200 translate<0,0.000000,0>}
cylinder{<24.130000,-0.1,-38.100000><24.130000,0.135000,-38.100000>2.463800 translate<0,0.000000,0>}}
//POWER silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.869000,0.000000,-49.750000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.969000,0.000000,-49.750000>}
box{<0,0,-0.101600><22.900000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.969000,0.000000,-49.750000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.969000,0.000000,-49.750000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.969000,0.000000,-43.690000>}
box{<0,0,-0.101600><6.060000,0.036000,0.101600> rotate<0,90.000000,0> translate<29.969000,0.000000,-43.690000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.969000,0.000000,-43.690000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.969000,0.000000,-41.690000>}
box{<0,0,-0.101600><2.828427,0.036000,0.101600> rotate<0,-44.997030,0> translate<29.969000,0.000000,-43.690000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<31.969000,0.000000,-41.690000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.869000,0.000000,-41.690000>}
box{<0,0,-0.101600><18.900000,0.036000,0.101600> rotate<0,0.000000,0> translate<31.969000,0.000000,-41.690000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.869000,0.000000,-41.690000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.869000,0.000000,-43.690000>}
box{<0,0,-0.101600><2.828427,0.036000,0.101600> rotate<0,44.997030,0> translate<50.869000,0.000000,-41.690000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.869000,0.000000,-43.690000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.869000,0.000000,-49.750000>}
box{<0,0,-0.101600><6.060000,0.036000,0.101600> rotate<0,-90.000000,0> translate<52.869000,0.000000,-49.750000> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.198000,0.000000,-30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.817000,0.000000,-30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<59.817000,0.000000,-30.480000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.309000,0.000000,-31.369000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.309000,0.000000,-29.591000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.467000,0.000000,-29.591000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.467000,0.000000,-31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,-31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.801000,0.000000,-31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.801000,0.000000,-29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.848000,0.000000,-31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-31.496000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.848000,0.000000,-29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-29.464000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.213000,0.000000,-31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.959000,0.000000,-30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.578000,0.000000,-30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<52.578000,0.000000,-30.480000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<59.690000,0.000000,-30.480000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<53.086000,0.000000,-30.480000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.198000,0.000000,-33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.817000,0.000000,-33.274000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<59.817000,0.000000,-33.274000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.309000,0.000000,-34.163000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.309000,0.000000,-32.385000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.467000,0.000000,-32.385000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.467000,0.000000,-34.163000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-34.163000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,-34.163000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-34.417000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-34.417000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-34.417000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.801000,0.000000,-34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-32.131000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-32.131000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.801000,0.000000,-32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-34.417000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.848000,0.000000,-34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-34.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-34.290000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-34.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-32.131000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.848000,0.000000,-32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-32.258000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-32.258000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-32.258000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-34.417000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-34.417000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-34.417000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-32.131000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-32.131000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-32.131000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-34.163000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.213000,0.000000,-34.163000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.959000,0.000000,-33.274000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.578000,0.000000,-33.274000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<52.578000,0.000000,-33.274000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<59.690000,0.000000,-33.274000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<53.086000,0.000000,-33.274000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.198000,0.000000,-27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.817000,0.000000,-27.686000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<59.817000,0.000000,-27.686000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.309000,0.000000,-28.575000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.309000,0.000000,-26.797000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.467000,0.000000,-26.797000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.467000,0.000000,-28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-28.575000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,-28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-28.829000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-28.829000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.801000,0.000000,-28.702000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-26.543000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-26.543000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.801000,0.000000,-26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-28.829000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.848000,0.000000,-28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-28.702000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-28.702000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-26.543000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.848000,0.000000,-26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-26.670000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-28.829000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-26.543000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-28.575000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.213000,0.000000,-28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.959000,0.000000,-27.686000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.578000,0.000000,-27.686000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<52.578000,0.000000,-27.686000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<59.690000,0.000000,-27.686000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<53.086000,0.000000,-27.686000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.198000,0.000000,-36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<59.817000,0.000000,-36.068000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<59.817000,0.000000,-36.068000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.309000,0.000000,-36.957000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.309000,0.000000,-35.179000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.467000,0.000000,-35.179000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.467000,0.000000,-36.957000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-35.179000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,-36.957000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,-36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-37.211000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-37.211000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-37.211000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-37.211000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<58.801000,0.000000,-37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.309000,0.000000,-34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.928000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-35.052000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.928000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.801000,0.000000,-35.052000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-37.211000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.848000,0.000000,-37.211000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-37.084000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-37.084000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-37.084000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-35.052000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.848000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.975000,0.000000,-35.052000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,-35.052000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.975000,0.000000,-35.052000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-37.211000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-37.211000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-37.211000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,-34.925000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.848000,0.000000,-34.925000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.467000,0.000000,-34.925000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-35.179000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.213000,0.000000,-36.957000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.213000,0.000000,-36.957000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.959000,0.000000,-36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.578000,0.000000,-36.068000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<52.578000,0.000000,-36.068000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<59.690000,0.000000,-36.068000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<53.086000,0.000000,-36.068000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<63.246000,0.000000,-42.418000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<62.865000,0.000000,-42.418000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<62.865000,0.000000,-42.418000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<62.357000,0.000000,-43.307000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<62.357000,0.000000,-41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<56.515000,0.000000,-41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<56.515000,0.000000,-43.307000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,-41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.611000,0.000000,-43.307000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.611000,0.000000,-43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.357000,0.000000,-43.561000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,-43.561000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.976000,0.000000,-43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,-43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,-43.561000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<61.849000,0.000000,-43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.357000,0.000000,-41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,-41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<61.976000,0.000000,-41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,-41.402000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,-41.275000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<61.849000,0.000000,-41.402000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,-43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,-43.561000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<56.896000,0.000000,-43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,-43.434000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,-43.434000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.023000,0.000000,-43.434000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,-41.402000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,-41.275000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<56.896000,0.000000,-41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,-41.402000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,-41.402000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.023000,0.000000,-41.402000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,-43.561000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,-43.561000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.515000,0.000000,-43.561000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.515000,0.000000,-41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,-41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.515000,0.000000,-41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.261000,0.000000,-41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.261000,0.000000,-43.307000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.261000,0.000000,-43.307000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<56.007000,0.000000,-42.418000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<55.626000,0.000000,-42.418000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<55.626000,0.000000,-42.418000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<62.738000,0.000000,-42.418000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<56.134000,0.000000,-42.418000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.718000,0.000000,-24.638000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.718000,0.000000,-25.019000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.718000,0.000000,-25.019000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.607000,0.000000,-25.527000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<28.829000,0.000000,-25.527000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<28.829000,0.000000,-31.369000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.607000,0.000000,-31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,-25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.607000,0.000000,-25.273000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.829000,0.000000,-25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-25.908000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.861000,0.000000,-25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,-26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-25.908000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.734000,0.000000,-26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-25.908000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.575000,0.000000,-25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,-26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-25.908000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<28.575000,0.000000,-25.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,-30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-30.988000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.734000,0.000000,-30.861000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,-30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,-26.035000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.734000,0.000000,-26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,-30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-30.988000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<28.575000,0.000000,-30.988000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,-30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,-26.035000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.702000,0.000000,-26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,-30.988000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.861000,0.000000,-30.988000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,-30.988000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.575000,0.000000,-30.988000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,-31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.607000,0.000000,-31.623000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.829000,0.000000,-31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.718000,0.000000,-31.877000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.718000,0.000000,-32.258000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.718000,0.000000,-32.258000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-270.000000,0> translate<29.718000,0.000000,-25.146000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-270.000000,0> translate<29.718000,0.000000,-31.750000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<36.830000,0.000000,0.254000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.211000,0.000000,0.254000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<36.830000,0.000000,0.254000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<37.719000,0.000000,1.143000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<37.719000,0.000000,-0.635000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<43.561000,0.000000,-0.635000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<43.561000,0.000000,1.143000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,-0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.465000,0.000000,1.143000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.465000,0.000000,1.143000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.719000,0.000000,1.397000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,1.397000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.719000,0.000000,1.397000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,1.397000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.100000,0.000000,1.397000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.719000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,-0.889000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.719000,0.000000,-0.889000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,-0.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,-0.889000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.100000,0.000000,-0.889000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,1.397000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.053000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,1.270000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.227000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,-0.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,-0.889000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<43.053000,0.000000,-0.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.053000,0.000000,-0.762000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.227000,0.000000,-0.762000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.227000,0.000000,-0.762000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,1.397000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,1.397000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.180000,0.000000,1.397000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.561000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,-0.889000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.180000,0.000000,-0.889000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,-0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,1.143000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.815000,0.000000,1.143000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<44.069000,0.000000,0.254000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<44.450000,0.000000,0.254000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<44.069000,0.000000,0.254000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<37.338000,0.000000,0.254000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<43.942000,0.000000,0.254000>}
//X2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-13.589000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-14.859000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.083000,0.000000,-14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-14.859000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-13.589000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.353000,0.000000,-13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-14.859000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.083000,0.000000,-14.859000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-13.589000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-14.859000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<29.083000,0.000000,-13.589000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-22.479000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.908000,0.000000,-22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-22.479000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,-22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-22.479000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.782000,0.000000,-22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-11.049000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.782000,0.000000,-11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-11.049000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,-11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.178000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-11.684000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-21.844000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-21.844000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.178000,0.000000,-21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-18.669000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-19.939000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.083000,0.000000,-19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-19.939000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-18.669000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.353000,0.000000,-18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-19.939000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.083000,0.000000,-19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-19.939000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<29.083000,0.000000,-18.669000> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<28.829000,0.000000,-14.224000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<28.829000,0.000000,-14.224000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-16.383000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-17.145000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-12.115800>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-12.115800> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<28.829000,0.000000,-19.304000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<28.829000,0.000000,-19.304000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-21.412200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-21.844000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-13.716000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-14.732000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-18.796000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-19.812000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-19.812000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-19.812000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-21.844000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-13.716000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-14.732000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-18.796000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-19.812000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-19.812000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-19.812000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-22.479000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-18.796000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-19.812000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-19.812000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-19.812000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-13.462000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-13.462000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-18.542000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-18.542000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-18.796000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<33.782000,0.000000,-18.542000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-18.542000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-18.542000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-18.796000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.512000,0.000000,-18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-18.542000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-14.986000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.766000,0.000000,-14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-13.462000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-11.684000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.766000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-19.812000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-20.066000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<33.782000,0.000000,-20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-22.479000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-20.066000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-19.812000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.512000,0.000000,-19.812000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-21.844000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.766000,0.000000,-21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-14.732000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-14.732000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-13.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-13.716000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-13.462000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-13.462000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-13.462000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-14.986000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-14.732000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-14.986000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<33.782000,0.000000,-14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-13.462000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-13.716000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<33.782000,0.000000,-13.462000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-13.462000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-13.716000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.512000,0.000000,-13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-14.732000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.512000,0.000000,-14.732000> }
//X3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-3.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-3.429000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-3.429000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-3.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-4.699000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.083000,0.000000,-4.699000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-4.699000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-4.699000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-3.429000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.353000,0.000000,-3.429000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-3.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-4.699000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.083000,0.000000,-4.699000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-3.429000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-4.699000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<29.083000,0.000000,-3.429000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-12.319000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.908000,0.000000,-12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-12.319000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-12.319000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,-12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-12.319000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-12.319000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.782000,0.000000,-12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-0.889000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<33.782000,0.000000,-0.889000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.908000,0.000000,-0.889000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.908000,0.000000,-0.889000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-1.524000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-1.524000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.178000,0.000000,-1.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-1.524000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-1.524000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-1.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-11.684000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.178000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-8.509000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-9.779000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.083000,0.000000,-9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-9.779000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-9.779000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.083000,0.000000,-9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-9.779000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-8.509000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.353000,0.000000,-8.509000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-9.779000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.083000,0.000000,-9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.083000,0.000000,-8.509000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.353000,0.000000,-9.779000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<29.083000,0.000000,-8.509000> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<28.829000,0.000000,-4.064000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<28.829000,0.000000,-4.064000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-6.223000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-6.985000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-1.524000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-1.955800>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-1.955800> }
object{ARC(2.667000,0.152400,126.869898,180.000000,0.036000) translate<28.829000,0.000000,-9.144000>}
object{ARC(2.667000,0.152400,180.000000,233.130102,0.036000) translate<28.829000,0.000000,-9.144000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-11.252200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.178000,0.000000,-11.684000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.178000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-1.524000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-3.556000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-4.572000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-8.636000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-9.652000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-11.684000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.512000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-3.556000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-4.572000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-8.636000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-9.652000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-12.319000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.290000,0.000000,-12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-8.636000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-9.652000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-0.889000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-3.302000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-8.382000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-8.636000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<33.782000,0.000000,-8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-8.382000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-8.382000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-8.636000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.512000,0.000000,-8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-8.382000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-4.826000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.766000,0.000000,-4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-1.524000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.766000,0.000000,-1.524000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-9.652000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-9.906000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<33.782000,0.000000,-9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-12.319000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.782000,0.000000,-12.319000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-9.906000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-9.652000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.512000,0.000000,-9.652000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-11.684000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.766000,0.000000,-11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-4.572000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-3.556000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-3.556000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.512000,0.000000,-3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-3.302000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-4.826000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.766000,0.000000,-4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-4.572000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-4.826000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-26.563298,0> translate<33.782000,0.000000,-4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.782000,0.000000,-3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,-3.556000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,26.563298,0> translate<33.782000,0.000000,-3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-3.556000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.512000,0.000000,-3.556000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.766000,0.000000,-4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.512000,0.000000,-4.572000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<32.512000,0.000000,-4.572000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  DC_MOTOR_DRIVER(-46.998500,0,21.018500,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//H1	MOUNT-HOLE3.0	3,0
//H2	MOUNT-HOLE3.0	3,0
//H3	MOUNT-HOLE3.0	3,0
//H4	MOUNT-HOLE3.0	3,0
//IC1	L293D	SOCKED-16
//POWER	9090-4V	9090-4V
