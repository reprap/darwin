//POVRay-File created by 3d41.ulp v1.05
///home/hoeken/Desktop/reprap/trunk/reprap/electronics/Arduino/opto_isolator/opto_isolator.brd
//9/2/08 9:29 PM

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
#local cam_y = 168;
#local cam_z = -61;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -2;
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

#local lgt1_pos_x = 20;
#local lgt1_pos_y = 30;
#local lgt1_pos_z = 14;
#local lgt1_intense = 0.720294;
#local lgt2_pos_x = -20;
#local lgt2_pos_y = 30;
#local lgt2_pos_z = 14;
#local lgt2_intense = 0.720294;
#local lgt3_pos_x = 20;
#local lgt3_pos_y = 30;
#local lgt3_pos_z = -9;
#local lgt3_intense = 0.720294;
#local lgt4_pos_x = -20;
#local lgt4_pos_y = 30;
#local lgt4_pos_z = -9;
#local lgt4_intense = 0.720294;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 52.781400;
#declare pcb_y_size = 26.914000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(115);
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
	//translate<-26.390700,0,-13.457000>
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


#macro OPTO_ISOLATOR(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<6.362600,-0.884000><59.144000,-0.884000>
<59.144000,-0.884000><59.144000,26.030000>
<59.144000,26.030000><6.362600,26.030000>
<6.362600,26.030000><6.362600,-0.884000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
cylinder{<9.398000,1,2.032000><9.398000,-5,2.032000>1.400000 texture{col_hls}}
cylinder{<9.398000,1,23.114000><9.398000,-5,23.114000>1.400000 texture{col_hls}}
cylinder{<56.134000,1,2.032000><56.134000,-5,2.032000>1.400000 texture{col_hls}}
cylinder{<56.134000,1,23.114000><56.134000,-5,23.114000>1.400000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<36.322000,0.000000,7.366000>}#end		//ceramic disc capacitator C1 100nF C050-035X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_50MM_76MM("100nF",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<36.322000,0.000000,16.764000>}#end		//ceramic disc capacitator C2 100nF C050-035X075
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP14("74ALS04N","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<43.942000,0.000000,12.192000>translate<0,3.000000,0> }#end		//DIP14 IC1 74ALS04N DIL14
#ifndef(pack_IC1) object{SOCKET_DIP14()rotate<0,-270.000000,0> rotate<0,0,0> translate<43.942000,0.000000,12.192000>}#end					//IC-Sockel 14Pin IC1 74ALS04N
#ifndef(pack_OK1) #declare global_pack_OK1=yes; object {IC_DIS_DIP8("HCPL2630","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,7.620000>translate<0,3.000000,0> }#end		//DIP8 OK1 HCPL2630 DIL08
#ifndef(pack_OK1) object{SOCKET_DIP8()rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,7.620000>}#end					//IC-Sockel 8Pin OK1 HCPL2630
#ifndef(pack_OK2) #declare global_pack_OK2=yes; object {IC_DIS_DIP8("HCPL2630","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,17.780000>translate<0,3.000000,0> }#end		//DIP8 OK2 HCPL2630 DIL08
#ifndef(pack_OK2) object{SOCKET_DIP8()rotate<0,-270.000000,0> rotate<0,0,0> translate<25.400000,0.000000,17.780000>}#end					//IC-Sockel 8Pin OK2 HCPL2630
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_025MMV(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<17.780000,0.000000,10.160000>}#end		//Discrete Resistor 0,25W Vertical 100mil R1 220 0207/2V
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_025MMV(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<17.780000,0.000000,5.080000>}#end		//Discrete Resistor 0,25W Vertical 100mil R2 220 0207/2V
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_025MMV(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<32.766000,0.000000,10.160000>}#end		//Discrete Resistor 0,25W Vertical 100mil R3 3.3K 0207/2V
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_025MMV(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<32.766000,0.000000,4.826000>}#end		//Discrete Resistor 0,25W Vertical 100mil R4 3.3K 0207/2V
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_025MMV(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<17.780000,0.000000,20.320000>}#end		//Discrete Resistor 0,25W Vertical 100mil R5 220 0207/2V
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_025MMV(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<17.780000,0.000000,15.240000>}#end		//Discrete Resistor 0,25W Vertical 100mil R6 220 0207/2V
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_025MMV(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<32.766000,0.000000,20.320000>}#end		//Discrete Resistor 0,25W Vertical 100mil R7 3.3K 0207/2V
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_025MMV(texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<32.766000,0.000000,15.240000>}#end		//Discrete Resistor 0,25W Vertical 100mil R8 3.3K 0207/2V
#ifndef(pack_SV1) #declare global_pack_SV1=yes; object {CON_DIS_WS6G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<54.610000,0.000000,12.446000>}#end		//Shrouded Header 6Pin SV1  ML6
#ifndef(pack_SV2) #declare global_pack_SV2=yes; object {CON_DIS_WS6G()translate<0,0,0> rotate<0,180.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<10.922000,0.000000,12.446000>}#end		//Shrouded Header 6Pin SV2  ML6
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<36.322000,0,9.906000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<36.322000,0,4.826000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<36.322000,0,19.304000> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<36.322000,0,14.224000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,19.812000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,17.272000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,14.732000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,12.192000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,9.652000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,7.112000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<40.132000,0,4.572000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,4.572000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,7.112000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,9.652000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,12.192000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,14.732000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,17.272000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<47.752000,0,19.812000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_OK1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<21.590000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_OK2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<29.210000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.766000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.766000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<32.766000,0,6.096000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<32.766000,0,3.556000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<17.780000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<17.780000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.766000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<32.766000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<32.766000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<32.766000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<53.340000,0,14.986000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<55.880000,0,14.986000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<53.340000,0,12.446000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<55.880000,0,12.446000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<53.340000,0,9.906000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<55.880000,0,9.906000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<12.192000,0,9.906000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<9.652000,0,9.906000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<12.192000,0,12.446000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<9.652000,0,12.446000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<12.192000,0,14.986000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<9.652000,0,14.986000> texture{col_thl}}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,10.160000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<9.652000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,12.700000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<7.620000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,12.700000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<9.652000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,15.240000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<9.652000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<7.620000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,19.050000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<7.620000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,7.620000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<10.160000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<12.700000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.192000,-1.535000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,12.700000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<12.192000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.192000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,15.240000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<12.192000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,17.780000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<10.160000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,8.890000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<12.700000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,-1.535000,6.350000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<12.700000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,8.890000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,16.510000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,19.050000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,11.430000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<19.050000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<19.050000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,3.810000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,6.350000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.590000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.050000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,8.890000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,44.997030,0> translate<19.050000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,11.430000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,13.970000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,16.510000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<21.590000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.700000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,17.780000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.700000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,19.050000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<21.590000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.780000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<21.590000,0.000000,21.590000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.780000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,15.240000>}
box{<0,0,-0.127000><11.430000,0.035000,0.127000> rotate<0,90.000000,0> translate<26.670000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,2.540000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<26.670000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<26.670000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,16.510000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<27.940000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,3.810000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<30.480000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,5.080000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,8.890000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<30.480000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,11.430000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,90.000000,0> translate<31.750000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<30.480000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,15.240000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<30.480000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,8.890000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,11.430000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,16.510000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,19.050000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,21.590000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,6.350000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<29.210000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,6.350000>}
box{<0,0,-0.127000><0.359210,0.035000,0.127000> rotate<0,-44.997030,0> translate<32.766000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,8.890000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,11.430000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,11.430000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<33.020000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,13.970000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,13.970000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,16.510000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,19.050000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,21.590000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,7.620000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<33.020000,0.000000,6.350000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<34.290000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,11.430000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<31.750000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,15.240000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<34.290000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,15.240000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<31.750000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,5.080000>}
box{<0,0,-0.127000><5.080000,0.035000,0.127000> rotate<0,0.000000,0> translate<31.750000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,5.080000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<36.322000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,5.080000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<36.322000,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,0.000000,3.556000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,7.620000>}
box{<0,0,-0.127000><5.747364,0.035000,0.127000> rotate<0,-44.997030,0> translate<32.766000,0.000000,3.556000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,10.160000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,10.160000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<36.322000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,-1.535000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,10.160000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,-26.563298,0> translate<36.322000,-1.535000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,10.160000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<36.830000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.560000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,13.970000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<35.560000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,13.970000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,26.563298,0> translate<36.322000,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<29.210000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,19.050000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,-44.997030,0> translate<29.210000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,0.000000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,19.050000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,26.563298,0> translate<36.322000,0.000000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.322000,-1.535000,19.304000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,19.050000>}
box{<0,0,-0.127000><0.567961,0.035000,0.127000> rotate<0,26.563298,0> translate<36.322000,-1.535000,19.304000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<33.020000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,13.970000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<33.020000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,13.970000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<38.100000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<38.100000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,10.160000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<38.100000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.240000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.290000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.290000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,20.320000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<34.290000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<32.766000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,21.590000>}
box{<0,0,-0.127000><6.604000,0.035000,0.127000> rotate<0,0.000000,0> translate<32.766000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,21.590000>}
box{<0,0,-0.127000><3.592102,0.035000,0.127000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,-1.535000,9.652000>}
box{<0,0,-0.127000><0.915810,0.035000,0.127000> rotate<0,33.687844,0> translate<39.370000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,0.000000,14.732000>}
box{<0,0,-0.127000><0.915810,0.035000,0.127000> rotate<0,33.687844,0> translate<39.370000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,0.000000,19.812000>}
box{<0,0,-0.127000><0.915810,0.035000,0.127000> rotate<0,33.687844,0> translate<39.370000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<36.830000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,1.270000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<36.830000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,0.000000,7.112000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,7.620000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.132000,0.000000,7.112000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,0.000000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,17.780000>}
box{<0,0,-0.127000><0.718420,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.132000,0.000000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<39.370000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,22.860000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<39.370000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<27.940000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,2.540000>}
box{<0,0,-0.127000><13.970000,0.035000,0.127000> rotate<0,0.000000,0> translate<27.940000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,0.000000,17.780000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,0.000000,2.540000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<40.640000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.132000,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,17.780000>}
box{<0,0,-0.127000><7.902625,0.035000,0.127000> rotate<0,-44.997030,0> translate<40.132000,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,20.320000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<45.720000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<41.910000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,7.620000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,-44.997030,0> translate<41.910000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<43.180000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,21.590000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,-44.997030,0> translate<43.180000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,21.590000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.752000,-1.535000,7.112000>}
box{<0,0,-0.127000><0.915810,0.035000,0.127000> rotate<0,33.687844,0> translate<46.990000,-1.535000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,1.270000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.720000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,2.540000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.720000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,21.590000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.640000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,22.860000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.640000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,0.000000,21.590000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,13.970000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<52.070000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,17.780000>}
box{<0,0,-0.127000><5.388154,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,0.000000,9.906000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.340000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.752000,0.000000,4.572000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,0.000000,10.160000>}
box{<0,0,-0.127000><7.902625,0.035000,0.127000> rotate<0,-44.997030,0> translate<47.752000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,12.446000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.340000,-1.535000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<52.070000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,12.700000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<52.070000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,14.986000>}
box{<0,0,-0.127000><2.794000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.340000,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.340000,-1.535000,17.780000>}
box{<0,0,-0.127000><7.184205,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,8.890000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,-44.997030,0> translate<48.260000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,11.430000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<54.610000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,8.890000>}
box{<0,0,-0.127000><10.776307,0.035000,0.127000> rotate<0,-44.997030,0> translate<48.260000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,9.906000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<55.880000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,10.160000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<55.880000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,12.446000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<55.880000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,12.700000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,-44.997030,0> translate<54.610000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,14.986000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<55.880000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.530000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<55.880000,0.000000,15.240000>}
box{<0,0,-0.127000><8.980256,0.035000,0.127000> rotate<0,44.997030,0> translate<49.530000,0.000000,21.590000> }
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
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,5.273500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,14.524000>}
box{<0,0,-0.203200><9.250500,0.035000,0.203200> rotate<0,90.000000,0> translate<7.581700,0.000000,14.524000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,5.273500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,19.872400>}
box{<0,0,-0.203200><14.598900,0.035000,0.203200> rotate<0,90.000000,0> translate<7.581700,-1.535000,19.872400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,5.273500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,0.000000,5.607100>}
box{<0,0,-0.203200><0.734704,0.035000,0.203200> rotate<0,-27.002709,0> translate<7.581700,0.000000,5.273500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,5.273500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,-1.535000,5.607100>}
box{<0,0,-0.203200><0.734704,0.035000,0.203200> rotate<0,-27.002709,0> translate<7.581700,-1.535000,5.273500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.600800,0.000000,5.283200>}
box{<0,0,-0.203200><0.019100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.600800,-1.535000,5.283200>}
box{<0,0,-0.203200><0.019100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.757200,0.000000,5.689600>}
box{<0,0,-0.203200><1.175500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.757200,-1.535000,5.689600>}
box{<0,0,-0.203200><1.175500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,6.096000>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,6.096000>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,6.502400>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,6.502400>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.466800,-1.535000,6.908800>}
box{<0,0,-0.203200><8.885100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830200,0.000000,6.908800>}
box{<0,0,-0.203200><9.248500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.250400,0.000000,7.315200>}
box{<0,0,-0.203200><4.668700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.060400,-1.535000,7.315200>}
box{<0,0,-0.203200><8.478700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.844000,0.000000,7.721600>}
box{<0,0,-0.203200><4.262300,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.654000,-1.535000,7.721600>}
box{<0,0,-0.203200><8.072300,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.437600,0.000000,8.128000>}
box{<0,0,-0.203200><3.855900,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.247600,-1.535000,8.128000>}
box{<0,0,-0.203200><7.665900,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.031200,0.000000,8.534400>}
box{<0,0,-0.203200><3.449500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.841200,-1.535000,8.534400>}
box{<0,0,-0.203200><7.259500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.036700,0.000000,8.940800>}
box{<0,0,-0.203200><1.455000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.036700,-1.535000,8.940800>}
box{<0,0,-0.203200><1.455000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.630300,0.000000,9.347200>}
box{<0,0,-0.203200><1.048600,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.630300,-1.535000,9.347200>}
box{<0,0,-0.203200><1.048600,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,9.753600>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,9.753600>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,10.160000>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,10.160000>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.732000,0.000000,10.566400>}
box{<0,0,-0.203200><1.150300,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.732000,-1.535000,10.566400>}
box{<0,0,-0.203200><1.150300,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.138400,0.000000,10.972800>}
box{<0,0,-0.203200><1.556700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.138400,-1.535000,10.972800>}
box{<0,0,-0.203200><1.556700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.138300,0.000000,11.379200>}
box{<0,0,-0.203200><1.556600,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.138300,-1.535000,11.379200>}
box{<0,0,-0.203200><1.556600,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.731900,0.000000,11.785600>}
box{<0,0,-0.203200><1.150200,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.731900,-1.535000,11.785600>}
box{<0,0,-0.203200><1.150200,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,12.192000>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,12.192000>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,12.598400>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,12.598400>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.630400,-1.535000,13.004800>}
box{<0,0,-0.203200><1.048700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.630500,0.000000,13.004800>}
box{<0,0,-0.203200><1.048800,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.694500,0.000000,13.411200>}
box{<0,0,-0.203200><1.112800,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.036800,-1.535000,13.411200>}
box{<0,0,-0.203200><1.455100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.288100,0.000000,13.817600>}
box{<0,0,-0.203200><0.706400,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,13.817600>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.881700,0.000000,14.224000>}
box{<0,0,-0.203200><0.300000,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.833500,-1.535000,14.224000>}
box{<0,0,-0.203200><1.251800,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,14.524000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.865700,0.000000,13.240000>}
box{<0,0,-0.203200><1.815850,0.035000,0.203200> rotate<0,44.997030,0> translate<7.581700,0.000000,14.524000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,14.630400>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,15.036800>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,15.443200>}
box{<0,0,-0.203200><0.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.935200,-1.535000,15.849600>}
box{<0,0,-0.203200><1.353500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,15.955900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,19.872400>}
box{<0,0,-0.203200><3.916500,0.035000,0.203200> rotate<0,90.000000,0> translate<7.581700,0.000000,19.872400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,15.955900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.209000,0.000000,19.583300>}
box{<0,0,-0.203200><5.129848,0.035000,0.203200> rotate<0,-44.997820,0> translate<7.581700,0.000000,15.955900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.881800,0.000000,16.256000>}
box{<0,0,-0.203200><0.300100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.256000>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.288200,0.000000,16.662400>}
box{<0,0,-0.203200><0.706500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.662400>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.694600,0.000000,17.068800>}
box{<0,0,-0.203200><1.112900,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830200,-1.535000,17.068800>}
box{<0,0,-0.203200><9.248500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.101000,0.000000,17.475200>}
box{<0,0,-0.203200><1.519300,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236600,-1.535000,17.475200>}
box{<0,0,-0.203200><9.654900,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.507400,0.000000,17.881600>}
box{<0,0,-0.203200><1.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.434100,-1.535000,17.881600>}
box{<0,0,-0.203200><25.852400,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.913800,0.000000,18.288000>}
box{<0,0,-0.203200><2.332100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033300,-1.535000,18.288000>}
box{<0,0,-0.203200><9.451600,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.320200,0.000000,18.694400>}
box{<0,0,-0.203200><2.738500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,18.694400>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.726600,0.000000,19.100800>}
box{<0,0,-0.203200><3.144900,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,19.100800>}
box{<0,0,-0.203200><9.131500,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.435800,0.000000,19.507200>}
box{<0,0,-0.203200><0.854100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.435800,-1.535000,19.507200>}
box{<0,0,-0.203200><0.854100,0.035000,0.203200> rotate<0,0.000000,0> translate<7.581700,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,0.000000,19.872400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,0.000000,19.538800>}
box{<0,0,-0.203200><0.734704,0.035000,0.203200> rotate<0,27.002709,0> translate<7.581700,0.000000,19.872400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.581700,-1.535000,19.872400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,-1.535000,19.538800>}
box{<0,0,-0.203200><0.734704,0.035000,0.203200> rotate<0,27.002709,0> translate<7.581700,-1.535000,19.872400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,0.000000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.236300,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,-1.535000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.236300,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,0.000000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.236300,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236300,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,-1.535000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.236300,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,0.000000,5.791100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<8.236400,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,-1.535000,5.791100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<8.236400,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,0.000000,19.354800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<8.236400,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.236400,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,-1.535000,19.354800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<8.236400,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,8.788400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<8.534400,0.000000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<8.534400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,9.443100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.534400,0.000000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.534400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.534400,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.534400,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<8.534400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<8.534400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.534400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.534400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.865700,0.000000,13.240000>}
box{<0,0,-0.203200><0.468458,0.035000,0.203200> rotate<0,-44.988382,0> translate<8.534400,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.534400,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<8.534400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<8.534400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.534400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.534400,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,8.788400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,0.000000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.189100,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.189100,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,0.000000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,0.000000,5.791100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.397900,0.000000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,-1.535000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,-1.535000,5.791100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.397900,-1.535000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,0.000000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,0.000000,19.354800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.397900,0.000000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.397900,-1.535000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,-1.535000,19.354800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.397900,-1.535000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,0.000000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,0.000000,5.607100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<9.398000,0.000000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,-1.535000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,-1.535000,5.607100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<9.398000,-1.535000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,0.000000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,0.000000,19.538800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<9.398000,0.000000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.398000,-1.535000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,-1.535000,19.538800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<9.398000,-1.535000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.745700,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.050600,0.000000,13.563500>}
box{<0,0,-0.203200><0.431194,0.035000,0.203200> rotate<0,44.997030,0> translate<9.745700,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.745700,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,13.868400>}
box{<0,0,-0.203200><0.369100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.745700,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.796500,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,13.817600>}
box{<0,0,-0.203200><6.916700,0.035000,0.203200> rotate<0,0.000000,0> translate<9.796500,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.038800,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931700,0.000000,5.689600>}
box{<0,0,-0.203200><6.892900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.038800,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.038800,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931700,-1.535000,5.689600>}
box{<0,0,-0.203200><6.892900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.038800,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.050600,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,13.563500>}
box{<0,0,-0.203200><0.064200,0.035000,0.203200> rotate<0,0.000000,0> translate<10.050600,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.446000,0.000000,9.119700>}
box{<0,0,-0.203200><0.468458,0.035000,0.203200> rotate<0,-45.005678,0> translate<10.114800,0.000000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.114800,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<10.114800,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<10.114800,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.114800,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.114800,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<10.114800,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<10.114800,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.114800,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.114800,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.114800,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<10.114800,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.165500,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.678400,0.000000,10.972800>}
box{<0,0,-0.203200><1.512900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.165500,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.165500,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.678400,-1.535000,10.972800>}
box{<0,0,-0.203200><1.512900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.165500,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.165600,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.678300,0.000000,11.379200>}
box{<0,0,-0.203200><1.512700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.165600,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.165600,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.678300,-1.535000,11.379200>}
box{<0,0,-0.203200><1.512700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.165600,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.267100,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.624800,0.000000,8.940800>}
box{<0,0,-0.203200><0.357700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.267100,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.267100,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.576800,0.000000,13.411200>}
box{<0,0,-0.203200><1.309700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.267100,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.267100,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.576800,-1.535000,13.411200>}
box{<0,0,-0.203200><1.309700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.267100,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.267200,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.576700,-1.535000,8.940800>}
box{<0,0,-0.203200><1.309500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.267200,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.360000,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.133000,0.000000,19.507200>}
box{<0,0,-0.203200><0.773000,0.035000,0.203200> rotate<0,0.000000,0> translate<10.360000,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.360000,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728600,-1.535000,19.507200>}
box{<0,0,-0.203200><6.368600,0.035000,0.203200> rotate<0,0.000000,0> translate<10.360000,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.368700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.475200,-1.535000,15.849600>}
box{<0,0,-0.203200><1.106500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.368700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.446000,0.000000,9.119700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.479000,0.000000,7.086600>}
box{<0,0,-0.203200><2.875167,0.035000,0.203200> rotate<0,44.998439,0> translate<10.446000,0.000000,9.119700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.470400,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.373500,0.000000,14.224000>}
box{<0,0,-0.203200><0.903100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.470400,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.470400,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.373500,-1.535000,14.224000>}
box{<0,0,-0.203200><0.903100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.470400,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,0.000000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.559500,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,-1.535000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.559500,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,0.000000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.559500,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559500,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,-1.535000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.559500,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,0.000000,5.073200>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,26.999053,0> translate<10.559600,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,-1.535000,5.073200>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,26.999053,0> translate<10.559600,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,0.000000,20.072700>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-26.999053,0> translate<10.559600,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.559600,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,-1.535000,20.072700>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-26.999053,0> translate<10.559600,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.571900,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.272000,0.000000,10.566400>}
box{<0,0,-0.203200><0.700100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.571900,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.571900,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.272000,-1.535000,10.566400>}
box{<0,0,-0.203200><0.700100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.571900,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.572000,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.271900,0.000000,11.785600>}
box{<0,0,-0.203200><0.699900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.572000,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.572000,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.271900,-1.535000,11.785600>}
box{<0,0,-0.203200><0.699900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.572000,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.673500,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.170400,0.000000,13.004800>}
box{<0,0,-0.203200><0.496900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.673500,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.673500,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.170400,-1.535000,13.004800>}
box{<0,0,-0.203200><0.496900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.673500,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.673600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.170300,-1.535000,9.347200>}
box{<0,0,-0.203200><0.496700,0.035000,0.203200> rotate<0,0.000000,0> translate<10.673600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,9.753600>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,10.160000>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,10.304700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,10.368800>}
box{<0,0,-0.203200><0.064100,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,10.304700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,9.999700>}
box{<0,0,-0.203200><0.431264,0.035000,0.203200> rotate<0,45.006424,0> translate<10.769500,0.000000,10.304700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,12.192000>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,12.192000>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,12.598400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,12.598400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,15.095200>}
box{<0,0,-0.203200><0.572100,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,0.000000,15.095200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<10.769500,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,14.630400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,14.630400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,15.036800>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,15.036800>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,0.000000,15.095200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,15.400200>}
box{<0,0,-0.203200><0.431264,0.035000,0.203200> rotate<0,-45.006424,0> translate<10.769500,0.000000,15.095200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.769500,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,15.443200>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<10.769500,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.914200,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,10.160000>}
box{<0,0,-0.203200><0.160200,0.035000,0.203200> rotate<0,0.000000,0> translate<10.914200,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<11.074400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,9.999700>}
box{<0,0,-0.203200><0.369100,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,0.000000,9.999700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.074400,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.074400,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<11.074400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<11.074400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.074400,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.074400,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<11.074400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<11.074400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,15.400200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,0.000000,14.523100>}
box{<0,0,-0.203200><0.877100,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.074400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.074400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.074400,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.195300,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,5.283200>}
box{<0,0,-0.203200><6.142800,0.035000,0.203200> rotate<0,0.000000,0> translate<11.195300,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.195300,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,5.283200>}
box{<0,0,-0.203200><6.142800,0.035000,0.203200> rotate<0,0.000000,0> translate<11.195300,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.209000,0.000000,19.583300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.650900,0.000000,19.583300>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<11.209000,0.000000,19.583300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.295100,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.135000,0.000000,19.913600>}
box{<0,0,-0.203200><5.839900,0.035000,0.203200> rotate<0,0.000000,0> translate<11.295100,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.295100,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.135000,-1.535000,19.913600>}
box{<0,0,-0.203200><5.839900,0.035000,0.203200> rotate<0,0.000000,0> translate<11.295100,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,0.000000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,0.000000,5.073200>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<11.607400,0.000000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,-1.535000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,-1.535000,5.073200>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<11.607400,-1.535000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,0.000000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,0.000000,20.072700>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<11.607400,0.000000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607400,-1.535000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,-1.535000,20.072700>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<11.607400,-1.535000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,0.000000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,4.241500>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,44.997030,0> translate<11.607500,0.000000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,-1.535000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,4.241500>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,44.997030,0> translate<11.607500,-1.535000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,0.000000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,20.904400>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.607500,0.000000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.607500,-1.535000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,20.904400>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,-44.997030,0> translate<11.607500,-1.535000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.650900,0.000000,19.583300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804700,0.000000,19.583300>}
box{<0,0,-0.203200><5.153800,0.035000,0.203200> rotate<0,0.000000,0> translate<11.650900,0.000000,19.583300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.352200,-1.535000,11.023500>}
box{<0,0,-0.203200><0.623100,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.166600,-1.535000,11.328400>}
box{<0,0,-0.203200><0.437500,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.729100,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.729100,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.803900,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,4.876800>}
box{<0,0,-0.203200><14.332700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.803900,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.803900,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.332600,0.000000,4.876800>}
box{<0,0,-0.203200><21.528700,0.035000,0.203200> rotate<0,0.000000,0> translate<11.803900,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.854800,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.829400,0.000000,20.320000>}
box{<0,0,-0.203200><23.974600,0.035000,0.203200> rotate<0,0.000000,0> translate<11.854800,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.854800,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.829400,-1.535000,20.320000>}
box{<0,0,-0.203200><23.974600,0.035000,0.203200> rotate<0,0.000000,0> translate<11.854800,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.166600,-1.535000,11.209000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.352200,-1.535000,11.023500>}
box{<0,0,-0.203200><0.262407,0.035000,0.203200> rotate<0,44.981592,0> translate<12.166600,-1.535000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.166600,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.166600,-1.535000,11.209000>}
box{<0,0,-0.203200><0.119400,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.166600,-1.535000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.210300,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931800,0.000000,4.470400>}
box{<0,0,-0.203200><4.721500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.210300,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.210300,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931800,-1.535000,4.470400>}
box{<0,0,-0.203200><4.721500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.210300,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.261200,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.134900,0.000000,20.726400>}
box{<0,0,-0.203200><4.873700,0.035000,0.203200> rotate<0,0.000000,0> translate<12.261200,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.261200,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.134900,-1.535000,20.726400>}
box{<0,0,-0.203200><4.873700,0.035000,0.203200> rotate<0,0.000000,0> translate<12.261200,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.285700,0.000000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,8.788400>}
box{<0,0,-0.203200><0.369100,0.035000,0.203200> rotate<0,0.000000,0> translate<12.285700,0.000000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.285700,0.000000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,0.000000,8.374200>}
box{<0,0,-0.203200><0.585838,0.035000,0.203200> rotate<0,44.990115,0> translate<12.285700,0.000000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,4.241400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,4.241500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.439200,0.000000,4.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,4.241400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,4.241500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.439200,-1.535000,4.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,4.241400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,3.193600>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,62.995007,0> translate<12.439200,0.000000,4.241400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,4.241400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,3.193600>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,62.995007,0> translate<12.439200,-1.535000,4.241400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,20.904400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,20.904500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.439200,0.000000,20.904500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,20.904400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,20.904500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.439200,-1.535000,20.904500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,0.000000,20.904500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,21.952300>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-62.995007,0> translate<12.439200,0.000000,20.904500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.439200,-1.535000,20.904500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,21.952300>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-62.995007,0> translate<12.439200,-1.535000,20.904500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.479000,0.000000,7.086600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.920900,0.000000,7.086600>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<12.479000,0.000000,7.086600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.529600,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,4.064000>}
box{<0,0,-0.203200><4.183600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.529600,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.529600,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,4.064000>}
box{<0,0,-0.203200><4.183600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.529600,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.539800,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.860200,0.000000,8.534400>}
box{<0,0,-0.203200><0.320400,0.035000,0.203200> rotate<0,0.000000,0> translate<12.539800,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.555500,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728500,0.000000,21.132800>}
box{<0,0,-0.203200><4.173000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.555500,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.555500,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728500,-1.535000,21.132800>}
box{<0,0,-0.203200><4.173000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.555500,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,9.443100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.654800,0.000000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.654800,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<12.654800,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.654800,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<12.654800,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<12.654800,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.654800,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.654800,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.654800,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<12.654800,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700000,0.000000,8.374200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.749000,0.000000,9.423300>}
box{<0,0,-0.203200><1.483581,0.035000,0.203200> rotate<0,-44.999761,0> translate<12.700000,0.000000,8.374200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,0.000000,0.335100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,0.870300>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,-62.987176,0> translate<12.700300,0.000000,0.335100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,-1.535000,0.335100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,0.870300>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,-62.987176,0> translate<12.700300,-1.535000,0.335100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,0.000000,0.335100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,0.000000,0.335100>}
box{<0,0,-0.203200><40.131300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700300,0.000000,0.335100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,-1.535000,0.335100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,-1.535000,0.335100>}
box{<0,0,-0.203200><40.131300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700300,-1.535000,0.335100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,0.000000,24.810800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,24.275600>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,62.987176,0> translate<12.700300,0.000000,24.810800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,-1.535000,24.810800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,24.275600>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,62.987176,0> translate<12.700300,-1.535000,24.810800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,0.000000,24.810800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,0.000000,24.810800>}
box{<0,0,-0.203200><40.131300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700300,0.000000,24.810800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.700300,-1.535000,24.810800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,-1.535000,24.810800>}
box{<0,0,-0.203200><40.131300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.700300,-1.535000,24.810800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.705500,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728500,0.000000,10.972800>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.705500,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.705600,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,11.379200>}
box{<0,0,-0.203200><4.007600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.705600,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.710700,0.000000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.821300,0.000000,24.790400>}
box{<0,0,-0.203200><40.110600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.710700,0.000000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.710700,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.821300,-1.535000,24.790400>}
box{<0,0,-0.203200><40.110600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.710700,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.736600,0.000000,0.406400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.795200,0.000000,0.406400>}
box{<0,0,-0.203200><40.058600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.736600,0.000000,0.406400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.736600,-1.535000,0.406400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.795200,-1.535000,0.406400>}
box{<0,0,-0.203200><40.058600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.736600,-1.535000,0.406400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.736700,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,3.657600>}
box{<0,0,-0.203200><3.976500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.736700,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.736700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,3.657600>}
box{<0,0,-0.203200><3.976500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.736700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.762600,0.000000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,21.539200>}
box{<0,0,-0.203200><3.950600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.762600,0.000000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.762600,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,21.539200>}
box{<0,0,-0.203200><3.950600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.762600,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.807100,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830100,0.000000,13.411200>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.807100,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.807100,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830100,-1.535000,13.411200>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.807100,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.807200,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.266600,0.000000,8.940800>}
box{<0,0,-0.203200><0.459400,0.035000,0.203200> rotate<0,0.000000,0> translate<12.807200,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.807200,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.434800,-1.535000,8.940800>}
box{<0,0,-0.203200><1.627600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.807200,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.908700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931700,-1.535000,15.849600>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<12.908700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.917900,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.614200,0.000000,24.384000>}
box{<0,0,-0.203200><39.696300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.917900,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.917900,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.614200,-1.535000,24.384000>}
box{<0,0,-0.203200><39.696300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.917900,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.920900,0.000000,7.086600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,0.000000,7.399000>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.920900,0.000000,7.086600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.943700,0.000000,0.812800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.342800,0.000000,0.812800>}
box{<0,0,-0.203200><27.399100,0.035000,0.203200> rotate<0,0.000000,0> translate<12.943700,0.000000,0.812800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.943700,-1.535000,0.812800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.588100,-1.535000,0.812800>}
box{<0,0,-0.203200><39.644400,0.035000,0.203200> rotate<0,0.000000,0> translate<12.943700,-1.535000,0.812800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.943800,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830100,0.000000,3.251200>}
box{<0,0,-0.203200><3.886300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.943800,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.943800,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.830100,-1.535000,3.251200>}
box{<0,0,-0.203200><3.886300,0.035000,0.203200> rotate<0,0.000000,0> translate<12.943800,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.969600,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,21.945600>}
box{<0,0,-0.203200><3.743600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.969600,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.969600,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,21.945600>}
box{<0,0,-0.203200><3.743600,0.035000,0.203200> rotate<0,0.000000,0> translate<12.969600,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,0.870300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,0.870400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,0.000000,0.870400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,0.870300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,0.870400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,-1.535000,0.870400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,0.870400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,0.000000,2.032000>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<12.973100,0.000000,0.870400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,0.870400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,-1.535000,2.032000>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<12.973100,-1.535000,0.870400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,3.193500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,3.193600>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,0.000000,3.193600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,3.193500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,3.193600>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,-1.535000,3.193600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,3.193500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,0.000000,2.032000>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<12.973100,0.000000,3.193500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,3.193500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,-1.535000,2.032000>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<12.973100,-1.535000,3.193500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,21.952300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,21.952400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,0.000000,21.952400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,21.952300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,21.952400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<12.973100,-1.535000,21.952400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,21.952400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,0.000000,23.114000>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<12.973100,0.000000,21.952400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,21.952400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,-1.535000,23.114000>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<12.973100,-1.535000,21.952400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,0.000000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157000,0.000000,23.114000>}
box{<0,0,-0.203200><1.176067,0.035000,0.203200> rotate<0,80.998473,0> translate<12.973100,0.000000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.973100,-1.535000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157000,-1.535000,23.114000>}
box{<0,0,-0.203200><1.176067,0.035000,0.203200> rotate<0,80.998473,0> translate<12.973100,-1.535000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.010400,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,14.224000>}
box{<0,0,-0.203200><3.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<13.010400,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.010400,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,14.224000>}
box{<0,0,-0.203200><3.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<13.010400,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.020300,0.000000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.511600,0.000000,23.977600>}
box{<0,0,-0.203200><39.491300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.020300,0.000000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.020300,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.511600,-1.535000,23.977600>}
box{<0,0,-0.203200><39.491300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.020300,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.028300,0.000000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.936400,0.000000,1.219200>}
box{<0,0,-0.203200><26.908100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.028300,0.000000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.028300,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.503500,-1.535000,1.219200>}
box{<0,0,-0.203200><39.475200,0.035000,0.203200> rotate<0,0.000000,0> translate<13.028300,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.028400,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236500,0.000000,2.844800>}
box{<0,0,-0.203200><4.208100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.028400,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.028400,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236500,-1.535000,2.844800>}
box{<0,0,-0.203200><4.208100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.028400,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.036300,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033400,0.000000,22.352000>}
box{<0,0,-0.203200><3.997100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.036300,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.036300,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033400,-1.535000,22.352000>}
box{<0,0,-0.203200><3.997100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.036300,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.084700,0.000000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.447300,0.000000,23.571200>}
box{<0,0,-0.203200><39.362600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.084700,0.000000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.084700,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.447300,-1.535000,23.571200>}
box{<0,0,-0.203200><39.362600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.084700,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.092700,0.000000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.530000,0.000000,1.625600>}
box{<0,0,-0.203200><26.437300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.092700,0.000000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.092700,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.439100,-1.535000,1.625600>}
box{<0,0,-0.203200><39.346400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.092700,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.092800,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.287200,-1.535000,2.438400>}
box{<0,0,-0.203200><14.194400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.092800,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.092800,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.717200,0.000000,2.438400>}
box{<0,0,-0.203200><25.624400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.092800,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.100700,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.784100,-1.535000,22.758400>}
box{<0,0,-0.203200><26.683400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.100700,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.100700,0.000000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.431100,0.000000,22.758400>}
box{<0,0,-0.203200><39.330400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.100700,0.000000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.111900,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.134900,0.000000,10.566400>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.111900,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.112000,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,11.785600>}
box{<0,0,-0.203200><3.601200,0.035000,0.203200> rotate<0,0.000000,0> translate<13.112000,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.149000,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.190500,-1.535000,23.164800>}
box{<0,0,-0.203200><27.041500,0.035000,0.203200> rotate<0,0.000000,0> translate<13.149000,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.149000,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.382900,0.000000,23.164800>}
box{<0,0,-0.203200><39.233900,0.035000,0.203200> rotate<0,0.000000,0> translate<13.149000,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.149500,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236600,0.000000,7.315200>}
box{<0,0,-0.203200><4.087100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.149500,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157000,0.000000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,0.000000,23.114000>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.157000,0.000000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157000,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,-1.535000,23.114000>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.157000,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.693600,-1.535000,2.032000>}
box{<0,0,-0.203200><14.536500,0.035000,0.203200> rotate<0,0.000000,0> translate<13.157100,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.157100,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.123600,0.000000,2.032000>}
box{<0,0,-0.203200><25.966500,0.035000,0.203200> rotate<0,0.000000,0> translate<13.157100,0.000000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.213500,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236500,0.000000,13.004800>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.213500,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.213500,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.236500,-1.535000,13.004800>}
box{<0,0,-0.203200><4.023000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.213500,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.213600,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.673000,0.000000,9.347200>}
box{<0,0,-0.203200><0.459400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.213600,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.213600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.028400,-1.535000,9.347200>}
box{<0,0,-0.203200><0.814800,0.035000,0.203200> rotate<0,0.000000,0> translate<13.213600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,0.000000,7.399000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,8.356600>}
box{<0,0,-0.203200><1.354251,0.035000,0.203200> rotate<0,-44.997030,0> translate<13.233300,0.000000,7.399000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,-1.535000,11.650900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,-1.535000,11.907000>}
box{<0,0,-0.203200><0.256100,0.035000,0.203200> rotate<0,90.000000,0> translate<13.233300,-1.535000,11.907000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,-1.535000,11.650900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.467500,-1.535000,7.416700>}
box{<0,0,-0.203200><5.988063,0.035000,0.203200> rotate<0,44.997030,0> translate<13.233300,-1.535000,11.650900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,11.785600>}
box{<0,0,-0.203200><3.479900,0.035000,0.203200> rotate<0,0.000000,0> translate<13.233300,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.233300,-1.535000,11.907000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,11.983100>}
box{<0,0,-0.203200><0.107692,0.035000,0.203200> rotate<0,-44.959412,0> translate<13.233300,-1.535000,11.907000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,10.066200>}
box{<0,0,-0.203200><0.623100,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,-1.535000,10.066200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,10.368800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.622000,-1.535000,9.753600>}
box{<0,0,-0.203200><0.312500,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.135100,0.000000,9.753600>}
box{<0,0,-0.203200><3.825600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,10.066200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,6.662400>}
box{<0,0,-0.203200><4.813629,0.035000,0.203200> rotate<0,44.997872,0> translate<13.309500,-1.535000,10.066200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.265800,0.000000,10.160000>}
box{<0,0,-0.203200><18.956300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033400,0.000000,12.192000>}
box{<0,0,-0.203200><3.723900,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033400,-1.535000,12.192000>}
box{<0,0,-0.203200><3.723900,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,12.598400>}
box{<0,0,-0.203200><5.207100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.624200,0.000000,12.598400>}
box{<0,0,-0.203200><16.314700,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,15.095300>}
box{<0,0,-0.203200><0.572200,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,0.000000,15.095300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<13.309500,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931800,0.000000,14.630400>}
box{<0,0,-0.203200><3.622300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931800,-1.535000,14.630400>}
box{<0,0,-0.203200><3.622300,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.036800>}
box{<0,0,-0.203200><5.207100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.062600,0.000000,15.036800>}
box{<0,0,-0.203200><18.753100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,0.000000,15.095300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,15.976600>}
box{<0,0,-0.203200><1.246417,0.035000,0.203200> rotate<0,-44.993780,0> translate<13.309500,0.000000,15.095300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.309500,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,15.443200>}
box{<0,0,-0.203200><4.028600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.309500,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.505000,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,11.379200>}
box{<0,0,-0.203200><3.208200,0.035000,0.203200> rotate<0,0.000000,0> translate<13.505000,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.555900,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.056600,0.000000,7.721600>}
box{<0,0,-0.203200><7.500700,0.035000,0.203200> rotate<0,0.000000,0> translate<13.555900,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.657400,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,15.443200>}
box{<0,0,-0.203200><3.680700,0.035000,0.203200> rotate<0,0.000000,0> translate<13.657400,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.749000,0.000000,9.423300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,9.423300>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<13.749000,0.000000,9.423300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.911400,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728500,-1.535000,10.972800>}
box{<0,0,-0.203200><2.817100,0.035000,0.203200> rotate<0,0.000000,0> translate<13.911400,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.962300,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033300,0.000000,8.128000>}
box{<0,0,-0.203200><3.071000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.962300,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.063800,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.931700,0.000000,15.849600>}
box{<0,0,-0.203200><2.867900,0.035000,0.203200> rotate<0,0.000000,0> translate<14.063800,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,8.356600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804800,0.000000,8.356600>}
box{<0,0,-0.203200><2.613900,0.035000,0.203200> rotate<0,0.000000,0> translate<14.190900,0.000000,8.356600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,9.423300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804800,0.000000,9.423300>}
box{<0,0,-0.203200><2.613900,0.035000,0.203200> rotate<0,0.000000,0> translate<14.190900,0.000000,9.423300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.190900,0.000000,15.976600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804700,0.000000,15.976600>}
box{<0,0,-0.203200><2.613800,0.035000,0.203200> rotate<0,0.000000,0> translate<14.190900,0.000000,15.976600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.317800,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.134900,-1.535000,10.566400>}
box{<0,0,-0.203200><2.817100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.317800,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.724200,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.565600,-1.535000,10.160000>}
box{<0,0,-0.203200><4.841400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.724200,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.130600,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.135000,-1.535000,9.753600>}
box{<0,0,-0.203200><2.004400,0.035000,0.203200> rotate<0,0.000000,0> translate<15.130600,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.537000,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.728600,-1.535000,9.347200>}
box{<0,0,-0.203200><1.191600,0.035000,0.203200> rotate<0,0.000000,0> translate<15.537000,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.943400,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,8.940800>}
box{<0,0,-0.203200><0.769800,0.035000,0.203200> rotate<0,0.000000,0> translate<15.943400,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.349800,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,8.534400>}
box{<0,0,-0.203200><0.363400,0.035000,0.203200> rotate<0,0.000000,0> translate<16.349800,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,3.368100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,2.743200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,0.000000,3.368100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,3.368100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,2.743200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,3.368100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,4.251800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,3.368100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,0.000000,3.368100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,4.251800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,3.368100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,3.368100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,4.251800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,4.876700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,0.000000,4.251800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,4.251800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,4.876700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,4.251800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,5.908100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,5.283200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,0.000000,5.908100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,5.908100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,5.283200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,5.908100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,6.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,5.908100>}
box{<0,0,-0.203200><0.754300,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,5.908100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,6.791800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,5.908100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,0.000000,5.908100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,6.791800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,7.416700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,0.000000,6.791800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,8.448100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,7.823200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,8.448100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,9.331800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,8.448100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,8.448100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,9.331800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,9.956700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,9.331800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,10.988100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,10.363200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,0.000000,10.988100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,10.988100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,10.363200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,10.988100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,11.871800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,10.988100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,0.000000,10.988100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,11.871800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,10.988100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,10.988100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,11.871800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,12.496700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,0.000000,11.871800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,11.871800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,12.496700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,11.871800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,13.528100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,12.903200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,0.000000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,13.528100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,12.903200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,13.528100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,0.000000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,13.528100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,15.036700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,0.000000,14.411800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,15.036700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,14.411800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.068100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,15.443200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,16.068100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.951800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.068100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,16.068100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,16.951800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,17.576700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,18.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,17.983200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,18.608100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,19.491800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,18.608100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,18.608100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,19.491800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,20.116700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,21.148100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,20.523200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,0.000000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,21.148100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,20.523200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<16.713200,-1.535000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,21.148100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,0.000000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,21.148100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.713200,-1.535000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,0.000000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,22.656700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,0.000000,22.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.713200,-1.535000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,22.656700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.713200,-1.535000,22.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.756200,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.033300,-1.535000,8.128000>}
box{<0,0,-0.203200><0.277100,0.035000,0.203200> rotate<0,0.000000,0> translate<16.756200,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804700,0.000000,15.976600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,15.443200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<16.804700,0.000000,15.976600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804700,0.000000,19.583300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,20.116700>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.804700,0.000000,19.583300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804800,0.000000,8.356600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,7.823200>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,45.002401,0> translate<16.804800,0.000000,8.356600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.804800,0.000000,9.423300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,9.956700>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,-45.002401,0> translate<16.804800,0.000000,9.423300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.162600,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,7.721600>}
box{<0,0,-0.203200><8.974000,0.035000,0.203200> rotate<0,0.000000,0> translate<17.162600,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,2.743200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,2.743200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,4.876700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,4.876700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,5.283200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,5.283200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,7.416700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,7.823200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,7.823200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,9.956700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,9.956700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,10.363200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,10.363200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,12.496700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,12.496700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,12.903200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,12.903200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,15.036700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,15.036700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,15.443200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,15.443200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,17.576700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,17.983200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,20.116700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,20.116700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,20.523200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,20.523200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,22.656700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.338100,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,22.656700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<17.338100,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.467500,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,7.416700>}
box{<0,0,-0.203200><0.754300,0.035000,0.203200> rotate<0,0.000000,0> translate<17.467500,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,3.276600>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,-45.002401,0> translate<18.221800,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,3.368100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,4.343300>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,45.002401,0> translate<18.221800,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,4.251800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,5.908100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,5.908100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,5.283200>}
box{<0,0,-0.203200><2.495500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.221800,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,5.283200>}
box{<0,0,-0.203200><2.495500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.221800,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,6.791800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,6.791800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,8.448100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,8.448100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,9.331800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,9.331800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,10.896600>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,-45.002401,0> translate<18.221800,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.792100,-1.535000,10.933600>}
box{<0,0,-0.203200><0.806597,0.035000,0.203200> rotate<0,-45.002053,0> translate<18.221800,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,12.201800>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,45.006746,0> translate<18.221800,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,11.963300>}
box{<0,0,-0.203200><0.754271,0.035000,0.203200> rotate<0,45.002401,0> translate<18.221800,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,13.198100>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,-45.006746,0> translate<18.221800,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,13.436600>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,0.000000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,14.741800>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,45.006746,0> translate<18.221800,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,14.503300>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.443200>}
box{<0,0,-0.203200><0.294800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.221800,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.068100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.068100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,15.443200>}
box{<0,0,-0.203200><2.495500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.221800,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.951800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,18.608100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,19.491800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,19.491800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,21.056600>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,21.148100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.221800,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,22.123300>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.221800,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,22.031800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<18.221800,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323300,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472000,0.000000,2.844800>}
box{<0,0,-0.203200><2.148700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323300,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323300,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472300,0.000000,7.315200>}
box{<0,0,-0.203200><2.149000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323300,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323300,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472300,-1.535000,7.315200>}
box{<0,0,-0.203200><2.149000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323300,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323300,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,13.004800>}
box{<0,0,-0.203200><0.193300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323300,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323300,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472300,-1.535000,17.475200>}
box{<0,0,-0.203200><2.149000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323300,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323400,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472000,-1.535000,2.844800>}
box{<0,0,-0.203200><2.148600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323400,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.323400,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472000,0.000000,13.004800>}
box{<0,0,-0.203200><2.148600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.323400,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.972000,-1.535000,9.753600>}
box{<0,0,-0.203200><1.547100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284600,0.000000,9.753600>}
box{<0,0,-0.203200><1.859700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.159200,-1.535000,10.566400>}
box{<0,0,-0.203200><0.734300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284500,0.000000,10.566400>}
box{<0,0,-0.203200><1.859600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284600,0.000000,19.913600>}
box{<0,0,-0.203200><1.859700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.424900,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284600,-1.535000,19.913600>}
box{<0,0,-0.203200><1.859700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.424900,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.425000,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284500,0.000000,20.726400>}
box{<0,0,-0.203200><1.859500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.425000,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.425000,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.284500,-1.535000,20.726400>}
box{<0,0,-0.203200><1.859500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.425000,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,13.198100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,12.201800>}
box{<0,0,-0.203200><0.996300,0.035000,0.203200> rotate<0,-90.000000,0> translate<18.516600,-1.535000,12.201800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,14.741800>}
box{<0,0,-0.203200><0.277200,0.035000,0.203200> rotate<0,-90.000000,0> translate<18.516600,-1.535000,14.741800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.460900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.019000>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,-90.000000,0> translate<18.516600,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.516600,-1.535000,15.460900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.786600,-1.535000,16.730900>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.516600,-1.535000,15.460900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526500,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.183000,0.000000,12.192000>}
box{<0,0,-0.203200><1.656500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526500,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526500,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.183000,0.000000,22.352000>}
box{<0,0,-0.203200><1.656500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526500,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526500,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.183000,-1.535000,22.352000>}
box{<0,0,-0.203200><1.656500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526500,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526600,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.182900,0.000000,8.128000>}
box{<0,0,-0.203200><1.656300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526600,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526600,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.182900,-1.535000,8.128000>}
box{<0,0,-0.203200><1.656300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526600,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.526600,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.182900,-1.535000,18.288000>}
box{<0,0,-0.203200><1.656300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.526600,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.551800,0.000000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.951800>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,44.987315,0> translate<18.551800,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.551800,0.000000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.157700,0.000000,17.246600>}
box{<0,0,-0.203200><1.605900,0.035000,0.203200> rotate<0,0.000000,0> translate<18.551800,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.551800,0.000000,18.313300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,18.608100>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,-44.987315,0> translate<18.551800,0.000000,18.313300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.551800,0.000000,18.313300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.157700,0.000000,18.313300>}
box{<0,0,-0.203200><1.605900,0.035000,0.203200> rotate<0,0.000000,0> translate<18.551800,0.000000,18.313300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628100,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081400,0.000000,4.470400>}
box{<0,0,-0.203200><1.453300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628100,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628100,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081400,-1.535000,4.470400>}
box{<0,0,-0.203200><1.453300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628100,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628100,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081400,0.000000,14.630400>}
box{<0,0,-0.203200><1.453300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628100,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628200,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081300,0.000000,5.689600>}
box{<0,0,-0.203200><1.453100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628200,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628200,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081300,-1.535000,5.689600>}
box{<0,0,-0.203200><1.453100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628200,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628200,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.905300,-1.535000,15.849600>}
box{<0,0,-0.203200><0.277100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628200,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.628200,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081300,0.000000,15.849600>}
box{<0,0,-0.203200><1.453100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.628200,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729700,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006300,0.000000,3.251200>}
box{<0,0,-0.203200><1.276600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729700,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729700,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006400,0.000000,6.908800>}
box{<0,0,-0.203200><1.276700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729700,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729700,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006400,-1.535000,6.908800>}
box{<0,0,-0.203200><1.276700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729700,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729700,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006400,0.000000,17.068800>}
box{<0,0,-0.203200><1.276700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729700,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006500,-1.535000,17.068800>}
box{<0,0,-0.203200><1.276800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729800,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006300,-1.535000,3.251200>}
box{<0,0,-0.203200><1.276500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729800,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.729800,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006300,0.000000,13.411200>}
box{<0,0,-0.203200><1.276500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.729800,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,3.276600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,3.276600>}
box{<0,0,-0.203200><1.240800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755100,0.000000,3.276600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,4.343300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,4.343300>}
box{<0,0,-0.203200><1.240800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755100,0.000000,4.343300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,10.896600>}
box{<0,0,-0.203200><1.240800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755100,0.000000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755100,0.000000,11.963300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,11.963300>}
box{<0,0,-0.203200><1.240800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755100,0.000000,11.963300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,13.436600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,13.436600>}
box{<0,0,-0.203200><1.240700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755200,0.000000,13.436600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,14.503300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,14.503300>}
box{<0,0,-0.203200><1.240700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755200,0.000000,14.503300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,21.056600>}
box{<0,0,-0.203200><1.240700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755200,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.755200,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,22.123300>}
box{<0,0,-0.203200><1.240700,0.035000,0.203200> rotate<0,0.000000,0> translate<18.755200,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.792100,-1.535000,10.933600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.829000,-1.535000,10.896600>}
box{<0,0,-0.203200><0.052255,0.035000,0.203200> rotate<0,45.074557,0> translate<18.792100,-1.535000,10.933600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.829000,-1.535000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.128400,-1.535000,9.597300>}
box{<0,0,-0.203200><1.837558,0.035000,0.203200> rotate<0,44.994826,0> translate<18.829000,-1.535000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.831300,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.964300,0.000000,9.347200>}
box{<0,0,-0.203200><1.133000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.831300,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.831300,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.964300,-1.535000,9.347200>}
box{<0,0,-0.203200><1.133000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.831300,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.831300,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.964300,0.000000,19.507200>}
box{<0,0,-0.203200><1.133000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.831300,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.831300,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.964300,-1.535000,19.507200>}
box{<0,0,-0.203200><1.133000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.831300,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.831400,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.964200,-1.535000,21.132800>}
box{<0,0,-0.203200><1.132800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.831400,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,3.368100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,4.251800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,4.251800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,3.657600>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.880200,-1.535000,4.064000>}
box{<0,0,-0.203200><1.033500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,5.908100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,6.791800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,0.000000,6.791800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,5.908100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,6.791800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,6.791800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.880000,0.000000,6.096000>}
box{<0,0,-0.203200><1.033300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.880000,-1.535000,6.096000>}
box{<0,0,-0.203200><1.033300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,6.502400>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,6.502400>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,8.448100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,9.331800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,0.000000,9.331800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,8.448100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,9.331800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,9.331800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922100,0.000000,8.534400>}
box{<0,0,-0.203200><1.075400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922100,-1.535000,8.534400>}
box{<0,0,-0.203200><1.075400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,8.940800>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,8.940800>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.068100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.951800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,0.000000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.068100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.951800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.311700,-1.535000,16.256000>}
box{<0,0,-0.203200><0.465000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.880000,0.000000,16.256000>}
box{<0,0,-0.203200><1.033300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.718100,-1.535000,16.662400>}
box{<0,0,-0.203200><0.871400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,16.662400>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,18.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,19.491800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,0.000000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,18.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,19.491800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922100,0.000000,18.694400>}
box{<0,0,-0.203200><1.075400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922100,-1.535000,18.694400>}
box{<0,0,-0.203200><1.075400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,19.100800>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,19.100800>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,21.148100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,22.031800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<18.846700,-1.535000,22.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,21.539200>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.846700,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922300,-1.535000,21.945600>}
box{<0,0,-0.203200><1.075600,0.035000,0.203200> rotate<0,0.000000,0> translate<18.846700,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,11.650900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,15.019000>}
box{<0,0,-0.203200><3.368100,0.035000,0.203200> rotate<0,90.000000,0> translate<19.583300,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,11.650900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,11.371300>}
box{<0,0,-0.203200><0.395343,0.035000,0.203200> rotate<0,45.007277,0> translate<19.583300,-1.535000,11.650900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922300,-1.535000,11.785600>}
box{<0,0,-0.203200><0.339000,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.183000,-1.535000,12.192000>}
box{<0,0,-0.203200><0.599700,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,12.598400>}
box{<0,0,-0.203200><6.553300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.472000,-1.535000,13.004800>}
box{<0,0,-0.203200><0.888700,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.006300,-1.535000,13.411200>}
box{<0,0,-0.203200><0.423000,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,13.817600>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.880200,-1.535000,14.224000>}
box{<0,0,-0.203200><0.296900,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.081400,-1.535000,14.630400>}
box{<0,0,-0.203200><0.498100,0.035000,0.203200> rotate<0,0.000000,0> translate<19.583300,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.583300,-1.535000,15.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.247600,-1.535000,15.683400>}
box{<0,0,-0.203200><0.939533,0.035000,0.203200> rotate<0,-45.001342,0> translate<19.583300,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.601000,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.036800>}
box{<0,0,-0.203200><6.535600,0.035000,0.203200> rotate<0,0.000000,0> translate<19.601000,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.786600,-1.535000,16.730900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922900,-1.535000,16.867100>}
box{<0,0,-0.203200><0.192687,0.035000,0.203200> rotate<0,-44.976006,0> translate<19.786600,-1.535000,16.730900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.855000,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,11.379200>}
box{<0,0,-0.203200><0.007800,0.035000,0.203200> rotate<0,0.000000,0> translate<19.855000,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,3.597700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,3.205700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,3.597700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,3.597700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,3.597700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,4.414200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,5.745700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,0.000000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,5.745700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,6.137700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,0.000000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,6.137700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,6.954200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,0.000000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,6.954200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,8.285700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,0.000000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,8.285700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,8.677700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,0.000000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,8.677700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,9.494200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,0.000000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,9.494200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,11.371300>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,11.371300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,12.034200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,11.642200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,13.757700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,13.365700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,13.757700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,14.574200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,16.297700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,15.905700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,0.000000,16.297700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,16.722200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,16.297700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,0.000000,16.297700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,16.722200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,17.114200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,0.000000,16.722200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,18.445700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,0.000000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,18.445700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,18.837700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,0.000000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,18.837700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,0.000000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,19.654200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,0.000000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,19.654200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,20.985700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<19.862800,-1.535000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,21.377700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<19.862800,-1.535000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.862800,-1.535000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,22.194200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<19.862800,-1.535000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.922900,-1.535000,16.867100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,17.114200>}
box{<0,0,-0.203200><0.267439,0.035000,0.203200> rotate<0,-67.505871,0> translate<19.922900,-1.535000,16.867100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,3.276600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,3.205700>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<19.995900,0.000000,3.276600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,4.343300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,4.414200>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<19.995900,0.000000,4.343300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,10.825700>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<19.995900,0.000000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,11.963300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,12.034200>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<19.995900,0.000000,11.963300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,13.436600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,13.365700>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<19.995900,0.000000,13.436600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,14.503300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,14.574200>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<19.995900,0.000000,14.503300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,20.985700>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<19.995900,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.995900,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,22.194200>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<19.995900,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.007400,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,15.443200>}
box{<0,0,-0.203200><0.709900,0.035000,0.203200> rotate<0,0.000000,0> translate<20.007400,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,2.905600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,2.905600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,4.714300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,4.714300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,5.445600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,5.445600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,7.254300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,7.254300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,7.985600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,7.985600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.128400,-1.535000,9.597300>}
box{<0,0,-0.203200><0.145876,0.035000,0.203200> rotate<0,-44.969259,0> translate<20.025200,-1.535000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,9.794300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,10.525600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,12.334300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,12.334300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,13.065600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,13.065600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,14.874300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,14.874300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,15.605600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.157700,0.000000,17.246600>}
box{<0,0,-0.203200><0.187313,0.035000,0.203200> rotate<0,-44.975402,0> translate<20.025200,0.000000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,17.414300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.157700,0.000000,18.313300>}
box{<0,0,-0.203200><0.187313,0.035000,0.203200> rotate<0,44.975402,0> translate<20.025200,0.000000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,18.145600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,19.954300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,19.954300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,20.685600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,0.000000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,20.685600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<20.025200,-1.535000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,0.000000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,22.494300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,0.000000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.025200,-1.535000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,22.494300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.025200,-1.535000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.247600,-1.535000,15.683400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,15.605600>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<20.247600,-1.535000,15.683400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,2.743200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,2.743200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,4.876700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,4.876700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,5.283200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,5.283200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,7.416700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,7.416700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,7.823200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,7.823200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,9.956700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,10.363200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,12.496700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,12.496700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,12.903200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,12.903200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,15.036700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,15.036700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,15.443200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,15.443200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,17.576700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,17.983200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,20.116700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,20.116700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,20.523200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,0.000000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,20.523200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<20.325300,-1.535000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,0.000000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,22.656700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,0.000000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.325300,-1.535000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,22.656700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<20.325300,-1.535000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,2.743200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,2.743200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,4.876700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,4.876700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,5.283200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,5.283200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.056600,0.000000,7.416700>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,7.416700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.056600,0.000000,7.823200>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,7.823200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,9.956700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,10.363200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,12.496700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,12.496700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,12.903200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,12.903200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,15.036700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,15.036700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,15.443200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,15.443200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,17.576700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,17.983200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,20.116700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,20.116700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,20.523200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,20.523200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,22.656700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.717300,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,22.656700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<20.717300,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.870900,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.277500,-1.535000,9.956700>}
box{<0,0,-0.203200><0.574949,0.035000,0.203200> rotate<0,44.989984,0> translate<20.870900,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.870900,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,10.363200>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<20.870900,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.056600,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.056600,0.000000,7.416700>}
box{<0,0,-0.203200><0.406500,0.035000,0.203200> rotate<0,-90.000000,0> translate<21.056600,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.074200,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,10.160000>}
box{<0,0,-0.203200><5.062400,0.035000,0.203200> rotate<0,0.000000,0> translate<21.074200,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.277500,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,9.956700>}
box{<0,0,-0.203200><1.185100,0.035000,0.203200> rotate<0,0.000000,0> translate<21.277500,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,7.823200>}
box{<0,0,-0.203200><0.406500,0.035000,0.203200> rotate<0,90.000000,0> translate<22.123300,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,7.416700>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.637300,0.000000,7.721600>}
box{<0,0,-0.203200><11.514000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,7.823200>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,17.983200>}
box{<0,0,-0.203200><0.406500,0.035000,0.203200> rotate<0,90.000000,0> translate<22.123300,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,17.576700>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.907400,0.000000,17.881600>}
box{<0,0,-0.203200><12.784100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.123300,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,17.983200>}
box{<0,0,-0.203200><0.339300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.123300,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,2.905600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,2.905600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,4.714300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,4.714300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,5.445600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,5.445600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,5.283200>}
box{<0,0,-0.203200><3.674000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.462600,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,5.283200>}
box{<0,0,-0.203200><5.874700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.462600,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,7.254300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,7.254300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,7.985600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,7.985600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,9.794300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,9.794300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,10.525600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,10.525600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,12.334300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,12.334300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,13.065600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,13.065600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,14.874300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,14.874300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,15.605600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,15.605600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.443200>}
box{<0,0,-0.203200><3.674000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.462600,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,15.443200>}
box{<0,0,-0.203200><5.874700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.462600,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,17.414300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,17.414300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,18.145600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,18.145600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,19.954300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,19.954300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,20.685600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,20.685600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<22.462600,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,22.494300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.462600,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,22.494300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<22.462600,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707600,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,7.315200>}
box{<0,0,-0.203200><3.429000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707600,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707600,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092300,0.000000,7.315200>}
box{<0,0,-0.203200><5.384700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707600,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707600,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092300,0.000000,17.475200>}
box{<0,0,-0.203200><5.384700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707600,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707600,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092300,-1.535000,17.475200>}
box{<0,0,-0.203200><5.384700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707600,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707800,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.880800,-1.535000,2.844800>}
box{<0,0,-0.203200><4.173000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707800,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707800,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092000,0.000000,2.844800>}
box{<0,0,-0.203200><5.384200,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707800,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707800,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,13.004800>}
box{<0,0,-0.203200><3.428800,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707800,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.707800,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092000,0.000000,13.004800>}
box{<0,0,-0.203200><5.384200,0.035000,0.203200> rotate<0,0.000000,0> translate<22.707800,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,3.205700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,3.205700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,4.414200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,4.414200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,5.745700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,5.745700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,6.954200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,6.954200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,8.285700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,8.285700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,9.494200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,9.494200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,10.825700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,10.825700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,12.034200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,12.034200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,13.365700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,13.365700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,14.574200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,14.574200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,15.905700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,15.905700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,17.114200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,17.114200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,18.445700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,18.445700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,19.654200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,19.654200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,20.985700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,0.000000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,20.985700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.854600,-1.535000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,0.000000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,22.194200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,0.000000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.854600,-1.535000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,22.194200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<22.854600,-1.535000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895300,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,9.753600>}
box{<0,0,-0.203200><3.241300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895300,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895300,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904600,0.000000,9.753600>}
box{<0,0,-0.203200><5.009300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895300,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895300,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904600,0.000000,19.913600>}
box{<0,0,-0.203200><5.009300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895300,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895300,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904600,-1.535000,19.913600>}
box{<0,0,-0.203200><5.009300,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895300,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895400,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,10.566400>}
box{<0,0,-0.203200><3.241200,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895400,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895400,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904500,0.000000,10.566400>}
box{<0,0,-0.203200><5.009100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895400,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895400,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904500,0.000000,20.726400>}
box{<0,0,-0.203200><5.009100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895400,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.895400,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904500,-1.535000,20.726400>}
box{<0,0,-0.203200><5.009100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.895400,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.996900,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,12.192000>}
box{<0,0,-0.203200><3.139700,0.035000,0.203200> rotate<0,0.000000,0> translate<22.996900,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.996900,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.803000,0.000000,12.192000>}
box{<0,0,-0.203200><4.806100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.996900,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.996900,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.803000,0.000000,22.352000>}
box{<0,0,-0.203200><4.806100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.996900,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.996900,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.803000,-1.535000,22.352000>}
box{<0,0,-0.203200><4.806100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.996900,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.997000,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,8.128000>}
box{<0,0,-0.203200><3.139600,0.035000,0.203200> rotate<0,0.000000,0> translate<22.997000,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.997000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.802900,0.000000,8.128000>}
box{<0,0,-0.203200><4.805900,0.035000,0.203200> rotate<0,0.000000,0> translate<22.997000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.997000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.802900,0.000000,18.288000>}
box{<0,0,-0.203200><4.805900,0.035000,0.203200> rotate<0,0.000000,0> translate<22.997000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.997000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.802900,-1.535000,18.288000>}
box{<0,0,-0.203200><4.805900,0.035000,0.203200> rotate<0,0.000000,0> translate<22.997000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098500,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,4.470400>}
box{<0,0,-0.203200><3.038100,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098500,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098500,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701400,0.000000,4.470400>}
box{<0,0,-0.203200><4.602900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098500,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098500,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,14.630400>}
box{<0,0,-0.203200><3.038100,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098500,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701400,0.000000,14.630400>}
box{<0,0,-0.203200><4.602900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098600,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,5.689600>}
box{<0,0,-0.203200><3.038000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098600,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098600,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701300,0.000000,5.689600>}
box{<0,0,-0.203200><4.602700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098600,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098600,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.525300,-1.535000,15.849600>}
box{<0,0,-0.203200><3.426700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098600,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.098600,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701300,0.000000,15.849600>}
box{<0,0,-0.203200><4.602700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.098600,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,3.597700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,3.597700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,4.022200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,4.022200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,6.137700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,6.137700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,6.562200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,6.562200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,8.677700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,8.677700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,9.102200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,9.102200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,11.217700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,11.217700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,11.642200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,11.642200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,13.757700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,13.757700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,14.182200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,14.182200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,16.297700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,16.297700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,16.722200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,16.722200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,18.837700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,18.837700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,19.262200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,19.262200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,21.377700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,0.000000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,21.377700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<23.154700,-1.535000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,0.000000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,21.802200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,0.000000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.154700,-1.535000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,21.802200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<23.154700,-1.535000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173500,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.474400,-1.535000,3.251200>}
box{<0,0,-0.203200><3.300900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173500,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173500,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626300,0.000000,3.251200>}
box{<0,0,-0.203200><4.452800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173500,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173500,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,13.411200>}
box{<0,0,-0.203200><2.963100,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173500,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173500,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626300,0.000000,13.411200>}
box{<0,0,-0.203200><4.452800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173500,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173600,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,6.908800>}
box{<0,0,-0.203200><2.963000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173600,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173600,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626400,0.000000,6.908800>}
box{<0,0,-0.203200><4.452800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173600,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173600,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626400,0.000000,17.068800>}
box{<0,0,-0.203200><4.452800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173600,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.173600,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626500,-1.535000,17.068800>}
box{<0,0,-0.203200><4.452900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.173600,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,9.347200>}
box{<0,0,-0.203200><2.921000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584300,0.000000,9.347200>}
box{<0,0,-0.203200><4.368700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,10.972800>}
box{<0,0,-0.203200><2.921000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584200,0.000000,10.972800>}
box{<0,0,-0.203200><4.368600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584300,0.000000,19.507200>}
box{<0,0,-0.203200><4.368700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584300,-1.535000,19.507200>}
box{<0,0,-0.203200><4.368700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584200,0.000000,21.132800>}
box{<0,0,-0.203200><4.368600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.215600,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584200,-1.535000,21.132800>}
box{<0,0,-0.203200><4.368600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.215600,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,8.534400>}
box{<0,0,-0.203200><2.878900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542100,0.000000,8.534400>}
box{<0,0,-0.203200><4.284400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,11.785600>}
box{<0,0,-0.203200><2.878900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542300,0.000000,11.785600>}
box{<0,0,-0.203200><4.284600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542100,0.000000,18.694400>}
box{<0,0,-0.203200><4.284400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542100,-1.535000,18.694400>}
box{<0,0,-0.203200><4.284400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542300,0.000000,21.945600>}
box{<0,0,-0.203200><4.284600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.257700,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542300,-1.535000,21.945600>}
box{<0,0,-0.203200><4.284600,0.035000,0.203200> rotate<0,0.000000,0> translate<23.257700,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,4.064000>}
box{<0,0,-0.203200><2.836800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500200,0.000000,4.064000>}
box{<0,0,-0.203200><4.200400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,6.096000>}
box{<0,0,-0.203200><2.836800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500000,0.000000,6.096000>}
box{<0,0,-0.203200><4.200200,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,14.224000>}
box{<0,0,-0.203200><2.836800,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500200,0.000000,14.224000>}
box{<0,0,-0.203200><4.200400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.931700,-1.535000,16.256000>}
box{<0,0,-0.203200><3.631900,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.299800,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500000,0.000000,16.256000>}
box{<0,0,-0.203200><4.200200,0.035000,0.203200> rotate<0,0.000000,0> translate<23.299800,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,3.597700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,4.022200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,3.597700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,4.022200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,3.657600>}
box{<0,0,-0.203200><2.819500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,3.657600>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,6.562200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,6.562200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,6.502400>}
box{<0,0,-0.203200><2.819500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,6.502400>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,9.102200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,9.102200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,8.940800>}
box{<0,0,-0.203200><2.819500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,8.940800>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,11.217700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,11.642200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,11.642200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,11.217700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,11.642200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,11.642200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,11.379200>}
box{<0,0,-0.203200><2.819500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,11.379200>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,13.757700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,14.182200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,13.757700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,14.182200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,13.817600>}
box{<0,0,-0.203200><2.819500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,13.817600>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,16.297700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,16.722200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,16.722200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,16.297700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,16.722200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,16.722200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.338100,-1.535000,16.662400>}
box{<0,0,-0.203200><4.021000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,16.662400>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,19.262200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,19.262200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,19.100800>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,19.100800>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,21.802200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,0.000000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,21.802200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<23.317100,-1.535000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,0.000000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,21.539200>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,0.000000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.317100,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,21.539200>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<23.317100,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,3.589000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.449000,-1.535000,3.276600>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,44.997030,0> translate<26.136600,-1.535000,3.589000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,3.589000>}
box{<0,0,-0.203200><11.430000,0.035000,0.203200> rotate<0,-90.000000,0> translate<26.136600,-1.535000,3.589000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.460900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.019000>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,-90.000000,0> translate<26.136600,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.136600,-1.535000,15.460900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.406600,-1.535000,16.730900>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.136600,-1.535000,15.460900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.449000,-1.535000,3.276600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.719000,-1.535000,2.006600>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<26.449000,-1.535000,3.276600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,4.030900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,15.019000>}
box{<0,0,-0.203200><10.988100,0.035000,0.203200> rotate<0,90.000000,0> translate<27.203300,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,4.030900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,3.751300>}
box{<0,0,-0.203200><0.395343,0.035000,0.203200> rotate<0,45.007277,0> translate<27.203300,-1.535000,4.030900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500200,-1.535000,4.064000>}
box{<0,0,-0.203200><0.296900,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701400,-1.535000,4.470400>}
box{<0,0,-0.203200><0.498100,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.792600,-1.535000,4.876800>}
box{<0,0,-0.203200><3.589300,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,5.283200>}
box{<0,0,-0.203200><1.134000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701300,-1.535000,5.689600>}
box{<0,0,-0.203200><0.498000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500000,-1.535000,6.096000>}
box{<0,0,-0.203200><0.296700,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,6.502400>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626400,-1.535000,6.908800>}
box{<0,0,-0.203200><0.423100,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092300,-1.535000,7.315200>}
box{<0,0,-0.203200><0.889000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,7.721600>}
box{<0,0,-0.203200><4.013300,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.802900,-1.535000,8.128000>}
box{<0,0,-0.203200><0.599600,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542100,-1.535000,8.534400>}
box{<0,0,-0.203200><0.338800,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,8.940800>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584300,-1.535000,9.347200>}
box{<0,0,-0.203200><0.381000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904600,-1.535000,9.753600>}
box{<0,0,-0.203200><0.701300,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,10.160000>}
box{<0,0,-0.203200><4.013300,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.904500,-1.535000,10.566400>}
box{<0,0,-0.203200><0.701200,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.584200,-1.535000,10.972800>}
box{<0,0,-0.203200><0.380900,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,11.379200>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542300,-1.535000,11.785600>}
box{<0,0,-0.203200><0.339000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.803000,-1.535000,12.192000>}
box{<0,0,-0.203200><0.599700,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.946600,-1.535000,12.598400>}
box{<0,0,-0.203200><2.743300,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.092000,-1.535000,13.004800>}
box{<0,0,-0.203200><0.888700,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.626300,-1.535000,13.411200>}
box{<0,0,-0.203200><0.423000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,13.817600>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.500200,-1.535000,14.224000>}
box{<0,0,-0.203200><0.296900,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.701400,-1.535000,14.630400>}
box{<0,0,-0.203200><0.498100,0.035000,0.203200> rotate<0,0.000000,0> translate<27.203300,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.203300,-1.535000,15.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.867600,-1.535000,15.683400>}
box{<0,0,-0.203200><0.939533,0.035000,0.203200> rotate<0,-45.001342,0> translate<27.203300,-1.535000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.221000,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.792600,-1.535000,15.036800>}
box{<0,0,-0.203200><3.571600,0.035000,0.203200> rotate<0,0.000000,0> translate<27.221000,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.406600,-1.535000,16.730900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542900,-1.535000,16.867100>}
box{<0,0,-0.203200><0.192687,0.035000,0.203200> rotate<0,-44.976006,0> translate<27.406600,-1.535000,16.730900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,3.597700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,3.205700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,3.597700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,3.597700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,3.597700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,3.751300>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,3.751300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,4.414200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,4.022200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,4.414200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,5.745700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,5.745700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,6.137700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,6.137700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,6.137700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,6.954200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,6.562200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,6.954200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,8.285700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,8.285700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,8.677700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,8.677700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,8.677700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,9.494200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,9.102200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,9.494200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,11.217700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,10.825700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,11.217700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,11.217700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,10.825700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,11.217700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,11.217700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,11.217700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,11.217700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,11.217700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,12.034200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,11.642200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,11.642200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,12.034200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,11.642200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,13.757700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,13.365700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,13.757700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,13.365700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,13.757700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,13.757700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,13.757700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,14.574200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,14.182200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,14.574200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,16.297700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,15.905700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,16.297700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,16.722200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,16.297700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,16.297700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,16.722200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,17.114200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,16.722200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,18.445700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,18.445700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,18.837700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,18.837700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,18.837700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,19.654200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,19.262200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,19.654200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,20.985700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,0.000000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,20.985700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<27.482800,-1.535000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,21.377700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,0.000000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,21.377700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.482800,-1.535000,21.377700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,0.000000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,22.194200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,0.000000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.482800,-1.535000,21.802200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,22.194200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<27.482800,-1.535000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.542900,-1.535000,16.867100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,17.114200>}
box{<0,0,-0.203200><0.267439,0.035000,0.203200> rotate<0,-67.505871,0> translate<27.542900,-1.535000,16.867100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.627400,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,15.443200>}
box{<0,0,-0.203200><0.709900,0.035000,0.203200> rotate<0,0.000000,0> translate<27.627400,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,2.905600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,4.714300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,4.714300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,5.445600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,5.445600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,7.254300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,7.254300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,7.985600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,7.985600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,9.794300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,9.794300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,10.525600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,10.525600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,12.334300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,12.034200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,12.334300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,12.034200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,13.065600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,13.365700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,13.065600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,13.365700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,14.874300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,14.874300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,15.605600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,17.414300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,17.414300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,18.145600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,18.145600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,19.954300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,19.954300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,20.685600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,0.000000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,20.685600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<27.645200,-1.535000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,0.000000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,22.494300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,0.000000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.645200,-1.535000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,22.494300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.645200,-1.535000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.719000,-1.535000,2.006600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.160900,-1.535000,2.006600>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<27.719000,-1.535000,2.006600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.867600,-1.535000,15.683400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,15.605600>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<27.867600,-1.535000,15.683400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,2.743200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,4.876700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,4.876700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,5.283200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,5.283200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,7.416700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,7.416700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,7.823200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,7.823200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,9.956700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,9.956700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,10.363200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,10.363200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,12.496700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,12.334300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,12.496700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,12.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,12.903200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,13.065600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,12.903200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,13.065600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,15.036700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,15.036700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,15.443200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,15.443200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,17.576700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,17.576700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,17.983200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,17.983200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,20.116700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,20.116700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,20.523200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,0.000000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,20.523200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<27.945300,-1.535000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,0.000000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,22.656700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,0.000000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.945300,-1.535000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,22.656700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<27.945300,-1.535000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.160900,-1.535000,2.006600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.130900,-1.535000,2.006600>}
box{<0,0,-0.203200><13.970000,0.035000,0.203200> rotate<0,0.000000,0> translate<28.160900,-1.535000,2.006600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,2.743200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,4.876700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,4.876700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,5.283200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,5.283200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,7.416700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,7.416700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,7.823200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,7.823200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,9.956700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,9.956700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,10.363200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,10.363200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.522400,0.000000,12.496700>}
box{<0,0,-0.203200><1.185100,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.946600,-1.535000,12.496700>}
box{<0,0,-0.203200><1.609300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.929000,0.000000,12.903200>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.946600,-1.535000,12.903200>}
box{<0,0,-0.203200><1.609300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,15.036700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,15.036700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,15.443200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,15.443200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,17.576700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,17.576700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,17.983200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,17.983200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,20.116700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,20.116700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,20.523200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,20.523200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,22.656700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.337300,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,22.656700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.337300,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.522400,0.000000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.929000,0.000000,12.903200>}
box{<0,0,-0.203200><0.574949,0.035000,0.203200> rotate<0,-44.989984,0> translate<29.522400,0.000000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.946600,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.946600,-1.535000,12.496700>}
box{<0,0,-0.203200><0.406500,0.035000,0.203200> rotate<0,-90.000000,0> translate<29.946600,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,2.743200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,2.905600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,2.743200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,4.714300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,4.876700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,4.714300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,4.876700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,5.445600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,5.445600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.199000,-1.535000,5.283200>}
box{<0,0,-0.203200><1.116400,0.035000,0.203200> rotate<0,0.000000,0> translate<30.082600,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.070100,0.000000,5.283200>}
box{<0,0,-0.203200><1.987500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.082600,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,7.254300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,7.416700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,7.254300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,7.416700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,7.985600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,7.985600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,9.794300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,9.794300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,10.525600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,10.525600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,14.874300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,15.036700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,14.874300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,15.036700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,15.605600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,15.605600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.199000,-1.535000,15.443200>}
box{<0,0,-0.203200><1.116400,0.035000,0.203200> rotate<0,0.000000,0> translate<30.082600,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,15.443200>}
box{<0,0,-0.203200><2.241500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.082600,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,17.414300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,17.414300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,18.145600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,18.145600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,19.954300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,19.954300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,20.685600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,20.685600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<30.082600,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,22.494300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.082600,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,22.494300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<30.082600,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.327600,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,7.315200>}
box{<0,0,-0.203200><0.889000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.327600,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.327600,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.230900,0.000000,7.315200>}
box{<0,0,-0.203200><2.903300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.327600,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.327600,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.222600,0.000000,17.475200>}
box{<0,0,-0.203200><1.895000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.327600,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.327600,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.222600,-1.535000,17.475200>}
box{<0,0,-0.203200><1.895000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.327600,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.327800,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.968500,0.000000,2.844800>}
box{<0,0,-0.203200><1.640700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.327800,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,2.905600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,3.205700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,2.905600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.552300,-1.535000,4.636500>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<30.474600,-1.535000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,4.714300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,4.414200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,4.714300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,5.745700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,5.445600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,5.745700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,5.445600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,6.954200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,7.254300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,6.954200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,-1.535000,7.254300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,8.285700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,7.985600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,8.285700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,7.985600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,9.494200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,9.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,9.494200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,-1.535000,9.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,10.825700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,10.525600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,10.825700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,10.525600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.552300,-1.535000,14.796500>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<30.474600,-1.535000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,14.874300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,14.574200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,14.874300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,15.905700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,15.605600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,15.905700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,15.605600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,17.114200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,17.414300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,17.114200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,-1.535000,17.414300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,18.445700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,18.145600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,18.445700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,18.145600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,19.654200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,19.954300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,19.654200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,-1.535000,19.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,20.985700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,0.000000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,20.685600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,20.985700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.474600,-1.535000,20.685600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,0.000000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,22.194200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,0.000000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.474600,-1.535000,22.494300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,22.194200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<30.474600,-1.535000,22.494300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515300,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,9.753600>}
box{<0,0,-0.203200><0.701300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515300,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515300,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.859400,0.000000,9.753600>}
box{<0,0,-0.203200><1.344100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515300,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515300,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.121000,0.000000,19.913600>}
box{<0,0,-0.203200><1.605700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515300,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515300,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.121000,-1.535000,19.913600>}
box{<0,0,-0.203200><1.605700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515300,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515400,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,10.566400>}
box{<0,0,-0.203200><0.701200,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515400,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515400,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.120900,0.000000,10.566400>}
box{<0,0,-0.203200><1.605500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515400,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515400,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.120900,0.000000,20.726400>}
box{<0,0,-0.203200><1.605500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515400,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.515400,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.120900,-1.535000,20.726400>}
box{<0,0,-0.203200><1.605500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.515400,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.552300,-1.535000,4.636500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,5.300900>}
box{<0,0,-0.203200><0.939533,0.035000,0.203200> rotate<0,-45.001342,0> translate<30.552300,-1.535000,4.636500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.552300,-1.535000,14.796500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,15.460900>}
box{<0,0,-0.203200><0.939533,0.035000,0.203200> rotate<0,-45.001342,0> translate<30.552300,-1.535000,14.796500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.616900,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019400,0.000000,22.352000>}
box{<0,0,-0.203200><1.402500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.616900,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.616900,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019400,-1.535000,22.352000>}
box{<0,0,-0.203200><1.402500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.616900,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.617000,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,8.128000>}
box{<0,0,-0.203200><0.599600,0.035000,0.203200> rotate<0,0.000000,0> translate<30.617000,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.617000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019300,0.000000,8.128000>}
box{<0,0,-0.203200><1.402300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.617000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.617000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019300,0.000000,18.288000>}
box{<0,0,-0.203200><1.402300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.617000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.617000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019300,-1.535000,18.288000>}
box{<0,0,-0.203200><1.402300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.617000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718500,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.171800,0.000000,4.470400>}
box{<0,0,-0.203200><1.453300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718500,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.656200,0.000000,14.630400>}
box{<0,0,-0.203200><0.937700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718600,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,5.689600>}
box{<0,0,-0.203200><0.498000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718600,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718600,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,5.689600>}
box{<0,0,-0.203200><0.980600,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718600,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718600,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.917700,0.000000,15.849600>}
box{<0,0,-0.203200><1.199100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718600,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.718600,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.917700,-1.535000,15.849600>}
box{<0,0,-0.203200><1.199100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.718600,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,3.205700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,3.597700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,0.000000,3.205700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,4.414200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,4.022200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,0.000000,4.414200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,5.816600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,5.745700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,6.137700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,5.745700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,6.883300>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<30.774700,0.000000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,6.954200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,6.562200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,-1.535000,6.954200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,8.356600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,8.285700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,8.677700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,8.285700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,9.423300>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<30.774700,0.000000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,9.494200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,9.102200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,-1.535000,9.494200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,10.896600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,10.825700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,11.217700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,10.825700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,14.574200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,14.182200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,0.000000,14.574200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,15.976600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,15.905700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,16.297700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,15.905700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,17.043300>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<30.774700,0.000000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,17.114200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,16.722200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,-1.535000,17.114200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,18.516600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,18.445700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,18.837700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,18.445700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,19.583300>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<30.774700,0.000000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,19.654200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,19.262200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,-1.535000,19.654200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,21.056600>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,-67.542284,0> translate<30.774700,0.000000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,20.985700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,21.377700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<30.774700,-1.535000,20.985700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,0.000000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,22.123300>}
box{<0,0,-0.203200><0.076716,0.035000,0.203200> rotate<0,67.542284,0> translate<30.774700,0.000000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.774700,-1.535000,22.194200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,21.802200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<30.774700,-1.535000,22.194200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.793500,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.251200>}
box{<0,0,-0.203200><0.905700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.793500,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.793500,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.070300,0.000000,6.908800>}
box{<0,0,-0.203200><1.276800,0.035000,0.203200> rotate<0,0.000000,0> translate<30.793500,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.793500,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.816200,0.000000,17.068800>}
box{<0,0,-0.203200><1.022700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.793500,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.793600,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,6.908800>}
box{<0,0,-0.203200><0.423000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.793600,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.793600,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.816200,-1.535000,17.068800>}
box{<0,0,-0.203200><1.022600,0.035000,0.203200> rotate<0,0.000000,0> translate<30.793600,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,5.816600>}
box{<0,0,-0.203200><0.895200,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,5.816600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,6.883300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.044800,0.000000,6.883300>}
box{<0,0,-0.203200><1.240800,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,6.883300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,8.356600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,0.000000,8.356600>}
box{<0,0,-0.203200><0.725000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,8.356600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,9.423300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,0.000000,9.423300>}
box{<0,0,-0.203200><0.725000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,9.423300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,10.896600>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,15.976600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,15.976600>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,15.976600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,17.043300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,17.043300>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,17.043300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,18.516600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,18.516600>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,18.516600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,19.583300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,19.583300>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,19.583300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,21.056600>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.804000,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,22.123300>}
box{<0,0,-0.203200><0.986700,0.035000,0.203200> rotate<0,0.000000,0> translate<30.804000,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.835600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,9.347200>}
box{<0,0,-0.203200><0.381000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.835600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.835600,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,10.972800>}
box{<0,0,-0.203200><0.381000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.835600,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.835600,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.714600,-1.535000,19.507200>}
box{<0,0,-0.203200><0.879000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.835600,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.835600,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.714500,-1.535000,21.132800>}
box{<0,0,-0.203200><0.878900,0.035000,0.203200> rotate<0,0.000000,0> translate<30.835600,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.877700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,8.534400>}
box{<0,0,-0.203200><0.338900,0.035000,0.203200> rotate<0,0.000000,0> translate<30.877700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.877700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,18.694400>}
box{<0,0,-0.203200><0.821500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.877700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.877700,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,21.945600>}
box{<0,0,-0.203200><0.821500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.877700,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.919800,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.765400,0.000000,4.064000>}
box{<0,0,-0.203200><0.845600,0.035000,0.203200> rotate<0,0.000000,0> translate<30.919800,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.919800,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,6.096000>}
box{<0,0,-0.203200><0.296800,0.035000,0.203200> rotate<0,0.000000,0> translate<30.919800,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.919800,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.249800,0.000000,14.224000>}
box{<0,0,-0.203200><0.330000,0.035000,0.203200> rotate<0,0.000000,0> translate<30.919800,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.919800,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.256000>}
box{<0,0,-0.203200><0.779400,0.035000,0.203200> rotate<0,0.000000,0> translate<30.919800,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,3.597700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,4.022200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,0.000000,4.022200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.657600>}
box{<0,0,-0.203200><0.762100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,6.137700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,6.562200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,6.562200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,6.502400>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,8.677700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,9.102200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,9.102200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,8.940800>}
box{<0,0,-0.203200><0.279500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,11.217700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,11.488600>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,11.488600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.046400,-1.535000,11.379200>}
box{<0,0,-0.203200><0.109300,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,11.488600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,11.209000>}
box{<0,0,-0.203200><0.395343,0.035000,0.203200> rotate<0,45.007277,0> translate<30.937100,-1.535000,11.488600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,13.911300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,14.182200>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,0.000000,14.182200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,0.000000,13.911300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.469000,0.000000,15.443200>}
box{<0,0,-0.203200><2.166434,0.035000,0.203200> rotate<0,-44.997030,0> translate<30.937100,0.000000,13.911300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,16.297700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,16.722200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,16.722200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.662400>}
box{<0,0,-0.203200><0.762100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,18.837700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,19.262200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,19.262200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,19.100800>}
box{<0,0,-0.203200><0.762100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,21.377700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,21.802200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<30.937100,-1.535000,21.802200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.937100,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,21.539200>}
box{<0,0,-0.203200><0.762100,0.035000,0.203200> rotate<0,0.000000,0> translate<30.937100,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,12.920900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.749000>}
box{<0,0,-0.203200><0.828100,0.035000,0.203200> rotate<0,90.000000,0> translate<31.013300,-1.535000,13.749000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,12.920900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.880800,-1.535000,12.053300>}
box{<0,0,-0.203200><1.226901,0.035000,0.203200> rotate<0,45.000332,0> translate<31.013300,-1.535000,12.920900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.222500,-1.535000,13.004800>}
box{<0,0,-0.203200><1.209200,0.035000,0.203200> rotate<0,0.000000,0> translate<31.013300,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.816100,-1.535000,13.411200>}
box{<0,0,-0.203200><0.802800,0.035000,0.203200> rotate<0,0.000000,0> translate<31.013300,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.749000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.749100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<31.013300,-1.535000,13.749100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.013300,-1.535000,13.749100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.970900,-1.535000,14.706600>}
box{<0,0,-0.203200><1.354180,0.035000,0.203200> rotate<0,-44.994039,0> translate<31.013300,-1.535000,13.749100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.081800,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,13.817600>}
box{<0,0,-0.203200><0.617400,0.035000,0.203200> rotate<0,0.000000,0> translate<31.081800,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,11.209000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,5.300900>}
box{<0,0,-0.203200><5.908100,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.216600,-1.535000,5.300900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.216600,-1.535000,15.460900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,-1.535000,15.773300>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.216600,-1.535000,15.460900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.335800,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.637300,-1.535000,12.598400>}
box{<0,0,-0.203200><2.301500,0.035000,0.203200> rotate<0,0.000000,0> translate<31.335800,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.488200,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,14.224000>}
box{<0,0,-0.203200><0.211000,0.035000,0.203200> rotate<0,0.000000,0> translate<31.488200,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,0.000000,8.356600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,8.356600>}
box{<0,0,-0.203200><0.261700,0.035000,0.203200> rotate<0,0.000000,0> translate<31.529000,0.000000,8.356600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,0.000000,9.423300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.469000,0.000000,10.363200>}
box{<0,0,-0.203200><1.329290,0.035000,0.203200> rotate<0,-44.993983,0> translate<31.529000,0.000000,9.423300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.529000,-1.535000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.994100,-1.535000,15.773300>}
box{<0,0,-0.203200><0.465100,0.035000,0.203200> rotate<0,0.000000,0> translate<31.529000,-1.535000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.114100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,2.489200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<31.699200,0.000000,3.114100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.997800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.114100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,0.000000,3.114100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,3.997800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,4.622700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.699200,0.000000,3.997800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,5.654100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,5.029200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<31.699200,0.000000,5.654100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,5.816600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,0.000000,5.654100>}
box{<0,0,-0.203200><0.162500,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,0.000000,5.654100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,13.528100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,12.903200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<31.699200,-1.535000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,13.528100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,-1.535000,13.528100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,14.411800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.994100,-1.535000,14.706600>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,-44.987315,0> translate<31.699200,-1.535000,14.411800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.068100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.994100,-1.535000,15.773300>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,44.987315,0> translate<31.699200,-1.535000,16.068100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.951800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.068100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,-1.535000,16.068100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,16.951800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,17.576700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.699200,-1.535000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,18.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,17.983200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<31.699200,-1.535000,18.608100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,19.491800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,18.608100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,-1.535000,18.608100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,19.491800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,20.116700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.699200,-1.535000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,21.148100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,20.523200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<31.699200,-1.535000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,21.148100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.699200,-1.535000,21.148100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.699200,-1.535000,22.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,22.656700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.699200,-1.535000,22.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.742200,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.019500,-1.535000,12.192000>}
box{<0,0,-0.203200><0.277300,0.035000,0.203200> rotate<0,0.000000,0> translate<31.742200,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,8.356600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,7.823200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<31.790700,0.000000,8.356600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,10.363200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<31.790700,0.000000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,15.976600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,15.443200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<31.790700,0.000000,15.976600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,17.043300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,17.576700>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.790700,0.000000,17.043300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,18.516600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,17.983200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<31.790700,0.000000,18.516600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,19.583300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,20.116700>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.790700,0.000000,19.583300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,20.523200>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<31.790700,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.790700,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,22.656700>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.790700,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.880800,-1.535000,12.053300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,12.496700>}
box{<0,0,-0.203200><0.626992,0.035000,0.203200> rotate<0,-45.003491,0> translate<31.880800,-1.535000,12.053300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.894600,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.917900,-1.535000,14.630400>}
box{<0,0,-0.203200><0.023300,0.035000,0.203200> rotate<0,0.000000,0> translate<31.894600,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.970900,-1.535000,14.706600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.994100,-1.535000,14.706600>}
box{<0,0,-0.203200><0.023200,0.035000,0.203200> rotate<0,0.000000,0> translate<31.970900,-1.535000,14.706600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.044800,0.000000,6.883300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,7.162700>}
box{<0,0,-0.203200><0.395061,0.035000,0.203200> rotate<0,-45.007285,0> translate<32.044800,0.000000,6.883300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.121800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.864100>}
box{<0,0,-0.203200><0.742300,0.035000,0.203200> rotate<0,90.000000,0> translate<32.283300,-1.535000,7.864100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.121800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,7.162700>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,-45.067155,0> translate<32.283300,-1.535000,7.121800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,7.315200>}
box{<0,0,-0.203200><6.121500,0.035000,0.203200> rotate<0,0.000000,0> translate<32.283300,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572600,-1.535000,7.721600>}
box{<0,0,-0.203200><6.289300,0.035000,0.203200> rotate<0,0.000000,0> translate<32.283300,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,7.864100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,7.823200>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,45.067155,0> translate<32.283300,-1.535000,7.864100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,9.915800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,10.404100>}
box{<0,0,-0.203200><0.488300,0.035000,0.203200> rotate<0,90.000000,0> translate<32.283300,-1.535000,10.404100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,9.915800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,9.956700>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,-45.067155,0> translate<32.283300,-1.535000,9.915800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,10.160000>}
box{<0,0,-0.203200><2.971900,0.035000,0.203200> rotate<0,0.000000,0> translate<32.283300,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.283300,-1.535000,10.404100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,10.363200>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,45.067155,0> translate<32.283300,-1.535000,10.404100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,2.489200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,2.489200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,2.489200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,4.622700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.078500,0.000000,4.622700>}
box{<0,0,-0.203200><0.754400,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,4.622700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,5.029200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,5.029200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,5.029200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,7.162700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.078400,0.000000,7.162700>}
box{<0,0,-0.203200><0.754300,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,7.162700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,7.162700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,7.162700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,7.162700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,7.823200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,7.823200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,9.956700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.469000,0.000000,10.363200>}
box{<0,0,-0.203200><0.144900,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,10.363200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,12.496700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,12.903200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.469000,0.000000,15.443200>}
box{<0,0,-0.203200><0.144900,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,17.576700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,17.576700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,17.983200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,17.983200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,20.116700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,20.116700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,20.523200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,20.523200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,22.656700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.324100,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,22.656700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<32.324100,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.078400,0.000000,7.162700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.756600,0.000000,7.840900>}
box{<0,0,-0.203200><0.959120,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.078400,0.000000,7.162700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.078500,0.000000,4.622700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,7.840900>}
box{<0,0,-0.203200><4.551151,0.035000,0.203200> rotate<0,-44.997920,0> translate<33.078500,0.000000,4.622700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,2.489200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.114100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,0.000000,2.489200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,5.029200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,5.654100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,0.000000,5.029200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,7.162700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,6.537800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,7.162700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.756600,0.000000,8.372100>}
box{<0,0,-0.203200><0.776191,0.035000,0.203200> rotate<0,-45.002249,0> translate<33.207800,0.000000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,7.823200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,8.448100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,-1.535000,7.823200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,9.956700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,9.331800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,9.956700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,10.363200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,10.988100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,-1.535000,10.363200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,12.496700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,11.871800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,12.496700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,12.903200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.270100,-1.535000,12.965600>}
box{<0,0,-0.203200><0.088176,0.035000,0.203200> rotate<0,-45.042974,0> translate<33.207800,-1.535000,12.903200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,16.951800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,0.000000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,17.576700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.951800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,17.576700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.270100,-1.535000,18.045600>}
box{<0,0,-0.203200><0.088176,0.035000,0.203200> rotate<0,-45.042974,0> translate<33.207800,-1.535000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,17.983200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,18.608100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,0.000000,17.983200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,19.491800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,0.000000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,20.116700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,19.491800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,20.116700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.741200,-1.535000,21.056600>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,-1.535000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,20.523200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,21.148100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.207800,0.000000,20.523200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,-1.535000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.741200,-1.535000,22.123300>}
box{<0,0,-0.203200><0.754342,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,-1.535000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.207800,0.000000,22.656700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,22.031800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<33.207800,0.000000,22.656700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.270100,-1.535000,12.965600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.571600,-1.535000,10.664100>}
box{<0,0,-0.203200><3.254813,0.035000,0.203200> rotate<0,44.997030,0> translate<33.270100,-1.535000,12.965600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.270100,-1.535000,18.045600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.542400,-1.535000,15.773300>}
box{<0,0,-0.203200><3.213517,0.035000,0.203200> rotate<0,44.997030,0> translate<33.270100,-1.535000,18.045600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.283800,-1.535000,4.546600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.997800>}
box{<0,0,-0.203200><0.776191,0.035000,0.203200> rotate<0,44.991811,0> translate<33.283800,-1.535000,4.546600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.283800,-1.535000,4.546600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,4.546600>}
box{<0,0,-0.203200><1.971400,0.035000,0.203200> rotate<0,0.000000,0> translate<33.283800,-1.535000,4.546600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.309300,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.840500,-1.535000,17.475200>}
box{<0,0,-0.203200><0.531200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.309300,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.309300,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.501000,0.000000,17.475200>}
box{<0,0,-0.203200><1.191700,0.035000,0.203200> rotate<0,0.000000,0> translate<33.309300,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.360100,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,4.470400>}
box{<0,0,-0.203200><1.895100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.360100,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.410900,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,9.753600>}
box{<0,0,-0.203200><1.844300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.410900,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.410900,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.423000,0.000000,19.913600>}
box{<0,0,-0.203200><2.012100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.410900,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.410900,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.423000,-1.535000,19.913600>}
box{<0,0,-0.203200><2.012100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.410900,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.411000,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.473900,-1.535000,10.566400>}
box{<0,0,-0.203200><2.062900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.411000,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.411000,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.752200,-1.535000,20.726400>}
box{<0,0,-0.203200><4.341200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.411000,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.411000,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.891700,0.000000,20.726400>}
box{<0,0,-0.203200><5.480700,0.035000,0.203200> rotate<0,0.000000,0> translate<33.411000,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.461700,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,6.908800>}
box{<0,0,-0.203200><4.943100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.461700,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.461800,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.739000,0.000000,5.283200>}
box{<0,0,-0.203200><0.277200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.461800,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512500,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.756600,0.000000,8.128000>}
box{<0,0,-0.203200><0.244100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512500,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512500,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.043700,-1.535000,12.192000>}
box{<0,0,-0.203200><0.531200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512500,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512500,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.377700,-1.535000,22.352000>}
box{<0,0,-0.203200><5.865200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512500,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512500,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.495400,0.000000,22.352000>}
box{<0,0,-0.203200><18.982900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512500,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512600,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.137000,-1.535000,8.128000>}
box{<0,0,-0.203200><5.624400,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512600,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.512600,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.313800,0.000000,18.288000>}
box{<0,0,-0.203200><1.801200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.512600,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.537800,-1.535000,14.706600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,14.411800>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,44.987315,0> translate<33.537800,-1.535000,14.706600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.537800,-1.535000,14.706600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.296100,-1.535000,14.706600>}
box{<0,0,-0.203200><1.758300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.537800,-1.535000,14.706600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.537800,-1.535000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.068100>}
box{<0,0,-0.203200><0.416981,0.035000,0.203200> rotate<0,-44.987315,0> translate<33.537800,-1.535000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.537800,-1.535000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.339000,-1.535000,15.773300>}
box{<0,0,-0.203200><1.801200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.537800,-1.535000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.563400,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.310800,0.000000,2.844800>}
box{<0,0,-0.203200><4.747400,0.035000,0.203200> rotate<0,0.000000,0> translate<33.563400,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.614100,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,14.630400>}
box{<0,0,-0.203200><1.641100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.614100,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.614100,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.466100,-1.535000,15.849600>}
box{<0,0,-0.203200><1.852000,0.035000,0.203200> rotate<0,0.000000,0> translate<33.614100,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.715700,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.094600,0.000000,17.068800>}
box{<0,0,-0.203200><0.378900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.715700,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.715700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.246900,-1.535000,17.068800>}
box{<0,0,-0.203200><0.531200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.715700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.741200,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.082400,-1.535000,21.056600>}
box{<0,0,-0.203200><4.341200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.741200,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.741200,-1.535000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,-1.535000,22.123300>}
box{<0,0,-0.203200><5.407800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.741200,-1.535000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.756600,0.000000,8.372100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.756600,0.000000,7.840900>}
box{<0,0,-0.203200><0.531200,0.035000,0.203200> rotate<0,-90.000000,0> translate<33.756600,0.000000,7.840900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.766500,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.575300,-1.535000,4.064000>}
box{<0,0,-0.203200><1.808800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.766500,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.791800,-1.535000,3.073300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.114100>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,-44.926905,0> translate<33.791800,-1.535000,3.073300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.791800,-1.535000,3.073300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.689000,-1.535000,3.073300>}
box{<0,0,-0.203200><7.897200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.791800,-1.535000,3.073300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.791800,-1.535000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,5.654100>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,-44.926905,0> translate<33.791800,-1.535000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.791800,-1.535000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.600700,-1.535000,5.613300>}
box{<0,0,-0.203200><1.808900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.791800,-1.535000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.817300,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.372100,-1.535000,9.347200>}
box{<0,0,-0.203200><1.554800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.817300,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.817300,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,19.507200>}
box{<0,0,-0.203200><1.437900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.817300,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.817300,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,19.507200>}
box{<0,0,-0.203200><1.437900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.817300,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.817400,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.262900,-1.535000,10.972800>}
box{<0,0,-0.203200><1.445500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.817400,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.817400,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.778500,0.000000,21.132800>}
box{<0,0,-0.203200><11.961100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.817400,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.114100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.868500>}
box{<0,0,-0.203200><0.754400,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,0.000000,3.868500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.114100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.997800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,3.997800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.904400,0.000000,3.251200>}
box{<0,0,-0.203200><4.071700,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.867000,-1.535000,3.251200>}
box{<0,0,-0.203200><8.034300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.498000,0.000000,3.657600>}
box{<0,0,-0.203200><3.665300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.805400,-1.535000,3.657600>}
box{<0,0,-0.203200><4.972700,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,3.868500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,7.399000>}
box{<0,0,-0.203200><4.992952,0.035000,0.203200> rotate<0,-44.996219,0> translate<33.832700,0.000000,3.868500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,5.654100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,6.408400>}
box{<0,0,-0.203200><0.754300,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,0.000000,6.408400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,5.654100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,6.537800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,6.537800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.145400,0.000000,5.689600>}
box{<0,0,-0.203200><0.312700,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.677000,-1.535000,5.689600>}
box{<0,0,-0.203200><1.844300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.551800,0.000000,6.096000>}
box{<0,0,-0.203200><0.719100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.136600,-1.535000,6.096000>}
box{<0,0,-0.203200><5.303900,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,6.408400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,7.399000>}
box{<0,0,-0.203200><1.400920,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.832700,0.000000,6.408400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572500,-1.535000,6.502400>}
box{<0,0,-0.203200><4.739800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,8.448100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,9.331800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,9.331800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,8.534400>}
box{<0,0,-0.203200><24.092100,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.778500,-1.535000,8.940800>}
box{<0,0,-0.203200><1.945800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,10.988100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,11.871800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,11.871800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.856500,-1.535000,11.379200>}
box{<0,0,-0.203200><1.023800,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.450100,-1.535000,11.785600>}
box{<0,0,-0.203200><0.617400,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,13.911500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,14.411800>}
box{<0,0,-0.203200><0.500300,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,14.411800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,13.911500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,10.626100>}
box{<0,0,-0.203200><4.646187,0.035000,0.203200> rotate<0,44.997902,0> translate<33.832700,-1.535000,13.911500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,14.224000>}
box{<0,0,-0.203200><1.422500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.068100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.951800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.059700,-1.535000,16.256000>}
box{<0,0,-0.203200><1.227000,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.653300,-1.535000,16.662400>}
box{<0,0,-0.203200><0.820600,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,16.806900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,16.951800>}
box{<0,0,-0.203200><0.144900,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,0.000000,16.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,16.806900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.571600,0.000000,18.545800>}
box{<0,0,-0.203200><2.459176,0.035000,0.203200> rotate<0,-44.997030,0> translate<33.832700,0.000000,16.806900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,18.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,19.491800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,0.000000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.422900,0.000000,18.694400>}
box{<0,0,-0.203200><1.590200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,18.991400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,19.491800>}
box{<0,0,-0.203200><0.500400,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,-1.535000,19.491800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,18.991400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.475900,-1.535000,14.348200>}
box{<0,0,-0.203200><6.566476,0.035000,0.203200> rotate<0,44.997030,0> translate<33.832700,-1.535000,18.991400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,19.100800>}
box{<0,0,-0.203200><1.422500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,19.100800>}
box{<0,0,-0.203200><1.422500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,21.148100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,22.031800>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,90.000000,0> translate<33.832700,0.000000,22.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.184900,0.000000,21.539200>}
box{<0,0,-0.203200><12.352200,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.832700,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.591300,0.000000,21.945600>}
box{<0,0,-0.203200><12.758600,0.035000,0.203200> rotate<0,0.000000,0> translate<33.832700,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.926600,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,13.817600>}
box{<0,0,-0.203200><1.328600,0.035000,0.203200> rotate<0,0.000000,0> translate<33.926600,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.926700,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.958200,0.000000,6.502400>}
box{<0,0,-0.203200><1.031500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.926700,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.028200,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.575300,0.000000,4.064000>}
box{<0,0,-0.203200><1.547100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.028200,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.129700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.422900,-1.535000,18.694400>}
box{<0,0,-0.203200><1.293200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.129700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.333000,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.626100,-1.535000,13.411200>}
box{<0,0,-0.203200><1.293100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.333000,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.333100,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.364600,0.000000,6.908800>}
box{<0,0,-0.203200><1.031500,0.035000,0.203200> rotate<0,0.000000,0> translate<34.333100,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.434600,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,4.470400>}
box{<0,0,-0.203200><0.820600,0.035000,0.203200> rotate<0,0.000000,0> translate<34.434600,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.536100,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.829300,-1.535000,18.288000>}
box{<0,0,-0.203200><1.293200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.536100,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.739400,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,13.004800>}
box{<0,0,-0.203200><2.827200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.739400,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.739500,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.771000,0.000000,7.315200>}
box{<0,0,-0.203200><1.031500,0.035000,0.203200> rotate<0,0.000000,0> translate<34.739500,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,7.399000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,7.840900>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,90.000000,0> translate<34.823300,0.000000,7.840900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.177400,0.000000,7.721600>}
box{<0,0,-0.203200><1.354100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,7.840900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,9.939000>}
box{<0,0,-0.203200><2.098100,0.035000,0.203200> rotate<0,90.000000,0> translate<34.823300,0.000000,9.939000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,8.128000>}
box{<0,0,-0.203200><1.473300,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,8.534400>}
box{<0,0,-0.203200><1.473300,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.778500,0.000000,8.940800>}
box{<0,0,-0.203200><0.955200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.372100,0.000000,9.347200>}
box{<0,0,-0.203200><0.548800,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,9.753600>}
box{<0,0,-0.203200><0.431900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,9.939000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.789600,0.000000,13.905400>}
box{<0,0,-0.203200><5.609266,0.035000,0.203200> rotate<0,-44.997752,0> translate<34.823300,0.000000,9.939000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,11.447500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,11.650900>}
box{<0,0,-0.203200><0.203400,0.035000,0.203200> rotate<0,90.000000,0> translate<34.823300,0.000000,11.650900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,11.447500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.533000,0.000000,13.157200>}
box{<0,0,-0.203200><2.417881,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.823300,0.000000,11.447500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,11.650900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,15.019000>}
box{<0,0,-0.203200><3.368100,0.035000,0.203200> rotate<0,90.000000,0> translate<34.823300,0.000000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.161400,0.000000,11.785600>}
box{<0,0,-0.203200><0.338100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.567800,0.000000,12.192000>}
box{<0,0,-0.203200><0.744500,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.974200,0.000000,12.598400>}
box{<0,0,-0.203200><1.150900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.380600,0.000000,13.004800>}
box{<0,0,-0.203200><1.557300,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.626100,0.000000,13.411200>}
box{<0,0,-0.203200><0.802800,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,13.817600>}
box{<0,0,-0.203200><0.431900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,14.224000>}
box{<0,0,-0.203200><0.431900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,14.630400>}
box{<0,0,-0.203200><0.431900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.823300,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.823300,0.000000,15.019000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.789600,0.000000,18.985400>}
box{<0,0,-0.203200><5.609266,0.035000,0.203200> rotate<0,-44.997752,0> translate<34.823300,0.000000,15.019000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.841000,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,4.876800>}
box{<0,0,-0.203200><0.414200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.841000,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.841000,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.626200,0.000000,15.036800>}
box{<0,0,-0.203200><0.785200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.841000,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.942500,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572600,-1.535000,17.881600>}
box{<0,0,-0.203200><3.630100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.942500,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.044200,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,10.160000>}
box{<0,0,-0.203200><0.211000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.044200,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.145800,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,12.598400>}
box{<0,0,-0.203200><2.420800,0.035000,0.203200> rotate<0,0.000000,0> translate<35.145800,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.247400,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.270600,0.000000,5.283200>}
box{<0,0,-0.203200><0.023200,0.035000,0.203200> rotate<0,0.000000,0> translate<35.247400,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.247400,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.674200,0.000000,15.443200>}
box{<0,0,-0.203200><3.426800,0.035000,0.203200> rotate<0,0.000000,0> translate<35.247400,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,4.384100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,3.759200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,0.000000,4.384100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,4.384100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,3.759200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,-1.535000,4.384100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,4.546600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,4.384100>}
box{<0,0,-0.203200><0.162500,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,-1.535000,4.384100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,5.267800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,4.384100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,0.000000,4.384100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,5.267800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,5.892700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.255200,0.000000,5.267800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,9.464100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,8.839200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,0.000000,9.464100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,9.464100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,8.839200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,-1.535000,9.464100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,10.347800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,9.464100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,0.000000,9.464100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,10.347800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,9.464100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,-1.535000,9.464100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,10.347800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.571600,-1.535000,10.664100>}
box{<0,0,-0.203200><0.447386,0.035000,0.203200> rotate<0,-44.987975,0> translate<35.255200,-1.535000,10.347800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,10.347800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,10.972700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.255200,0.000000,10.347800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,13.782100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,13.157200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,0.000000,13.782100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,13.782100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,13.157200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,-1.535000,13.782100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,14.665800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,13.782100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,0.000000,13.782100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,14.665800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,13.782100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,-1.535000,13.782100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,14.665800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.296100,-1.535000,14.706600>}
box{<0,0,-0.203200><0.057771,0.035000,0.203200> rotate<0,-44.926905,0> translate<35.255200,-1.535000,14.665800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,14.665800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,15.290700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.255200,0.000000,14.665800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,18.862100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.571600,0.000000,18.545800>}
box{<0,0,-0.203200><0.447386,0.035000,0.203200> rotate<0,44.987975,0> translate<35.255200,0.000000,18.862100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,18.862100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,18.237200>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<35.255200,-1.535000,18.862100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,19.745800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,18.862100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,0.000000,18.862100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,19.745800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,18.862100>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.255200,-1.535000,18.862100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,0.000000,19.745800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,20.370700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.255200,0.000000,19.745800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.255200,-1.535000,19.745800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,20.370700>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.255200,-1.535000,19.745800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.339000,-1.535000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.542400,-1.535000,15.773300>}
box{<0,0,-0.203200><0.203400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.339000,-1.535000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.348900,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.475200>}
box{<0,0,-0.203200><3.055900,0.035000,0.203200> rotate<0,0.000000,0> translate<35.348900,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.450600,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.473800,0.000000,10.566400>}
box{<0,0,-0.203200><0.023200,0.035000,0.203200> rotate<0,0.000000,0> translate<35.450600,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.552200,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,12.192000>}
box{<0,0,-0.203200><2.014400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.552200,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.600700,-1.535000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,5.892700>}
box{<0,0,-0.203200><0.395131,0.035000,0.203200> rotate<0,-44.997030,0> translate<35.600700,-1.535000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.653800,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.677000,0.000000,5.689600>}
box{<0,0,-0.203200><0.023200,0.035000,0.203200> rotate<0,0.000000,0> translate<35.653800,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.653800,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.623200,0.000000,15.849600>}
box{<0,0,-0.203200><16.969400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.653800,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.755300,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.068800>}
box{<0,0,-0.203200><2.649500,0.035000,0.203200> rotate<0,0.000000,0> translate<35.755300,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.857000,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.826400,0.000000,10.972800>}
box{<0,0,-0.203200><16.969400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.857000,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,3.759200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,3.759200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,3.759200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,3.759200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,3.759200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,3.759200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,5.892700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,5.892700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,5.892700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,5.892700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,5.892700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,5.892700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,8.839200>}
box{<0,0,-0.203200><0.416500,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,8.839200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,10.972700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,10.972700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,10.972700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,13.157200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.533000,0.000000,13.157200>}
box{<0,0,-0.203200><0.652900,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,13.157200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,13.157200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,13.157200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,13.157200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,15.290700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,15.290700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,15.290700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,18.237200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,18.237200>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,18.237200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,0.000000,20.370700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,20.370700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,0.000000,20.370700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.880100,-1.535000,20.370700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,20.370700>}
box{<0,0,-0.203200><0.883700,0.035000,0.203200> rotate<0,0.000000,0> translate<35.880100,-1.535000,20.370700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.958600,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,11.785600>}
box{<0,0,-0.203200><1.608000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.958600,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.060200,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.136600,0.000000,6.096000>}
box{<0,0,-0.203200><3.076400,0.035000,0.203200> rotate<0,0.000000,0> translate<36.060200,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.060200,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.136600,0.000000,16.256000>}
box{<0,0,-0.203200><3.076400,0.035000,0.203200> rotate<0,0.000000,0> translate<36.060200,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.161700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572500,-1.535000,16.662400>}
box{<0,0,-0.203200><2.410800,0.035000,0.203200> rotate<0,0.000000,0> translate<36.161700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.263400,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.775700,0.000000,11.379200>}
box{<0,0,-0.203200><2.512300,0.035000,0.203200> rotate<0,0.000000,0> translate<36.263400,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.296600,0.000000,7.840900>}
box{<0,0,-0.203200><0.998300,0.035000,0.203200> rotate<0,-90.000000,0> translate<36.296600,0.000000,7.840900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.365000,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,11.379200>}
box{<0,0,-0.203200><1.201600,0.035000,0.203200> rotate<0,0.000000,0> translate<36.365000,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.466600,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572500,0.000000,6.502400>}
box{<0,0,-0.203200><2.105900,0.035000,0.203200> rotate<0,0.000000,0> translate<36.466600,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.466600,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572500,0.000000,16.662400>}
box{<0,0,-0.203200><2.105900,0.035000,0.203200> rotate<0,0.000000,0> translate<36.466600,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.568100,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.136600,-1.535000,16.256000>}
box{<0,0,-0.203200><2.568500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.568100,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.669800,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.485200,0.000000,11.785600>}
box{<0,0,-0.203200><1.815400,0.035000,0.203200> rotate<0,0.000000,0> translate<36.669800,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,3.759200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.080100,0.000000,4.075600>}
box{<0,0,-0.203200><0.447386,0.035000,0.203200> rotate<0,-45.006085,0> translate<36.763800,0.000000,3.759200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,3.759200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,4.384100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<36.763800,-1.535000,3.759200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,5.892700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,0.000000,5.613300>}
box{<0,0,-0.203200><0.395131,0.035000,0.203200> rotate<0,44.997030,0> translate<36.763800,0.000000,5.892700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,5.892700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,-1.535000,5.613300>}
box{<0,0,-0.203200><0.395131,0.035000,0.203200> rotate<0,44.997030,0> translate<36.763800,-1.535000,5.892700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,9.464100>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,-44.997030,0> translate<36.763800,-1.535000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,10.972700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,0.000000,10.693300>}
box{<0,0,-0.203200><0.395131,0.035000,0.203200> rotate<0,44.997030,0> translate<36.763800,0.000000,10.972700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,13.157200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043100,-1.535000,13.436600>}
box{<0,0,-0.203200><0.395061,0.035000,0.203200> rotate<0,-45.007285,0> translate<36.763800,-1.535000,13.157200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,15.290700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.665800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<36.763800,0.000000,15.290700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,18.237200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043100,-1.535000,18.516600>}
box{<0,0,-0.203200><0.395061,0.035000,0.203200> rotate<0,-45.007285,0> translate<36.763800,-1.535000,18.237200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,-1.535000,20.370700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.080100,-1.535000,20.054300>}
box{<0,0,-0.203200><0.447386,0.035000,0.203200> rotate<0,45.006085,0> translate<36.763800,-1.535000,20.370700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.763800,0.000000,20.370700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.745800>}
box{<0,0,-0.203200><0.883742,0.035000,0.203200> rotate<0,44.997030,0> translate<36.763800,0.000000,20.370700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.771400,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.802800,-1.535000,10.972800>}
box{<0,0,-0.203200><1.031400,0.035000,0.203200> rotate<0,0.000000,0> translate<36.771400,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.814500,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.137000,-1.535000,18.288000>}
box{<0,0,-0.203200><2.322500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.814500,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.814500,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.345800,-1.535000,20.320000>}
box{<0,0,-0.203200><0.531300,0.035000,0.203200> rotate<0,0.000000,0> translate<36.814500,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.814500,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.527400,0.000000,20.320000>}
box{<0,0,-0.203200><1.712900,0.035000,0.203200> rotate<0,0.000000,0> translate<36.814500,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.865400,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.674100,-1.535000,8.940800>}
box{<0,0,-0.203200><1.808700,0.035000,0.203200> rotate<0,0.000000,0> translate<36.865400,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.873000,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,6.908800>}
box{<0,0,-0.203200><1.531800,0.035000,0.203200> rotate<0,0.000000,0> translate<36.873000,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.873000,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.068800>}
box{<0,0,-0.203200><1.531800,0.035000,0.203200> rotate<0,0.000000,0> translate<36.873000,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.966900,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.816000,0.000000,5.689600>}
box{<0,0,-0.203200><4.849100,0.035000,0.203200> rotate<0,0.000000,0> translate<36.966900,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.966900,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.305400,-1.535000,5.689600>}
box{<0,0,-0.203200><7.338500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.966900,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.974500,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.035400,-1.535000,15.849600>}
box{<0,0,-0.203200><6.060900,0.035000,0.203200> rotate<0,0.000000,0> translate<36.974500,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.017700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,13.411200>}
box{<0,0,-0.203200><0.548900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.017700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.017700,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.412600,0.000000,15.036800>}
box{<0,0,-0.203200><1.394900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.017700,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043100,-1.535000,13.436600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,13.436600>}
box{<0,0,-0.203200><0.007800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.043100,-1.535000,13.436600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043100,-1.535000,18.516600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,18.516600>}
box{<0,0,-0.203200><0.007800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.043100,-1.535000,18.516600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,0.000000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,0.000000,5.613300>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.043200,0.000000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,-1.535000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,5.613300>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.043200,-1.535000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.043200,0.000000,10.693300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,0.000000,10.693300>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.043200,0.000000,10.693300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,0.000000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,0.000000,5.546100>}
box{<0,0,-0.203200><0.094964,0.035000,0.203200> rotate<0,45.039690,0> translate<37.050900,0.000000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,5.613300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,5.546100>}
box{<0,0,-0.203200><0.094964,0.035000,0.203200> rotate<0,45.039690,0> translate<37.050900,-1.535000,5.613300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,0.000000,10.693300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,0.000000,10.626100>}
box{<0,0,-0.203200><0.094964,0.035000,0.203200> rotate<0,45.039690,0> translate<37.050900,0.000000,10.693300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,13.436600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,13.503800>}
box{<0,0,-0.203200><0.094964,0.035000,0.203200> rotate<0,-45.039690,0> translate<37.050900,-1.535000,13.436600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.050900,-1.535000,18.516600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,18.583800>}
box{<0,0,-0.203200><0.094964,0.035000,0.203200> rotate<0,-45.039690,0> translate<37.050900,-1.535000,18.516600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.068500,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.091600,0.000000,4.064000>}
box{<0,0,-0.203200><0.023100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.068500,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.068600,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.472200,-1.535000,4.064000>}
box{<0,0,-0.203200><1.403600,0.035000,0.203200> rotate<0,0.000000,0> translate<37.068600,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.076200,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,12.192000>}
box{<0,0,-0.203200><1.328600,0.035000,0.203200> rotate<0,0.000000,0> translate<37.076200,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.080100,0.000000,4.075600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.419000,0.000000,0.736600>}
box{<0,0,-0.203200><4.721988,0.035000,0.203200> rotate<0,44.997888,0> translate<37.080100,0.000000,4.075600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.080100,-1.535000,20.054300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.082400,-1.535000,21.056600>}
box{<0,0,-0.203200><1.417466,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.080100,-1.535000,20.054300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,0.000000,5.546100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,0.000000,5.516100>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,18.395614,0> translate<37.118000,0.000000,5.546100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,5.546100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,5.516100>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,18.395614,0> translate<37.118000,-1.535000,5.546100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,0.000000,10.626100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,0.000000,10.596100>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,18.395614,0> translate<37.118000,0.000000,10.626100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,10.626100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,10.596100>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,18.395614,0> translate<37.118000,-1.535000,10.626100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,13.503800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,13.533800>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,-18.395614,0> translate<37.118000,-1.535000,13.503800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.118000,-1.535000,18.583800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,18.613800>}
box{<0,0,-0.203200><0.095058,0.035000,0.203200> rotate<0,-18.395614,0> translate<37.118000,-1.535000,18.583800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,0.000000,5.516100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,0.000000,5.395900>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,63.430762,0> translate<37.208200,0.000000,5.516100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,5.516100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,5.395900>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,63.430762,0> translate<37.208200,-1.535000,5.516100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,0.000000,10.596100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,0.000000,10.475900>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,63.430762,0> translate<37.208200,0.000000,10.596100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,10.596100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,10.475900>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,63.430762,0> translate<37.208200,-1.535000,10.596100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,13.533800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,13.654000>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,-63.430762,0> translate<37.208200,-1.535000,13.533800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.208200,-1.535000,18.613800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,18.734000>}
box{<0,0,-0.203200><0.134388,0.035000,0.203200> rotate<0,-63.430762,0> translate<37.208200,-1.535000,18.613800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.220900,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.209400,0.000000,19.913600>}
box{<0,0,-0.203200><0.988500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.220900,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.223100,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.209200,-1.535000,10.566400>}
box{<0,0,-0.203200><0.986100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.223100,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.223100,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.891700,0.000000,10.566400>}
box{<0,0,-0.203200><1.668600,0.035000,0.203200> rotate<0,0.000000,0> translate<37.223100,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.248500,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,18.694400>}
box{<0,0,-0.203200><7.938100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.248500,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,5.395900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,5.300900>}
box{<0,0,-0.203200><0.134350,0.035000,0.203200> rotate<0,44.997030,0> translate<37.268300,-1.535000,5.395900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,0.000000,5.395900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.382000,0.000000,4.282100>}
box{<0,0,-0.203200><1.575080,0.035000,0.203200> rotate<0,44.999602,0> translate<37.268300,0.000000,5.395900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,0.000000,10.475900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,10.380900>}
box{<0,0,-0.203200><0.134350,0.035000,0.203200> rotate<0,44.997030,0> translate<37.268300,0.000000,10.475900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,10.475900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,10.380900>}
box{<0,0,-0.203200><0.134350,0.035000,0.203200> rotate<0,44.997030,0> translate<37.268300,-1.535000,10.475900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,13.654000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,13.749000>}
box{<0,0,-0.203200><0.134350,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.268300,-1.535000,13.654000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.268300,-1.535000,18.734000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,19.870600>}
box{<0,0,-0.203200><1.607324,0.035000,0.203200> rotate<0,-44.999551,0> translate<37.268300,-1.535000,18.734000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.271800,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443100,-1.535000,9.347200>}
box{<0,0,-0.203200><1.171300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.271800,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.279400,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,7.315200>}
box{<0,0,-0.203200><1.125400,0.035000,0.203200> rotate<0,0.000000,0> translate<37.279400,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.279400,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.475200>}
box{<0,0,-0.203200><1.125400,0.035000,0.203200> rotate<0,0.000000,0> translate<37.279400,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,5.293200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,5.300900>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,-1.535000,5.300900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,5.293200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.267800>}
box{<0,0,-0.203200><0.035921,0.035000,0.203200> rotate<0,44.997030,0> translate<37.363300,-1.535000,5.293200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,7.399000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,7.840900>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,0.000000,7.840900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572600,0.000000,7.721600>}
box{<0,0,-0.203200><1.209300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.363300,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,7.840900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,9.438700>}
box{<0,0,-0.203200><1.597800,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,0.000000,9.438700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.137000,0.000000,8.128000>}
box{<0,0,-0.203200><1.773700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.363300,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.960200,0.000000,8.534400>}
box{<0,0,-0.203200><13.596900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.363300,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.674100,0.000000,8.940800>}
box{<0,0,-0.203200><1.310800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.363300,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443100,0.000000,9.347200>}
box{<0,0,-0.203200><1.079800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.363300,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,9.438700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,9.464100>}
box{<0,0,-0.203200><0.035921,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.363300,0.000000,9.438700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,10.373200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,10.380900>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,0.000000,10.380900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,10.373200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,10.380900>}
box{<0,0,-0.203200><0.007700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,-1.535000,10.380900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,0.000000,10.373200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.347800>}
box{<0,0,-0.203200><0.035921,0.035000,0.203200> rotate<0,44.997030,0> translate<37.363300,0.000000,10.373200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,10.373200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.347800>}
box{<0,0,-0.203200><0.035921,0.035000,0.203200> rotate<0,44.997030,0> translate<37.363300,-1.535000,10.373200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,13.749000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,13.756800>}
box{<0,0,-0.203200><0.007800,0.035000,0.203200> rotate<0,90.000000,0> translate<37.363300,-1.535000,13.756800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.363300,-1.535000,13.756800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,13.782100>}
box{<0,0,-0.203200><0.035850,0.035000,0.203200> rotate<0,-44.884028,0> translate<37.363300,-1.535000,13.756800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.373300,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.602300,-1.535000,5.283200>}
box{<0,0,-0.203200><1.229000,0.035000,0.203200> rotate<0,0.000000,0> translate<37.373300,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.380900,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.674200,-1.535000,15.443200>}
box{<0,0,-0.203200><1.293300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.380900,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.381000,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.602300,0.000000,5.283200>}
box{<0,0,-0.203200><1.221300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.381000,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,4.384100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.069500>}
box{<0,0,-0.203200><0.685400,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,-1.535000,5.069500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.470400>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.388200,-1.535000,4.876800>}
box{<0,0,-0.203200><0.999500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.069500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,-1.535000,5.120900>}
box{<0,0,-0.203200><0.054170,0.035000,0.203200> rotate<0,-71.593774,0> translate<37.388700,-1.535000,5.069500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.155100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.267800>}
box{<0,0,-0.203200><0.112700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,-1.535000,5.267800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,5.155100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,-1.535000,5.120900>}
box{<0,0,-0.203200><0.038237,0.035000,0.203200> rotate<0,63.430762,0> translate<37.388700,-1.535000,5.155100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,9.464100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.149600>}
box{<0,0,-0.203200><0.685500,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,0.000000,10.149600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,9.464100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.149600>}
box{<0,0,-0.203200><0.685500,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,-1.535000,10.149600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,9.753600>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,9.753600>}
box{<0,0,-0.203200><1.016100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.149600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,0.000000,10.200900>}
box{<0,0,-0.203200><0.054075,0.035000,0.203200> rotate<0,-71.560328,0> translate<37.388700,0.000000,10.149600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.149600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,-1.535000,10.200900>}
box{<0,0,-0.203200><0.054075,0.035000,0.203200> rotate<0,-71.560328,0> translate<37.388700,-1.535000,10.149600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.235000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.347800>}
box{<0,0,-0.203200><0.112800,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,0.000000,10.347800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,10.235000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,0.000000,10.200900>}
box{<0,0,-0.203200><0.038147,0.035000,0.203200> rotate<0,63.363597,0> translate<37.388700,0.000000,10.235000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.235100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.347800>}
box{<0,0,-0.203200><0.112700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,-1.535000,10.347800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,10.235100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.405800,-1.535000,10.200900>}
box{<0,0,-0.203200><0.038237,0.035000,0.203200> rotate<0,63.430762,0> translate<37.388700,-1.535000,10.235100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,13.782100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,13.894800>}
box{<0,0,-0.203200><0.112700,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,-1.535000,13.894800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.498000,-1.535000,13.817600>}
box{<0,0,-0.203200><0.109300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,-1.535000,13.894800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.399400,-1.535000,13.916300>}
box{<0,0,-0.203200><0.024015,0.035000,0.203200> rotate<0,-63.537451,0> translate<37.388700,-1.535000,13.894800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.012900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.665800>}
box{<0,0,-0.203200><0.652900,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,0.000000,14.665800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.012900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.464900,0.000000,15.089100>}
box{<0,0,-0.203200><1.521977,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.388700,0.000000,14.012900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.599800,0.000000,14.224000>}
box{<0,0,-0.203200><0.211100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.006200,0.000000,14.630400>}
box{<0,0,-0.203200><0.617500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.092900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.745800>}
box{<0,0,-0.203200><0.652900,0.035000,0.203200> rotate<0,90.000000,0> translate<37.388700,0.000000,19.745800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.092900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.464900,0.000000,20.169100>}
box{<0,0,-0.203200><1.521977,0.035000,0.203200> rotate<0,-44.997030,0> translate<37.388700,0.000000,19.092900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.396600,0.000000,19.100800>}
box{<0,0,-0.203200><0.007900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.388700,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.803000,0.000000,19.507200>}
box{<0,0,-0.203200><0.414300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.388700,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.392100,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.527400,0.000000,10.160000>}
box{<0,0,-0.203200><1.135300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.392100,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.392100,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.527500,-1.535000,10.160000>}
box{<0,0,-0.203200><1.135400,0.035000,0.203200> rotate<0,0.000000,0> translate<37.392100,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.399400,-1.535000,13.916300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,13.749000>}
box{<0,0,-0.203200><0.236527,0.035000,0.203200> rotate<0,45.014158,0> translate<37.399400,-1.535000,13.916300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.482600,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.485300,0.000000,12.598400>}
box{<0,0,-0.203200><1.002700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.482600,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,11.209000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.879000,-1.535000,10.896600>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,44.997030,0> translate<37.566600,-1.535000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,13.749000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.566600,-1.535000,11.209000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,-90.000000,0> translate<37.566600,-1.535000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.635000,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.674100,-1.535000,19.100800>}
box{<0,0,-0.203200><1.039100,0.035000,0.203200> rotate<0,0.000000,0> translate<37.635000,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.685800,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.572600,0.000000,17.881600>}
box{<0,0,-0.203200><0.886800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.685800,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.787300,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443200,-1.535000,15.036800>}
box{<0,0,-0.203200><0.655900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.787300,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.787400,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.388200,0.000000,4.876800>}
box{<0,0,-0.203200><0.600800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.787400,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.879000,-1.535000,10.896600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.553300,-1.535000,10.222400>}
box{<0,0,-0.203200><0.953533,0.035000,0.203200> rotate<0,44.992782,0> translate<37.879000,-1.535000,10.896600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.889000,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.775800,0.000000,13.004800>}
box{<0,0,-0.203200><0.886800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.889000,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.041400,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443100,-1.535000,19.507200>}
box{<0,0,-0.203200><0.401700,0.035000,0.203200> rotate<0,0.000000,0> translate<38.041400,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.092200,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.137000,0.000000,18.288000>}
box{<0,0,-0.203200><1.044800,0.035000,0.203200> rotate<0,0.000000,0> translate<38.092200,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.193700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,14.630400>}
box{<0,0,-0.203200><0.211100,0.035000,0.203200> rotate<0,0.000000,0> translate<38.193700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.193800,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.470400>}
box{<0,0,-0.203200><0.160200,0.035000,0.203200> rotate<0,0.000000,0> translate<38.193800,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.295400,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.724800,0.000000,13.411200>}
box{<0,0,-0.203200><14.429400,0.035000,0.203200> rotate<0,0.000000,0> translate<38.295400,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.349600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.382000,0.000000,4.282100>}
box{<0,0,-0.203200><0.073077,0.035000,0.203200> rotate<0,67.466149,0> translate<38.354000,0.000000,4.349600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.349600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,-1.535000,3.938900>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,67.497630,0> translate<38.354000,-1.535000,4.349600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.349600>}
box{<0,0,-0.203200><0.221800,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.354000,0.000000,4.349600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.349600>}
box{<0,0,-0.203200><0.221800,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.354000,-1.535000,4.349600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,0.000000,4.571400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<38.354000,0.000000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,-1.535000,4.571400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<38.354000,-1.535000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,0.000000,4.572400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<38.354000,0.000000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,-1.535000,4.572400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<38.354000,-1.535000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.572400>}
box{<0,0,-0.203200><0.221900,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.354000,0.000000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.572400>}
box{<0,0,-0.203200><0.221900,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.354000,-1.535000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,0.000000,4.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,0.000000,5.205000>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-67.497630,0> translate<38.354000,0.000000,4.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.354000,-1.535000,4.794300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,-1.535000,5.205000>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-67.497630,0> translate<38.354000,-1.535000,4.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,6.899700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,6.507700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,0.000000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,6.899700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,6.507700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,-1.535000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,6.899700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,0.000000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,6.899700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,-1.535000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,7.716200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,0.000000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,7.716200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,-1.535000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,9.047700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,0.000000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,9.047700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,-1.535000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,9.439700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,0.000000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,9.439700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,-1.535000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.553300,-1.535000,10.222400>}
box{<0,0,-0.203200><0.387762,0.035000,0.203200> rotate<0,-67.477977,0> translate<38.404800,-1.535000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,10.256200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,0.000000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,11.587700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,0.000000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,11.979700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,0.000000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,12.796200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,0.000000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.475900,-1.535000,14.348200>}
box{<0,0,-0.203200><0.185654,0.035000,0.203200> rotate<0,67.477762,0> translate<38.404800,-1.535000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,14.519700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,-1.535000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,15.336200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,-1.535000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,16.667700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,0.000000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,16.667700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,-1.535000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.059700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,0.000000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.059700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,-1.535000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,0.000000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,17.876200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,0.000000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,17.876200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<38.404800,-1.535000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,19.207700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<38.404800,-1.535000,19.599700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,19.870600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.404800,-1.535000,19.599700>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,-90.000000,0> translate<38.404800,-1.535000,19.599700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.464900,0.000000,15.089100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,15.336200>}
box{<0,0,-0.203200><0.267439,0.035000,0.203200> rotate<0,-67.505871,0> translate<38.464900,0.000000,15.089100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.464900,0.000000,20.169100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,20.416200>}
box{<0,0,-0.203200><0.267439,0.035000,0.203200> rotate<0,-67.505871,0> translate<38.464900,0.000000,20.169100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.498600,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.340100,0.000000,18.694400>}
box{<0,0,-0.203200><4.841500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.498600,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,-1.535000,3.938900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,-1.535000,3.624500>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,44.997030,0> translate<38.524100,-1.535000,3.938900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,0.000000,5.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,0.000000,5.519400>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.524100,0.000000,5.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.524100,-1.535000,5.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,-1.535000,5.519400>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.524100,-1.535000,5.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,6.507700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,6.207600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,0.000000,6.507700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,6.507700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,6.207600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,-1.535000,6.507700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,8.016300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,8.016300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,-1.535000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,8.747600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,0.000000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,8.747600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,-1.535000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,10.556300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,11.287600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,0.000000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,13.096300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,15.636300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,15.636300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,-1.535000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,16.367600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,0.000000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,16.367600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,-1.535000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,18.176300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,18.176300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,-1.535000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,-1.535000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,18.907600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<38.567200,-1.535000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.567200,0.000000,20.416200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,20.716300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.567200,0.000000,20.416200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.701800,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.891400,0.000000,13.817600>}
box{<0,0,-0.203200><0.189600,0.035000,0.203200> rotate<0,0.000000,0> translate<38.701800,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.789600,0.000000,13.905400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,13.827600>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<38.789600,0.000000,13.905400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.789600,0.000000,18.985400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,18.907600>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<38.789600,0.000000,18.985400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,-1.535000,3.624500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,-1.535000,3.454400>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,22.496430,0> translate<38.838500,-1.535000,3.624500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,0.000000,5.519400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,0.000000,5.689500>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-22.496430,0> translate<38.838500,0.000000,5.519400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.838500,-1.535000,5.519400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,-1.535000,5.689500>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-22.496430,0> translate<38.838500,-1.535000,5.519400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,6.045200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,6.045200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,-1.535000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,8.178700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,0.000000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,8.178700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,-1.535000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,8.585200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,8.585200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,-1.535000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,10.718700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,0.000000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,11.125200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,13.258700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,0.000000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,13.665200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.041200,0.000000,15.708300>}
box{<0,0,-0.203200><0.188216,0.035000,0.203200> rotate<0,-22.489589,0> translate<38.867300,0.000000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,15.798700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,-1.535000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,16.205200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,16.205200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,-1.535000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,18.338700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,0.000000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,18.338700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<38.867300,-1.535000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,18.745200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,0.000000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,-1.535000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,18.745200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<38.867300,-1.535000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.867300,0.000000,20.716300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.041200,0.000000,20.788300>}
box{<0,0,-0.203200><0.188216,0.035000,0.203200> rotate<0,-22.489589,0> translate<38.867300,0.000000,20.716300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.041200,0.000000,15.708300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.048700,0.000000,15.719600>}
box{<0,0,-0.203200><0.013562,0.035000,0.203200> rotate<0,-56.423378,0> translate<39.041200,0.000000,15.708300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.041200,0.000000,20.788300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.048700,0.000000,20.799600>}
box{<0,0,-0.203200><0.013562,0.035000,0.203200> rotate<0,-56.423378,0> translate<39.041200,0.000000,20.788300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.048700,0.000000,15.719600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.086800,0.000000,15.727200>}
box{<0,0,-0.203200><0.038851,0.035000,0.203200> rotate<0,-11.280265,0> translate<39.048700,0.000000,15.719600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.048700,0.000000,20.799600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.086700,0.000000,20.807200>}
box{<0,0,-0.203200><0.038753,0.035000,0.203200> rotate<0,-11.309186,0> translate<39.048700,0.000000,20.799600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.086700,0.000000,20.807200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.114400,0.000000,20.818600>}
box{<0,0,-0.203200><0.029954,0.035000,0.203200> rotate<0,-22.368255,0> translate<39.086700,0.000000,20.807200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.086800,0.000000,15.727200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.114400,0.000000,15.738600>}
box{<0,0,-0.203200><0.029862,0.035000,0.203200> rotate<0,-22.441272,0> translate<39.086800,0.000000,15.727200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.087800,-1.535000,11.196300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,11.125200>}
box{<0,0,-0.203200><0.185654,0.035000,0.203200> rotate<0,22.516298,0> translate<39.087800,-1.535000,11.196300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.087800,-1.535000,11.196300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.565400,-1.535000,10.718700>}
box{<0,0,-0.203200><0.675428,0.035000,0.203200> rotate<0,44.997030,0> translate<39.087800,-1.535000,11.196300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.114400,0.000000,15.738600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,0.000000,15.773300>}
box{<0,0,-0.203200><0.049003,0.035000,0.203200> rotate<0,-45.079703,0> translate<39.114400,0.000000,15.738600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.114400,0.000000,20.818600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,0.000000,20.853300>}
box{<0,0,-0.203200><0.049003,0.035000,0.203200> rotate<0,-45.079703,0> translate<39.114400,0.000000,20.818600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,0.000000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.198100,0.000000,15.773300>}
box{<0,0,-0.203200><0.049100,0.035000,0.203200> rotate<0,0.000000,0> translate<39.149000,0.000000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,0.000000,20.853300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.198000,0.000000,20.853300>}
box{<0,0,-0.203200><0.049000,0.035000,0.203200> rotate<0,0.000000,0> translate<39.149000,0.000000,20.853300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.149000,-1.535000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.419000,-1.535000,23.393300>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<39.149000,-1.535000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.181700,0.000000,3.482400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,0.000000,3.454400>}
box{<0,0,-0.203200><0.073077,0.035000,0.203200> rotate<0,22.527911,0> translate<39.181700,0.000000,3.482400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.181700,0.000000,3.482400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,0.000000,1.803300>}
box{<0,0,-0.203200><2.374677,0.035000,0.203200> rotate<0,44.995324,0> translate<39.181700,0.000000,3.482400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.198000,0.000000,20.853300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,20.878700>}
box{<0,0,-0.203200><0.066354,0.035000,0.203200> rotate<0,-22.505462,0> translate<39.198000,0.000000,20.853300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.198100,0.000000,15.773300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,15.798700>}
box{<0,0,-0.203200><0.066262,0.035000,0.203200> rotate<0,-22.538560,0> translate<39.198100,0.000000,15.773300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,0.000000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,3.454400>}
box{<0,0,-0.203200><0.882200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.249200,0.000000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,-1.535000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,3.454400>}
box{<0,0,-0.203200><0.882200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.249200,-1.535000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,0.000000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,5.689500>}
box{<0,0,-0.203200><0.882200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.249200,0.000000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.249200,-1.535000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,5.689500>}
box{<0,0,-0.203200><0.882200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.249200,-1.535000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,6.045200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,6.045200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,8.178700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,8.178700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,8.585200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,8.585200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,10.718700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,11.125200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,11.125200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,13.258700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,13.665200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.443900,0.000000,15.798700>}
box{<0,0,-0.203200><0.184600,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,15.798700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,16.205200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,16.205200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,18.338700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,18.338700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,18.745200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,-1.535000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,18.745200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,-1.535000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.259300,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.444000,0.000000,20.878700>}
box{<0,0,-0.203200><0.184700,0.035000,0.203200> rotate<0,0.000000,0> translate<39.259300,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.311300,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.826400,-1.535000,10.972800>}
box{<0,0,-0.203200><13.515100,0.035000,0.203200> rotate<0,0.000000,0> translate<39.311300,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.412900,-1.535000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.590900,-1.535000,21.056600>}
box{<0,0,-0.203200><0.251659,0.035000,0.203200> rotate<0,-44.980932,0> translate<39.412900,-1.535000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.412900,-1.535000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,20.878700>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<39.412900,-1.535000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.413000,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.254400,0.000000,3.251200>}
box{<0,0,-0.203200><4.841400,0.035000,0.203200> rotate<0,0.000000,0> translate<39.413000,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.443900,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.482000,0.000000,15.806300>}
box{<0,0,-0.203200><0.038851,0.035000,0.203200> rotate<0,-11.280265,0> translate<39.443900,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.444000,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.482000,0.000000,20.886300>}
box{<0,0,-0.203200><0.038753,0.035000,0.203200> rotate<0,-11.309186,0> translate<39.444000,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.482000,0.000000,15.806300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.493400,0.000000,15.798700>}
box{<0,0,-0.203200><0.013701,0.035000,0.203200> rotate<0,33.687844,0> translate<39.482000,0.000000,15.806300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.482000,0.000000,20.886300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.493300,0.000000,20.878700>}
box{<0,0,-0.203200><0.013618,0.035000,0.203200> rotate<0,33.921211,0> translate<39.482000,0.000000,20.886300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.493300,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,20.878700>}
box{<0,0,-0.203200><1.511300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.493300,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.493400,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,15.798700>}
box{<0,0,-0.203200><1.511200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.493400,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.565400,-1.535000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,10.718700>}
box{<0,0,-0.203200><1.439200,0.035000,0.203200> rotate<0,0.000000,0> translate<39.565400,-1.535000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.590900,-1.535000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.903300,-1.535000,21.369000>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<39.590900,-1.535000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.667100,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.778500,-1.535000,21.132800>}
box{<0,0,-0.203200><6.111400,0.035000,0.203200> rotate<0,0.000000,0> translate<39.667100,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.819400,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.660800,0.000000,2.844800>}
box{<0,0,-0.203200><4.841400,0.035000,0.203200> rotate<0,0.000000,0> translate<39.819400,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.903300,-1.535000,21.369000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,-1.535000,22.326600>}
box{<0,0,-0.203200><1.354251,0.035000,0.203200> rotate<0,-44.997030,0> translate<39.903300,-1.535000,21.369000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.073500,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.184900,-1.535000,21.539200>}
box{<0,0,-0.203200><6.111400,0.035000,0.203200> rotate<0,0.000000,0> translate<40.073500,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,0.000000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,0.000000,4.571400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.130900,0.000000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,-1.535000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.130900,-1.535000,4.571400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.130900,-1.535000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.570900>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,90.000000,0> translate<40.131400,0.000000,4.570900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.570900>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,90.000000,0> translate<40.131400,-1.535000,4.570900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,3.657600>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,3.657600>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.064000>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.064000>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.470400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.470400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.570900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.570900>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,4.570900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.570900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.570900>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,4.570900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.573000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,5.689500>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,90.000000,0> translate<40.131400,0.000000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.573000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,5.689500>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,90.000000,0> translate<40.131400,-1.535000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.573000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.573000>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,4.573000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.573000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.573000>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,4.573000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.876800>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.876800>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,5.283200>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.131400,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,5.283200>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.131400,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,0.000000,3.454400>}
box{<0,0,-0.203200><0.882300,0.035000,0.203200> rotate<0,0.000000,0> translate<40.132400,0.000000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,-1.535000,3.454400>}
box{<0,0,-0.203200><0.882300,0.035000,0.203200> rotate<0,0.000000,0> translate<40.132400,-1.535000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.570900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,3.454400>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.132400,0.000000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.570900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,3.454400>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.132400,-1.535000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,4.573000>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.132400,0.000000,4.573000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,4.573000>}
box{<0,0,-0.203200><1.116500,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.132400,-1.535000,4.573000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,0.000000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,0.000000,5.689500>}
box{<0,0,-0.203200><0.882300,0.035000,0.203200> rotate<0,0.000000,0> translate<40.132400,0.000000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.132400,-1.535000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,-1.535000,5.689500>}
box{<0,0,-0.203200><0.882300,0.035000,0.203200> rotate<0,0.000000,0> translate<40.132400,-1.535000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,0.000000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,0.000000,4.572400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,90.000000,0> translate<40.133000,0.000000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,-1.535000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,-1.535000,4.572400>}
box{<0,0,-0.203200><0.001000,0.035000,0.203200> rotate<0,90.000000,0> translate<40.133000,-1.535000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,0.000000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.571400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.133000,0.000000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,-1.535000,4.571400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.571400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.133000,-1.535000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,0.000000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.572400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.133000,0.000000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.133000,-1.535000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.572400>}
box{<0,0,-0.203200><1.776900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.133000,-1.535000,4.572400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.225800,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.067200,0.000000,2.438400>}
box{<0,0,-0.203200><4.841400,0.035000,0.203200> rotate<0,0.000000,0> translate<40.225800,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.419000,0.000000,0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,0.000000,0.736600>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.419000,0.000000,0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.419000,-1.535000,23.393300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,-1.535000,23.393300>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<40.419000,-1.535000,23.393300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.479900,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.591300,-1.535000,21.945600>}
box{<0,0,-0.203200><6.111400,0.035000,0.203200> rotate<0,0.000000,0> translate<40.479900,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.632200,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.473600,0.000000,2.032000>}
box{<0,0,-0.203200><4.841400,0.035000,0.203200> rotate<0,0.000000,0> translate<40.632200,0.000000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,0.000000,0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.480900,0.000000,0.736600>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.860900,0.000000,0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,0.000000,1.803300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,1.803300>}
box{<0,0,-0.203200><7.178100,0.035000,0.203200> rotate<0,0.000000,0> translate<40.860900,0.000000,1.803300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,-1.535000,22.326600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,-1.535000,22.326600>}
box{<0,0,-0.203200><7.178100,0.035000,0.203200> rotate<0,0.000000,0> translate<40.860900,-1.535000,22.326600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.860900,-1.535000,23.393300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.480900,-1.535000,23.393300>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,0.000000,0> translate<40.860900,-1.535000,23.393300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.326900,0.000000,6.178800>}
box{<0,0,-0.203200><0.348893,0.035000,0.203200> rotate<0,-22.513530,0> translate<41.004600,0.000000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,6.207600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,-1.535000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,8.016300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,0.000000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,8.016300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,8.747600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,0.000000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,8.747600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,-1.535000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,10.556300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,0.000000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,10.556300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,-1.535000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,11.287600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,11.287600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,-1.535000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,13.096300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,0.000000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,13.827600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,0.000000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,15.636300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,15.636300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,-1.535000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,16.367600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,0.000000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,16.367600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,-1.535000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.065800,0.000000,18.313300>}
box{<0,0,-0.203200><0.066262,0.035000,0.203200> rotate<0,22.538560,0> translate<41.004600,0.000000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,18.176300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,-1.535000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,18.907600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,0.000000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,18.907600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<41.004600,-1.535000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,20.716300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.004600,-1.535000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,20.716300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<41.004600,-1.535000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,0.000000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,0.000000,3.624500>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-22.496430,0> translate<41.014700,0.000000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,-1.535000,3.454400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,-1.535000,3.624500>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-22.496430,0> translate<41.014700,-1.535000,3.454400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,0.000000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,0.000000,5.519400>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,22.496430,0> translate<41.014700,0.000000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.014700,-1.535000,5.689500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,-1.535000,5.519400>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,22.496430,0> translate<41.014700,-1.535000,5.689500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.065800,0.000000,18.313300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.959000,0.000000,18.313300>}
box{<0,0,-0.203200><1.893200,0.035000,0.203200> rotate<0,0.000000,0> translate<41.065800,0.000000,18.313300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127000,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.743800,-1.535000,8.128000>}
box{<0,0,-0.203200><5.616800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127000,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.757000,0.000000,8.128000>}
box{<0,0,-0.203200><5.630000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,18.288000>}
box{<0,0,-0.203200><4.059600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127100,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.409600,0.000000,6.096000>}
box{<0,0,-0.203200><0.282500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127100,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127200,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.711800,-1.535000,6.096000>}
box{<0,0,-0.203200><3.584600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127200,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127200,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.441800,-1.535000,16.256000>}
box{<0,0,-0.203200><2.314600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127200,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.127200,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.756600,0.000000,16.256000>}
box{<0,0,-0.203200><5.629400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.127200,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.326900,0.000000,6.178800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,0.000000,2.319000>}
box{<0,0,-0.203200><5.458511,0.035000,0.203200> rotate<0,44.997772,0> translate<41.326900,0.000000,6.178800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.372300,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511700,0.000000,10.566400>}
box{<0,0,-0.203200><5.139400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.372300,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.372300,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511700,-1.535000,10.566400>}
box{<0,0,-0.203200><5.139400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.372300,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.372300,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.372100,0.000000,20.726400>}
box{<0,0,-0.203200><3.999800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.372300,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.372300,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.372100,-1.535000,20.726400>}
box{<0,0,-0.203200><3.999800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.372300,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.372400,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511400,0.000000,13.817600>}
box{<0,0,-0.203200><5.139000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.372400,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,6.507700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,-1.535000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,7.716200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,0.000000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,7.716200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,-1.535000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,9.047700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,0.000000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,9.047700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,-1.535000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,10.256200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,0.000000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,10.256200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,-1.535000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,11.587700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,0.000000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,11.587700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,-1.535000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,12.796200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,0.000000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,14.127700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,0.000000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,15.336200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,0.000000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,15.336200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,-1.535000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,16.667700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,0.000000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,16.667700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,-1.535000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,17.876200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,-1.535000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,19.207700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,0.000000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,19.207700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.396600,-1.535000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,0.000000,20.716300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,20.416200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,0.000000,20.716300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.396600,-1.535000,20.716300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,20.416200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<41.396600,-1.535000,20.716300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,0.000000,3.624500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,0.000000,3.938900>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.425400,0.000000,3.624500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,-1.535000,3.624500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,-1.535000,3.938900>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.425400,-1.535000,3.624500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,0.000000,5.519400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,0.000000,5.205000>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,44.997030,0> translate<41.425400,0.000000,5.519400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.425400,-1.535000,5.519400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,-1.535000,5.205000>}
box{<0,0,-0.203200><0.444629,0.035000,0.203200> rotate<0,44.997030,0> translate<41.425400,-1.535000,5.519400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.458500,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.273400,-1.535000,3.657600>}
box{<0,0,-0.203200><0.814900,0.035000,0.203200> rotate<0,0.000000,0> translate<41.458500,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.458500,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.848000,0.000000,3.657600>}
box{<0,0,-0.203200><2.389500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.458500,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.488100,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.395800,0.000000,13.004800>}
box{<0,0,-0.203200><4.907700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.488100,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.488200,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.395700,0.000000,11.379200>}
box{<0,0,-0.203200><4.907500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.488200,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.488200,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.395700,-1.535000,11.379200>}
box{<0,0,-0.203200><4.907500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.488200,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.629000,-1.535000,15.443200>}
box{<0,0,-0.203200><1.039300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589700,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294200,0.000000,15.443200>}
box{<0,0,-0.203200><4.704500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589700,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589800,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294100,0.000000,8.940800>}
box{<0,0,-0.203200><4.704300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589800,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589800,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294100,-1.535000,8.940800>}
box{<0,0,-0.203200><4.704300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589800,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589800,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.746500,0.000000,19.100800>}
box{<0,0,-0.203200><2.156700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589800,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.589800,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,19.100800>}
box{<0,0,-0.203200><3.596800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.589800,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.593500,-1.535000,12.899300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,12.796200>}
box{<0,0,-0.203200><0.145876,0.035000,0.203200> rotate<0,44.969259,0> translate<41.593500,-1.535000,12.899300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.593500,-1.535000,12.899300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940800,-1.535000,17.246600>}
box{<0,0,-0.203200><6.148011,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.593500,-1.535000,12.899300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.661600,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.222400,0.000000,5.283200>}
box{<0,0,-0.203200><0.560800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.661600,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.661600,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.899000,-1.535000,5.283200>}
box{<0,0,-0.203200><2.237400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.661600,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.689000,-1.535000,3.073300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.084900,-1.535000,7.469100>}
box{<0,0,-0.203200><6.216671,0.035000,0.203200> rotate<0,-44.996379,0> translate<41.689000,-1.535000,3.073300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691300,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192600,0.000000,7.721600>}
box{<0,0,-0.203200><4.501300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691300,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691300,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192600,-1.535000,7.721600>}
box{<0,0,-0.203200><4.501300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691300,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691300,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.067400,-1.535000,17.881600>}
box{<0,0,-0.203200><3.376100,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691300,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691400,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.118200,-1.535000,6.502400>}
box{<0,0,-0.203200><3.426800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691400,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691400,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.848200,-1.535000,16.662400>}
box{<0,0,-0.203200><2.156800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691400,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.691400,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192500,0.000000,16.662400>}
box{<0,0,-0.203200><4.501100,0.035000,0.203200> rotate<0,0.000000,0> translate<41.691400,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,6.507700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,6.899700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,-1.535000,6.507700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,7.324200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,0.000000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,7.324200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,9.439700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,0.000000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,9.439700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,-1.535000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,9.864200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,0.000000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,9.864200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,11.979700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,0.000000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,11.979700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,-1.535000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,12.404200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,0.000000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,12.404200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,14.127700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,14.519700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,0.000000,14.127700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,14.944200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,0.000000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,14.944200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,17.059700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,0.000000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.059700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,-1.535000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.484200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,19.599700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,0.000000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,19.599700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<41.696700,-1.535000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,0.000000,20.416200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,20.024200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,0.000000,20.416200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.696700,-1.535000,20.416200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,20.024200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<41.696700,-1.535000,20.416200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.699000,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.395800,-1.535000,13.004800>}
box{<0,0,-0.203200><4.696800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.699000,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.736500,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147300,0.000000,14.224000>}
box{<0,0,-0.203200><4.410800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.736500,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.736600,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147400,0.000000,10.160000>}
box{<0,0,-0.203200><4.410800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.736600,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.736600,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147400,-1.535000,10.160000>}
box{<0,0,-0.203200><4.410800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.736600,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.736600,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.965700,0.000000,20.320000>}
box{<0,0,-0.203200><3.229100,0.035000,0.203200> rotate<0,0.000000,0> translate<41.736600,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.736600,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,20.320000>}
box{<0,0,-0.203200><3.450000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.736600,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,0.000000,3.938900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.349600>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-67.497630,0> translate<41.739800,0.000000,3.938900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,-1.535000,3.938900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.349600>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,-67.497630,0> translate<41.739800,-1.535000,3.938900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,0.000000,5.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.794300>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,67.497630,0> translate<41.739800,0.000000,5.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.739800,-1.535000,5.205000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.794300>}
box{<0,0,-0.203200><0.444532,0.035000,0.203200> rotate<0,67.497630,0> translate<41.739800,-1.535000,5.205000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.778600,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.105200,0.000000,11.785600>}
box{<0,0,-0.203200><4.326600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.778600,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.778600,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.105200,-1.535000,11.785600>}
box{<0,0,-0.203200><4.326600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.778600,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.778700,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.105300,0.000000,12.598400>}
box{<0,0,-0.203200><4.326600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.778700,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.778700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.105300,-1.535000,12.598400>}
box{<0,0,-0.203200><4.326600,0.035000,0.203200> rotate<0,0.000000,0> translate<41.778700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.791600,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.679800,-1.535000,4.064000>}
box{<0,0,-0.203200><0.888200,0.035000,0.203200> rotate<0,0.000000,0> translate<41.791600,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.791600,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.441600,0.000000,4.064000>}
box{<0,0,-0.203200><1.650000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.791600,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820700,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063100,0.000000,9.347200>}
box{<0,0,-0.203200><4.242400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820700,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820700,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063100,-1.535000,9.347200>}
box{<0,0,-0.203200><4.242400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820700,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820700,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.152900,0.000000,19.507200>}
box{<0,0,-0.203200><2.332200,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820700,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820700,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,19.507200>}
box{<0,0,-0.203200><3.365900,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820700,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820800,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.222600,-1.535000,15.036800>}
box{<0,0,-0.203200><0.401800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820800,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.820800,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063200,0.000000,15.036800>}
box{<0,0,-0.203200><4.242400,0.035000,0.203200> rotate<0,0.000000,0> translate<41.820800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,6.899700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,7.324200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.524600,-1.535000,6.908800>}
box{<0,0,-0.203200><3.665500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,7.155000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,7.324200>}
box{<0,0,-0.203200><0.169200,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,7.155000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940900,0.000000,3.073300>}
box{<0,0,-0.203200><5.772466,0.035000,0.203200> rotate<0,44.996328,0> translate<41.859100,0.000000,7.155000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.931000,-1.535000,7.315200>}
box{<0,0,-0.203200><4.071900,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,7.315200>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,9.864200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,9.864200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,9.753600>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,9.753600>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,12.404200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,12.404200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,12.192000>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,12.192000>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,14.944200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,14.630400>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,14.673300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,14.944200>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,14.673300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,18.000800>}
box{<0,0,-0.203200><4.705796,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.859100,-1.535000,14.673300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,17.246600>}
box{<0,0,-0.203200><0.186900,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.484200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.254600,-1.535000,17.068800>}
box{<0,0,-0.203200><2.395500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.068800>}
box{<0,0,-0.203200><4.165700,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.959000,0.000000,17.246600>}
box{<0,0,-0.203200><1.099900,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.661000,-1.535000,17.475200>}
box{<0,0,-0.203200><2.801900,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,20.024200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,0.000000,20.024200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,20.024200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<41.859100,-1.535000,20.024200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.559300,0.000000,19.913600>}
box{<0,0,-0.203200><2.700200,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.859100,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,19.913600>}
box{<0,0,-0.203200><3.327500,0.035000,0.203200> rotate<0,0.000000,0> translate<41.859100,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.875800,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.628800,0.000000,4.876800>}
box{<0,0,-0.203200><0.753000,0.035000,0.203200> rotate<0,0.000000,0> translate<41.875800,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.875800,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.492600,-1.535000,4.876800>}
box{<0,0,-0.203200><1.616800,0.035000,0.203200> rotate<0,0.000000,0> translate<41.875800,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.349600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.571400>}
box{<0,0,-0.203200><0.221800,0.035000,0.203200> rotate<0,90.000000,0> translate<41.909900,0.000000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.349600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.571400>}
box{<0,0,-0.203200><0.221800,0.035000,0.203200> rotate<0,90.000000,0> translate<41.909900,-1.535000,4.571400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.035200,0.000000,4.470400>}
box{<0,0,-0.203200><1.125300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.909900,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.086200,-1.535000,4.470400>}
box{<0,0,-0.203200><1.176300,0.035000,0.203200> rotate<0,0.000000,0> translate<41.909900,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,0.000000,4.794300>}
box{<0,0,-0.203200><0.221900,0.035000,0.203200> rotate<0,90.000000,0> translate<41.909900,0.000000,4.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.572400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.909900,-1.535000,4.794300>}
box{<0,0,-0.203200><0.221900,0.035000,0.203200> rotate<0,90.000000,0> translate<41.909900,-1.535000,4.794300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.105400,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,6.908800>}
box{<0,0,-0.203200><3.919400,0.035000,0.203200> rotate<0,0.000000,0> translate<42.105400,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.105400,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.874400,-1.535000,13.411200>}
box{<0,0,-0.203200><9.769000,0.035000,0.203200> rotate<0,0.000000,0> translate<42.105400,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.130900,-1.535000,2.006600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.443300,-1.535000,2.319000>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<42.130900,-1.535000,2.006600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.156300,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,2.032000>}
box{<0,0,-0.203200><10.218500,0.035000,0.203200> rotate<0,0.000000,0> translate<42.156300,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.443300,-1.535000,2.319000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.409600,-1.535000,6.285400>}
box{<0,0,-0.203200><5.609266,0.035000,0.203200> rotate<0,-44.997752,0> translate<42.443300,-1.535000,2.319000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.511800,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192500,0.000000,6.502400>}
box{<0,0,-0.203200><3.680700,0.035000,0.203200> rotate<0,0.000000,0> translate<42.511800,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.511800,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511400,-1.535000,13.817600>}
box{<0,0,-0.203200><3.999600,0.035000,0.203200> rotate<0,0.000000,0> translate<42.511800,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.562600,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.439200,-1.535000,2.438400>}
box{<0,0,-0.203200><9.876600,0.035000,0.203200> rotate<0,0.000000,0> translate<42.562600,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.918200,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.756600,0.000000,6.096000>}
box{<0,0,-0.203200><3.838400,0.035000,0.203200> rotate<0,0.000000,0> translate<42.918200,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.918200,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147300,-1.535000,14.224000>}
box{<0,0,-0.203200><3.229100,0.035000,0.203200> rotate<0,0.000000,0> translate<42.918200,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.959000,0.000000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.400900,0.000000,17.246600>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<42.959000,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.959000,0.000000,18.313300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.456600,0.000000,21.810900>}
box{<0,0,-0.203200><4.946353,0.035000,0.203200> rotate<0,-44.997030,0> translate<42.959000,0.000000,18.313300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.969000,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.503600,-1.535000,2.844800>}
box{<0,0,-0.203200><9.534600,0.035000,0.203200> rotate<0,0.000000,0> translate<42.969000,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.324600,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.115400,0.000000,5.689600>}
box{<0,0,-0.203200><4.790800,0.035000,0.203200> rotate<0,0.000000,0> translate<43.324600,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.324600,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,14.630400>}
box{<0,0,-0.203200><2.700200,0.035000,0.203200> rotate<0,0.000000,0> translate<43.324600,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.375400,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.588200,-1.535000,3.251200>}
box{<0,0,-0.203200><9.212800,0.035000,0.203200> rotate<0,0.000000,0> translate<43.375400,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.400900,0.000000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,19.870600>}
box{<0,0,-0.203200><3.710826,0.035000,0.203200> rotate<0,-44.998122,0> translate<43.400900,0.000000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.629400,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.475200>}
box{<0,0,-0.203200><2.395400,0.035000,0.203200> rotate<0,0.000000,0> translate<43.629400,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.731000,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294200,0.000000,5.283200>}
box{<0,0,-0.203200><2.563200,0.035000,0.203200> rotate<0,0.000000,0> translate<43.731000,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.731000,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063200,-1.535000,15.036800>}
box{<0,0,-0.203200><2.332200,0.035000,0.203200> rotate<0,0.000000,0> translate<43.731000,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.781800,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511400,-1.535000,3.657600>}
box{<0,0,-0.203200><2.729600,0.035000,0.203200> rotate<0,0.000000,0> translate<43.781800,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.035800,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192600,0.000000,17.881600>}
box{<0,0,-0.203200><2.156800,0.035000,0.203200> rotate<0,0.000000,0> translate<44.035800,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.137400,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063200,0.000000,4.876800>}
box{<0,0,-0.203200><1.925800,0.035000,0.203200> rotate<0,0.000000,0> translate<44.137400,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.137400,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294200,-1.535000,15.443200>}
box{<0,0,-0.203200><2.156800,0.035000,0.203200> rotate<0,0.000000,0> translate<44.137400,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.188200,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147300,-1.535000,4.064000>}
box{<0,0,-0.203200><1.959100,0.035000,0.203200> rotate<0,0.000000,0> translate<44.188200,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.442200,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.757000,0.000000,18.288000>}
box{<0,0,-0.203200><2.314800,0.035000,0.203200> rotate<0,0.000000,0> translate<44.442200,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.543800,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,4.470400>}
box{<0,0,-0.203200><1.481000,0.035000,0.203200> rotate<0,0.000000,0> translate<44.543800,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.543800,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,15.849600>}
box{<0,0,-0.203200><6.992800,0.035000,0.203200> rotate<0,0.000000,0> translate<44.543800,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.594600,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,4.470400>}
box{<0,0,-0.203200><1.430200,0.035000,0.203200> rotate<0,0.000000,0> translate<44.594600,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.848600,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.671200,0.000000,18.694400>}
box{<0,0,-0.203200><6.822600,0.035000,0.203200> rotate<0,0.000000,0> translate<44.848600,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.950200,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.147300,0.000000,4.064000>}
box{<0,0,-0.203200><1.197100,0.035000,0.203200> rotate<0,0.000000,0> translate<44.950200,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.950200,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.756600,-1.535000,16.256000>}
box{<0,0,-0.203200><1.806400,0.035000,0.203200> rotate<0,0.000000,0> translate<44.950200,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.001000,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063200,-1.535000,4.876800>}
box{<0,0,-0.203200><1.062200,0.035000,0.203200> rotate<0,0.000000,0> translate<45.001000,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,0.000000,2.319000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.499000,0.000000,2.006600>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,44.997030,0> translate<45.186600,0.000000,2.319000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,20.099000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,18.000800>}
box{<0,0,-0.203200><2.098200,0.035000,0.203200> rotate<0,-90.000000,0> translate<45.186600,-1.535000,18.000800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,20.540900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,20.099000>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,-90.000000,0> translate<45.186600,-1.535000,20.099000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.186600,-1.535000,20.540900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,-1.535000,22.123300>}
box{<0,0,-0.203200><2.237852,0.035000,0.203200> rotate<0,-44.997030,0> translate<45.186600,-1.535000,20.540900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.255000,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294100,0.000000,19.100800>}
box{<0,0,-0.203200><1.039100,0.035000,0.203200> rotate<0,0.000000,0> translate<45.255000,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.356600,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.511400,0.000000,3.657600>}
box{<0,0,-0.203200><1.154800,0.035000,0.203200> rotate<0,0.000000,0> translate<45.356600,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.356600,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.192500,-1.535000,16.662400>}
box{<0,0,-0.203200><0.835900,0.035000,0.203200> rotate<0,0.000000,0> translate<45.356600,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.407400,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294200,-1.535000,5.283200>}
box{<0,0,-0.203200><0.886800,0.035000,0.203200> rotate<0,0.000000,0> translate<45.407400,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.499000,0.000000,2.006600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,2.006600>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.499000,0.000000,2.006600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.661400,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.063100,0.000000,19.507200>}
box{<0,0,-0.203200><0.401700,0.035000,0.203200> rotate<0,0.000000,0> translate<45.661400,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.763000,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.217000,0.000000,3.251200>}
box{<0,0,-0.203200><2.454000,0.035000,0.203200> rotate<0,0.000000,0> translate<45.763000,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.763000,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,17.068800>}
box{<0,0,-0.203200><0.261800,0.035000,0.203200> rotate<0,0.000000,0> translate<45.763000,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.813800,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.493200,-1.535000,5.689600>}
box{<0,0,-0.203200><9.679400,0.035000,0.203200> rotate<0,0.000000,0> translate<45.813800,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940800,-1.535000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940900,-1.535000,17.246600>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<45.940800,-1.535000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940900,0.000000,3.073300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,3.073300>}
box{<0,0,-0.203200><2.098100,0.035000,0.203200> rotate<0,0.000000,0> translate<45.940900,0.000000,3.073300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.940900,-1.535000,17.246600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,17.330600>}
box{<0,0,-0.203200><0.118723,0.035000,0.203200> rotate<0,-45.031153,0> translate<45.940900,-1.535000,17.246600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,4.359700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,3.967700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,4.359700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,4.359700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,3.967700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,-1.535000,4.359700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,4.784200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,4.359700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,4.359700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,4.784200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,4.359700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,-1.535000,4.359700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,4.784200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,5.176200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,4.784200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,4.784200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,5.176200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,-1.535000,4.784200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,6.899700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,6.507700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,6.899700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,6.899700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,7.324200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,7.716200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,9.047700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,9.047700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,-1.535000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,9.439700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,9.439700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,-1.535000,9.439700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,10.256200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,9.864200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,10.256200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,-1.535000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,11.587700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,11.587700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,-1.535000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,11.979700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,11.979700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,-1.535000,11.979700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,12.796200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,12.404200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,12.796200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,-1.535000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,14.127700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,14.127700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,-1.535000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,14.519700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,14.519700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,-1.535000,14.519700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,15.336200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,14.944200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,15.336200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,-1.535000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,16.667700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,16.667700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,-1.535000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,17.330600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,-1.535000,17.059700>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,-1.535000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.059700>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,17.059700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,17.484200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,17.876200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<46.024800,0.000000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,19.207700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<46.024800,0.000000,19.599700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,19.870600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.024800,0.000000,19.599700>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,-90.000000,0> translate<46.024800,0.000000,19.599700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.084900,-1.535000,7.469100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,7.716200>}
box{<0,0,-0.203200><0.267439,0.035000,0.203200> rotate<0,-67.505871,0> translate<46.084900,-1.535000,7.469100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,3.967700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,3.667600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,3.967700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,3.967700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,3.667600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,-1.535000,3.967700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,5.176200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,5.476300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,5.176200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,5.176200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,5.476300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,-1.535000,5.176200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,6.507700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,6.207600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,6.507700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,8.016300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,8.016300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,-1.535000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,8.747600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,8.747600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,-1.535000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,10.556300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,10.556300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,-1.535000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,11.287600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,11.287600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,-1.535000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,13.096300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,13.096300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,-1.535000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,14.127700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,13.827600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,14.127700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,14.127700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,13.827600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,-1.535000,14.127700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,15.636300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,15.636300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,-1.535000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,16.367600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,-1.535000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,16.367600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,-1.535000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,18.176300>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.187200,0.000000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.187200,0.000000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,18.907600>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<46.187200,0.000000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.220200,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.756600,-1.535000,6.096000>}
box{<0,0,-0.203200><0.536400,0.035000,0.203200> rotate<0,0.000000,0> translate<46.220200,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,17.942200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,19.141700>}
box{<0,0,-0.203200><1.199500,0.035000,0.203200> rotate<0,90.000000,0> translate<46.253300,-1.535000,19.141700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,17.942200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,18.176300>}
box{<0,0,-0.203200><0.330997,0.035000,0.203200> rotate<0,-45.009269,0> translate<46.253300,-1.535000,17.942200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.757000,-1.535000,18.288000>}
box{<0,0,-0.203200><0.503700,0.035000,0.203200> rotate<0,0.000000,0> translate<46.253300,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.401300,-1.535000,18.694400>}
box{<0,0,-0.203200><4.148000,0.035000,0.203200> rotate<0,0.000000,0> translate<46.253300,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.294100,-1.535000,19.100800>}
box{<0,0,-0.203200><0.040800,0.035000,0.203200> rotate<0,0.000000,0> translate<46.253300,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.253300,-1.535000,19.141700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,18.907600>}
box{<0,0,-0.203200><0.330997,0.035000,0.203200> rotate<0,45.009269,0> translate<46.253300,-1.535000,19.141700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.409600,-1.535000,6.285400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,6.207600>}
box{<0,0,-0.203200><0.109955,0.035000,0.203200> rotate<0,45.033874,0> translate<46.409600,-1.535000,6.285400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.456600,0.000000,21.810900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,0.000000,22.123300>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<46.456600,0.000000,21.810900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,3.667600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,3.505200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,3.667600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,3.667600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,3.505200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,3.667600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,5.476300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,5.638700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,5.476300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,5.476300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,5.638700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,-1.535000,5.476300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,6.045200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,6.045200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.661200,-1.535000,8.088300>}
box{<0,0,-0.203200><0.188216,0.035000,0.203200> rotate<0,-22.489589,0> translate<46.487300,-1.535000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,8.178700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,8.585200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,8.585200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,10.718700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,10.718700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,-1.535000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,11.125200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,11.125200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,13.258700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,13.258700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,-1.535000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,13.665200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,13.665200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,15.798700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,15.798700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,-1.535000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,16.205200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,16.205200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,18.338700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,0.000000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,18.338700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<46.487300,-1.535000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,0.000000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,18.745200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,0.000000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.487300,-1.535000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,18.745200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<46.487300,-1.535000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.661200,-1.535000,8.088300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.668700,-1.535000,8.099600>}
box{<0,0,-0.203200><0.013562,0.035000,0.203200> rotate<0,-56.423378,0> translate<46.661200,-1.535000,8.088300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.668700,-1.535000,8.099600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.706700,-1.535000,8.107200>}
box{<0,0,-0.203200><0.038753,0.035000,0.203200> rotate<0,-11.309186,0> translate<46.668700,-1.535000,8.099600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.706700,-1.535000,8.107200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.734400,-1.535000,8.118600>}
box{<0,0,-0.203200><0.029954,0.035000,0.203200> rotate<0,-22.368255,0> translate<46.706700,-1.535000,8.107200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.734400,-1.535000,8.118600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,-1.535000,8.153300>}
box{<0,0,-0.203200><0.049003,0.035000,0.203200> rotate<0,-45.079703,0> translate<46.734400,-1.535000,8.118600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,-1.535000,8.153300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.818000,-1.535000,8.153300>}
box{<0,0,-0.203200><0.049000,0.035000,0.203200> rotate<0,0.000000,0> translate<46.769000,-1.535000,8.153300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,-1.535000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.210900,-1.535000,22.123300>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<46.769000,-1.535000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.769000,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.309000,0.000000,22.123300>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<46.769000,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.818000,-1.535000,8.153300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,8.178700>}
box{<0,0,-0.203200><0.066354,0.035000,0.203200> rotate<0,-22.505462,0> translate<46.818000,-1.535000,8.153300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,3.505200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.471000,0.000000,3.505200>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,3.505200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,3.505200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,3.505200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,3.505200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,5.638700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.064500,0.000000,5.638700>}
box{<0,0,-0.203200><1.185200,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,5.638700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,5.638700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,5.638700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,5.638700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.471000,0.000000,6.045200>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,6.045200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.064000,-1.535000,8.178700>}
box{<0,0,-0.203200><0.184700,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,8.178700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,8.585200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,8.585200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,10.718700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,10.718700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,11.125200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,11.125200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,13.258700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,13.258700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,13.665200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,13.665200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,15.798700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,15.798700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,16.205200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,16.205200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,18.338700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,18.338700>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,0.000000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,18.745200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,0.000000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.879300,-1.535000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,18.745200>}
box{<0,0,-0.203200><1.745300,0.035000,0.203200> rotate<0,0.000000,0> translate<46.879300,-1.535000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.032900,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.210900,0.000000,21.056600>}
box{<0,0,-0.203200><0.251659,0.035000,0.203200> rotate<0,-44.980932,0> translate<47.032900,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.032900,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,20.878700>}
box{<0,0,-0.203200><1.591700,0.035000,0.203200> rotate<0,0.000000,0> translate<47.032900,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.064000,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.102000,-1.535000,8.186300>}
box{<0,0,-0.203200><0.038753,0.035000,0.203200> rotate<0,-11.309186,0> translate<47.064000,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.102000,-1.535000,8.186300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.113300,-1.535000,8.178700>}
box{<0,0,-0.203200><0.013618,0.035000,0.203200> rotate<0,33.921211,0> translate<47.102000,-1.535000,8.186300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.113300,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,8.178700>}
box{<0,0,-0.203200><1.511300,0.035000,0.203200> rotate<0,0.000000,0> translate<47.113300,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.210900,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.309000,0.000000,21.056600>}
box{<0,0,-0.203200><2.098100,0.035000,0.203200> rotate<0,0.000000,0> translate<47.210900,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.210900,-1.535000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,-1.535000,22.123300>}
box{<0,0,-0.203200><0.828100,0.035000,0.203200> rotate<0,0.000000,0> translate<47.210900,-1.535000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,1.803300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.242400,0.000000,2.006600>}
box{<0,0,-0.203200><0.287580,0.035000,0.203200> rotate<0,-44.982943,0> translate<48.039000,0.000000,1.803300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,2.006600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.242400,0.000000,2.006600>}
box{<0,0,-0.203200><0.203400,0.035000,0.203200> rotate<0,0.000000,0> translate<48.039000,0.000000,2.006600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,0.000000,3.073300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.471000,0.000000,3.505200>}
box{<0,0,-0.203200><0.610870,0.035000,0.203200> rotate<0,-44.990398,0> translate<48.039000,0.000000,3.073300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,-1.535000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.242400,-1.535000,22.123300>}
box{<0,0,-0.203200><0.203400,0.035000,0.203200> rotate<0,0.000000,0> translate<48.039000,-1.535000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.039000,-1.535000,22.326600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.242400,-1.535000,22.123300>}
box{<0,0,-0.203200><0.287580,0.035000,0.203200> rotate<0,44.982943,0> translate<48.039000,-1.535000,22.326600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.064500,0.000000,5.638700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.471000,0.000000,6.045200>}
box{<0,0,-0.203200><0.574878,0.035000,0.203200> rotate<0,-44.997030,0> translate<48.064500,0.000000,5.638700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.480900,0.000000,0.736600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.793300,0.000000,1.049000>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,-44.997030,0> translate<48.480900,0.000000,0.736600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.480900,-1.535000,23.393300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.793300,-1.535000,23.080900>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,44.997030,0> translate<48.480900,-1.535000,23.393300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.557100,0.000000,0.812800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.588100,0.000000,0.812800>}
box{<0,0,-0.203200><4.031000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.557100,0.000000,0.812800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,3.505200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,3.667600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,3.505200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,5.638700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,5.476300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,5.638700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,6.045200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,6.207600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,6.045200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,8.016300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,8.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,8.016300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,8.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,8.747600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,0.000000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,8.585200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,8.747600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,8.585200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,10.556300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,10.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,10.556300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,10.718700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,11.287600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,0.000000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,11.125200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,11.287600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,11.125200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,13.096300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,13.258700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,13.096300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,13.258700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,13.827600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,0.000000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,13.665200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,13.827600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,13.665200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,15.636300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,15.798700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,15.636300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,15.798700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,16.367600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,0.000000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,16.205200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,16.367600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,16.205200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,18.176300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,18.338700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,18.176300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,-1.535000,18.338700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,18.907600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,0.000000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,-1.535000,18.745200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,18.907600>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-22.502043,0> translate<48.624600,-1.535000,18.745200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.624600,0.000000,20.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,20.716300>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,22.502043,0> translate<48.624600,0.000000,20.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.709400,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.382900,-1.535000,23.164800>}
box{<0,0,-0.203200><3.673500,0.035000,0.203200> rotate<0,0.000000,0> translate<48.709400,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.553800,0.000000,8.128000>}
box{<0,0,-0.203200><1.806800,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747000,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,8.128000>}
box{<0,0,-0.203200><9.177800,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747000,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747000,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.807700,-1.535000,18.288000>}
box{<0,0,-0.203200><2.060700,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747000,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.077600,0.000000,18.288000>}
box{<0,0,-0.203200><3.330600,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747200,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,6.096000>}
box{<0,0,-0.203200><9.177600,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747200,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747200,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,16.256000>}
box{<0,0,-0.203200><2.789400,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747200,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.747200,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.109600,0.000000,16.256000>}
box{<0,0,-0.203200><5.362400,0.035000,0.203200> rotate<0,0.000000,0> translate<48.747200,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.793300,0.000000,1.049000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.413300,0.000000,8.669000>}
box{<0,0,-0.203200><10.776307,0.035000,0.203200> rotate<0,-44.997030,0> translate<48.793300,0.000000,1.049000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.793300,-1.535000,23.080900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.560900,-1.535000,18.313300>}
box{<0,0,-0.203200><6.742405,0.035000,0.203200> rotate<0,44.997030,0> translate<48.793300,-1.535000,23.080900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.963500,0.000000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.503500,0.000000,1.219200>}
box{<0,0,-0.203200><3.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<48.963500,0.000000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992300,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.420000,0.000000,10.566400>}
box{<0,0,-0.203200><3.427700,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992300,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992300,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.420000,-1.535000,10.566400>}
box{<0,0,-0.203200><3.427700,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992300,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992300,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.639200,0.000000,20.726400>}
box{<0,0,-0.203200><0.646900,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992300,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992400,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.795300,-1.535000,3.657600>}
box{<0,0,-0.203200><3.802900,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992400,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992400,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,13.817600>}
box{<0,0,-0.203200><2.544200,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992400,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.992400,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,13.817600>}
box{<0,0,-0.203200><8.932400,0.035000,0.203200> rotate<0,0.000000,0> translate<48.992400,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,3.667600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,3.967700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,3.667600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,5.476300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,5.176200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,5.476300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,6.207600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,6.507700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,6.207600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,7.716200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,8.016300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,7.716200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,8.016300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,9.047700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,0.000000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,8.747600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,9.047700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,8.747600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,10.256200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,10.556300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,10.256200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,10.556300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,11.587700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,0.000000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,11.287600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,11.587700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,11.287600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,12.796200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,13.096300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,12.796200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,13.096300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,14.127700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,0.000000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,13.827600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,14.127700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,13.827600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,15.336200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,15.636300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,15.336200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,15.636300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,16.667700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,0.000000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,16.367600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,16.667700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,16.367600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,17.876200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,18.176300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,17.876200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,-1.535000,18.176300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,19.207700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,0.000000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,-1.535000,18.907600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,19.207700>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,-44.997030,0> translate<49.016600,-1.535000,18.907600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.016600,0.000000,20.716300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,20.416200>}
box{<0,0,-0.203200><0.424405,0.035000,0.203200> rotate<0,44.997030,0> translate<49.016600,0.000000,20.716300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.108100,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.280800,-1.535000,13.004800>}
box{<0,0,-0.203200><3.172700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.108100,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.108100,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.318400,0.000000,13.004800>}
box{<0,0,-0.203200><3.210300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.108100,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.108200,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.826300,0.000000,11.379200>}
box{<0,0,-0.203200><3.718100,0.035000,0.203200> rotate<0,0.000000,0> translate<49.108200,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.108200,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.826300,-1.535000,11.379200>}
box{<0,0,-0.203200><3.718100,0.035000,0.203200> rotate<0,0.000000,0> translate<49.108200,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.115800,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.431100,-1.535000,22.758400>}
box{<0,0,-0.203200><3.315300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.115800,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209700,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.336700,-1.535000,5.283200>}
box{<0,0,-0.203200><5.127000,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209700,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,15.443200>}
box{<0,0,-0.203200><2.326900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209700,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,15.443200>}
box{<0,0,-0.203200><3.012700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209700,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209800,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.366600,0.000000,8.940800>}
box{<0,0,-0.203200><2.156800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209800,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209800,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.724700,-1.535000,8.940800>}
box{<0,0,-0.203200><3.514900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209800,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209800,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.994900,-1.535000,19.100800>}
box{<0,0,-0.203200><0.785100,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209800,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.209800,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.264800,0.000000,19.100800>}
box{<0,0,-0.203200><2.055000,0.035000,0.203200> rotate<0,0.000000,0> translate<49.209800,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.309000,0.000000,21.056600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.839700,0.000000,15.526000>}
box{<0,0,-0.203200><7.821520,0.035000,0.203200> rotate<0,44.996512,0> translate<49.309000,0.000000,21.056600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.309000,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.750900,0.000000,22.123300>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.309000,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311300,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.147400,0.000000,7.721600>}
box{<0,0,-0.203200><0.836100,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311300,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311300,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,7.721600>}
box{<0,0,-0.203200><8.613500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311300,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311300,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.214100,-1.535000,17.881600>}
box{<0,0,-0.203200><1.902800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311300,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311300,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.484000,0.000000,17.881600>}
box{<0,0,-0.203200><3.172700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311300,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311400,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,6.502400>}
box{<0,0,-0.203200><8.613400,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311400,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311400,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,16.662400>}
box{<0,0,-0.203200><2.225200,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311400,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.311400,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.703200,0.000000,16.662400>}
box{<0,0,-0.203200><4.391800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.311400,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,3.967700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,4.359700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,3.967700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,5.176200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,4.784200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,5.176200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,6.507700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,6.899700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,6.507700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,7.324200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,7.716200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,7.324200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,7.716200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,9.439700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,0.000000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,9.047700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,9.439700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,9.047700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,9.864200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,10.256200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,9.864200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,10.256200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,11.979700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,0.000000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,11.587700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,11.979700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,11.587700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,12.404200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,12.796200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,12.404200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,12.796200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,14.127700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,14.519700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,0.000000,14.127700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,14.127700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,14.519700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,14.127700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,14.944200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,15.336200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,14.944200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,15.336200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.059700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,0.000000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,16.667700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.059700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,16.667700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.484200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,17.876200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.484200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,-1.535000,17.876200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,19.599700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,0.000000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,-1.535000,19.207700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,19.599700>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,-67.492017,0> translate<49.316700,-1.535000,19.207700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.316700,0.000000,20.416200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,20.024200>}
box{<0,0,-0.203200><0.424309,0.035000,0.203200> rotate<0,67.492017,0> translate<49.316700,0.000000,20.416200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356500,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.002400,-1.535000,4.064000>}
box{<0,0,-0.203200><3.645900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356500,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356500,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,14.224000>}
box{<0,0,-0.203200><2.180100,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356500,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356500,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.521500,0.000000,14.224000>}
box{<0,0,-0.203200><3.165000,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356500,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356600,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,10.160000>}
box{<0,0,-0.203200><2.865800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356600,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356600,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,10.160000>}
box{<0,0,-0.203200><2.865800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356600,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.356600,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.045600,0.000000,20.320000>}
box{<0,0,-0.203200><0.689000,0.035000,0.203200> rotate<0,0.000000,0> translate<49.356600,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.369900,0.000000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.439100,0.000000,1.625600>}
box{<0,0,-0.203200><3.069200,0.035000,0.203200> rotate<0,0.000000,0> translate<49.369900,0.000000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.398600,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.419900,0.000000,11.785600>}
box{<0,0,-0.203200><3.021300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.398600,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.398600,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.419900,-1.535000,11.785600>}
box{<0,0,-0.203200><3.021300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.398600,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.398700,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,12.598400>}
box{<0,0,-0.203200><2.823700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.398700,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.398700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,12.598400>}
box{<0,0,-0.203200><2.823700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.398700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440700,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.773000,0.000000,9.347200>}
box{<0,0,-0.203200><2.332300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440700,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440700,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.318300,-1.535000,9.347200>}
box{<0,0,-0.203200><2.877600,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440700,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440700,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.588500,-1.535000,19.507200>}
box{<0,0,-0.203200><0.147800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440700,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440700,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.858400,0.000000,19.507200>}
box{<0,0,-0.203200><1.417700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440700,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440800,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.728000,-1.535000,4.876800>}
box{<0,0,-0.203200><4.287200,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440800,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440800,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,15.036800>}
box{<0,0,-0.203200><2.095800,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440800,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.440800,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,15.036800>}
box{<0,0,-0.203200><2.781600,0.035000,0.203200> rotate<0,0.000000,0> translate<49.440800,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,4.359700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,4.784200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,4.784200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.321600,-1.535000,4.470400>}
box{<0,0,-0.203200><3.842500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,6.899700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,7.324200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,6.908800>}
box{<0,0,-0.203200><8.445700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,7.053300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,7.324200>}
box{<0,0,-0.203200><0.270900,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,7.324200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,7.053300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,9.796700>}
box{<0,0,-0.203200><3.879683,0.035000,0.203200> rotate<0,-44.998074,0> translate<49.479100,0.000000,7.053300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.741000,0.000000,7.315200>}
box{<0,0,-0.203200><0.261900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,7.315200>}
box{<0,0,-0.203200><8.445700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,9.864200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,9.439700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,9.864200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,9.864200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.179400,0.000000,9.753600>}
box{<0,0,-0.203200><2.700300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,9.753600>}
box{<0,0,-0.203200><2.743300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,12.404200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,11.979700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,12.404200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,12.404200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,12.192000>}
box{<0,0,-0.203200><2.743300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,12.192000>}
box{<0,0,-0.203200><2.743300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,14.944200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,14.519700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,14.944200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,14.944200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,14.630400>}
box{<0,0,-0.203200><2.057500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,14.630400>}
box{<0,0,-0.203200><2.743300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.484200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.059700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.484200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,17.484200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,17.068800>}
box{<0,0,-0.203200><2.057500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.296800,0.000000,17.068800>}
box{<0,0,-0.203200><3.817700,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,17.475200>}
box{<0,0,-0.203200><2.057500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.890400,0.000000,17.475200>}
box{<0,0,-0.203200><3.411300,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,19.616600>}
box{<0,0,-0.203200><0.016900,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,-1.535000,19.616600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,19.599700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,20.024200>}
box{<0,0,-0.203200><0.424500,0.035000,0.203200> rotate<0,90.000000,0> translate<49.479100,0.000000,20.024200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,-1.535000,19.616600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,17.559100>}
box{<0,0,-0.203200><2.909744,0.035000,0.203200> rotate<0,44.997030,0> translate<49.479100,-1.535000,19.616600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.479100,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.452000,0.000000,19.913600>}
box{<0,0,-0.203200><0.972900,0.035000,0.203200> rotate<0,0.000000,0> translate<49.479100,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.522200,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.495400,-1.535000,22.352000>}
box{<0,0,-0.203200><2.973200,0.035000,0.203200> rotate<0,0.000000,0> translate<49.522200,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.750900,0.000000,22.123300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.770700,0.000000,16.103500>}
box{<0,0,-0.203200><8.513283,0.035000,0.203200> rotate<0,44.997030,0> translate<49.750900,0.000000,22.123300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.776300,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,2.032000>}
box{<0,0,-0.203200><2.598500,0.035000,0.203200> rotate<0,0.000000,0> translate<49.776300,0.000000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.928600,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.562200,0.000000,21.945600>}
box{<0,0,-0.203200><2.633600,0.035000,0.203200> rotate<0,0.000000,0> translate<49.928600,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<49.928600,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.562200,-1.535000,21.945600>}
box{<0,0,-0.203200><2.633600,0.035000,0.203200> rotate<0,0.000000,0> translate<49.928600,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.182700,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.439200,0.000000,2.438400>}
box{<0,0,-0.203200><2.256500,0.035000,0.203200> rotate<0,0.000000,0> translate<50.182700,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.335000,0.000000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.769200,0.000000,21.539200>}
box{<0,0,-0.203200><2.434200,0.035000,0.203200> rotate<0,0.000000,0> translate<50.335000,0.000000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.335000,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.769200,-1.535000,21.539200>}
box{<0,0,-0.203200><2.434200,0.035000,0.203200> rotate<0,0.000000,0> translate<50.335000,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.589100,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.503600,0.000000,2.844800>}
box{<0,0,-0.203200><1.914500,0.035000,0.203200> rotate<0,0.000000,0> translate<50.589100,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.741400,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.976300,0.000000,21.132800>}
box{<0,0,-0.203200><2.234900,0.035000,0.203200> rotate<0,0.000000,0> translate<50.741400,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.741400,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.976300,-1.535000,21.132800>}
box{<0,0,-0.203200><2.234900,0.035000,0.203200> rotate<0,0.000000,0> translate<50.741400,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<50.995500,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.588200,0.000000,3.251200>}
box{<0,0,-0.203200><1.592700,0.035000,0.203200> rotate<0,0.000000,0> translate<50.995500,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.147800,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.270700,0.000000,20.726400>}
box{<0,0,-0.203200><2.122900,0.035000,0.203200> rotate<0,0.000000,0> translate<51.147800,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.147800,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.270700,-1.535000,20.726400>}
box{<0,0,-0.203200><2.122900,0.035000,0.203200> rotate<0,0.000000,0> translate<51.147800,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.401900,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.795300,0.000000,3.657600>}
box{<0,0,-0.203200><1.393400,0.035000,0.203200> rotate<0,0.000000,0> translate<51.401900,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,13.749000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.299700,-1.535000,12.986000>}
box{<0,0,-0.203200><1.079116,0.035000,0.203200> rotate<0,44.993276,0> translate<51.536600,-1.535000,13.749000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,14.190900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,13.749000>}
box{<0,0,-0.203200><0.441900,0.035000,0.203200> rotate<0,-90.000000,0> translate<51.536600,-1.535000,13.749000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,17.559100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.536600,-1.535000,14.190900>}
box{<0,0,-0.203200><3.368200,0.035000,0.203200> rotate<0,-90.000000,0> translate<51.536600,-1.535000,14.190900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.554200,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.677100,0.000000,20.320000>}
box{<0,0,-0.203200><2.122900,0.035000,0.203200> rotate<0,0.000000,0> translate<51.554200,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.554200,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.677100,-1.535000,20.320000>}
box{<0,0,-0.203200><2.122900,0.035000,0.203200> rotate<0,0.000000,0> translate<51.554200,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.808300,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.002400,0.000000,4.064000>}
box{<0,0,-0.203200><1.194100,0.035000,0.203200> rotate<0,0.000000,0> translate<51.808300,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.960600,0.000000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.236700,0.000000,19.913600>}
box{<0,0,-0.203200><2.276100,0.035000,0.203200> rotate<0,0.000000,0> translate<51.960600,0.000000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<51.960600,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.236700,-1.535000,19.913600>}
box{<0,0,-0.203200><2.276100,0.035000,0.203200> rotate<0,0.000000,0> translate<51.960600,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.214700,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.321600,0.000000,4.470400>}
box{<0,0,-0.203200><1.106900,0.035000,0.203200> rotate<0,0.000000,0> translate<52.214700,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<52.222400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.222400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,9.796700>}
box{<0,0,-0.203200><0.572100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.222400,0.000000,9.796700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<52.222400,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<52.222400,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<52.222400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<52.222400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.222400,0.000000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.222400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.299700,-1.535000,12.986000>}
box{<0,0,-0.203200><0.109248,0.035000,0.203200> rotate<0,-44.959948,0> translate<52.222400,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<52.222400,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<52.222400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,14.523100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.222400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.222400,0.000000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,16.103500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<52.222400,0.000000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.367000,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.171800,0.000000,19.507200>}
box{<0,0,-0.203200><2.804800,0.035000,0.203200> rotate<0,0.000000,0> translate<52.367000,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.367000,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.171800,-1.535000,19.507200>}
box{<0,0,-0.203200><2.804800,0.035000,0.203200> rotate<0,0.000000,0> translate<52.367000,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,2.031900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,0.870400>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<52.374800,0.000000,2.031900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,2.031900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,0.870400>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<52.374800,-1.535000,2.031900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,2.031900>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.374800,0.000000,2.031900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,2.031900>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.374800,-1.535000,2.031900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,3.193500>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-80.992899,0> translate<52.374800,0.000000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,3.193500>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-80.992899,0> translate<52.374800,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,23.113900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,21.952400>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<52.374800,0.000000,23.113900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,23.113900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,21.952400>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,80.992899,0> translate<52.374800,-1.535000,23.113900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,23.113900>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.374800,0.000000,23.113900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,23.113900>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.374800,-1.535000,23.113900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,0.000000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,24.275600>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<52.374800,0.000000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.374800,-1.535000,23.114000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,24.275600>}
box{<0,0,-0.203200><1.176083,0.035000,0.203200> rotate<0,-80.993662,0> translate<52.374800,-1.535000,23.114000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,0.870300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,0.000000,0.335100>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,62.987176,0> translate<52.558800,0.000000,0.870300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,0.870300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,-1.535000,0.335100>}
box{<0,0,-0.203200><0.600715,0.035000,0.203200> rotate<0,62.987176,0> translate<52.558800,-1.535000,0.870300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,0.870400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,0.870300>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,0.000000,0.870300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,0.870400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,0.870300>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,-1.535000,0.870300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,3.193600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,3.193500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,0.000000,3.193500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,3.193600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,3.193500>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,-1.535000,3.193500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,3.193600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,4.241400>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-62.995007,0> translate<52.558800,0.000000,3.193600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,3.193600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,4.241400>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-62.995007,0> translate<52.558800,-1.535000,3.193600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,21.952300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,20.904500>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,62.995007,0> translate<52.558800,0.000000,21.952300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,21.952300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,20.904500>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,62.995007,0> translate<52.558800,-1.535000,21.952300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,21.952400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,21.952300>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,0.000000,21.952300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,21.952400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,21.952300>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<52.558800,-1.535000,21.952300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,0.000000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558900,0.000000,24.275600>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<52.558800,0.000000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558800,-1.535000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558900,-1.535000,24.275600>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<52.558800,-1.535000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558900,0.000000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,0.000000,24.810800>}
box{<0,0,-0.203200><0.600670,0.035000,0.203200> rotate<0,-62.995674,0> translate<52.558900,0.000000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.558900,-1.535000,24.275600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.831600,-1.535000,24.810800>}
box{<0,0,-0.203200><0.600670,0.035000,0.203200> rotate<0,-62.995674,0> translate<52.558900,-1.535000,24.275600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.621100,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.728000,0.000000,4.876800>}
box{<0,0,-0.203200><1.106900,0.035000,0.203200> rotate<0,0.000000,0> translate<52.621100,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.773400,0.000000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,19.100800>}
box{<0,0,-0.203200><5.151400,0.035000,0.203200> rotate<0,0.000000,0> translate<52.773400,0.000000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.773400,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,19.100800>}
box{<0,0,-0.203200><5.151400,0.035000,0.203200> rotate<0,0.000000,0> translate<52.773400,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.877100,0.000000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,16.103500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<52.877100,0.000000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.925700,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.230600,-1.535000,13.563500>}
box{<0,0,-0.203200><0.431194,0.035000,0.203200> rotate<0,44.997030,0> translate<52.925700,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.925700,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,13.868400>}
box{<0,0,-0.203200><0.877100,0.035000,0.203200> rotate<0,0.000000,0> translate<52.925700,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<52.976500,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,13.817600>}
box{<0,0,-0.203200><4.948300,0.035000,0.203200> rotate<0,0.000000,0> translate<52.976500,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.027500,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.336700,0.000000,5.283200>}
box{<0,0,-0.203200><1.309200,0.035000,0.203200> rotate<0,0.000000,0> translate<53.027500,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,4.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,4.241400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<53.092700,0.000000,4.241400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,4.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,4.241400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<53.092700,-1.535000,4.241400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,4.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,0.000000,5.073200>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.092700,0.000000,4.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,4.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,-1.535000,5.073200>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.092700,-1.535000,4.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,20.904400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,0.000000,20.072700>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,44.997030,0> translate<53.092700,0.000000,20.904400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,20.904400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,-1.535000,20.072700>}
box{<0,0,-0.203200><1.176201,0.035000,0.203200> rotate<0,44.997030,0> translate<53.092700,-1.535000,20.904400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,20.904500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,0.000000,20.904400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<53.092700,0.000000,20.904400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,20.904500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.092700,-1.535000,20.904400>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<53.092700,-1.535000,20.904400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.179800,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,18.694400>}
box{<0,0,-0.203200><4.745000,0.035000,0.203200> rotate<0,0.000000,0> translate<53.179800,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.179800,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,18.694400>}
box{<0,0,-0.203200><4.745000,0.035000,0.203200> rotate<0,0.000000,0> translate<53.179800,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.230600,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,13.563500>}
box{<0,0,-0.203200><0.572200,0.035000,0.203200> rotate<0,0.000000,0> translate<53.230600,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.433900,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.493200,0.000000,5.689600>}
box{<0,0,-0.203200><2.059300,0.035000,0.203200> rotate<0,0.000000,0> translate<53.433900,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.560900,-1.535000,18.313300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,18.000900>}
box{<0,0,-0.203200><0.441800,0.035000,0.203200> rotate<0,44.997030,0> translate<53.560900,-1.535000,18.313300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.586200,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,18.288000>}
box{<0,0,-0.203200><4.338600,0.035000,0.203200> rotate<0,0.000000,0> translate<53.586200,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.586200,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,18.288000>}
box{<0,0,-0.203200><4.338600,0.035000,0.203200> rotate<0,0.000000,0> translate<53.586200,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.802800,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,10.749600>}
box{<0,0,-0.203200><0.387282,0.035000,0.203200> rotate<0,45.007491,0> translate<53.802800,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<53.802800,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,11.602300>}
box{<0,0,-0.203200><0.387282,0.035000,0.203200> rotate<0,-45.007491,0> translate<53.802800,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.802800,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<53.802800,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<53.802800,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.802800,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<53.802800,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.802800,0.000000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,15.448800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<53.802800,0.000000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.840300,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,6.096000>}
box{<0,0,-0.203200><4.084500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.840300,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.853500,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,10.972800>}
box{<0,0,-0.203200><0.223100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.853500,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.853500,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.366400,-1.535000,10.972800>}
box{<0,0,-0.203200><1.512900,0.035000,0.203200> rotate<0,0.000000,0> translate<53.853500,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.853500,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,11.379200>}
box{<0,0,-0.203200><0.223100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.853500,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.853600,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.366300,-1.535000,11.379200>}
box{<0,0,-0.203200><1.512700,0.035000,0.203200> rotate<0,0.000000,0> translate<53.853600,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,16.032900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,18.000900>}
box{<0,0,-0.203200><1.968000,0.035000,0.203200> rotate<0,90.000000,0> translate<53.873300,-1.535000,18.000900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,16.032900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.826113,0.035000,0.203200> rotate<0,44.992126,0> translate<53.873300,-1.535000,16.032900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,16.256000>}
box{<0,0,-0.203200><4.051500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.873300,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,16.662400>}
box{<0,0,-0.203200><4.051500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.873300,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,17.068800>}
box{<0,0,-0.203200><4.051500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.873300,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,17.475200>}
box{<0,0,-0.203200><4.051500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.873300,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.873300,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,17.881600>}
box{<0,0,-0.203200><4.051500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.873300,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,0.000000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,0.000000,5.073200>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.924400,0.000000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,-1.535000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,-1.535000,5.073200>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.924400,-1.535000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,0.000000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,0.000000,20.072700>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.924400,0.000000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924400,-1.535000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,-1.535000,20.072700>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<53.924400,-1.535000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,0.000000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,0.000000,5.607100>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-26.999053,0> translate<53.924500,0.000000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,-1.535000,5.073200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,-1.535000,5.607100>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,-26.999053,0> translate<53.924500,-1.535000,5.073200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,0.000000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,0.000000,19.538800>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,26.999053,0> translate<53.924500,0.000000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.924500,-1.535000,20.072700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,-1.535000,19.538800>}
box{<0,0,-0.203200><1.175982,0.035000,0.203200> rotate<0,26.999053,0> translate<53.924500,-1.535000,20.072700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.955100,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.264800,0.000000,13.411200>}
box{<0,0,-0.203200><1.309700,0.035000,0.203200> rotate<0,0.000000,0> translate<53.955100,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.955100,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.264800,-1.535000,13.411200>}
box{<0,0,-0.203200><1.309700,0.035000,0.203200> rotate<0,0.000000,0> translate<53.955100,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.955200,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.264700,-1.535000,8.940800>}
box{<0,0,-0.203200><1.309500,0.035000,0.203200> rotate<0,0.000000,0> translate<53.955200,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<53.992600,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,17.881600>}
box{<0,0,-0.203200><3.932200,0.035000,0.203200> rotate<0,0.000000,0> translate<53.992600,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.056700,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.516000,0.000000,15.849600>}
box{<0,0,-0.203200><0.459300,0.035000,0.203200> rotate<0,0.000000,0> translate<54.056700,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.056700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.163200,-1.535000,15.849600>}
box{<0,0,-0.203200><1.106500,0.035000,0.203200> rotate<0,0.000000,0> translate<54.056700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,11.209000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,10.749600>}
box{<0,0,-0.203200><0.459400,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.076600,0.000000,10.749600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,11.602300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.076600,0.000000,11.209000>}
box{<0,0,-0.203200><0.393300,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.076600,0.000000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.158400,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.061500,0.000000,14.224000>}
box{<0,0,-0.203200><0.903100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.158400,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.158400,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.061500,-1.535000,14.224000>}
box{<0,0,-0.203200><0.903100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.158400,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.246700,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,6.502400>}
box{<0,0,-0.203200><3.678100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.246700,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.259900,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.960000,-1.535000,10.566400>}
box{<0,0,-0.203200><0.700100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.259900,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.260000,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.959900,-1.535000,11.785600>}
box{<0,0,-0.203200><0.699900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.260000,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.361500,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.858400,0.000000,13.004800>}
box{<0,0,-0.203200><0.496900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.361500,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.361500,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.858400,-1.535000,13.004800>}
box{<0,0,-0.203200><0.496900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.361500,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.361600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.858300,-1.535000,9.347200>}
box{<0,0,-0.203200><0.496700,0.035000,0.203200> rotate<0,0.000000,0> translate<54.361600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.399000,0.000000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,17.475200>}
box{<0,0,-0.203200><3.525800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.399000,0.000000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<54.457500,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,9.753600>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,10.160000>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<54.457500,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.031700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.908800>}
box{<0,0,-0.203200><0.877100,0.035000,0.203200> rotate<0,90.000000,0> translate<54.457500,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.031700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,12.336700>}
box{<0,0,-0.203200><0.431264,0.035000,0.203200> rotate<0,-45.006424,0> translate<54.457500,0.000000,12.031700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.617800,0.000000,12.192000>}
box{<0,0,-0.203200><0.160300,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,12.192000>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,12.598400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,12.598400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<54.457500,0.000000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<54.457500,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,14.630400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,14.630400>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,15.036800>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,15.036800>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,15.443200>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.457500,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,15.443200>}
box{<0,0,-0.203200><0.304900,0.035000,0.203200> rotate<0,0.000000,0> translate<54.457500,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.653100,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,6.908800>}
box{<0,0,-0.203200><3.271700,0.035000,0.203200> rotate<0,0.000000,0> translate<54.653100,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<54.762400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.762400,-1.535000,9.443100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,10.368800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<54.762400,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<54.762400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.762400,-1.535000,11.983100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,12.336700>}
box{<0,0,-0.203200><0.572100,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.762400,0.000000,12.336700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<54.762400,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,12.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<54.762400,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<54.762400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<54.762400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,14.523100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.762400,0.000000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,-90.000000,0> translate<54.762400,-1.535000,14.523100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,0.000000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.839700,0.000000,15.526000>}
box{<0,0,-0.203200><0.109248,0.035000,0.203200> rotate<0,-44.959948,0> translate<54.762400,0.000000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.762400,-1.535000,15.448800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<54.762400,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.805400,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,17.068800>}
box{<0,0,-0.203200><3.119400,0.035000,0.203200> rotate<0,0.000000,0> translate<54.805400,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,0.000000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.972300,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,-1.535000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.972300,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,0.000000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.972300,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972300,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,-1.535000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<54.972300,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,0.000000,5.791100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<54.972400,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,-1.535000,5.791100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<54.972400,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,0.000000,19.354800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<54.972400,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.972400,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,-1.535000,19.354800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<54.972400,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.059500,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,7.315200>}
box{<0,0,-0.203200><2.865300,0.035000,0.203200> rotate<0,0.000000,0> translate<55.059500,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.143300,0.000000,10.749600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.143300,0.000000,11.209000>}
box{<0,0,-0.203200><0.459400,0.035000,0.203200> rotate<0,90.000000,0> translate<55.143300,0.000000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.143300,0.000000,10.749600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,11.023500>}
box{<0,0,-0.203200><0.387282,0.035000,0.203200> rotate<0,-45.007491,0> translate<55.143300,0.000000,10.749600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.143300,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.366500,0.000000,10.972800>}
box{<0,0,-0.203200><0.223200,0.035000,0.203200> rotate<0,0.000000,0> translate<55.143300,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.143300,0.000000,11.209000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.339900,0.000000,11.405700>}
box{<0,0,-0.203200><0.278105,0.035000,0.203200> rotate<0,-45.011597,0> translate<55.143300,0.000000,11.209000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.211800,0.000000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,16.662400>}
box{<0,0,-0.203200><2.713000,0.035000,0.203200> rotate<0,0.000000,0> translate<55.211800,0.000000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.313400,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.366300,0.000000,11.379200>}
box{<0,0,-0.203200><0.052900,0.035000,0.203200> rotate<0,0.000000,0> translate<55.313400,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.339900,0.000000,11.405700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,11.328400>}
box{<0,0,-0.203200><0.109248,0.035000,0.203200> rotate<0,45.034112,0> translate<55.339900,0.000000,11.405700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,8.788400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,11.023500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,11.328400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,13.563500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,13.868400>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.417100,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,16.103500>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,0.000000,0> translate<55.417100,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.465900,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,7.721600>}
box{<0,0,-0.203200><2.458900,0.035000,0.203200> rotate<0,0.000000,0> translate<55.465900,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.618200,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,16.256000>}
box{<0,0,-0.203200><2.306600,0.035000,0.203200> rotate<0,0.000000,0> translate<55.618200,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.770700,0.000000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,16.103500>}
box{<0,0,-0.203200><0.572100,0.035000,0.203200> rotate<0,0.000000,0> translate<55.770700,0.000000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.872300,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,8.128000>}
box{<0,0,-0.203200><2.052500,0.035000,0.203200> rotate<0,0.000000,0> translate<55.872300,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,0.000000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,0.000000,5.791100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.133900,0.000000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,-1.535000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-1.535000,5.791100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.133900,-1.535000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,0.000000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,0.000000,19.354800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.133900,0.000000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.133900,-1.535000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-1.535000,19.354800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.133900,-1.535000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,0.000000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,0.000000,5.607100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<56.134000,0.000000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-1.535000,5.791100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,-1.535000,5.607100>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,9.001161,0> translate<56.134000,-1.535000,5.791100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,0.000000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,0.000000,19.538800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<56.134000,0.000000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.134000,-1.535000,19.354800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,-1.535000,19.538800>}
box{<0,0,-0.203200><1.175984,0.035000,0.203200> rotate<0,-9.001161,0> translate<56.134000,-1.535000,19.354800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.278700,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,8.534400>}
box{<0,0,-0.203200><1.646100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.278700,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,9.443100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<56.342800,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,0.000000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,11.023500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,-1.535000,11.023500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<56.342800,0.000000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,11.328400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,11.983100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<56.342800,-1.535000,11.328400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,0.000000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,13.563500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,-1.535000,13.563500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<56.342800,0.000000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,13.868400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,14.523100>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,-44.997030,0> translate<56.342800,-1.535000,13.868400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,0.000000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,15.448800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,0.000000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.342800,-1.535000,16.103500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925886,0.035000,0.203200> rotate<0,44.997030,0> translate<56.342800,-1.535000,16.103500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.393500,0.000000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,10.972800>}
box{<0,0,-0.203200><1.531300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.393500,0.000000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.393500,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,10.972800>}
box{<0,0,-0.203200><1.531300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.393500,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.393600,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,11.379200>}
box{<0,0,-0.203200><1.531200,0.035000,0.203200> rotate<0,0.000000,0> translate<56.393600,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.393600,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,11.379200>}
box{<0,0,-0.203200><1.531200,0.035000,0.203200> rotate<0,0.000000,0> translate<56.393600,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.413300,0.000000,8.669000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.413300,0.000000,8.859000>}
box{<0,0,-0.203200><0.190000,0.035000,0.203200> rotate<0,90.000000,0> translate<56.413300,0.000000,8.859000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.413300,0.000000,8.859000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,9.443100>}
box{<0,0,-0.203200><0.826113,0.035000,0.203200> rotate<0,-44.992126,0> translate<56.413300,0.000000,8.859000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.495100,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,8.940800>}
box{<0,0,-0.203200><1.429700,0.035000,0.203200> rotate<0,0.000000,0> translate<56.495100,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.495100,0.000000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,13.411200>}
box{<0,0,-0.203200><1.429700,0.035000,0.203200> rotate<0,0.000000,0> translate<56.495100,0.000000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.495100,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,13.411200>}
box{<0,0,-0.203200><1.429700,0.035000,0.203200> rotate<0,0.000000,0> translate<56.495100,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.495200,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,8.940800>}
box{<0,0,-0.203200><1.429600,0.035000,0.203200> rotate<0,0.000000,0> translate<56.495200,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.596700,0.000000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,15.849600>}
box{<0,0,-0.203200><1.328100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.596700,0.000000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.596700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,15.849600>}
box{<0,0,-0.203200><1.328100,0.035000,0.203200> rotate<0,0.000000,0> translate<56.596700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.698400,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,14.224000>}
box{<0,0,-0.203200><1.226400,0.035000,0.203200> rotate<0,0.000000,0> translate<56.698400,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.698400,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,14.224000>}
box{<0,0,-0.203200><1.226400,0.035000,0.203200> rotate<0,0.000000,0> translate<56.698400,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.774800,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,5.689600>}
box{<0,0,-0.203200><1.150000,0.035000,0.203200> rotate<0,0.000000,0> translate<56.774800,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.774800,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,5.689600>}
box{<0,0,-0.203200><1.150000,0.035000,0.203200> rotate<0,0.000000,0> translate<56.774800,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.799900,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,10.566400>}
box{<0,0,-0.203200><1.124900,0.035000,0.203200> rotate<0,0.000000,0> translate<56.799900,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.799900,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,10.566400>}
box{<0,0,-0.203200><1.124900,0.035000,0.203200> rotate<0,0.000000,0> translate<56.799900,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.800000,0.000000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,11.785600>}
box{<0,0,-0.203200><1.124800,0.035000,0.203200> rotate<0,0.000000,0> translate<56.800000,0.000000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.800000,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,11.785600>}
box{<0,0,-0.203200><1.124800,0.035000,0.203200> rotate<0,0.000000,0> translate<56.800000,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.901500,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,9.347200>}
box{<0,0,-0.203200><1.023300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.901500,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.901500,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,13.004800>}
box{<0,0,-0.203200><1.023300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.901500,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.901500,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,13.004800>}
box{<0,0,-0.203200><1.023300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.901500,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.901600,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,9.347200>}
box{<0,0,-0.203200><1.023200,0.035000,0.203200> rotate<0,0.000000,0> translate<56.901600,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,10.368800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,0.000000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,9.443100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,10.368800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,-1.535000,10.368800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,9.753600>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,9.753600>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,10.160000>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,10.160000>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,0.000000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,11.983100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,12.908800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,-1.535000,12.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,12.192000>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,12.192000>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,12.598400>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,12.598400>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,0.000000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,14.523100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,15.448800>}
box{<0,0,-0.203200><0.925700,0.035000,0.203200> rotate<0,90.000000,0> translate<56.997500,-1.535000,15.448800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,14.630400>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,14.630400>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,15.036800>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,15.036800>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,15.443200>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<56.997500,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,15.443200>}
box{<0,0,-0.203200><0.927300,0.035000,0.203200> rotate<0,0.000000,0> translate<56.997500,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.096000,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,19.507200>}
box{<0,0,-0.203200><0.828800,0.035000,0.203200> rotate<0,0.000000,0> translate<57.096000,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.096000,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,19.507200>}
box{<0,0,-0.203200><0.828800,0.035000,0.203200> rotate<0,0.000000,0> translate<57.096000,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,0.000000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<57.295500,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,-1.535000,5.607100>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<57.295500,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,0.000000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<57.295500,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295500,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,-1.535000,19.538800>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,0.000000,0> translate<57.295500,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,0.000000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,5.286400>}
box{<0,0,-0.203200><0.706216,0.035000,0.203200> rotate<0,27.005923,0> translate<57.295600,0.000000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,-1.535000,5.607100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,5.286400>}
box{<0,0,-0.203200><0.706216,0.035000,0.203200> rotate<0,27.005923,0> translate<57.295600,-1.535000,5.607100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,0.000000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,19.859500>}
box{<0,0,-0.203200><0.706216,0.035000,0.203200> rotate<0,-27.005923,0> translate<57.295600,0.000000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.295600,-1.535000,19.538800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,19.859500>}
box{<0,0,-0.203200><0.706216,0.035000,0.203200> rotate<0,-27.005923,0> translate<57.295600,-1.535000,19.538800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,19.859500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,0.000000,5.286400>}
box{<0,0,-0.203200><14.573100,0.035000,0.203200> rotate<0,-90.000000,0> translate<57.924800,0.000000,5.286400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,19.859500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<57.924800,-1.535000,5.286400>}
box{<0,0,-0.203200><14.573100,0.035000,0.203200> rotate<0,-90.000000,0> translate<57.924800,-1.535000,5.286400> }
texture{col_pol}
}
#end
union{
cylinder{<36.322000,0.038000,9.906000><36.322000,-1.538000,9.906000>0.406400}
cylinder{<36.322000,0.038000,4.826000><36.322000,-1.538000,4.826000>0.406400}
cylinder{<36.322000,0.038000,19.304000><36.322000,-1.538000,19.304000>0.406400}
cylinder{<36.322000,0.038000,14.224000><36.322000,-1.538000,14.224000>0.406400}
cylinder{<40.132000,0.038000,19.812000><40.132000,-1.538000,19.812000>0.406400}
cylinder{<40.132000,0.038000,17.272000><40.132000,-1.538000,17.272000>0.406400}
cylinder{<40.132000,0.038000,14.732000><40.132000,-1.538000,14.732000>0.406400}
cylinder{<40.132000,0.038000,12.192000><40.132000,-1.538000,12.192000>0.406400}
cylinder{<40.132000,0.038000,9.652000><40.132000,-1.538000,9.652000>0.406400}
cylinder{<40.132000,0.038000,7.112000><40.132000,-1.538000,7.112000>0.406400}
cylinder{<40.132000,0.038000,4.572000><40.132000,-1.538000,4.572000>0.406400}
cylinder{<47.752000,0.038000,4.572000><47.752000,-1.538000,4.572000>0.406400}
cylinder{<47.752000,0.038000,7.112000><47.752000,-1.538000,7.112000>0.406400}
cylinder{<47.752000,0.038000,9.652000><47.752000,-1.538000,9.652000>0.406400}
cylinder{<47.752000,0.038000,12.192000><47.752000,-1.538000,12.192000>0.406400}
cylinder{<47.752000,0.038000,14.732000><47.752000,-1.538000,14.732000>0.406400}
cylinder{<47.752000,0.038000,17.272000><47.752000,-1.538000,17.272000>0.406400}
cylinder{<47.752000,0.038000,19.812000><47.752000,-1.538000,19.812000>0.406400}
cylinder{<21.590000,0.038000,11.430000><21.590000,-1.538000,11.430000>0.406400}
cylinder{<21.590000,0.038000,8.890000><21.590000,-1.538000,8.890000>0.406400}
cylinder{<21.590000,0.038000,6.350000><21.590000,-1.538000,6.350000>0.406400}
cylinder{<21.590000,0.038000,3.810000><21.590000,-1.538000,3.810000>0.406400}
cylinder{<29.210000,0.038000,3.810000><29.210000,-1.538000,3.810000>0.406400}
cylinder{<29.210000,0.038000,6.350000><29.210000,-1.538000,6.350000>0.406400}
cylinder{<29.210000,0.038000,8.890000><29.210000,-1.538000,8.890000>0.406400}
cylinder{<29.210000,0.038000,11.430000><29.210000,-1.538000,11.430000>0.406400}
cylinder{<21.590000,0.038000,21.590000><21.590000,-1.538000,21.590000>0.406400}
cylinder{<21.590000,0.038000,19.050000><21.590000,-1.538000,19.050000>0.406400}
cylinder{<21.590000,0.038000,16.510000><21.590000,-1.538000,16.510000>0.406400}
cylinder{<21.590000,0.038000,13.970000><21.590000,-1.538000,13.970000>0.406400}
cylinder{<29.210000,0.038000,13.970000><29.210000,-1.538000,13.970000>0.406400}
cylinder{<29.210000,0.038000,16.510000><29.210000,-1.538000,16.510000>0.406400}
cylinder{<29.210000,0.038000,19.050000><29.210000,-1.538000,19.050000>0.406400}
cylinder{<29.210000,0.038000,21.590000><29.210000,-1.538000,21.590000>0.406400}
cylinder{<17.780000,0.038000,8.890000><17.780000,-1.538000,8.890000>0.406400}
cylinder{<17.780000,0.038000,11.430000><17.780000,-1.538000,11.430000>0.406400}
cylinder{<17.780000,0.038000,6.350000><17.780000,-1.538000,6.350000>0.406400}
cylinder{<17.780000,0.038000,3.810000><17.780000,-1.538000,3.810000>0.406400}
cylinder{<32.766000,0.038000,8.890000><32.766000,-1.538000,8.890000>0.406400}
cylinder{<32.766000,0.038000,11.430000><32.766000,-1.538000,11.430000>0.406400}
cylinder{<32.766000,0.038000,6.096000><32.766000,-1.538000,6.096000>0.406400}
cylinder{<32.766000,0.038000,3.556000><32.766000,-1.538000,3.556000>0.406400}
cylinder{<17.780000,0.038000,19.050000><17.780000,-1.538000,19.050000>0.406400}
cylinder{<17.780000,0.038000,21.590000><17.780000,-1.538000,21.590000>0.406400}
cylinder{<17.780000,0.038000,16.510000><17.780000,-1.538000,16.510000>0.406400}
cylinder{<17.780000,0.038000,13.970000><17.780000,-1.538000,13.970000>0.406400}
cylinder{<32.766000,0.038000,19.050000><32.766000,-1.538000,19.050000>0.406400}
cylinder{<32.766000,0.038000,21.590000><32.766000,-1.538000,21.590000>0.406400}
cylinder{<32.766000,0.038000,16.510000><32.766000,-1.538000,16.510000>0.406400}
cylinder{<32.766000,0.038000,13.970000><32.766000,-1.538000,13.970000>0.406400}
cylinder{<53.340000,0.038000,14.986000><53.340000,-1.538000,14.986000>0.457200}
cylinder{<55.880000,0.038000,14.986000><55.880000,-1.538000,14.986000>0.457200}
cylinder{<53.340000,0.038000,12.446000><53.340000,-1.538000,12.446000>0.457200}
cylinder{<55.880000,0.038000,12.446000><55.880000,-1.538000,12.446000>0.457200}
cylinder{<53.340000,0.038000,9.906000><53.340000,-1.538000,9.906000>0.457200}
cylinder{<55.880000,0.038000,9.906000><55.880000,-1.538000,9.906000>0.457200}
cylinder{<12.192000,0.038000,9.906000><12.192000,-1.538000,9.906000>0.457200}
cylinder{<9.652000,0.038000,9.906000><9.652000,-1.538000,9.906000>0.457200}
cylinder{<12.192000,0.038000,12.446000><12.192000,-1.538000,12.446000>0.457200}
cylinder{<9.652000,0.038000,12.446000><9.652000,-1.538000,12.446000>0.457200}
cylinder{<12.192000,0.038000,14.986000><12.192000,-1.538000,14.986000>0.457200}
cylinder{<9.652000,0.038000,14.986000><9.652000,-1.538000,14.986000>0.457200}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.563600,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.343100,0.000000,0.355600>}
box{<0,0,-0.101600><0.779500,0.036000,0.101600> rotate<0,0.000000,0> translate<13.563600,0.000000,0.355600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.953300,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.953300,0.000000,2.694300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<13.953300,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.563600,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.343100,0.000000,2.694300>}
box{<0,0,-0.101600><0.779500,0.036000,0.101600> rotate<0,0.000000,0> translate<13.563600,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.122700,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.122700,0.000000,2.694300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<15.122700,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.122700,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.681800,0.000000,0.355600>}
box{<0,0,-0.101600><2.810749,0.036000,0.101600> rotate<0,56.306782,0> translate<15.122700,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.681800,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.681800,0.000000,2.694300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<16.681800,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.244900,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.465300,0.000000,2.694300>}
box{<0,0,-0.101600><0.779600,0.036000,0.101600> rotate<0,0.000000,0> translate<46.465300,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.465300,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.075600,0.000000,2.304500>}
box{<0,0,-0.101600><0.551190,0.036000,0.101600> rotate<0,-45.004380,0> translate<46.075600,0.000000,2.304500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.075600,0.000000,2.304500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.075600,0.000000,0.745300>}
box{<0,0,-0.101600><1.559200,0.036000,0.101600> rotate<0,-90.000000,0> translate<46.075600,0.000000,0.745300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.075600,0.000000,0.745300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.465300,0.000000,0.355600>}
box{<0,0,-0.101600><0.551119,0.036000,0.101600> rotate<0,44.997030,0> translate<46.075600,0.000000,0.745300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.465300,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.244900,0.000000,0.355600>}
box{<0,0,-0.101600><0.779600,0.036000,0.101600> rotate<0,0.000000,0> translate<46.465300,0.000000,0.355600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.244900,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.634700,0.000000,0.745300>}
box{<0,0,-0.101600><0.551190,0.036000,0.101600> rotate<0,-44.989680,0> translate<47.244900,0.000000,0.355600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.634700,0.000000,0.745300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.634700,0.000000,2.304500>}
box{<0,0,-0.101600><1.559200,0.036000,0.101600> rotate<0,90.000000,0> translate<47.634700,0.000000,2.304500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.634700,0.000000,2.304500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.244900,0.000000,2.694300>}
box{<0,0,-0.101600><0.551260,0.036000,0.101600> rotate<0,44.997030,0> translate<47.244900,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.414300,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.414300,0.000000,0.745300>}
box{<0,0,-0.101600><1.949000,0.036000,0.101600> rotate<0,-90.000000,0> translate<48.414300,0.000000,0.745300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.414300,0.000000,0.745300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.804000,0.000000,0.355600>}
box{<0,0,-0.101600><0.551119,0.036000,0.101600> rotate<0,44.997030,0> translate<48.414300,0.000000,0.745300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<48.804000,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<49.583600,0.000000,0.355600>}
box{<0,0,-0.101600><0.779600,0.036000,0.101600> rotate<0,0.000000,0> translate<48.804000,0.000000,0.355600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<49.583600,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<49.973400,0.000000,0.745300>}
box{<0,0,-0.101600><0.551190,0.036000,0.101600> rotate<0,-44.989680,0> translate<49.583600,0.000000,0.355600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<49.973400,0.000000,0.745300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<49.973400,0.000000,2.694300>}
box{<0,0,-0.101600><1.949000,0.036000,0.101600> rotate<0,90.000000,0> translate<49.973400,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.532500,0.000000,0.355600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.532500,0.000000,2.694300>}
box{<0,0,-0.101600><2.338700,0.036000,0.101600> rotate<0,90.000000,0> translate<51.532500,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.753000,0.000000,2.694300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.312100,0.000000,2.694300>}
box{<0,0,-0.101600><1.559100,0.036000,0.101600> rotate<0,0.000000,0> translate<50.753000,0.000000,2.694300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.656400,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.114100,0.000000,25.299700>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<14.114100,0.000000,25.299700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.114100,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,25.028600>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.843000,0.000000,25.028600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,25.028600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,23.943900>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.843000,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.114100,0.000000,23.672800>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<13.843000,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.114100,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.656400,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<14.114100,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.656400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.927600,0.000000,23.943900>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<14.656400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.927600,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.927600,0.000000,25.028600>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,90.000000,0> translate<14.927600,0.000000,25.028600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.927600,0.000000,25.028600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.656400,0.000000,25.299700>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<14.656400,0.000000,25.299700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.480100,0.000000,23.130500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.480100,0.000000,24.757400>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<15.480100,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.480100,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.293500,0.000000,24.757400>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<15.480100,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.293500,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.564700,0.000000,24.486200>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<16.293500,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.564700,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.564700,0.000000,23.943900>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.564700,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.564700,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.293500,0.000000,23.672800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<16.293500,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.293500,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.480100,0.000000,23.672800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<15.480100,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.388300,0.000000,25.028600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.388300,0.000000,23.943900>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<17.388300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.388300,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.659500,0.000000,23.672800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<17.388300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.117200,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.659500,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<17.117200,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.479700,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.022000,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<18.479700,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.022000,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.293200,0.000000,23.943900>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<19.022000,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.293200,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.293200,0.000000,24.486200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<19.293200,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.293200,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.022000,0.000000,24.757400>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<19.022000,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.022000,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.479700,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<18.479700,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.479700,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.208600,0.000000,24.486200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<18.208600,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.208600,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.208600,0.000000,23.943900>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.208600,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.208600,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.479700,0.000000,23.672800>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<18.208600,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.482800,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.025100,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<21.482800,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.753900,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.753900,0.000000,25.299700>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,90.000000,0> translate<21.753900,0.000000,25.299700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.482800,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.025100,0.000000,25.299700>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<21.482800,0.000000,25.299700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.574200,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.387600,0.000000,23.672800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,0.000000,0> translate<22.574200,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.387600,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.658800,0.000000,23.943900>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<23.387600,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.658800,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.387600,0.000000,24.215100>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<23.387600,0.000000,24.215100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.387600,0.000000,24.215100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.845300,0.000000,24.215100>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<22.845300,0.000000,24.215100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.845300,0.000000,24.215100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.574200,0.000000,24.486200>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<22.574200,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.574200,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.845300,0.000000,24.757400>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<22.574200,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.845300,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.658800,0.000000,24.757400>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<22.845300,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.482400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.024700,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<24.482400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.024700,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.295900,0.000000,23.943900>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<25.024700,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.295900,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.295900,0.000000,24.486200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<25.295900,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.295900,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.024700,0.000000,24.757400>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<25.024700,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.024700,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.482400,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<24.482400,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.482400,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.211300,0.000000,24.486200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<24.211300,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.211300,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.211300,0.000000,23.943900>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.211300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.211300,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.482400,0.000000,23.672800>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<24.211300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.848400,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.119500,0.000000,25.299700>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<25.848400,0.000000,25.299700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.119500,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.119500,0.000000,23.672800>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.119500,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.848400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.390700,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<25.848400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.210900,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.753200,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<27.210900,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.753200,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.024400,0.000000,24.486200>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<27.753200,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.024400,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.024400,0.000000,23.672800>}
box{<0,0,-0.076200><0.813400,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.024400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.024400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.210900,0.000000,23.672800>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<27.210900,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.210900,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.939800,0.000000,23.943900>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<26.939800,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.939800,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.210900,0.000000,24.215100>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<26.939800,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.210900,0.000000,24.215100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.024400,0.000000,24.215100>}
box{<0,0,-0.076200><0.813500,0.036000,0.076200> rotate<0,0.000000,0> translate<27.210900,0.000000,24.215100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.848000,0.000000,25.028600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.848000,0.000000,23.943900>}
box{<0,0,-0.076200><1.084700,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.848000,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.848000,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.119200,0.000000,23.672800>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,44.986466,0> translate<28.848000,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.576900,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.119200,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<28.576900,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.939400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.481700,0.000000,23.672800>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<29.939400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.481700,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.752900,0.000000,23.943900>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-44.986466,0> translate<30.481700,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.752900,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.752900,0.000000,24.486200>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,90.000000,0> translate<30.752900,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.752900,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.481700,0.000000,24.757400>}
box{<0,0,-0.076200><0.383535,0.036000,0.076200> rotate<0,44.997030,0> translate<30.481700,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.481700,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.939400,0.000000,24.757400>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,0.000000,0> translate<29.939400,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.939400,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.668300,0.000000,24.486200>}
box{<0,0,-0.076200><0.383464,0.036000,0.076200> rotate<0,-45.007595,0> translate<29.668300,0.000000,24.486200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.668300,0.000000,24.486200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.668300,0.000000,23.943900>}
box{<0,0,-0.076200><0.542300,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.668300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.668300,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.939400,0.000000,23.672800>}
box{<0,0,-0.076200><0.383393,0.036000,0.076200> rotate<0,44.997030,0> translate<29.668300,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.305400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.305400,0.000000,24.757400>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,90.000000,0> translate<31.305400,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.305400,0.000000,24.215100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.847700,0.000000,24.757400>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.305400,0.000000,24.215100> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.847700,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.118800,0.000000,24.757400>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<31.847700,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.306700,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.849000,0.000000,23.672800>}
box{<0,0,-0.076200><1.212620,0.036000,0.076200> rotate<0,63.430762,0> translate<34.306700,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.849000,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.391300,0.000000,24.757400>}
box{<0,0,-0.076200><1.212620,0.036000,0.076200> rotate<0,-63.430762,0> translate<34.849000,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.943800,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.486100,0.000000,25.299700>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<35.943800,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.486100,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.486100,0.000000,23.672800>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.486100,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.943800,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.028400,0.000000,23.672800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<35.943800,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.580900,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.580900,0.000000,23.943900>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,90.000000,0> translate<37.580900,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.580900,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.852000,0.000000,23.943900>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<37.580900,0.000000,23.943900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.852000,0.000000,23.943900>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.852000,0.000000,23.672800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.852000,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.852000,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.580900,0.000000,23.672800>}
box{<0,0,-0.076200><0.271100,0.036000,0.076200> rotate<0,0.000000,0> translate<37.580900,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.399400,0.000000,24.757400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.941700,0.000000,25.299700>}
box{<0,0,-0.076200><0.766928,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.399400,0.000000,24.757400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.941700,0.000000,25.299700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.941700,0.000000,23.672800>}
box{<0,0,-0.076200><1.626900,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.941700,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.399400,0.000000,23.672800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.484000,0.000000,23.672800>}
box{<0,0,-0.076200><1.084600,0.036000,0.076200> rotate<0,0.000000,0> translate<38.399400,0.000000,23.672800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.338800,0.000000,1.474100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.338800,0.000000,0.304800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<18.338800,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.338800,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.533600,0.000000,1.084300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<18.338800,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.533600,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.923400,0.000000,1.084300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<18.533600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<18.923400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.118300,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<18.923400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.118300,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.118300,0.000000,0.304800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.118300,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.702900,0.000000,1.279200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.702900,0.000000,0.499600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<19.702900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.702900,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.897800,0.000000,0.304800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<19.702900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.508100,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<19.897800,0.000000,1.084300>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<19.508100,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.482400,0.000000,1.279200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.482400,0.000000,0.499600>}
box{<0,0,-0.050800><0.779600,0.036000,0.050800> rotate<0,-90.000000,0> translate<20.482400,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.482400,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.677300,0.000000,0.304800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,44.982329,0> translate<20.482400,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.287600,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<20.677300,0.000000,1.084300>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<20.287600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.067100,0.000000,-0.084900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.067100,0.000000,1.084300>}
box{<0,0,-0.050800><1.169200,0.036000,0.050800> rotate<0,90.000000,0> translate<21.067100,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.067100,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.651700,0.000000,1.084300>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<21.067100,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.651700,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.846600,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<21.651700,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.846600,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.846600,0.000000,0.499600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<21.846600,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.846600,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.651700,0.000000,0.304800>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<21.651700,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.651700,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<21.067100,0.000000,0.304800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,0.000000,0> translate<21.067100,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,1.084300>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<22.236400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.889400>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.431200,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.889400>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<22.236400,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,1.084300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,90.000000,0> translate<22.236400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<22.236400,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<22.431200,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.431200,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<22.236400,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.236400,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<22.236400,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.821000,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.600500,0.000000,1.474100>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,-56.307347,0> translate<22.821000,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.990300,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<24.769800,0.000000,1.474100>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,-56.307347,0> translate<23.990300,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.159600,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.159600,0.000000,1.084300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<25.159600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.159600,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.354400,0.000000,1.084300>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<25.159600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.354400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.549300,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<25.354400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.549300,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.549300,0.000000,0.304800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<25.549300,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.549300,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.744200,0.000000,1.084300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<25.549300,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.744200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.939100,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<25.744200,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.939100,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<25.939100,0.000000,0.304800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<25.939100,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.523700,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.913500,0.000000,1.084300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<26.523700,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.913500,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.108400,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<26.913500,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.108400,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.108400,0.000000,0.304800>}
box{<0,0,-0.050800><0.584600,0.036000,0.050800> rotate<0,-90.000000,0> translate<27.108400,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.108400,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.523700,0.000000,0.304800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<26.523700,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.523700,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.328900,0.000000,0.499600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<26.328900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.328900,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.523700,0.000000,0.694500>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<26.328900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<26.523700,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.108400,0.000000,0.694500>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<26.523700,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.498200,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.498200,0.000000,1.474100>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,90.000000,0> translate<27.498200,0.000000,1.474100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.082800,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.498200,0.000000,0.694500>}
box{<0,0,-0.050800><0.702583,0.036000,0.050800> rotate<0,33.685582,0> translate<27.498200,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.498200,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.082800,0.000000,1.084300>}
box{<0,0,-0.050800><0.702639,0.036000,0.050800> rotate<0,-33.692367,0> translate<27.498200,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.057200,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.667400,0.000000,0.304800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<28.667400,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.667400,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.472600,0.000000,0.499600>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<28.472600,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.472600,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.472600,0.000000,0.889400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<28.472600,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.472600,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.667400,0.000000,1.084300>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<28.472600,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.667400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.057200,0.000000,1.084300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<28.667400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.057200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.252100,0.000000,0.889400>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<29.057200,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.252100,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.252100,0.000000,0.694500>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<29.252100,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.252100,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.472600,0.000000,0.694500>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<28.472600,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.641900,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.641900,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<29.641900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.641900,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.836700,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<29.641900,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.836700,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.836700,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<29.836700,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.836700,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.641900,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<29.641900,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.226500,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.226500,0.000000,1.084300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<30.226500,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.226500,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.616200,0.000000,1.084300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<30.226500,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.616200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<30.811100,0.000000,1.084300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<30.616200,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.200900,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.200900,0.000000,1.084300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<31.200900,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.200900,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.590600,0.000000,1.084300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<31.200900,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.590600,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.785500,0.000000,1.084300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<31.590600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.175300,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.175300,0.000000,1.084300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<32.175300,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.175300,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.565000,0.000000,1.084300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<32.175300,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.565000,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.759900,0.000000,1.084300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<32.565000,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.344500,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.344500,0.000000,1.279200>}
box{<0,0,-0.050800><0.974400,0.036000,0.050800> rotate<0,90.000000,0> translate<33.344500,0.000000,1.279200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.344500,0.000000,1.279200>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.539400,0.000000,1.474100>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<33.344500,0.000000,1.279200> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.149700,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.539400,0.000000,0.889400>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<33.149700,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.929200,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.929200,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<33.929200,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.929200,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.124000,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<33.929200,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.124000,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.124000,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<34.124000,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.124000,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.929200,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<33.929200,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.708600,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.098400,0.000000,0.304800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<34.708600,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.098400,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.293300,0.000000,0.499600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<35.098400,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.293300,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.293300,0.000000,0.889400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<35.293300,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.293300,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.098400,0.000000,1.084300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<35.098400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.098400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.708600,0.000000,1.084300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<34.708600,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.708600,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.513800,0.000000,0.889400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<34.513800,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.513800,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.513800,0.000000,0.499600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<34.513800,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.513800,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<34.708600,0.000000,0.304800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<34.513800,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.683100,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.683100,0.000000,1.084300>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,90.000000,0> translate<35.683100,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<35.683100,0.000000,0.694500>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.072800,0.000000,1.084300>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<35.683100,0.000000,0.694500> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.072800,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.267700,0.000000,1.084300>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<36.072800,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.047200,0.000000,-0.084900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.242100,0.000000,-0.084900>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,0.000000,0> translate<37.047200,0.000000,-0.084900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.242100,0.000000,-0.084900>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.437000,0.000000,0.110000>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,-44.997030,0> translate<37.242100,0.000000,-0.084900> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.437000,0.000000,0.110000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.437000,0.000000,1.084300>}
box{<0,0,-0.050800><0.974300,0.036000,0.050800> rotate<0,90.000000,0> translate<37.437000,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.437000,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.852300,0.000000,1.084300>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<36.852300,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.852300,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.657500,0.000000,0.889400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<36.657500,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.657500,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.657500,0.000000,0.499600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<36.657500,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.657500,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.852300,0.000000,0.304800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<36.657500,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.852300,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.437000,0.000000,0.304800>}
box{<0,0,-0.050800><0.584700,0.036000,0.050800> rotate<0,0.000000,0> translate<36.852300,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.826800,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.606300,0.000000,1.474100>}
box{<0,0,-0.050800><1.405305,0.036000,0.050800> rotate<0,-56.307347,0> translate<37.826800,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.190900,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.580700,0.000000,0.304800>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<39.190900,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.580700,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.775600,0.000000,0.499600>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-44.982329,0> translate<39.580700,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.775600,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.775600,0.000000,0.889400>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,90.000000,0> translate<39.775600,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.775600,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.580700,0.000000,1.084300>}
box{<0,0,-0.050800><0.275630,0.036000,0.050800> rotate<0,44.997030,0> translate<39.580700,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.580700,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.190900,0.000000,1.084300>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,0.000000,0> translate<39.190900,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.190900,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.996100,0.000000,0.889400>}
box{<0,0,-0.050800><0.275560,0.036000,0.050800> rotate<0,-45.011732,0> translate<38.996100,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.996100,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.996100,0.000000,0.499600>}
box{<0,0,-0.050800><0.389800,0.036000,0.050800> rotate<0,-90.000000,0> translate<38.996100,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<38.996100,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<39.190900,0.000000,0.304800>}
box{<0,0,-0.050800><0.275489,0.036000,0.050800> rotate<0,44.997030,0> translate<38.996100,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.165400,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.360200,0.000000,1.084300>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<40.165400,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.360200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.360200,0.000000,0.304800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,-90.000000,0> translate<40.360200,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.165400,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.555100,0.000000,0.304800>}
box{<0,0,-0.050800><0.389700,0.036000,0.050800> rotate<0,0.000000,0> translate<40.165400,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.360200,0.000000,1.669000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.360200,0.000000,1.474100>}
box{<0,0,-0.050800><0.194900,0.036000,0.050800> rotate<0,-90.000000,0> translate<40.360200,0.000000,1.474100> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<40.944900,0.000000,0.889400>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<41.724400,0.000000,0.889400>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<40.944900,0.000000,0.889400> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.114200,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.503900,0.000000,1.474100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<42.114200,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.503900,0.000000,1.474100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.503900,0.000000,0.304800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<42.503900,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.114200,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<42.893700,0.000000,0.304800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<42.114200,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.283500,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.283500,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,90.000000,0> translate<43.283500,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.283500,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.478300,0.000000,0.499600>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<43.283500,0.000000,0.499600> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.478300,0.000000,0.499600>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.478300,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,-90.000000,0> translate<43.478300,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.478300,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.283500,0.000000,0.304800>}
box{<0,0,-0.050800><0.194800,0.036000,0.050800> rotate<0,0.000000,0> translate<43.283500,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.868100,0.000000,1.084300>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.257800,0.000000,1.474100>}
box{<0,0,-0.050800><0.551190,0.036000,0.050800> rotate<0,-45.004380,0> translate<43.868100,0.000000,1.084300> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.257800,0.000000,1.474100>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.257800,0.000000,0.304800>}
box{<0,0,-0.050800><1.169300,0.036000,0.050800> rotate<0,-90.000000,0> translate<44.257800,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<43.868100,0.000000,0.304800>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<44.647600,0.000000,0.304800>}
box{<0,0,-0.050800><0.779500,0.036000,0.050800> rotate<0,0.000000,0> translate<43.868100,0.000000,0.304800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,21.865500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.800900,0.000000,21.865500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<40.800900,0.000000,21.865500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.800900,0.000000,21.865500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,21.742700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<40.678100,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,21.496900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.678100,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.800900,0.000000,21.374100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<40.678100,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.800900,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,21.374100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<40.800900,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,22.111300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<42.174900,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,22.111300>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.174900,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<42.543500,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,21.742700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.666300,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,21.619800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<42.543500,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,21.619800>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.174900,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.420600,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,21.374100>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<42.420600,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,22.111300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<42.923300,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,22.111300>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.923300,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<43.291900,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,21.742700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.414700,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,21.619800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<43.291900,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,21.619800>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.923300,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.169000,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,21.374100>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<43.169000,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,22.111300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<43.671700,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.040300,0.000000,22.111300>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.671700,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.040300,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<44.040300,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,21.742700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,-90.000000,0> translate<44.163100,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.040300,0.000000,21.619800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<44.040300,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.040300,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,21.619800>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.671700,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.917400,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,21.374100>}
box{<0,0,-0.038100><0.347472,0.036000,0.038100> rotate<0,44.997030,0> translate<43.917400,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,22.111300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<44.420100,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.911500,0.000000,22.111300>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<44.420100,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.665800,0.000000,21.742700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<44.420100,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.408300,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,21.374100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<45.916900,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.408300,0.000000,21.865500>}
box{<0,0,-0.038100><0.694945,0.036000,0.038100> rotate<0,-44.997030,0> translate<45.916900,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.408300,0.000000,21.865500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.408300,0.000000,21.988400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,90.000000,0> translate<46.408300,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.408300,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.285500,0.000000,22.111300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<46.285500,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.285500,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.039700,0.000000,22.111300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.039700,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.039700,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<45.916900,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.665300,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.665300,0.000000,21.988400>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,90.000000,0> translate<46.665300,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.665300,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.788100,0.000000,22.111300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<46.665300,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.788100,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.033900,0.000000,22.111300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.788100,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.033900,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.156700,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<47.033900,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.156700,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.156700,0.000000,21.496900>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.156700,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.156700,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.033900,0.000000,21.374100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<47.033900,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.033900,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.788100,0.000000,21.374100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.788100,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.788100,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.665300,0.000000,21.496900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<46.665300,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.665300,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.156700,0.000000,21.988400>}
box{<0,0,-0.038100><0.695015,0.036000,0.038100> rotate<0,-45.002859,0> translate<46.665300,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.413700,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.413700,0.000000,21.988400>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,90.000000,0> translate<47.413700,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.413700,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.536500,0.000000,22.111300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<47.413700,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.536500,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.782300,0.000000,22.111300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<47.536500,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.782300,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.905100,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<47.782300,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.905100,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.905100,0.000000,21.496900>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.905100,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.905100,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.782300,0.000000,21.374100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<47.782300,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.782300,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.536500,0.000000,21.374100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<47.536500,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.536500,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.413700,0.000000,21.496900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<47.413700,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.413700,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.905100,0.000000,21.988400>}
box{<0,0,-0.038100><0.695015,0.036000,0.038100> rotate<0,-45.002859,0> translate<47.413700,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,22.111300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<48.162100,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,22.111300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.284900,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,22.111300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.988400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<48.530700,0.000000,22.111300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.988400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.865500>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.653500,0.000000,21.865500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.865500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,21.742700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<48.530700,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.619800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<48.530700,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.496900>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.653500,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.653500,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,21.374100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<48.530700,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,21.374100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.284900,0.000000,21.374100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,21.374100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.496900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<48.162100,0.000000,21.496900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.496900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.619800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,90.000000,0> translate<48.162100,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.619800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,21.742700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<48.162100,0.000000,21.619800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.865500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<48.162100,0.000000,21.865500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.865500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.162100,0.000000,21.988400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,90.000000,0> translate<48.162100,0.000000,21.988400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.284900,0.000000,21.742700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.530700,0.000000,21.742700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.284900,0.000000,21.742700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,22.390100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.678100,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,22.390100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<40.678100,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,22.881500>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<41.426500,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,22.390100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.549300,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.672200,0.000000,22.390100>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<41.426500,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.250200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.127300>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.549300,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.416800,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.048200,0.000000,22.881500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.048200,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.048200,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.925400,0.000000,22.758700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<41.925400,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.925400,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.925400,0.000000,22.512900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.925400,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.925400,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.048200,0.000000,22.390100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<41.925400,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.048200,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.416800,0.000000,22.390100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.048200,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.042400,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.796600,0.000000,22.390100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<42.796600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.796600,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.673800,0.000000,22.512900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<42.673800,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.673800,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.673800,0.000000,22.758700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<42.673800,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.673800,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.796600,0.000000,22.881500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.673800,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.796600,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.042400,0.000000,22.881500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<42.796600,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.042400,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.165200,0.000000,22.758700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<43.042400,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.165200,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.165200,0.000000,22.635800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.165200,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.165200,0.000000,22.635800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.673800,0.000000,22.635800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<42.673800,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,22.881500>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,90.000000,0> translate<43.422200,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.790800,0.000000,22.881500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.422200,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.790800,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,22.758700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<43.790800,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,22.390100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.913600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,22.390100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<44.170600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,22.512900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.539200,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,22.635800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<44.539200,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,22.635800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.293400,0.000000,22.635800>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<44.293400,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.293400,0.000000,22.635800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,22.758700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<44.170600,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.293400,0.000000,22.881500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.170600,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.293400,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,22.881500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<44.293400,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,22.390100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.041800,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,22.512900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<44.919000,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,22.758700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<44.919000,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,22.881500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.919000,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,22.881500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.041800,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,22.758700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<45.287600,0.000000,22.881500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,22.635800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<45.410400,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,22.635800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,22.635800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<44.919000,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.907200,0.000000,23.004400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.784400,0.000000,23.127300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<46.784400,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.784400,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.538600,0.000000,23.127300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.538600,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.538600,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.415800,0.000000,23.004400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<46.415800,0.000000,23.004400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.415800,0.000000,23.004400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.415800,0.000000,22.512900>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,-90.000000,0> translate<46.415800,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.415800,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.538600,0.000000,22.390100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<46.415800,0.000000,22.512900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.538600,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.784400,0.000000,22.390100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.538600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.784400,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.907200,0.000000,22.512900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<46.784400,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.907200,0.000000,22.512900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.907200,0.000000,22.758700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<46.907200,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.907200,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.661500,0.000000,22.758700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<46.661500,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,23.127300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<47.164200,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,23.127300>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<47.164200,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,23.004400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<47.532800,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,23.004400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,22.758700>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.655600,0.000000,22.758700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,22.758700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,22.635800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<47.532800,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,22.635800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,22.635800>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<47.164200,0.000000,22.635800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,22.390100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.912600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.404000,0.000000,22.390100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<47.912600,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.152400,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,22.390100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<48.661000,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,22.390100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.152400,0.000000,22.881500>}
box{<0,0,-0.038100><0.694945,0.036000,0.038100> rotate<0,-44.997030,0> translate<48.661000,0.000000,22.390100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.152400,0.000000,22.881500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.152400,0.000000,23.004400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,90.000000,0> translate<49.152400,0.000000,23.004400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.152400,0.000000,23.004400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.029600,0.000000,23.127300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<49.029600,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.029600,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,23.127300>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.783800,0.000000,23.127300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,23.127300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,23.004400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<48.661000,0.000000,23.004400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,25.413300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,24.676100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.678100,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.046700,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<40.678100,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.046700,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<41.046700,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,25.290400>}
box{<0,0,-0.038100><0.491500,0.036000,0.038100> rotate<0,90.000000,0> translate<41.169500,0.000000,25.290400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,25.290400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.046700,0.000000,25.413300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<41.046700,0.000000,25.413300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.046700,0.000000,25.413300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,25.413300>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<40.678100,0.000000,25.413300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.795100,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,24.676100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<41.549300,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<41.426500,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,25.044700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<41.426500,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,25.167500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<41.426500,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.795100,0.000000,25.167500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<41.549300,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.795100,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,25.044700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<41.795100,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,24.921800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.917900,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,24.921800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,24.921800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<41.426500,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.174900,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.543500,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,24.921800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<42.543500,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.543500,0.000000,24.921800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,24.921800>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<42.297700,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,24.921800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,25.044700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,45.020348,0> translate<42.174900,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,25.167500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.174900,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,25.167500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.297700,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,25.167500>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<42.923300,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,24.676100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.046100,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.169000,0.000000,24.676100>}
box{<0,0,-0.038100><0.245700,0.036000,0.038100> rotate<0,0.000000,0> translate<42.923300,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,25.536200>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,25.413300>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.046100,0.000000,25.413300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.667900,0.000000,24.430400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.790800,0.000000,24.430400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,0.000000,0> translate<43.667900,0.000000,24.430400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.790800,0.000000,24.430400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,24.553300>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<43.790800,0.000000,24.430400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,24.553300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,25.167500>}
box{<0,0,-0.038100><0.614200,0.036000,0.038100> rotate<0,90.000000,0> translate<43.913600,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.545000,0.000000,25.167500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.545000,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.545000,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,25.044700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<43.422200,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,24.798900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.422200,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.422200,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.545000,0.000000,24.676100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<43.422200,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.545000,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.913600,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<43.545000,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,25.167500>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,90.000000,0> translate<44.170600,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.170600,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,25.167500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<44.170600,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.539200,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,25.044700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<44.539200,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.662000,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<44.662000,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,24.676100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.041800,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<44.919000,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,25.044700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<44.919000,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,25.167500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.919000,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.041800,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,25.167500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.041800,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.287600,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,25.044700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<45.287600,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,24.921800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<45.410400,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.410400,0.000000,24.921800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.919000,0.000000,24.921800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<44.919000,0.000000,24.921800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.158800,0.000000,25.413300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.158800,0.000000,24.676100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<46.158800,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.158800,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.790200,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<45.790200,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.790200,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.667400,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<45.667400,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.667400,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.667400,0.000000,25.044700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<45.667400,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.667400,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.790200,0.000000,25.167500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<45.667400,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.790200,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.158800,0.000000,25.167500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<45.790200,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,25.413300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,24.676100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.164200,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<47.164200,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,24.798900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<47.532800,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,25.044700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<47.655600,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.655600,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,25.167500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<47.532800,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.532800,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.164200,0.000000,25.167500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<47.164200,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,24.798900>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.912600,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.912600,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.035400,0.000000,24.676100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<47.912600,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.035400,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.404000,0.000000,24.676100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<48.035400,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.404000,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.404000,0.000000,24.553300>}
box{<0,0,-0.038100><0.614200,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.404000,0.000000,24.553300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.404000,0.000000,24.553300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.281200,0.000000,24.430400>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<48.281200,0.000000,24.430400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.281200,0.000000,24.430400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.158300,0.000000,24.430400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,0.000000,0> translate<48.158300,0.000000,24.430400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,25.167500>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.661000,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,25.167500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,25.044700>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.783800,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,25.044700>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.661000,0.000000,25.044700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,25.044700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,25.167500>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,90.000000,0> translate<48.661000,0.000000,25.167500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,24.798900>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.661000,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,24.798900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,24.676100>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.783800,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.783800,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,24.676100>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.661000,0.000000,24.676100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,24.676100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.661000,0.000000,24.798900>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,90.000000,0> translate<48.661000,0.000000,24.798900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,24.397300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.397300>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<40.678100,0.000000,24.397300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.397300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.274400>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.169500,0.000000,24.274400> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,24.274400>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,23.782900>}
box{<0,0,-0.038100><0.695015,0.036000,0.038100> rotate<0,-45.002859,0> translate<40.678100,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,23.660100>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,-90.000000,0> translate<40.678100,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<40.678100,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.169500,0.000000,23.660100>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<40.678100,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.795100,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<41.549300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.795100,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<41.795100,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<41.917900,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<41.549300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,23.782900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<41.426500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.426500,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.905800>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-45.020348,0> translate<41.426500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.549300,0.000000,23.905800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<41.917900,0.000000,23.905800>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<41.549300,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,24.151500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.297700,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.174900,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,23.782900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.174900,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.174900,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,23.660100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<42.174900,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.297700,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.666300,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<42.297700,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,24.397300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,23.660100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<42.923300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<42.923300,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,24.151500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<42.923300,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.046100,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<43.046100,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.291900,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<43.291900,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.414700,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<43.414700,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,24.397300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<43.671700,0.000000,24.397300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<43.671700,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,24.028700>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<43.671700,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,24.397300>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.163100,0.000000,23.660100>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,-90.000000,0> translate<44.163100,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.542900,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.788700,0.000000,23.660100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<44.542900,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.788700,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.911500,0.000000,23.782900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.788700,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.911500,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.911500,0.000000,24.028700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<44.911500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.911500,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.788700,0.000000,24.151500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<44.788700,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.788700,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.542900,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<44.542900,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.542900,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<44.420100,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,23.782900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<44.420100,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.420100,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<44.542900,0.000000,23.660100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<44.420100,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.537100,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.291300,0.000000,23.660100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.291300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.291300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.168500,0.000000,23.782900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<45.168500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.168500,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.168500,0.000000,24.028700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<45.168500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.168500,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.291300,0.000000,24.151500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<45.168500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.291300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.537100,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<45.291300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.537100,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.659900,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<45.537100,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.659900,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.659900,0.000000,23.905800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<45.659900,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.659900,0.000000,23.905800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.168500,0.000000,23.905800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<45.168500,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,24.397300>}
box{<0,0,-0.038100><0.737200,0.036000,0.038100> rotate<0,90.000000,0> translate<45.916900,0.000000,24.397300> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.285500,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,23.905800>}
box{<0,0,-0.038100><0.442984,0.036000,0.038100> rotate<0,33.684257,0> translate<45.916900,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<45.916900,0.000000,23.905800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.285500,0.000000,24.151500>}
box{<0,0,-0.038100><0.442984,0.036000,0.038100> rotate<0,-33.684257,0> translate<45.916900,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.909100,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.663300,0.000000,23.660100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.663300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.663300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.540500,0.000000,23.782900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<46.540500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.540500,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.540500,0.000000,24.028700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<46.540500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.540500,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.663300,0.000000,24.151500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<46.540500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.663300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.909100,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<46.663300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.909100,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.031900,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<46.909100,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.031900,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.031900,0.000000,23.905800>}
box{<0,0,-0.038100><0.122900,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.031900,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.031900,0.000000,23.905800>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<46.540500,0.000000,23.905800>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,0.000000,0> translate<46.540500,0.000000,23.905800> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.288900,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.288900,0.000000,24.151500>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,90.000000,0> translate<47.288900,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.288900,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.657500,0.000000,24.151500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<47.288900,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.657500,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.780300,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<47.657500,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.780300,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<47.780300,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<47.780300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.037300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.037300,0.000000,23.782900>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,90.000000,0> translate<48.037300,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.037300,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.160100,0.000000,23.782900>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.037300,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.160100,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.160100,0.000000,23.660100>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.160100,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.160100,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.037300,0.000000,23.660100>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<48.037300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.902900,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.534300,0.000000,24.151500>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<48.534300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.534300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.411500,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<48.411500,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.411500,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.411500,0.000000,23.782900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<48.411500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.411500,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.534300,0.000000,23.660100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<48.411500,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.534300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<48.902900,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,0.000000,0> translate<48.534300,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.282700,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.528500,0.000000,23.660100>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<49.282700,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.528500,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.651300,0.000000,23.782900>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<49.528500,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.651300,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.651300,0.000000,24.028700>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,90.000000,0> translate<49.651300,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.651300,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.528500,0.000000,24.151500>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<49.528500,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.528500,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.282700,0.000000,24.151500>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,0.000000,0> translate<49.282700,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.282700,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.159900,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,-44.997030,0> translate<49.159900,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.159900,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.159900,0.000000,23.782900>}
box{<0,0,-0.038100><0.245800,0.036000,0.038100> rotate<0,-90.000000,0> translate<49.159900,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.159900,0.000000,23.782900>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.282700,0.000000,23.660100>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<49.159900,0.000000,23.782900> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.908300,0.000000,23.660100>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.908300,0.000000,24.151500>}
box{<0,0,-0.038100><0.491400,0.036000,0.038100> rotate<0,90.000000,0> translate<49.908300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<49.908300,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.031100,0.000000,24.151500>}
box{<0,0,-0.038100><0.122800,0.036000,0.038100> rotate<0,0.000000,0> translate<49.908300,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.031100,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.154000,0.000000,24.028700>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,44.973712,0> translate<50.031100,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.154000,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.154000,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<50.154000,0.000000,23.660100> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.154000,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.276900,0.000000,24.151500>}
box{<0,0,-0.038100><0.173736,0.036000,0.038100> rotate<0,-44.973712,0> translate<50.154000,0.000000,24.028700> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.276900,0.000000,24.151500>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.399700,0.000000,24.028700>}
box{<0,0,-0.038100><0.173665,0.036000,0.038100> rotate<0,44.997030,0> translate<50.276900,0.000000,24.151500> }
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.399700,0.000000,24.028700>}
cylinder{<0,0,0><0,0.036000,0>0.038100 translate<50.399700,0.000000,23.660100>}
box{<0,0,-0.038100><0.368600,0.036000,0.038100> rotate<0,-90.000000,0> translate<50.399700,0.000000,23.660100> }
difference{
cylinder{<40.944800,0,21.615400><40.944800,0.036000,21.615400>0.566300 translate<0,0.000000,0>}
cylinder{<40.944800,-0.1,21.615400><40.944800,0.135000,21.615400>0.439300 translate<0,0.000000,0>}}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.957000,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,7.670800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<36.322000,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<35.687000,0.000000,7.670800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<35.687000,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,8.890000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.957000,0.000000,7.035800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,7.035800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<36.322000,0.000000,7.035800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,7.035800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<35.687000,0.000000,7.035800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<35.687000,0.000000,7.035800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,7.035800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,5.842000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,11.049000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,11.049000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,11.049000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,3.937000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.544000,0.000000,3.937000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,3.683000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,3.683000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,3.683000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,3.937000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,10.795000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.100000,0.000000,10.795000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<37.846000,0.000000,3.937000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<34.798000,0.000000,3.937000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<34.798000,0.000000,10.795000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<37.846000,0.000000,10.795000>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.957000,0.000000,17.068800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,17.068800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<36.322000,0.000000,17.068800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,17.068800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<35.687000,0.000000,17.068800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<35.687000,0.000000,17.068800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,17.068800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,18.288000>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.957000,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,16.433800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<36.322000,0.000000,16.433800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<36.322000,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<35.687000,0.000000,16.433800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<35.687000,0.000000,16.433800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,15.240000>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,20.447000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.544000,0.000000,13.335000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.544000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.798000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,13.081000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.798000,0.000000,13.081000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,20.193000>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.100000,0.000000,20.193000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<37.846000,0.000000,13.335000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<34.798000,0.000000,13.335000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<34.798000,0.000000,20.193000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<37.846000,0.000000,20.193000>}
//H1 silk screen
object{ARC(1.778000,2.286000,180.000000,270.000000,0.036000) translate<9.398000,0.000000,2.032000>}
object{ARC(1.778000,2.286000,0.000000,90.000000,0.036000) translate<9.398000,0.000000,2.032000>}
difference{
cylinder{<9.398000,0,2.032000><9.398000,0.036000,2.032000>0.863600 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,2.032000><9.398000,0.135000,2.032000>0.406400 translate<0,0.000000,0>}}
difference{
cylinder{<9.398000,0,2.032000><9.398000,0.036000,2.032000>2.997200 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,2.032000><9.398000,0.135000,2.032000>2.844800 translate<0,0.000000,0>}}
difference{
cylinder{<9.398000,0,2.032000><9.398000,0.036000,2.032000>1.601600 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,2.032000><9.398000,0.135000,2.032000>1.398400 translate<0,0.000000,0>}}
//H2 silk screen
object{ARC(1.778000,2.286000,180.000000,270.000000,0.036000) translate<9.398000,0.000000,23.114000>}
object{ARC(1.778000,2.286000,0.000000,90.000000,0.036000) translate<9.398000,0.000000,23.114000>}
difference{
cylinder{<9.398000,0,23.114000><9.398000,0.036000,23.114000>0.863600 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,23.114000><9.398000,0.135000,23.114000>0.406400 translate<0,0.000000,0>}}
difference{
cylinder{<9.398000,0,23.114000><9.398000,0.036000,23.114000>2.997200 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,23.114000><9.398000,0.135000,23.114000>2.844800 translate<0,0.000000,0>}}
difference{
cylinder{<9.398000,0,23.114000><9.398000,0.036000,23.114000>1.601600 translate<0,0.000000,0>}
cylinder{<9.398000,-0.1,23.114000><9.398000,0.135000,23.114000>1.398400 translate<0,0.000000,0>}}
//H3 silk screen
object{ARC(1.778000,2.286000,180.000000,270.000000,0.036000) translate<56.134000,0.000000,2.032000>}
object{ARC(1.778000,2.286000,0.000000,90.000000,0.036000) translate<56.134000,0.000000,2.032000>}
difference{
cylinder{<56.134000,0,2.032000><56.134000,0.036000,2.032000>0.863600 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,2.032000><56.134000,0.135000,2.032000>0.406400 translate<0,0.000000,0>}}
difference{
cylinder{<56.134000,0,2.032000><56.134000,0.036000,2.032000>2.997200 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,2.032000><56.134000,0.135000,2.032000>2.844800 translate<0,0.000000,0>}}
difference{
cylinder{<56.134000,0,2.032000><56.134000,0.036000,2.032000>1.601600 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,2.032000><56.134000,0.135000,2.032000>1.398400 translate<0,0.000000,0>}}
//H4 silk screen
object{ARC(1.778000,2.286000,180.000000,270.000000,0.036000) translate<56.134000,0.000000,23.114000>}
object{ARC(1.778000,2.286000,0.000000,90.000000,0.036000) translate<56.134000,0.000000,23.114000>}
difference{
cylinder{<56.134000,0,23.114000><56.134000,0.036000,23.114000>0.863600 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,23.114000><56.134000,0.135000,23.114000>0.406400 translate<0,0.000000,0>}}
difference{
cylinder{<56.134000,0,23.114000><56.134000,0.036000,23.114000>2.997200 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,23.114000><56.134000,0.135000,23.114000>2.844800 translate<0,0.000000,0>}}
difference{
cylinder{<56.134000,0,23.114000><56.134000,0.036000,23.114000>1.601600 translate<0,0.000000,0>}
cylinder{<56.134000,-0.1,23.114000><56.134000,0.135000,23.114000>1.398400 translate<0,0.000000,0>}}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,21.082000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.863000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,3.302000>}
box{<0,0,-0.076200><17.780000,0.036000,0.076200> rotate<0,-90.000000,0> translate<41.021000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,3.302000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,3.302000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.021000,0.000000,3.302000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.863000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.958000,0.000000,21.082000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<44.958000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.021000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,21.082000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<41.021000,0.000000,21.082000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<43.942000,0.000000,21.082000>}
//OK1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,12.700000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.321000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,2.540000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.479000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,2.540000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,2.540000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,12.700000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.416000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,12.700000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,12.700000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<25.400000,0.000000,12.700000>}
//OK2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,22.860000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<28.321000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,12.700000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.479000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,12.700000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.321000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,22.860000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<26.416000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,22.860000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,22.860000> }
object{ARC(1.016000,0.152400,180.000000,360.000000,0.036000) translate<25.400000,0.000000,22.860000>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,9.779000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,10.414000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,11.430000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,11.430000> }
difference{
cylinder{<17.780000,0,8.890000><17.780000,0.036000,8.890000>1.346200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,8.890000><17.780000,0.135000,8.890000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<17.780000,0,8.890000><17.780000,0.036000,8.890000>1.092200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,8.890000><17.780000,0.135000,8.890000>0.939800 translate<0,0.000000,0>}}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,5.461000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,5.461000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,5.334000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,4.826000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,3.810000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,3.810000> }
difference{
cylinder{<17.780000,0,6.350000><17.780000,0.036000,6.350000>1.346200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,6.350000><17.780000,0.135000,6.350000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<17.780000,0,6.350000><17.780000,0.036000,6.350000>1.092200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,6.350000><17.780000,0.135000,6.350000>0.939800 translate<0,0.000000,0>}}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,9.779000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,9.779000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,10.414000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,11.430000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,11.430000> }
difference{
cylinder{<32.766000,0,8.890000><32.766000,0.036000,8.890000>1.346200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,8.890000><32.766000,0.135000,8.890000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<32.766000,0,8.890000><32.766000,0.036000,8.890000>1.092200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,8.890000><32.766000,0.135000,8.890000>0.939800 translate<0,0.000000,0>}}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,5.207000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,4.572000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,4.572000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,3.556000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,3.556000> }
difference{
cylinder{<32.766000,0,6.096000><32.766000,0.036000,6.096000>1.346200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,6.096000><32.766000,0.135000,6.096000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<32.766000,0,6.096000><32.766000,0.036000,6.096000>1.092200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,6.096000><32.766000,0.135000,6.096000>0.939800 translate<0,0.000000,0>}}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,19.939000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,20.574000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,21.590000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<17.780000,0.000000,21.590000> }
difference{
cylinder{<17.780000,0,19.050000><17.780000,0.036000,19.050000>1.346200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,19.050000><17.780000,0.135000,19.050000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<17.780000,0,19.050000><17.780000,0.036000,19.050000>1.092200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,19.050000><17.780000,0.135000,19.050000>0.939800 translate<0,0.000000,0>}}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,15.621000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,15.621000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,14.986000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.780000,0.000000,13.970000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<17.780000,0.000000,13.970000> }
difference{
cylinder{<17.780000,0,16.510000><17.780000,0.036000,16.510000>1.346200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,16.510000><17.780000,0.135000,16.510000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<17.780000,0,16.510000><17.780000,0.036000,16.510000>1.092200 translate<0,0.000000,0>}
cylinder{<17.780000,-0.1,16.510000><17.780000,0.135000,16.510000>0.939800 translate<0,0.000000,0>}}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,19.939000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,19.939000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,20.574000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,21.590000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,90.000000,0> translate<32.766000,0.000000,21.590000> }
difference{
cylinder{<32.766000,0,19.050000><32.766000,0.036000,19.050000>1.346200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,19.050000><32.766000,0.135000,19.050000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<32.766000,0,19.050000><32.766000,0.036000,19.050000>1.092200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,19.050000><32.766000,0.135000,19.050000>0.939800 translate<0,0.000000,0>}}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,15.621000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,15.621000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,14.986000>}
box{<0,0,-0.304800><0.508000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<32.766000,0.000000,13.970000>}
box{<0,0,-0.304800><0.889000,0.036000,0.304800> rotate<0,-90.000000,0> translate<32.766000,0.000000,13.970000> }
difference{
cylinder{<32.766000,0,16.510000><32.766000,0.036000,16.510000>1.346200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,16.510000><32.766000,0.135000,16.510000>1.193800 translate<0,0.000000,0>}}
difference{
cylinder{<32.766000,0,16.510000><32.766000,0.036000,16.510000>1.092200 translate<0,0.000000,0>}
cylinder{<32.766000,-0.1,16.510000><32.766000,0.135000,16.510000>0.939800 translate<0,0.000000,0>}}
//SV1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,6.096000>}
box{<0,0,-0.076200><12.700000,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.785000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,6.096000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.435000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.785000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,18.796000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.435000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,18.796000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,4.826000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,20.066000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,10.414000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.435000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,14.478000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.197000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.197000,0.000000,14.478000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.435000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,18.796000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.435000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.181000,0.000000,14.478000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.181000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,4.826000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,7.366000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,7.366000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.055000,0.000000,13.081000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,-90.000000,0> translate<59.055000,0.000000,13.081000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,10.414000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,14.478000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,10.414000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,90.000000,0> translate<51.435000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.435000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.181000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<51.181000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.181000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,10.414000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,5.842000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<51.181000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.039000,0.000000,5.842000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<51.181000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.039000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.039000,0.000000,19.050000>}
box{<0,0,-0.025400><13.208000,0.036000,0.025400> rotate<0,90.000000,0> translate<58.039000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<58.039000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,19.050000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<51.181000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<51.181000,0.000000,14.478000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,-90.000000,0> translate<51.181000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<51.181000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,14.478000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,14.986000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,14.986000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,16.256000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.292000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.292000,0.000000,16.256000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<50.165000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<50.165000,0.000000,20.066000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,90.000000,0> translate<50.165000,0.000000,20.066000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<55.880000,0.000000,12.446000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<55.880000,0.000000,14.986000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<55.880000,0.000000,9.906000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<53.340000,0.000000,12.446000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<53.340000,0.000000,14.986000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<53.340000,0.000000,9.906000>}
//SV2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,18.796000>}
box{<0,0,-0.076200><12.700000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.747000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,18.796000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.747000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.747000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,6.096000>}
box{<0,0,-0.076200><6.350000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.747000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,6.096000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.477000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,20.066000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.477000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,4.826000>}
box{<0,0,-0.076200><8.890000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.477000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,14.478000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,10.414000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.335000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,10.414000>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.335000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,6.096000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.097000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,10.414000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.097000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,20.066000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.477000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,13.081000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,17.526000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.477000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,7.366000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,0.000000,11.811000>}
box{<0,0,-0.076200><4.445000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.477000,0.000000,11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,14.478000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.367000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,10.414000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.367000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,18.796000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,14.478000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.097000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,14.478000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.097000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,14.478000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.351000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,19.050000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,90.000000,0> translate<14.351000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,19.050000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<7.493000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,5.842000>}
box{<0,0,-0.025400><13.208000,0.036000,0.025400> rotate<0,-90.000000,0> translate<7.493000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.493000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,5.842000>}
box{<0,0,-0.025400><6.858000,0.036000,0.025400> rotate<0,0.000000,0> translate<7.493000,0.000000,5.842000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,5.842000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<14.351000,0.000000,10.414000>}
box{<0,0,-0.025400><4.572000,0.036000,0.025400> rotate<0,90.000000,0> translate<14.351000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.351000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,10.414000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.351000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,9.906000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.367000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,9.906000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,9.906000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,9.906000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,8.636000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,8.636000>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,8.636000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,8.636000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,4.826000>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.367000,0.000000,4.826000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<9.652000,0.000000,12.446000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<9.652000,0.000000,9.906000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<9.652000,0.000000,14.986000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<12.192000,0.000000,12.446000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<12.192000,0.000000,9.906000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<12.192000,0.000000,14.986000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  OPTO_ISOLATOR(-32.753300,0,-12.573000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//H1	MOUNT-HOLE2.8	2,8
//H2	MOUNT-HOLE2.8	2,8
//H3	MOUNT-HOLE2.8	2,8
//H4	MOUNT-HOLE2.8	2,8
