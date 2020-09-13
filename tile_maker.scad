$fn=60;

translate([0,-147.5,0]) {
    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_1_1.STL", convexity=3, center=true);
}

//translate([0,-1*2*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_1_2.STL", convexity=3, center=true);
//}

//translate([0,-1*1*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_1_3_fix.stl", convexity=3, center=true);
//}

//translate([0,-1*0*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_1_4_fix.stl", convexity=3, center=true);
//}

//translate([-50*1,-1*3*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_2_1.STL", convexity=3, center=true);
//}

//translate([-50*1,-1*2*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_2_2.STL", convexity=3, center=true);
//}

//translate([-50*1,-1*1*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_2_3_fix.stl", convexity=3, center=true);
//}

//translate([-50*1,-1*0*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_2_4.STL", convexity=3, center=true);
//}

//translate([-50*2,-1*3*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_3_1.STL", convexity=3, center=true);
//}

//translate([-50*2,-1*2*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_3_2.STL", convexity=3, center=true);
//}

//translate([-50*2,-1*1*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_3_3.STL", convexity=3, center=true);
//}

//translate([-50*2,-1*0*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_3_4.STL", convexity=3, center=true);
//}

//translate([-50*3,-1*3*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_4_1.STL", convexity=3, center=true);
//}

//translate([-50*3,-1*2*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_4_2.STL", convexity=3, center=true);
//}

//translate([-50*3,-1*1*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_4_3.STL", convexity=3, center=true);
//}

// this one w/o fins and w/ custom bottom plate!
//translate([-50*3,-1*0*49.17,0]) {
//    import("./selected_geo_tiles/SRTMGL1_003_8.65_48.19_tile_4_4.STL", convexity=3, center=true);
//}



    translate([0,0.14,-2]) {
        // base plate
        cube(size = [50,49.21,2], center = false);
        
        //sandwiched plate
        translate([0,0,-4]) {   
            cube(size = [35,34.21,4], center = false);
            //50-35= 15 -> 11-13 width for fins 
        }
        
        // common fin geometry
        CubePoints = [
          [  0+8,     0,  1 ],  //0
          [ 34.21-8,  0,  1 ],  //1
          [ 34.21,   12,  0 ],  //2
          [  0,      12,  0 ],  //3
          [  0+8,     0,  3 ],  //4
          [ 34.21-8,  0,  3 ],  //5
          [ 34.21,   12,  4 ],  //6
          [  0,      12,  4 ]]; //7
      
        CubeFaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
      
        // fin x
        translate([0.4,-12,-4]) {   
            polyhedron( CubePoints, CubeFaces );
        }
        
        // fin y
        translate([-12,34.21,-4]) {   
            rotate(a=270, v=[y]){
                polyhedron( CubePoints, CubeFaces );
            }
        }
        
        // bottom plate
        translate([0,0,-6]) {   
            cube(size = [50,49.21,2], center = false);
        }
        
//        // bottom plate last piece
//        translate([0,0,-6]) {   
//            cube(size = [35,34.21,4], center = false);
//        }
 
    }
