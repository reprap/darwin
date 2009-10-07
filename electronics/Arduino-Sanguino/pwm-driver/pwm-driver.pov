//POVRay-File created by 3d41.ulp v1.05
///home/hoeken/Desktop/reprap/trunk/users/hoeken/arduino/electronics/pwm-driver/pwm-driver.brd
// 1/06/2008 11:23:00 

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
#local cam_y = 251;
#local cam_z = -116;
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

#local lgt1_pos_x = 29;
#local lgt1_pos_y = 44;
#local lgt1_pos_z = 26;
#local lgt1_intense = 0.757143;
#local lgt2_pos_x = -29;
#local lgt2_pos_y = 44;
#local lgt2_pos_z = 26;
#local lgt2_intense = 0.757143;
#local lgt3_pos_x = 29;
#local lgt3_pos_y = 44;
#local lgt3_pos_z = -18;
#local lgt3_intense = 0.757143;
#local lgt4_pos_x = -29;
#local lgt4_pos_y = 44;
#local lgt4_pos_z = -18;
#local lgt4_intense = 0.757143;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 78.740000;
#declare pcb_y_size = 50.800000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(111);
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
	//translate<-39.370000,0,-25.400000>
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


#macro PWM_DRIVER(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<7.620000,27.940000><7.620000,78.740000>
<7.620000,78.740000><86.360000,78.740000>
<86.360000,78.740000><86.360000,27.940000>
<86.360000,27.940000><7.620000,27.940000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
cylinder{<81.915000,1,74.295000><81.915000,-5,74.295000>1.500000 texture{col_hls}}
cylinder{<12.065000,1,74.295000><12.065000,-5,74.295000>1.500000 texture{col_hls}}
cylinder{<12.065000,1,32.385000><12.065000,-5,32.385000>1.500000 texture{col_hls}}
cylinder{<81.915000,1,32.385000><81.915000,-5,32.385000>1.500000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<60.325000,-0.000000,64.135000>}#end		//ceramic disc capacitator C1 100nF C050-045X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_ELKO_3MM5_8MM("100uF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<60.325000,-0.000000,55.880000>}#end		//Elko 3,5mm Pitch, 8mm  Diameter, 11,5mm High C2 100uF E3,5-8
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<22.225000,-0.000000,58.420000>}#end		//Diode DO35 10mm hor. D1 1N4004 DO41-10
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<46.990000,-0.000000,58.420000>}#end		//Diode DO35 10mm hor. D2 1N4004 DO41-10
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO41_102MM_H("1N4004",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<71.120000,-0.000000,58.420000>}#end		//Diode DO35 10mm hor. D3 1N4004 DO41-10
#ifndef(pack_INPUTS) #declare global_pack_INPUTS=yes; object {PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<27.940000,-0.000000,72.390000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) INPUTS  1X04
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<31.750000,-0.000000,40.640000>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<56.515000,-0.000000,40.640000>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<82.550000,-0.000000,40.640000>}#end		//Diskrete 5MM LED LED3  LED5MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<39.370000,-0.000000,73.025000>}#end		//Diskrete 5MM LED LED4  LED5MM
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<26.670000,-0.000000,59.690000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 1K 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<51.435000,-0.000000,59.055000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 1K 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<74.930000,-0.000000,59.690000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 1K 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<54.610000,-0.000000,59.055000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 560 0207/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<78.740000,-0.000000,59.690000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R5 560 0207/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<29.845000,-0.000000,59.690000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R6 560 0207/7
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_075MM(texture{pigment{Green*0.7}finish{phong 0.2}},texture{pigment{Blue}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<45.720000,-0.000000,72.390000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R7 560 0207/7
#ifndef(pack_T1) #declare global_pack_T1=yes; object {TR_TO220_S("TIP120",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<22.225000,-0.000000,46.355000>}#end		//TO220 Vertical T1 TIP120 TO220V
#ifndef(pack_T2) #declare global_pack_T2=yes; object {TR_TO220_S("TIP120",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<46.990000,-0.000000,46.355000>}#end		//TO220 Vertical T2 TIP120 TO220V
#ifndef(pack_T3) #declare global_pack_T3=yes; object {TR_TO220_S("TIP120",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<71.120000,-0.000000,46.355000>}#end		//TO220 Vertical T3 TIP120 TO220V
#ifndef(pack_X4) #declare global_pack_X4=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<71.120000,-0.000000,40.005000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X4 MST2V MSTBV2
#ifndef(pack_X5) #declare global_pack_X5=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<46.990000,-0.000000,40.005000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X5 MST2V MSTBV2
#ifndef(pack_X6) #declare global_pack_X6=yes; object {CON_PHOENIX_508_MSTBV_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-0.000000,0> rotate<0,0,0> translate<22.225000,-0.000000,40.005000>}#end		//Connector PHOENIX type MSTBV vertical 2 pins X6 MST2V MSTBV2
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<57.785000,0,64.135000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<62.865000,0,64.135000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<58.547000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<62.103000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<22.225000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<22.225000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<46.990000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<46.990000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<71.120000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,1.117600,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<71.120000,0,53.340000> texture{col_thl}}
#ifndef(global_pack_INPUTS) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.130000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_INPUTS) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<26.670000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_INPUTS) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<29.210000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_INPUTS) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<31.750000,0,72.390000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<33.020000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<30.480000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<57.785000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<55.245000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<83.820000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<81.280000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,71.755000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<39.370000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<67.310000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<62.230000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<57.150000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_POWER) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.600000,1.600000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<52.070000,0,74.295000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<26.670000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<26.670000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,55.245000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<51.435000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<74.930000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<74.930000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<54.610000,0,55.245000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<54.610000,0,62.865000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<78.740000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<78.740000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.845000,0,55.880000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.845000,0,63.500000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,76.200000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<45.720000,0,68.580000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<24.765000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<22.225000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<19.685000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<49.530000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<46.990000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<44.450000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<73.660000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<71.120000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_T3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<68.580000,0,48.895000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<68.580000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<73.660000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<19.685000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.095600,1.397000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.765000,0,40.005000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.016000,0.609600,1,16,1,0) translate<45.720000,0,66.040000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<19.685000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,36.830000>}
box{<0,0,-0.635000><4.490128,0.035000,0.635000> rotate<0,44.997030,0> translate<19.685000,-0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.225000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,48.260000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,44.997030,0> translate<22.225000,-0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,48.260000>}
box{<0,0,-0.635000><6.350000,0.035000,0.635000> rotate<0,90.000000,0> translate<22.860000,-0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.225000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,49.530000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,-44.997030,0> translate<22.225000,-0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.225000,-0.000000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,53.340000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,0.000000,0> translate<22.225000,-0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,53.340000>}
box{<0,0,-0.635000><3.810000,0.035000,0.635000> rotate<0,90.000000,0> translate<22.860000,-0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.765000,-0.000000,40.005000>}
box{<0,0,-0.635000><2.694077,0.035000,0.635000> rotate<0,44.997030,0> translate<22.860000,-0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.765000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<25.400000,-0.000000,40.640000>}
box{<0,0,-0.635000><0.898026,0.035000,0.635000> rotate<0,-44.997030,0> translate<24.765000,-0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<24.765000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-0.000000,50.800000>}
box{<0,0,-0.635000><2.694077,0.035000,0.635000> rotate<0,-44.997030,0> translate<24.765000,-0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<26.670000,-0.000000,55.880000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<26.670000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<26.670000,-0.000000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<26.670000,-0.000000,72.390000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,90.000000,0> translate<26.670000,-0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,72.390000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<29.210000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.210000,-1.535000,69.215000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,68.580000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<29.210000,-1.535000,69.215000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<25.400000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<30.480000,-0.000000,40.640000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,0.000000,0> translate<25.400000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<29.845000,-0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<30.480000,-0.000000,55.880000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,0.000000,0> translate<29.845000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.845000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,68.580000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.845000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<30.480000,-0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-0.000000,53.340000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<30.480000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<33.020000,-0.000000,53.340000>}
box{<0,0,-0.254000><12.700000,0.035000,0.254000> rotate<0,90.000000,0> translate<33.020000,-0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.385000,-1.535000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,67.945000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<32.385000,-1.535000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.020000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,67.945000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<33.020000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<31.750000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.290000,-1.535000,72.390000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<31.750000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-0.000000,71.755000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-0.000000,72.390000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,90.000000,0> translate<39.370000,-0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,60.960000>}
box{<0,0,-0.635000><12.700000,0.035000,0.635000> rotate<0,90.000000,0> translate<40.640000,-0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<29.845000,-0.000000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,63.500000>}
box{<0,0,-0.635000><10.795000,0.035000,0.635000> rotate<0,0.000000,0> translate<29.845000,-0.000000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,63.500000>}
box{<0,0,-0.635000><2.540000,0.035000,0.635000> rotate<0,90.000000,0> translate<40.640000,-0.000000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.290000,-1.535000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,66.040000>}
box{<0,0,-0.254000><8.980256,0.035000,0.254000> rotate<0,44.997030,0> translate<34.290000,-1.535000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<33.655000,-1.535000,67.945000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,59.690000>}
box{<0,0,-0.304800><11.674333,0.035000,0.304800> rotate<0,44.997030,0> translate<33.655000,-1.535000,67.945000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.370000,-0.000000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-0.000000,72.390000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<39.370000,-0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<22.860000,-0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<43.180000,-0.000000,36.830000>}
box{<0,0,-0.635000><20.320000,0.035000,0.635000> rotate<0,0.000000,0> translate<22.860000,-0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<43.180000,-0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,38.100000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<43.180000,-0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,40.005000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,90.000000,0> translate<44.450000,-0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,44.450000>}
box{<0,0,-0.635000><5.388154,0.035000,0.635000> rotate<0,44.997030,0> translate<40.640000,-0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<44.450000,-0.000000,44.450000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<44.450000,-0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<40.640000,-1.535000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<45.720000,-1.535000,66.040000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<40.640000,-1.535000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,63.500000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.720000,-0.000000,68.580000>}
box{<0,0,-0.635000><7.184205,0.035000,0.635000> rotate<0,-44.997030,0> translate<40.640000,-0.000000,63.500000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-0.000000,72.390000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<45.720000,-0.000000,76.200000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<41.910000,-0.000000,72.390000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<46.990000,-0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<46.990000,-0.000000,48.895000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<46.990000,-0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<46.990000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<46.990000,-0.000000,53.340000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<46.990000,-0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.910000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,59.690000>}
box{<0,0,-0.304800><6.985000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.910000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,40.640000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,90.000000,0> translate<49.530000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<46.990000,-0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,41.910000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,44.997030,0> translate<46.990000,-0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,41.910000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,90.000000,0> translate<49.530000,-0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,53.340000>}
box{<0,0,-0.304800><4.445000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,-1.535000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,59.055000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<48.895000,-1.535000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,59.055000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,60.960000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<49.530000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<45.720000,-0.000000,68.580000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<50.800000,-0.000000,73.660000>}
box{<0,0,-0.635000><7.184205,0.035000,0.635000> rotate<0,-44.997030,0> translate<45.720000,-0.000000,68.580000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,53.340000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,55.245000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,-1.535000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,-1.535000,62.865000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.530000,-1.535000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<50.800000,-0.000000,73.660000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<52.070000,-0.000000,74.295000>}
box{<0,0,-0.635000><1.419903,0.035000,0.635000> rotate<0,-26.563298,0> translate<50.800000,-0.000000,73.660000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-0.000000,55.245000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,90.000000,0> translate<54.610000,-0.000000,55.245000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,59.690000>}
box{<0,0,-0.635000><1.270000,0.035000,0.635000> rotate<0,-90.000000,0> translate<54.610000,-0.000000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<40.640000,-0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,60.960000>}
box{<0,0,-0.635000><13.970000,0.035000,0.635000> rotate<0,0.000000,0> translate<40.640000,-0.000000,60.960000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,60.960000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,62.865000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,90.000000,0> translate<54.610000,-0.000000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<49.530000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.245000,-0.000000,40.640000>}
box{<0,0,-0.635000><5.715000,0.035000,0.635000> rotate<0,0.000000,0> translate<49.530000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<54.610000,-0.000000,59.690000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-0.000000,58.420000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,44.997030,0> translate<54.610000,-0.000000,59.690000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,-0.000000,62.865000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-0.000000,64.135000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.610000,-0.000000,62.865000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<54.610000,-0.000000,54.610000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-0.000000,52.070000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<54.610000,-0.000000,54.610000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-0.000000,52.070000>}
box{<0,0,-0.254000><11.430000,0.035000,0.254000> rotate<0,90.000000,0> translate<57.150000,-0.000000,52.070000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.150000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.785000,-0.000000,40.640000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,0.000000,0> translate<57.150000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.880000,-0.000000,64.135000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,-0.000000,64.135000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.880000,-0.000000,64.135000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-0.000000,55.880000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,44.997030,0> translate<55.880000,-0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.420000,-0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<58.547000,-0.000000,55.880000>}
box{<0,0,-0.635000><0.127000,0.035000,0.635000> rotate<0,0.000000,0> translate<58.420000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<66.040000,-0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<66.040000,-0.000000,46.990000>}
box{<0,0,-0.635000><11.430000,0.035000,0.635000> rotate<0,-90.000000,0> translate<66.040000,-0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<55.880000,-0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<66.040000,-0.000000,58.420000>}
box{<0,0,-0.635000><10.160000,0.035000,0.635000> rotate<0,0.000000,0> translate<55.880000,-0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<68.580000,-0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<68.580000,-0.000000,40.005000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,-90.000000,0> translate<68.580000,-0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<66.040000,-0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<68.580000,-0.000000,44.450000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,44.997030,0> translate<66.040000,-0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-0.000000,48.895000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<71.120000,-0.000000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-0.000000,53.340000>}
box{<0,0,-0.635000><4.445000,0.035000,0.635000> rotate<0,90.000000,0> translate<71.120000,-0.000000,53.340000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<45.720000,-0.000000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,-0.000000,66.040000>}
box{<0,0,-0.254000><26.670000,0.035000,0.254000> rotate<0,0.000000,0> translate<45.720000,-0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,40.640000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,90.000000,0> translate<73.660000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<71.120000,-0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,41.910000>}
box{<0,0,-0.635000><3.592102,0.035000,0.635000> rotate<0,44.997030,0> translate<71.120000,-0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,41.910000>}
box{<0,0,-0.635000><1.905000,0.035000,0.635000> rotate<0,90.000000,0> translate<73.660000,-0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,49.530000>}
box{<0,0,-0.635000><0.635000,0.035000,0.635000> rotate<0,90.000000,0> translate<73.660000,-0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<66.040000,-0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,58.420000>}
box{<0,0,-0.635000><7.620000,0.035000,0.635000> rotate<0,0.000000,0> translate<66.040000,-0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<74.930000,-0.000000,50.800000>}
box{<0,0,-0.635000><1.796051,0.035000,0.635000> rotate<0,-44.997030,0> translate<73.660000,-0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<74.930000,-0.000000,50.800000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<74.930000,-0.000000,55.880000>}
box{<0,0,-0.635000><5.080000,0.035000,0.635000> rotate<0,90.000000,0> translate<74.930000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,-0.000000,66.040000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,-0.000000,63.500000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<72.390000,-0.000000,66.040000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,58.420000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<78.740000,-0.000000,63.500000>}
box{<0,0,-0.635000><7.184205,0.035000,0.635000> rotate<0,-44.997030,0> translate<73.660000,-0.000000,58.420000> }
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<73.660000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.635000 translate<81.280000,-0.000000,40.640000>}
box{<0,0,-0.635000><7.620000,0.035000,0.635000> rotate<0,0.000000,0> translate<73.660000,-0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<78.740000,-0.000000,55.880000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<83.820000,-0.000000,50.800000>}
box{<0,0,-0.254000><7.184205,0.035000,0.254000> rotate<0,44.997030,0> translate<78.740000,-0.000000,55.880000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<83.820000,-0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<83.820000,-0.000000,50.800000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,90.000000,0> translate<83.820000,-0.000000,50.800000> }
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
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,78.740000>}
box{<0,0,-0.203200><50.800000,0.035000,0.203200> rotate<0,90.000000,0> translate<7.620000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.360000,-1.535000,27.940000>}
box{<0,0,-0.203200><78.740000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.620000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.620000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.360000,-1.535000,78.740000>}
box{<0,0,-0.203200><78.740000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.620000,-1.535000,78.740000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.360000,-1.535000,78.740000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.360000,-1.535000,27.940000>}
box{<0,0,-0.203200><50.800000,0.035000,0.203200> rotate<0,-90.000000,0> translate<86.360000,-1.535000,27.940000> }
texture{col_pol}
}
#end
union{
cylinder{<57.785000,0.038000,64.135000><57.785000,-1.538000,64.135000>0.406400}
cylinder{<62.865000,0.038000,64.135000><62.865000,-1.538000,64.135000>0.406400}
cylinder{<58.547000,0.038000,55.880000><58.547000,-1.538000,55.880000>0.406400}
cylinder{<62.103000,0.038000,55.880000><62.103000,-1.538000,55.880000>0.406400}
cylinder{<22.225000,0.038000,63.500000><22.225000,-1.538000,63.500000>0.558800}
cylinder{<22.225000,0.038000,53.340000><22.225000,-1.538000,53.340000>0.558800}
cylinder{<46.990000,0.038000,63.500000><46.990000,-1.538000,63.500000>0.558800}
cylinder{<46.990000,0.038000,53.340000><46.990000,-1.538000,53.340000>0.558800}
cylinder{<71.120000,0.038000,63.500000><71.120000,-1.538000,63.500000>0.558800}
cylinder{<71.120000,0.038000,53.340000><71.120000,-1.538000,53.340000>0.558800}
cylinder{<24.130000,0.038000,72.390000><24.130000,-1.538000,72.390000>0.508000}
cylinder{<26.670000,0.038000,72.390000><26.670000,-1.538000,72.390000>0.508000}
cylinder{<29.210000,0.038000,72.390000><29.210000,-1.538000,72.390000>0.508000}
cylinder{<31.750000,0.038000,72.390000><31.750000,-1.538000,72.390000>0.508000}
cylinder{<33.020000,0.038000,40.640000><33.020000,-1.538000,40.640000>0.406400}
cylinder{<30.480000,0.038000,40.640000><30.480000,-1.538000,40.640000>0.406400}
cylinder{<57.785000,0.038000,40.640000><57.785000,-1.538000,40.640000>0.406400}
cylinder{<55.245000,0.038000,40.640000><55.245000,-1.538000,40.640000>0.406400}
cylinder{<83.820000,0.038000,40.640000><83.820000,-1.538000,40.640000>0.406400}
cylinder{<81.280000,0.038000,40.640000><81.280000,-1.538000,40.640000>0.406400}
cylinder{<39.370000,0.038000,71.755000><39.370000,-1.538000,71.755000>0.406400}
cylinder{<39.370000,0.038000,74.295000><39.370000,-1.538000,74.295000>0.406400}
cylinder{<67.310000,0.038000,74.295000><67.310000,-1.538000,74.295000>0.800000}
cylinder{<62.230000,0.038000,74.295000><62.230000,-1.538000,74.295000>0.800000}
cylinder{<57.150000,0.038000,74.295000><57.150000,-1.538000,74.295000>0.800000}
cylinder{<52.070000,0.038000,74.295000><52.070000,-1.538000,74.295000>0.800000}
cylinder{<26.670000,0.038000,55.880000><26.670000,-1.538000,55.880000>0.406400}
cylinder{<26.670000,0.038000,63.500000><26.670000,-1.538000,63.500000>0.406400}
cylinder{<51.435000,0.038000,55.245000><51.435000,-1.538000,55.245000>0.406400}
cylinder{<51.435000,0.038000,62.865000><51.435000,-1.538000,62.865000>0.406400}
cylinder{<74.930000,0.038000,55.880000><74.930000,-1.538000,55.880000>0.406400}
cylinder{<74.930000,0.038000,63.500000><74.930000,-1.538000,63.500000>0.406400}
cylinder{<54.610000,0.038000,55.245000><54.610000,-1.538000,55.245000>0.406400}
cylinder{<54.610000,0.038000,62.865000><54.610000,-1.538000,62.865000>0.406400}
cylinder{<78.740000,0.038000,55.880000><78.740000,-1.538000,55.880000>0.406400}
cylinder{<78.740000,0.038000,63.500000><78.740000,-1.538000,63.500000>0.406400}
cylinder{<29.845000,0.038000,55.880000><29.845000,-1.538000,55.880000>0.406400}
cylinder{<29.845000,0.038000,63.500000><29.845000,-1.538000,63.500000>0.406400}
cylinder{<45.720000,0.038000,76.200000><45.720000,-1.538000,76.200000>0.406400}
cylinder{<45.720000,0.038000,68.580000><45.720000,-1.538000,68.580000>0.406400}
cylinder{<24.765000,0.038000,48.895000><24.765000,-1.538000,48.895000>0.508000}
cylinder{<22.225000,0.038000,48.895000><22.225000,-1.538000,48.895000>0.508000}
cylinder{<19.685000,0.038000,48.895000><19.685000,-1.538000,48.895000>0.508000}
cylinder{<49.530000,0.038000,48.895000><49.530000,-1.538000,48.895000>0.508000}
cylinder{<46.990000,0.038000,48.895000><46.990000,-1.538000,48.895000>0.508000}
cylinder{<44.450000,0.038000,48.895000><44.450000,-1.538000,48.895000>0.508000}
cylinder{<73.660000,0.038000,48.895000><73.660000,-1.538000,48.895000>0.508000}
cylinder{<71.120000,0.038000,48.895000><71.120000,-1.538000,48.895000>0.508000}
cylinder{<68.580000,0.038000,48.895000><68.580000,-1.538000,48.895000>0.508000}
cylinder{<68.580000,0.038000,40.005000><68.580000,-1.538000,40.005000>0.698500}
cylinder{<73.660000,0.038000,40.005000><73.660000,-1.538000,40.005000>0.698500}
cylinder{<44.450000,0.038000,40.005000><44.450000,-1.538000,40.005000>0.698500}
cylinder{<49.530000,0.038000,40.005000><49.530000,-1.538000,40.005000>0.698500}
cylinder{<19.685000,0.038000,40.005000><19.685000,-1.538000,40.005000>0.698500}
cylinder{<24.765000,0.038000,40.005000><24.765000,-1.538000,40.005000>0.698500}
//Holes(fast)/Vias
cylinder{<45.720000,0.038000,66.040000><45.720000,-1.538000,66.040000>0.304800 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.822600,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.822600,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<67.822600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.822600,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.636000,0.000000,31.040100>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<67.822600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.636000,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.907200,0.000000,30.769000>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<68.636000,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.907200,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.907200,0.000000,30.226600>}
box{<0,0,-0.076200><0.542400,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.907200,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.907200,0.000000,30.226600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.636000,0.000000,29.955500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<68.636000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.636000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.822600,0.000000,29.955500>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<67.822600,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.459700,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.459700,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.459700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.459700,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,29.955500>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.459700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.002000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.544300,0.000000,29.413200>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<70.002000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.544300,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.544300,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<70.544300,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.096800,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.096800,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<71.096800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.096800,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.639100,0.000000,30.497800>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<71.096800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.639100,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.181400,0.000000,31.040100>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<71.639100,0.000000,30.497800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.181400,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.181400,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.181400,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.733900,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.276200,0.000000,31.040100>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<72.733900,0.000000,30.497800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.276200,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.276200,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.276200,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.733900,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.818500,0.000000,29.413200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<72.733900,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.021200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.105800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<68.021200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.563500,0.000000,33.817000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.563500,0.000000,32.732300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<68.563500,0.000000,32.732300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.101200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.185800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<73.101200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.891200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.975800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<43.891200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.433500,0.000000,33.817000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.433500,0.000000,32.732300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.433500,0.000000,32.732300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.971200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.055800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<48.971200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.206200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.290800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<24.206200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.126200,0.000000,33.274600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.210800,0.000000,33.274600>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<19.126200,0.000000,33.274600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.668500,0.000000,33.817000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.668500,0.000000,32.732300>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.668500,0.000000,32.732300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.692600,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.692600,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<43.692600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.692600,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.506000,0.000000,31.040100>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<43.692600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.506000,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.777200,0.000000,30.769000>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<44.506000,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.777200,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.777200,0.000000,30.226600>}
box{<0,0,-0.076200><0.542400,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.777200,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.777200,0.000000,30.226600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.506000,0.000000,29.955500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<44.506000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.506000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.692600,0.000000,29.955500>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<43.692600,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.329700,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.329700,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.329700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.329700,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.872000,0.000000,29.955500>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.329700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.872000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.414300,0.000000,29.413200>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<45.872000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.414300,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.414300,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<46.414300,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.966800,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.966800,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<46.966800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.966800,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.509100,0.000000,30.497800>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<46.966800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.509100,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.051400,0.000000,31.040100>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.509100,0.000000,30.497800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.051400,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.051400,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.051400,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.688500,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.603900,0.000000,29.413200>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<48.603900,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.603900,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.688500,0.000000,30.497800>}
box{<0,0,-0.076200><1.533856,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.603900,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.688500,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.688500,0.000000,30.769000>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,90.000000,0> translate<49.688500,0.000000,30.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.688500,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.417300,0.000000,31.040100>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<49.417300,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.417300,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.875000,0.000000,31.040100>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<48.875000,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.875000,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.603900,0.000000,30.769000>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.603900,0.000000,30.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.927600,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.927600,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<18.927600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.927600,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.741000,0.000000,31.040100>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.927600,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.741000,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.012200,0.000000,30.769000>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<19.741000,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.012200,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.012200,0.000000,30.226600>}
box{<0,0,-0.076200><0.542400,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.012200,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.012200,0.000000,30.226600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.741000,0.000000,29.955500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<19.741000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.741000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.927600,0.000000,29.955500>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<18.927600,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.564700,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.564700,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.564700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.564700,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.107000,0.000000,29.955500>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.564700,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.107000,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.649300,0.000000,29.413200>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<21.107000,0.000000,29.955500> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.649300,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.649300,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<21.649300,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.201800,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.201800,0.000000,31.040100>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<22.201800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.201800,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.744100,0.000000,30.497800>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,44.997030,0> translate<22.201800,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.744100,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.286400,0.000000,31.040100>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.744100,0.000000,30.497800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.286400,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.286400,0.000000,29.413200>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.286400,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.838900,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.110000,0.000000,31.040100>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.838900,0.000000,30.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.110000,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,31.040100>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<24.110000,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,31.040100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,30.769000>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<24.652300,0.000000,31.040100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,30.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,30.497800>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.923500,0.000000,30.497800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,30.497800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,30.226600>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.652300,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,30.226600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.381200,0.000000,30.226600>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<24.381200,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,30.226600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,29.955500>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<24.652300,0.000000,30.226600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,29.955500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,29.684300>}
box{<0,0,-0.076200><0.271200,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.923500,0.000000,29.684300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.923500,0.000000,29.684300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,29.413200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<24.652300,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.652300,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.110000,0.000000,29.413200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<24.110000,0.000000,29.413200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.110000,0.000000,29.413200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.838900,0.000000,29.684300>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<23.838900,0.000000,29.684300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,74.968100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,75.336700>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,90.000000,0> translate<31.482700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.605600,0.000000,75.459500>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<31.482700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.605600,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.851300,0.000000,75.459500>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<31.605600,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.851300,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.974200,0.000000,75.336700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<31.851300,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.974200,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.974200,0.000000,74.968100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<31.974200,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,75.716500>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,75.716500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.974200,0.000000,75.962200>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<31.974200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.974200,0.000000,75.962200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,76.207900>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,-44.997030,0> translate<31.974200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,76.207900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,76.207900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,76.207900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,76.464900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.728500,0.000000,76.710600>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,-44.985374,0> translate<31.482700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.728500,0.000000,76.710600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,76.956300>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,44.985374,0> translate<31.482700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,76.956300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,76.956300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.728500,0.000000,77.213300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,77.459000>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,44.985374,0> translate<31.482700,0.000000,77.459000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<31.482700,0.000000,77.459000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,77.459000>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<31.482700,0.000000,77.459000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,77.213300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<32.219900,0.000000,77.704700>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,90.000000,0> translate<32.219900,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,74.968100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.942700,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,75.336700>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,90.000000,0> translate<28.942700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.065600,0.000000,75.459500>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<28.942700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.065600,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.311300,0.000000,75.459500>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<29.065600,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.311300,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.434200,0.000000,75.336700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<29.311300,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.434200,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.434200,0.000000,74.968100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<29.434200,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,75.716500>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.942700,0.000000,75.716500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.434200,0.000000,75.962200>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<29.434200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.434200,0.000000,75.962200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,76.207900>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,-44.997030,0> translate<29.434200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,76.207900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,76.207900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.942700,0.000000,76.207900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,76.464900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.942700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.188500,0.000000,76.710600>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,-44.985374,0> translate<28.942700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.188500,0.000000,76.710600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,76.956300>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,44.985374,0> translate<28.942700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,76.956300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,76.956300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<28.942700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,77.213300>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,-90.000000,0> translate<29.679900,0.000000,77.213300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.679900,0.000000,77.213300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.188500,0.000000,77.704700>}
box{<0,0,-0.038100><0.694945,0.036000,0.038100> rotate<0,44.997030,0> translate<29.188500,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.188500,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.065600,0.000000,77.704700>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,0.000000,0> translate<29.065600,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.065600,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,77.581900>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<28.942700,0.000000,77.581900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,77.581900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,77.336100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<28.942700,0.000000,77.336100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<28.942700,0.000000,77.336100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<29.065600,0.000000,77.213300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<28.942700,0.000000,77.336100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,74.968100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<26.402700,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,75.336700>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,90.000000,0> translate<26.402700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.525600,0.000000,75.459500>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<26.402700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.525600,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,75.459500>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<26.525600,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,75.336700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<26.771300,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,74.968100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.894200,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,75.716500>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<26.402700,0.000000,75.716500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,75.962200>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<26.894200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,75.962200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,76.207900>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,-44.997030,0> translate<26.894200,0.000000,75.962200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,76.207900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,76.207900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<26.402700,0.000000,76.207900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,76.464900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<26.402700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.648500,0.000000,76.710600>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,-44.985374,0> translate<26.402700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.648500,0.000000,76.710600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,76.956300>}
box{<0,0,-0.038100><0.347543,0.036000,0.038100> rotate<0,44.985374,0> translate<26.402700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,76.956300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,76.956300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<26.402700,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.525600,0.000000,77.213300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,77.336100>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<26.402700,0.000000,77.336100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,77.336100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,77.581900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<26.402700,0.000000,77.581900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.402700,0.000000,77.581900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.525600,0.000000,77.704700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<26.402700,0.000000,77.581900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.525600,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.648500,0.000000,77.704700>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,0.000000,0> translate<26.525600,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.648500,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,77.581900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<26.648500,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,77.581900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,77.459000>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<26.771300,0.000000,77.459000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.771300,0.000000,77.581900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,77.704700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<26.771300,0.000000,77.581900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<26.894200,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.017100,0.000000,77.704700>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,0.000000,0> translate<26.894200,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.017100,0.000000,77.704700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,77.581900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<27.017100,0.000000,77.704700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,77.581900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,77.336100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<27.139900,0.000000,77.336100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.139900,0.000000,77.336100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<27.017100,0.000000,77.213300>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<27.017100,0.000000,77.213300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.985600,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.336700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<23.862700,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.090900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<23.862700,0.000000,75.090900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.090900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.985600,0.000000,74.968100>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<23.862700,0.000000,75.090900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.985600,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,74.968100>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,0.000000,0> translate<23.985600,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,74.968100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,75.090900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<24.477100,0.000000,74.968100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,75.090900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,75.336700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<24.599900,0.000000,75.336700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,75.336700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,75.459500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<24.477100,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.231300,0.000000,75.459500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<24.231300,0.000000,75.459500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.231300,0.000000,75.459500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.231300,0.000000,75.213800>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,-90.000000,0> translate<24.231300,0.000000,75.213800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.716500>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<23.862700,0.000000,75.716500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,75.716500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.207900>}
box{<0,0,-0.038100><0.885967,0.036000,0.038100> rotate<0,-33.684257,0> translate<23.862700,0.000000,75.716500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.207900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,76.207900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<23.862700,0.000000,76.207900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.464900>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,0.000000,0> translate<23.862700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.464900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.833500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,90.000000,0> translate<24.599900,0.000000,76.833500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.599900,0.000000,76.833500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,76.956300>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<24.477100,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<24.477100,0.000000,76.956300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.985600,0.000000,76.956300>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,0.000000,0> translate<23.985600,0.000000,76.956300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.985600,0.000000,76.956300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,76.833500>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<23.862700,0.000000,76.833500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,76.833500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<23.862700,0.000000,76.464900>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<23.862700,0.000000,76.464900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,45.148500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,45.148500>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,45.148500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,45.148500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,45.923800>}
box{<0,0,-0.063500><0.775300,0.036000,0.063500> rotate<0,90.000000,0> translate<9.180800,0.000000,45.923800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,45.923800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.439300,0.000000,46.182300>}
box{<0,0,-0.063500><0.365574,0.036000,0.063500> rotate<0,-44.997030,0> translate<9.180800,0.000000,45.923800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.439300,0.000000,46.182300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,46.182300>}
box{<0,0,-0.063500><0.516900,0.036000,0.063500> rotate<0,0.000000,0> translate<9.439300,0.000000,46.182300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,46.182300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,45.923800>}
box{<0,0,-0.063500><0.365504,0.036000,0.063500> rotate<0,45.008114,0> translate<9.956200,0.000000,46.182300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,45.923800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,45.148500>}
box{<0,0,-0.063500><0.775300,0.036000,0.063500> rotate<0,-90.000000,0> translate<10.214600,0.000000,45.148500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,46.692100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,46.692100>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,46.692100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,46.692100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,47.209000>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<10.214600,0.000000,47.209000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,47.209000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,47.725900>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,-44.997030,0> translate<10.214600,0.000000,47.209000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,47.725900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,47.725900>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,47.725900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,48.235700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,48.235700>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,48.235700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,48.235700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,48.752600>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,-44.997030,0> translate<9.180800,0.000000,48.235700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,48.752600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,49.269500>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<9.180800,0.000000,49.269500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,49.269500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,49.269500>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,49.269500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,51.322900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,51.322900>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,51.322900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,51.322900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,52.098200>}
box{<0,0,-0.063500><0.775300,0.036000,0.063500> rotate<0,90.000000,0> translate<10.731500,0.000000,52.098200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,52.098200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,52.356700>}
box{<0,0,-0.063500><0.365504,0.036000,0.063500> rotate<0,45.008114,0> translate<10.473100,0.000000,52.356700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,52.356700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.439300,0.000000,52.356700>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<9.439300,0.000000,52.356700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.439300,0.000000,52.356700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,52.098200>}
box{<0,0,-0.063500><0.365574,0.036000,0.063500> rotate<0,-44.997030,0> translate<9.180800,0.000000,52.098200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,52.098200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,51.322900>}
box{<0,0,-0.063500><0.775300,0.036000,0.063500> rotate<0,-90.000000,0> translate<9.180800,0.000000,51.322900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,52.866500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,52.866500>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<9.697700,0.000000,52.866500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,52.866500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,53.383400>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<9.697700,0.000000,53.383400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,53.383400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,53.641800>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,90.000000,0> translate<9.697700,0.000000,53.641800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,54.152800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,54.411200>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,90.000000,0> translate<9.697700,0.000000,54.411200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,54.411200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,54.411200>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<9.697700,0.000000,54.411200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,54.152800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,54.669700>}
box{<0,0,-0.063500><0.516900,0.036000,0.063500> rotate<0,90.000000,0> translate<10.731500,0.000000,54.669700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.922400,0.000000,54.411200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,54.411200>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,0.000000,0> translate<8.922400,0.000000,54.411200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,55.181800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,55.698700>}
box{<0,0,-0.063500><1.155824,0.036000,0.063500> rotate<0,-26.563298,0> translate<9.697700,0.000000,55.181800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,55.698700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,56.215600>}
box{<0,0,-0.063500><1.155824,0.036000,0.063500> rotate<0,26.563298,0> translate<9.697700,0.000000,56.215600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,57.500700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,56.983800>}
box{<0,0,-0.063500><0.516900,0.036000,0.063500> rotate<0,-90.000000,0> translate<10.731500,0.000000,56.983800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,56.983800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,56.725400>}
box{<0,0,-0.063500><0.365433,0.036000,0.063500> rotate<0,-44.997030,0> translate<10.473100,0.000000,56.725400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,56.725400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,56.725400>}
box{<0,0,-0.063500><0.516900,0.036000,0.063500> rotate<0,0.000000,0> translate<9.956200,0.000000,56.725400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,56.725400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,56.983800>}
box{<0,0,-0.063500><0.365504,0.036000,0.063500> rotate<0,44.985946,0> translate<9.697700,0.000000,56.983800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,56.983800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,57.500700>}
box{<0,0,-0.063500><0.516900,0.036000,0.063500> rotate<0,90.000000,0> translate<9.697700,0.000000,57.500700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,57.500700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,57.759200>}
box{<0,0,-0.063500><0.365574,0.036000,0.063500> rotate<0,-44.997030,0> translate<9.697700,0.000000,57.500700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.956200,0.000000,57.759200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,57.759200>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,0.000000,0> translate<9.956200,0.000000,57.759200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,57.759200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,56.725400>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,-90.000000,0> translate<10.214600,0.000000,56.725400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,58.269000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,58.269000>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,0.000000,0> translate<9.697700,0.000000,58.269000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.214600,0.000000,58.269000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,58.785900>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<9.697700,0.000000,58.785900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,58.785900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,59.044300>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,90.000000,0> translate<9.697700,0.000000,59.044300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,61.098900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,61.615800>}
box{<0,0,-0.063500><1.155824,0.036000,0.063500> rotate<0,-26.563298,0> translate<9.697700,0.000000,61.098900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,61.615800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,62.132700>}
box{<0,0,-0.063500><1.155824,0.036000,0.063500> rotate<0,26.563298,0> translate<9.697700,0.000000,62.132700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,62.642500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,63.159400>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<9.180800,0.000000,63.159400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,63.159400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,63.159400>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,63.159400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,62.642500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,63.676300>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,90.000000,0> translate<10.731500,0.000000,63.676300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,64.186100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,64.186100>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,0.000000,0> translate<10.473100,0.000000,64.186100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,64.186100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,64.444500>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,90.000000,0> translate<10.473100,0.000000,64.444500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.473100,0.000000,64.444500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,64.444500>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,0.000000,0> translate<10.473100,0.000000,64.444500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,64.444500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,64.186100>}
box{<0,0,-0.063500><0.258400,0.036000,0.063500> rotate<0,-90.000000,0> translate<10.731500,0.000000,64.186100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.697700,0.000000,64.957900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,65.474800>}
box{<0,0,-0.063500><0.731007,0.036000,0.063500> rotate<0,44.997030,0> translate<9.180800,0.000000,65.474800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.180800,0.000000,65.474800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,65.474800>}
box{<0,0,-0.063500><1.550700,0.036000,0.063500> rotate<0,0.000000,0> translate<9.180800,0.000000,65.474800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,64.957900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.731500,0.000000,65.991700>}
box{<0,0,-0.063500><1.033800,0.036000,0.063500> rotate<0,90.000000,0> translate<10.731500,0.000000,65.991700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,47.655100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,47.498400>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,47.498400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,47.498400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,47.184800>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.216300,0.000000,47.184800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,47.184800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,47.028100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.216300,0.000000,47.184800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,47.028100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,47.028100>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,47.028100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,47.028100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,47.184800>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,47.028100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,47.184800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,47.498400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<36.156900,0.000000,47.498400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,47.498400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,47.655100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<36.000200,0.000000,47.655100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,48.120300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,48.433900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<36.156900,0.000000,48.433900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,48.433900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,48.590600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<36.000200,0.000000,48.590600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,48.590600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,48.590600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.686600,0.000000,48.590600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,48.590600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.433900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.529900,0.000000,48.433900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.433900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.120300>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.529900,0.000000,48.120300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.120300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,47.963600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<35.529900,0.000000,48.120300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,47.963600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,47.963600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.686600,0.000000,47.963600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,47.963600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,48.120300>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,47.963600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,48.899100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.899100>}
box{<0,0,-0.038100><0.940500,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,48.899100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,48.899100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,49.369400>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<35.529900,0.000000,49.369400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,49.369400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,49.526100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.529900,0.000000,49.369400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,49.526100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,49.526100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.686600,0.000000,49.526100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,49.526100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,49.369400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<36.000200,0.000000,49.526100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,49.369400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,48.899100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<36.156900,0.000000,48.899100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,49.834600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,49.834600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,49.834600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,49.834600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,49.991300>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,49.834600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,49.991300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,50.461600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<36.156900,0.000000,50.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,50.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.313600,0.000000,50.461600>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,50.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.313600,0.000000,50.461600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,50.304900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<36.313600,0.000000,50.461600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,50.304900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,50.148100>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,-90.000000,0> translate<36.470400,0.000000,50.148100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,50.770100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,50.770100>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,50.770100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,50.770100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.083600>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,44.997030,0> translate<35.529900,0.000000,51.083600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.083600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.240400>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<35.529900,0.000000,51.240400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.549600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.706300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<35.529900,0.000000,51.706300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,51.706300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,51.706300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,51.706300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,51.549600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,51.863100>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<36.156900,0.000000,51.863100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.059600,0.000000,51.706300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,51.706300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<35.059600,0.000000,51.706300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,52.486700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,52.643500>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,90.000000,0> translate<36.470400,0.000000,52.643500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.470400,0.000000,52.643500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.313600,0.000000,52.800200>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<36.313600,0.000000,52.800200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.313600,0.000000,52.800200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,52.800200>}
box{<0,0,-0.038100><0.783700,0.036000,0.038100> rotate<0,0.000000,0> translate<35.529900,0.000000,52.800200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,52.800200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,52.329900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.529900,0.000000,52.329900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,52.329900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,52.173200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<35.529900,0.000000,52.329900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,52.173200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,52.173200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.686600,0.000000,52.173200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,52.173200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,52.329900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,52.173200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,52.329900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,52.800200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<36.156900,0.000000,52.800200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,53.108700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,53.108700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,53.108700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,53.108700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,53.265400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<35.529900,0.000000,53.265400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,53.265400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,53.579000>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<35.529900,0.000000,53.579000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,53.579000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,53.735700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.529900,0.000000,53.579000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,53.735700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,53.735700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<35.686600,0.000000,53.735700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,54.200900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,54.200900>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,54.200900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,54.200900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,54.357700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-45.015305,0> translate<36.000200,0.000000,54.200900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,54.044200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,54.357700>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<35.529900,0.000000,54.357700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,55.603300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,55.603300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,55.603300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,55.603300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,56.073600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,56.073600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,56.073600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,56.230300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,56.073600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,56.230300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,56.230300>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,56.230300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,56.230300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,56.073600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.686600,0.000000,56.230300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,56.073600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,55.603300>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.843400,0.000000,55.603300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,55.916800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,56.230300>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.843400,0.000000,55.916800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,56.538800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,56.538800>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,56.538800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,56.538800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.009100>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,57.009100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.009100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,57.165800>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,57.009100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,57.165800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,57.165800>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,57.165800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,57.165800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.009100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.686600,0.000000,57.165800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.009100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,56.538800>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.843400,0.000000,56.538800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,56.852300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,57.165800>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.843400,0.000000,56.852300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,57.474300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.474300>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,57.474300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.474300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.944600>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,57.944600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,57.944600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,58.101300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,57.944600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,58.101300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,58.101300>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,58.101300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,58.101300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.944600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.686600,0.000000,58.101300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.944600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.474300>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.843400,0.000000,57.474300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.843400,0.000000,57.787800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,58.101300>}
box{<0,0,-0.038100><0.443356,0.036000,0.038100> rotate<0,-44.997030,0> translate<35.843400,0.000000,57.787800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,58.409800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,58.409800>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,58.409800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,58.409800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,59.036800>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,59.036800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,58.409800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.686600,0.000000,58.723300>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<35.686600,0.000000,58.723300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,60.907800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,60.280800>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<36.156900,0.000000,60.280800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,60.280800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,60.907800>}
box{<0,0,-0.038100><0.886712,0.036000,0.038100> rotate<0,44.997030,0> translate<35.529900,0.000000,60.907800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.529900,0.000000,60.907800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,60.907800>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,60.907800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,60.907800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,60.751100>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,60.751100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,60.751100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,60.437500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<35.216300,0.000000,60.437500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,60.437500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,60.280800>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.216300,0.000000,60.437500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,61.216300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,61.216300>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,61.216300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,61.216300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,61.373000>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.216300,0.000000,61.373000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,61.373000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,61.686600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,61.686600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,61.686600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,61.843300>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,61.686600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,61.843300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,61.843300>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,61.843300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,61.843300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,61.686600>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<36.000200,0.000000,61.843300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,61.686600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,61.373000>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<36.156900,0.000000,61.373000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,61.373000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,61.216300>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,61.216300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,61.216300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,61.843300>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,44.992462,0> translate<35.373100,0.000000,61.843300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,62.151800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,62.151800>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,62.151800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,62.151800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,62.308500>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<35.216300,0.000000,62.308500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,62.308500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,62.622100>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,62.622100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,62.622100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,62.778800>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<35.216300,0.000000,62.622100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,62.778800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,62.778800>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<35.373100,0.000000,62.778800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,62.778800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,62.622100>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<36.000200,0.000000,62.778800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,62.622100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,62.308500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<36.156900,0.000000,62.308500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,62.308500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,62.151800>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<36.000200,0.000000,62.151800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,62.151800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,62.778800>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,44.992462,0> translate<35.373100,0.000000,62.778800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,63.087300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,63.714300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<35.216300,0.000000,63.714300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.216300,0.000000,63.714300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,63.714300>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<35.216300,0.000000,63.714300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<35.373100,0.000000,63.714300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,63.087300>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,44.992462,0> translate<35.373100,0.000000,63.714300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.000200,0.000000,63.087300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.156900,0.000000,63.087300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<36.000200,0.000000,63.087300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,45.135800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.135800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,45.135800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.135800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.330600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,45.330600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.330600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,45.525500>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,45.330600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,45.525500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,45.525500>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,45.525500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,45.525500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.720400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<12.504700,0.000000,45.720400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,45.720400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,45.915300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,45.720400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,45.915300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,45.915300>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,45.915300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,46.499900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,46.889700>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,46.889700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,46.889700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,47.084600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,46.889700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,47.084600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,47.084600>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,47.084600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,47.084600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,46.499900>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,46.499900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,46.499900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,46.305100>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,46.305100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,46.305100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,46.499900>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<12.894500,0.000000,46.499900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,46.499900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,47.084600>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<12.894500,0.000000,47.084600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,47.474400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,47.474400>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<12.114900,0.000000,47.474400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,48.059000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,47.474400>}
box{<0,0,-0.050800><0.702583,0.036000,0.050800> rotate<0,-56.308478,0> translate<12.894500,0.000000,47.474400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,47.474400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,48.059000>}
box{<0,0,-0.050800><0.702639,0.036000,0.050800> rotate<0,56.301693,0> translate<12.504700,0.000000,48.059000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,49.033400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,48.643600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,48.643600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,48.643600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,48.448800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,48.448800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,48.448800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,48.448800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,48.448800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,48.448800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,48.643600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<12.504700,0.000000,48.643600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,48.643600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,49.033400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,49.033400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,49.033400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,49.228300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,49.033400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,49.228300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,49.228300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,49.228300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,49.228300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,48.448800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<12.894500,0.000000,48.448800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,49.618100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,49.618100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,49.618100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,49.618100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,49.812900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<13.089400,0.000000,49.812900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,49.812900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,49.812900>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,49.812900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,49.812900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,49.618100>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,49.618100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,50.202700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,50.202700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,50.202700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,50.202700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,50.592400>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.504700,0.000000,50.592400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,50.592400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,50.787300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,50.787300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,51.177100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,51.177100>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,51.177100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,51.177100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,51.566800>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.504700,0.000000,51.566800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,51.566800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,51.761700>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,51.761700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,52.151500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,52.151500>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,52.151500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,52.151500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,52.541200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.504700,0.000000,52.541200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,52.541200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,52.736100>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,52.736100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,53.320700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.309800,0.000000,53.320700>}
box{<0,0,-0.050800><0.974400,0.036000,0.050800> rotate<0,0.000000,0> translate<12.309800,0.000000,53.320700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.309800,0.000000,53.320700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,53.515600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<12.114900,0.000000,53.515600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,53.125900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,53.515600>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,90.000000,0> translate<12.699600,0.000000,53.515600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,53.905400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,53.905400>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,53.905400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,53.905400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,54.100200>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<13.089400,0.000000,54.100200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,54.100200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,54.100200>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,54.100200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,54.100200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,53.905400>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,53.905400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,54.684800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,55.074600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<13.284200,0.000000,55.074600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,55.074600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,55.269500>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<13.089400,0.000000,55.269500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,55.269500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,55.269500>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,55.269500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,55.269500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,55.074600>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,55.074600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,55.074600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,54.684800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<12.504700,0.000000,54.684800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,54.684800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,54.490000>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<12.504700,0.000000,54.684800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,54.490000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,54.490000>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,54.490000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,54.490000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,54.684800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,54.490000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,55.659300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,55.659300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,55.659300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.894500,0.000000,55.659300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,56.049000>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.504700,0.000000,56.049000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,56.049000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,56.243900>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,56.243900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.673900,0.000000,57.023400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.673900,0.000000,57.218300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<13.673900,0.000000,57.218300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.673900,0.000000,57.218300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.479000,0.000000,57.413200>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<13.479000,0.000000,57.413200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.479000,0.000000,57.413200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,57.413200>}
box{<0,0,-0.050800><0.974300,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,57.413200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,57.413200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,56.828500>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<12.504700,0.000000,56.828500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,56.828500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,56.633700>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<12.504700,0.000000,56.828500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,56.633700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,56.633700>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,56.633700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,56.633700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,56.828500>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,56.633700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,56.828500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,57.413200>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<13.284200,0.000000,57.413200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,57.803000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,58.582500>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,33.686713,0> translate<12.114900,0.000000,58.582500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.673900,0.000000,58.972300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,58.972300>}
box{<0,0,-0.050800><1.169200,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,58.972300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,58.972300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,59.556900>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,59.556900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,59.556900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,59.751800>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<12.504700,0.000000,59.556900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,59.751800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,59.751800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,59.751800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,59.751800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,59.556900>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<13.089400,0.000000,59.751800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,59.556900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,58.972300>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,58.972300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,60.141600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.141600>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,60.141600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.141600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,60.336400>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,60.141600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,60.336400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.531300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<13.089400,0.000000,60.531300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.531300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,60.726200>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<13.089400,0.000000,60.531300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,60.726200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.921100>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,45.011732,0> translate<13.089400,0.000000,60.921100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,60.921100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,60.921100>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<12.504700,0.000000,60.921100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,62.090400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,62.090400>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<12.114900,0.000000,62.090400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,62.090400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,61.505700>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,61.505700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,61.505700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,61.310900>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,-44.997030,0> translate<13.089400,0.000000,61.310900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,61.310900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,61.310900>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<12.699600,0.000000,61.310900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,61.310900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,61.505700>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<12.504700,0.000000,61.505700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,61.505700>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,62.090400>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,90.000000,0> translate<12.504700,0.000000,62.090400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,62.480200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.699600,0.000000,63.259700>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<12.699600,0.000000,63.259700> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,63.649500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,64.039200>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.114900,0.000000,64.039200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,64.039200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,64.039200>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<12.114900,0.000000,64.039200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,63.649500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,64.429000>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<13.284200,0.000000,64.429000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,64.818800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,64.818800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,64.818800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,64.818800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,65.013600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<13.089400,0.000000,65.013600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.089400,0.000000,65.013600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,65.013600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<13.089400,0.000000,65.013600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,65.013600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,64.818800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<13.284200,0.000000,64.818800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.504700,0.000000,65.403400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,65.793100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,44.989680,0> translate<12.114900,0.000000,65.793100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<12.114900,0.000000,65.793100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,65.793100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,0.000000,0> translate<12.114900,0.000000,65.793100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,65.403400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<13.284200,0.000000,66.182900>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<13.284200,0.000000,66.182900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,47.028100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,47.028100>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,47.028100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,47.028100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,47.655100>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,47.655100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,47.963600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,48.120300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434900,0.000000,48.120300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,48.120300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,48.120300>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<37.434900,0.000000,48.120300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,47.963600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,48.277100>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,48.277100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<36.964600,0.000000,48.120300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,48.120300>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<36.964600,0.000000,48.120300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,49.214200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,48.743900>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.434900,0.000000,48.743900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,48.743900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,48.587200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.434900,0.000000,48.743900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,48.587200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,48.587200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,48.587200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,48.587200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,48.743900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,48.587200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,48.743900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,49.214200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,49.214200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,49.993000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,49.679400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,49.679400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,49.679400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,49.522700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,49.522700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,49.522700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,49.522700>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,49.522700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,49.522700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,49.679400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.434900,0.000000,49.679400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,49.679400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,49.993000>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434900,0.000000,49.993000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,49.993000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,50.149700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.434900,0.000000,49.993000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,50.149700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,50.149700>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,50.149700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,50.149700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,49.522700>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.748400,0.000000,49.522700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,50.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,50.458200>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,0.000000,0> translate<37.434900,0.000000,50.458200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,50.458200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,50.928500>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434900,0.000000,50.928500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,50.928500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,51.085200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.434900,0.000000,50.928500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,51.085200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,51.085200>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,51.085200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,51.393700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,51.864000>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,51.864000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,51.864000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,52.020700>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.905200,0.000000,52.020700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,52.020700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,51.864000>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.748400,0.000000,51.864000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,51.864000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,51.550400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.748400,0.000000,51.550400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,51.550400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,51.393700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.591600,0.000000,51.393700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,51.393700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,51.550400>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.434900,0.000000,51.550400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,51.550400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,52.020700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434900,0.000000,52.020700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,52.799500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,52.485900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,52.485900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,52.485900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,52.329200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,52.329200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,52.329200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,52.329200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,52.329200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,52.329200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,52.485900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.434900,0.000000,52.485900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,52.485900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,52.799500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<37.434900,0.000000,52.799500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,52.799500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,52.956200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.434900,0.000000,52.799500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,52.956200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,52.956200>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,52.956200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,52.956200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,52.329200>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.748400,0.000000,52.329200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,54.827200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,54.670500>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.121300,0.000000,54.670500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,54.670500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,54.356900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.121300,0.000000,54.356900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,54.356900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,54.200200>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<37.121300,0.000000,54.356900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,54.200200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,54.200200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,54.200200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,54.200200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,54.356900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,54.200200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,54.356900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,54.670500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,54.670500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,54.670500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,54.827200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.905200,0.000000,54.827200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,54.827200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,54.827200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,54.827200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,54.827200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,54.513700>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.591600,0.000000,54.513700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,55.135700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,55.135700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,55.135700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,55.135700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,55.762700>}
box{<0,0,-0.038100><1.130424,0.036000,0.038100> rotate<0,-33.685033,0> translate<37.121300,0.000000,55.135700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,55.762700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,55.762700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,55.762700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,56.071200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,56.071200>}
box{<0,0,-0.038100><0.783900,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,56.071200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,56.071200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,56.227900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,56.071200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,56.227900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,56.541500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,56.541500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,56.541500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,56.698200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.905200,0.000000,56.698200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,56.698200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,56.698200>}
box{<0,0,-0.038100><0.783900,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,56.698200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,58.569200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.412500>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.121300,0.000000,58.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.098900>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.121300,0.000000,58.098900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.098900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,57.942200>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<37.121300,0.000000,58.098900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,57.942200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,57.942200>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,57.942200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,57.942200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,58.098900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,57.942200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,58.098900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,58.412500>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,58.412500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,58.412500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,58.569200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.905200,0.000000,58.569200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,58.569200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,58.569200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.591600,0.000000,58.569200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,58.569200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,58.255700>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.591600,0.000000,58.255700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,58.877700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.877700>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,58.877700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,58.877700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,59.348000>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,90.000000,0> translate<37.121300,0.000000,59.348000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,59.348000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,59.504700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.121300,0.000000,59.348000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,59.504700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,59.504700>}
box{<0,0,-0.038100><0.313500,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,59.504700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.591600,0.000000,59.504700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,59.348000>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<37.591600,0.000000,59.504700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,59.348000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.748400,0.000000,58.877700>}
box{<0,0,-0.038100><0.470300,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.748400,0.000000,58.877700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,59.813200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,59.813200>}
box{<0,0,-0.038100><0.940600,0.036000,0.038100> rotate<0,0.000000,0> translate<37.121300,0.000000,59.813200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,59.813200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,60.440200>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,90.000000,0> translate<38.061900,0.000000,60.440200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,61.684200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,61.997700>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,-26.563298,0> translate<37.434900,0.000000,61.684200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,61.997700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,62.311200>}
box{<0,0,-0.038100><0.701007,0.036000,0.038100> rotate<0,26.563298,0> translate<37.434900,0.000000,62.311200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,63.246700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,62.619700>}
box{<0,0,-0.038100><0.627000,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,62.619700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,62.619700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,63.246700>}
box{<0,0,-0.038100><0.886712,0.036000,0.038100> rotate<0,44.997030,0> translate<37.434900,0.000000,63.246700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.434900,0.000000,63.246700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,63.246700>}
box{<0,0,-0.038100><0.156800,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,63.246700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,63.246700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,63.090000>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.121300,0.000000,63.090000> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,63.090000>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,62.776400>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<37.121300,0.000000,62.776400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,62.776400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,62.619700>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<37.121300,0.000000,62.776400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,63.555200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,63.555200>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<37.905200,0.000000,63.555200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,63.555200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,63.711900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,90.000000,0> translate<37.905200,0.000000,63.711900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,63.711900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,63.711900>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,0.000000,0> translate<37.905200,0.000000,63.711900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,63.711900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,63.555200>}
box{<0,0,-0.038100><0.156700,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,63.555200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,64.022900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,64.022900>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,64.022900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,64.022900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,64.179600>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,44.978755,0> translate<37.121300,0.000000,64.179600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,64.179600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,64.493200>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,90.000000,0> translate<37.121300,0.000000,64.493200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.121300,0.000000,64.493200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,64.649900>}
box{<0,0,-0.038100><0.221678,0.036000,0.038100> rotate<0,-44.978755,0> translate<37.121300,0.000000,64.493200> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,64.649900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,64.649900>}
box{<0,0,-0.038100><0.627100,0.036000,0.038100> rotate<0,0.000000,0> translate<37.278100,0.000000,64.649900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,64.649900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,64.493200>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,44.997030,0> translate<37.905200,0.000000,64.649900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,64.493200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,64.179600>}
box{<0,0,-0.038100><0.313600,0.036000,0.038100> rotate<0,-90.000000,0> translate<38.061900,0.000000,64.179600> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<38.061900,0.000000,64.179600>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,64.022900>}
box{<0,0,-0.038100><0.221607,0.036000,0.038100> rotate<0,-44.997030,0> translate<37.905200,0.000000,64.022900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.905200,0.000000,64.022900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<37.278100,0.000000,64.649900>}
box{<0,0,-0.038100><0.886783,0.036000,0.038100> rotate<0,44.992462,0> translate<37.278100,0.000000,64.649900> }
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,64.135000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<60.020200,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.020200,0.000000,63.500000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<60.020200,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.020200,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.801000,0.000000,64.135000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<58.801000,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.655200,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.655200,0.000000,64.135000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<60.655200,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.655200,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<60.655200,0.000000,63.500000>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,-90.000000,0> translate<60.655200,0.000000,63.500000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.655200,0.000000,64.135000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.849000,0.000000,64.135000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<60.655200,0.000000,64.135000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,66.167000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.642000,0.000000,62.103000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<56.642000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,61.849000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.754000,0.000000,61.849000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.896000,0.000000,61.849000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.008000,0.000000,66.167000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<64.008000,0.000000,66.167000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.754000,0.000000,66.421000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,66.421000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.896000,0.000000,66.421000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<63.754000,0.000000,66.167000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<63.754000,0.000000,62.103000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<56.896000,0.000000,62.103000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<56.896000,0.000000,66.167000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.896000,0.000000,57.023000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.658000,0.000000,57.023000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<56.896000,0.000000,57.023000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.277000,0.000000,57.404000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.277000,0.000000,57.404000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.674000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,55.880000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<58.674000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,54.610000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,54.610000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.563000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,57.150000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<60.071000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.071000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,57.150000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.563000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,57.150000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.563000,0.000000,55.880000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.563000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.960000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.976000,0.000000,55.880000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.960000,0.000000,55.880000> }
difference{
cylinder{<60.325000,0,55.880000><60.325000,0.036000,55.880000>4.140200 translate<0,0.000000,0>}
cylinder{<60.325000,-0.1,55.880000><60.325000,0.135000,55.880000>3.987800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-0.000000,0> translate<60.833000,0.000000,55.880000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,56.388000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.495000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,60.452000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,60.452000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.955000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,56.388000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.955000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<22.225000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<22.225000,0.000000,62.484000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,-90.000000,0> translate<22.225000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<22.225000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<22.225000,0.000000,54.356000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,90.000000,0> translate<22.225000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,59.436000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<22.225000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,59.944000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.225000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,59.436000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<21.590000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.590000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.590000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.225000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.225000,0.000000,58.420000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<22.225000,0.000000,57.023000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<22.225000,0.000000,61.404500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<22.225000,0.000000,55.435500>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.388000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.260000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,60.452000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,60.452000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.720000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.260000,0.000000,56.388000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<46.990000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<46.990000,0.000000,62.484000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,-90.000000,0> translate<46.990000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<46.990000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<46.990000,0.000000,54.356000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,90.000000,0> translate<46.990000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.990000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,59.436000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.355000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<46.990000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,59.944000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.990000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,59.436000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<46.355000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.355000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.990000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.990000,0.000000,58.420000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<46.990000,0.000000,57.023000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<46.990000,0.000000,61.404500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<46.990000,0.000000,55.435500>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,56.388000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.390000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,60.452000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,60.452000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.850000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,60.452000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.850000,0.000000,60.452000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,56.388000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.390000,0.000000,56.388000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.850000,0.000000,56.388000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<71.120000,0.000000,63.500000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<71.120000,0.000000,62.484000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,-90.000000,0> translate<71.120000,0.000000,62.484000> }
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<71.120000,0.000000,53.340000>}
cylinder{<0,0,0><0,0.036000,0>0.381000 translate<71.120000,0.000000,54.356000>}
box{<0,0,-0.381000><1.016000,0.036000,0.381000> rotate<0,90.000000,0> translate<71.120000,0.000000,54.356000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,57.785000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,59.436000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.485000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,59.436000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<71.120000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,59.944000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<71.120000,0.000000,59.944000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,59.436000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<70.485000,0.000000,59.436000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.485000,0.000000,58.420000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.120000,0.000000,58.420000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.755000,0.000000,58.420000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<71.120000,0.000000,58.420000> }
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<71.120000,0.000000,57.023000>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<71.120000,0.000000,61.404500>}
box{<-0.952500,0,-0.381000><0.952500,0.036000,0.381000> rotate<0,-90.000000,0> translate<71.120000,0.000000,55.435500>}
//H1 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<81.915000,0.000000,74.295000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<81.915000,0.000000,74.295000>}
difference{
cylinder{<81.915000,0,74.295000><81.915000,0.036000,74.295000>3.505200 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,74.295000><81.915000,0.135000,74.295000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<81.915000,0,74.295000><81.915000,0.036000,74.295000>0.990600 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,74.295000><81.915000,0.135000,74.295000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<81.915000,0,74.295000><81.915000,0.036000,74.295000>1.701600 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,74.295000><81.915000,0.135000,74.295000>1.498400 translate<0,0.000000,0>}}
//H2 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<12.065000,0.000000,74.295000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<12.065000,0.000000,74.295000>}
difference{
cylinder{<12.065000,0,74.295000><12.065000,0.036000,74.295000>3.505200 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,74.295000><12.065000,0.135000,74.295000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<12.065000,0,74.295000><12.065000,0.036000,74.295000>0.990600 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,74.295000><12.065000,0.135000,74.295000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<12.065000,0,74.295000><12.065000,0.036000,74.295000>1.701600 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,74.295000><12.065000,0.135000,74.295000>1.498400 translate<0,0.000000,0>}}
//H3 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<12.065000,0.000000,32.385000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<12.065000,0.000000,32.385000>}
difference{
cylinder{<12.065000,0,32.385000><12.065000,0.036000,32.385000>3.505200 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,32.385000><12.065000,0.135000,32.385000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<12.065000,0,32.385000><12.065000,0.036000,32.385000>0.990600 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,32.385000><12.065000,0.135000,32.385000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<12.065000,0,32.385000><12.065000,0.036000,32.385000>1.701600 translate<0,0.000000,0>}
cylinder{<12.065000,-0.1,32.385000><12.065000,0.135000,32.385000>1.498400 translate<0,0.000000,0>}}
//H4 silk screen
object{ARC(2.159000,2.489200,180.000000,270.000000,0.036000) translate<81.915000,0.000000,32.385000>}
object{ARC(2.159000,2.489200,0.000000,90.000000,0.036000) translate<81.915000,0.000000,32.385000>}
difference{
cylinder{<81.915000,0,32.385000><81.915000,0.036000,32.385000>3.505200 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,32.385000><81.915000,0.135000,32.385000>3.352800 translate<0,0.000000,0>}}
difference{
cylinder{<81.915000,0,32.385000><81.915000,0.036000,32.385000>0.990600 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,32.385000><81.915000,0.135000,32.385000>0.533400 translate<0,0.000000,0>}}
difference{
cylinder{<81.915000,0,32.385000><81.915000,0.036000,32.385000>1.701600 translate<0,0.000000,0>}
cylinder{<81.915000,-0.1,32.385000><81.915000,0.135000,32.385000>1.498400 translate<0,0.000000,0>}}
//INPUTS silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,73.660000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.940000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.845000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.480000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.845000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,71.120000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.575000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.575000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,71.755000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.940000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<24.765000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.400000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.765000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,73.660000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.400000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<27.305000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.940000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.305000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,71.120000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.035000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.035000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,71.755000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<25.400000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.860000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.860000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<22.860000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.495000,0.000000,71.120000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.495000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,73.660000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<32.385000,0.000000,73.660000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,73.025000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,71.755000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.020000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.020000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<32.385000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,73.660000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,73.025000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.480000,0.000000,73.025000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,71.755000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,71.120000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<30.480000,0.000000,71.755000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,71.120000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.115000,0.000000,71.120000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<29.210000,0.000000,72.390000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<26.670000,0.000000,72.390000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<24.130000,0.000000,72.390000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<31.750000,0.000000,72.390000>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.210000,0.000000,38.735000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<29.210000,0.000000,38.735000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<31.750000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<31.750000,0.000000,40.640000>}
difference{
cylinder{<31.750000,0,40.640000><31.750000,0.036000,40.640000>2.616200 translate<0,0.000000,0>}
cylinder{<31.750000,-0.1,40.640000><31.750000,0.135000,40.640000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.975000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.975000,0.000000,38.735000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.975000,0.000000,38.735000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<56.515000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<56.515000,0.000000,40.640000>}
difference{
cylinder{<56.515000,0,40.640000><56.515000,0.036000,40.640000>2.616200 translate<0,0.000000,0>}
cylinder{<56.515000,-0.1,40.640000><56.515000,0.135000,40.640000>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.010000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.010000,0.000000,38.735000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<80.010000,0.000000,38.735000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<82.550000,0.000000,40.640000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<82.550000,0.000000,40.640000>}
difference{
cylinder{<82.550000,0,40.640000><82.550000,0.036000,40.640000>2.616200 translate<0,0.000000,0>}
cylinder{<82.550000,-0.1,40.640000><82.550000,0.135000,40.640000>2.463800 translate<0,0.000000,0>}}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<41.275000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,75.565000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<37.465000,0.000000,75.565000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<39.370000,0.000000,73.025000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<39.370000,0.000000,73.025000>}
difference{
cylinder{<39.370000,0,73.025000><39.370000,0.036000,73.025000>2.616200 translate<0,0.000000,0>}
cylinder{<39.370000,-0.1,73.025000><39.370000,0.135000,73.025000>2.463800 translate<0,0.000000,0>}}
//POWER silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.240000,0.000000,78.325000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.140000,0.000000,78.325000>}
box{<0,0,-0.101600><22.900000,0.036000,0.101600> rotate<0,0.000000,0> translate<48.240000,0.000000,78.325000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.140000,0.000000,78.325000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.140000,0.000000,72.265000>}
box{<0,0,-0.101600><6.060000,0.036000,0.101600> rotate<0,-90.000000,0> translate<71.140000,0.000000,72.265000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<71.140000,0.000000,72.265000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.140000,0.000000,70.265000>}
box{<0,0,-0.101600><2.828427,0.036000,0.101600> rotate<0,-44.997030,0> translate<69.140000,0.000000,70.265000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<69.140000,0.000000,70.265000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.240000,0.000000,70.265000>}
box{<0,0,-0.101600><18.900000,0.036000,0.101600> rotate<0,0.000000,0> translate<50.240000,0.000000,70.265000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.240000,0.000000,70.265000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.240000,0.000000,72.265000>}
box{<0,0,-0.101600><2.828427,0.036000,0.101600> rotate<0,44.997030,0> translate<48.240000,0.000000,72.265000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.240000,0.000000,72.265000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.240000,0.000000,78.325000>}
box{<0,0,-0.101600><6.060000,0.036000,0.101600> rotate<0,90.000000,0> translate<48.240000,0.000000,78.325000> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.670000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.670000,0.000000,56.261000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<26.670000,0.000000,56.261000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<25.781000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<27.559000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<27.559000,0.000000,62.611000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<25.781000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.781000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.527000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.527000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.813000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<27.686000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.527000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.654000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.654000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<27.686000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.686000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.686000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.527000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.813000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.813000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.559000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.781000,0.000000,62.865000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.781000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.670000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.670000,0.000000,63.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<26.670000,0.000000,63.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<26.670000,0.000000,56.388000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<26.670000,0.000000,62.992000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.435000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.435000,0.000000,55.626000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<51.435000,0.000000,55.626000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<50.546000,0.000000,56.134000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<52.324000,0.000000,56.134000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<52.324000,0.000000,61.976000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<50.546000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,55.880000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,56.515000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.292000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,56.515000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.292000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,56.515000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.578000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,56.515000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<52.451000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,61.595000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<50.292000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.419000,0.000000,56.642000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.419000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,61.595000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.451000,0.000000,61.468000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,56.642000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.451000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,61.595000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.292000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.578000,0.000000,61.595000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.578000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.324000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.546000,0.000000,62.230000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.546000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.435000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.435000,0.000000,62.865000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<51.435000,0.000000,62.865000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<51.435000,0.000000,55.753000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<51.435000,0.000000,62.357000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,56.261000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<74.930000,0.000000,56.261000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<74.041000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<75.819000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<75.819000,0.000000,62.611000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<74.041000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.819000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.041000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.787000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<73.787000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.073000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<75.946000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<73.787000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.914000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.914000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<75.946000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.946000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<75.946000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.787000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.787000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.073000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.073000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.819000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.041000,0.000000,62.865000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.041000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<74.930000,0.000000,63.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<74.930000,0.000000,63.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<74.930000,0.000000,56.388000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<74.930000,0.000000,62.992000>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,55.245000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,55.626000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<54.610000,0.000000,55.626000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.721000,0.000000,56.134000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<55.499000,0.000000,56.134000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<55.499000,0.000000,61.976000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.721000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,55.880000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.721000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,56.515000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.467000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,56.515000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<53.467000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,56.515000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<55.753000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,56.515000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<55.626000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,61.595000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<53.467000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.594000,0.000000,56.642000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.594000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,61.595000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<55.626000,0.000000,61.468000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,61.468000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.626000,0.000000,56.642000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.626000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.467000,0.000000,61.595000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.467000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,61.976000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.753000,0.000000,61.595000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.753000,0.000000,61.595000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.499000,0.000000,62.230000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,62.230000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.721000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,62.484000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<54.610000,0.000000,62.865000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<54.610000,0.000000,62.865000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<54.610000,0.000000,55.753000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<54.610000,0.000000,62.357000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.740000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.740000,0.000000,56.261000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<78.740000,0.000000,56.261000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<77.851000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<79.629000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<79.629000,0.000000,62.611000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<77.851000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.851000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<77.597000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<77.597000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<79.883000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<79.756000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<77.597000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.724000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.724000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<79.756000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.756000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.756000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.597000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<77.597000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.883000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<79.883000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<79.629000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<77.851000,0.000000,62.865000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<77.851000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.740000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<78.740000,0.000000,63.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<78.740000,0.000000,63.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<78.740000,0.000000,56.388000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<78.740000,0.000000,62.992000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.845000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.845000,0.000000,56.261000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<29.845000,0.000000,56.261000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<28.956000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<30.734000,0.000000,56.769000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<30.734000,0.000000,62.611000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<28.956000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.956000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.702000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<28.702000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,57.150000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<30.988000,0.000000,57.150000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,57.277000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,57.150000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<30.861000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<28.702000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.829000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.829000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,62.230000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.861000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.861000,0.000000,57.277000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.861000,0.000000,57.277000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.702000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.702000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,62.611000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.988000,0.000000,62.230000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.988000,0.000000,62.230000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.734000,0.000000,62.865000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.956000,0.000000,62.865000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<28.956000,0.000000,62.865000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.845000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<29.845000,0.000000,63.500000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<29.845000,0.000000,63.500000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.845000,0.000000,56.388000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<29.845000,0.000000,62.992000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.720000,0.000000,76.200000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.720000,0.000000,75.819000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,-90.000000,0> translate<45.720000,0.000000,75.819000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<46.609000,0.000000,75.311000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<44.831000,0.000000,75.311000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<44.831000,0.000000,69.469000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<46.609000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,75.565000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,75.565000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.831000,0.000000,75.565000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,75.311000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,74.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.863000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,74.803000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,74.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.736000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,75.311000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,74.930000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.577000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,74.803000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,74.930000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<44.577000,0.000000,74.930000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,69.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<46.736000,0.000000,69.977000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.736000,0.000000,74.803000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.736000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,69.850000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.577000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,69.977000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.704000,0.000000,74.803000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.704000,0.000000,74.803000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,69.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.863000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,69.469000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.577000,0.000000,69.850000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.577000,0.000000,69.850000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.831000,0.000000,69.215000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,69.215000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.831000,0.000000,69.215000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.720000,0.000000,68.961000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<45.720000,0.000000,68.580000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,-90.000000,0> translate<45.720000,0.000000,68.580000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-270.000000,0> translate<45.720000,0.000000,75.692000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-270.000000,0> translate<45.720000,0.000000,69.088000>}
//T1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.145000,0.000000,47.498000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.272000,0.000000,50.419000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,-87.504672,0> translate<17.145000,0.000000,47.498000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.526000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.272000,0.000000,50.419000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,-44.997030,0> translate<17.272000,0.000000,50.419000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.526000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.924000,0.000000,50.673000>}
box{<0,0,-0.063500><9.398000,0.036000,0.063500> rotate<0,0.000000,0> translate<17.526000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.178000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<26.924000,0.000000,50.673000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,44.997030,0> translate<26.924000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.178000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.305000,0.000000,47.498000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,87.504672,0> translate<27.178000,0.000000,50.419000> }
difference{
cylinder{<26.720800,0,50.063400><26.720800,0.036000,50.063400>0.317500 translate<0,0.000000,0>}
cylinder{<26.720800,-0.1,50.063400><26.720800,0.135000,50.063400>0.190500 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-180.000000,0> translate<22.225000,0.000000,46.736000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<26.606500,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<23.495000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<24.765000,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<20.955000,0.000000,47.371000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<17.843500,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<22.225000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<19.685000,0.000000,47.371000>}
//T2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<41.910000,0.000000,47.498000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,50.419000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,-87.504672,0> translate<41.910000,0.000000,47.498000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.291000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.037000,0.000000,50.419000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,-44.997030,0> translate<42.037000,0.000000,50.419000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<42.291000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<51.689000,0.000000,50.673000>}
box{<0,0,-0.063500><9.398000,0.036000,0.063500> rotate<0,0.000000,0> translate<42.291000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<51.943000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<51.689000,0.000000,50.673000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,44.997030,0> translate<51.689000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<51.943000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<52.070000,0.000000,47.498000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,87.504672,0> translate<51.943000,0.000000,50.419000> }
difference{
cylinder{<51.485800,0,50.063400><51.485800,0.036000,50.063400>0.317500 translate<0,0.000000,0>}
cylinder{<51.485800,-0.1,50.063400><51.485800,0.135000,50.063400>0.190500 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-180.000000,0> translate<46.990000,0.000000,46.736000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<51.371500,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<48.260000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<49.530000,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<45.720000,0.000000,47.371000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<42.608500,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<46.990000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<44.450000,0.000000,47.371000>}
//T3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<66.040000,0.000000,47.498000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<66.167000,0.000000,50.419000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,-87.504672,0> translate<66.040000,0.000000,47.498000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<66.421000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<66.167000,0.000000,50.419000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,-44.997030,0> translate<66.167000,0.000000,50.419000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<66.421000,0.000000,50.673000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.819000,0.000000,50.673000>}
box{<0,0,-0.063500><9.398000,0.036000,0.063500> rotate<0,0.000000,0> translate<66.421000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.073000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.819000,0.000000,50.673000>}
box{<0,0,-0.063500><0.359210,0.036000,0.063500> rotate<0,44.997030,0> translate<75.819000,0.000000,50.673000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.073000,0.000000,50.419000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.200000,0.000000,47.498000>}
box{<0,0,-0.063500><2.923760,0.036000,0.063500> rotate<0,87.504672,0> translate<76.073000,0.000000,50.419000> }
difference{
cylinder{<75.615800,0,50.063400><75.615800,0.036000,50.063400>0.317500 translate<0,0.000000,0>}
cylinder{<75.615800,-0.1,50.063400><75.615800,0.135000,50.063400>0.190500 translate<0,0.000000,0>}}
box{<-5.334000,0,-0.381000><5.334000,0.036000,0.381000> rotate<0,-180.000000,0> translate<71.120000,0.000000,46.736000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<75.501500,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<72.390000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<73.660000,0.000000,47.371000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<69.850000,0.000000,47.371000>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-180.000000,0> translate<66.738500,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<71.120000,0.000000,47.371000>}
box{<-0.889000,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-180.000000,0> translate<68.580000,0.000000,47.371000>}
//X4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.945000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.945000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.215000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<67.945000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<67.945000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.215000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.945000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,36.195000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,44.069000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.835000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,44.577000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<76.835000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,44.069000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.405000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,36.195000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.405000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,42.799000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.040000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,43.053000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<66.040000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,42.799000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.200000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,37.465000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<76.200000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<73.025000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.025000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.295000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.025000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<73.025000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.025000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.295000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<73.025000,0.000000,39.370000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<68.580000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<68.580000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.739000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<71.501000,0.000000,37.465000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<70.739000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.471800,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<66.040000,0.000000,37.465000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<73.660000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<73.660000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<75.768200,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<75.768200,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.040000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.072000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,42.799000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.088000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.152000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.168000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.072000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,44.577000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.088000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<73.152000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.168000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<73.152000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<74.168000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.405000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<65.405000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,44.069000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.342000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<72.898000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<72.898000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<73.152000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<72.898000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<72.898000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,43.053000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<69.342000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.040000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<66.040000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<74.168000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.835000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.422000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<74.422000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.168000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<74.168000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<74.422000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<76.200000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<74.422000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<69.088000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<68.072000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.818000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<69.342000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<69.088000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<67.818000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.818000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.072000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<67.818000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.342000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.088000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.088000,0.000000,42.799000> }
//X5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.815000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<45.085000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,36.195000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,44.069000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.705000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,44.577000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.705000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,44.069000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.275000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,36.195000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.275000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,42.799000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,43.053000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,42.799000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,37.465000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.070000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.895000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.895000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<48.895000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<48.895000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.895000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<48.895000,0.000000,39.370000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<44.450000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<44.450000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.609000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.371000,0.000000,37.465000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.609000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.341800,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,37.465000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<49.530000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<49.530000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.638200,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<51.638200,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,42.799000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.022000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.038000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.942000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,44.577000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<49.022000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.038000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<49.022000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.038000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.275000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.275000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,44.069000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.212000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<48.768000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<48.768000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<49.022000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<48.768000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.768000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,43.053000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.212000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.910000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<50.038000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.705000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.292000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<50.292000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.038000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<50.038000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.070000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.292000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<44.958000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.942000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<43.688000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.212000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<44.958000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<43.688000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.688000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.942000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<43.688000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.212000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<44.958000,0.000000,42.799000> }
//X6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<19.050000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<19.050000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.050000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,36.195000>}
box{<0,0,-0.076200><11.430000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.510000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,44.069000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.940000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,44.577000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<27.940000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,44.069000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.510000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,36.195000>}
box{<0,0,-0.076200><7.874000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.510000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,42.799000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,43.053000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.145000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,42.799000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.305000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,37.465000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.305000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.130000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.130000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.400000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,40.640000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.130000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,39.370000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,44.997030,0> translate<24.130000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.400000,0.000000,40.640000>}
box{<0,0,-0.076200><1.796051,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.130000,0.000000,39.370000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<19.685000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<19.685000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.844000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.606000,0.000000,37.465000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.844000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.576800,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,37.465000> }
object{ARC(2.667000,0.152400,216.869898,270.000000,0.036000) translate<24.765000,0.000000,39.116000>}
object{ARC(2.667000,0.152400,270.000000,323.130102,0.036000) translate<24.765000,0.000000,39.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.873200,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,37.465000>}
box{<0,0,-0.076200><0.431800,0.036000,0.076200> rotate<0,0.000000,0> translate<26.873200,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.177000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,42.799000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.193000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,42.799000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.257000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,42.799000>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.273000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.510000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.177000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,44.577000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.193000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,44.577000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.257000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,44.577000>}
box{<0,0,-0.076200><2.667000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.273000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.257000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.273000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.510000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.510000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,44.069000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.447000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<24.003000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.003000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<24.003000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,43.053000>}
box{<0,0,-0.076200><3.556000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.447000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<25.273000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.940000,0.000000,44.069000>}
box{<0,0,-0.076200><2.413000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.527000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.273000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.527000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.305000,0.000000,43.053000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<25.527000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<20.193000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,44.577000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.177000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.923000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,43.053000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.447000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,44.069000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,63.430762,0> translate<20.193000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,44.069000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,44.577000>}
box{<0,0,-0.076200><0.567961,0.036000,0.076200> rotate<0,-63.430762,0> translate<18.923000,0.000000,44.069000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<18.923000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.447000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,42.799000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.193000,0.000000,42.799000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  PWM_DRIVER(-46.990000,0,-53.340000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
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
//POWER	9090-4V	9090-4V
