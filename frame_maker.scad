$fn=60;
    

num_x = 4;
num_y = 4;

wall_thickness = 3;
fin_height = 12;
fin_thickness = 4;
rail_thickness = 2;
fin_tol = 0.5;
piece_x = 50;
piece_y = 49.21;

base_x = num_x*piece_x+fin_height+fin_tol+wall_thickness*2;
base_y = num_y*piece_y+fin_height+fin_tol+wall_thickness*2;

// common fin geometry; 1,5,6,2 + piece_x*num_x
CubePoints = [
  [  0+8,     0,  1 ],  //0
  [ piece_x*num_x+4,  0,  1 ],  //1
  [ piece_x*num_x+4+8,   12,  0 ],  //2
  [  0,      12,  0 ],  //3
  [  0+8,     0,  3 ],  //4
  [ piece_x*num_x+4,  0,  3 ],  //5
  [ piece_x*num_x+4+8,   12,  4 ],  //6
  [  0,      12,  4 ]   //7
]; 

CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]   // left
]; 
 
module rails() {
    cube(size = [fin_height+fin_tol+wall_thickness,base_y,rail_thickness], center = false);
    cube(size = [base_x,fin_height+fin_tol+wall_thickness,rail_thickness], center = false);
}

module railwalls() {
    cube(size = [wall_thickness,base_y,fin_thickness], center = false);
    cube(size = [base_x,wall_thickness,fin_thickness], center = false);
}

module finwalls() {
    translate([base_y,0,-(rail_thickness+fin_thickness)]) { 
        cube(size = [wall_thickness,base_y,2*rail_thickness+fin_thickness], center = false);
    }
    translate([0,base_x-2*wall_thickness,-(rail_thickness+fin_thickness)]) {
        cube(size = [base_x,wall_thickness,2*rail_thickness+fin_thickness], center = false);
    }
}

module fins() {  
    // fin x
    translate([wall_thickness,base_y-wall_thickness-fin_height+fin_tol,-rail_thickness])    {   
        polyhedron( CubePoints, CubeFaces );
    }
    
    // fin y
    translate([base_x-wall_thickness-fin_height+fin_tol,num_x*piece_x+8+4+wall_thickness,-rail_thickness]) {   
        rotate(a=270, v=[y]){
            polyhedron( CubePoints, CubeFaces );
        }
    }
}

module frame () {
    // railsides
    translate([0,0,-rail_thickness]) {
        rails();  //top
    } 
    translate([0,0,-(rail_thickness+fin_thickness)]) {
        railwalls();  //wall
    } 
    translate([0,0,-(rail_thickness*2+fin_thickness)]) {
        rails();  //bottom
    } 
   
    // finsides
    translate([0,0,-rail_thickness]) {
        finwalls();
    } 
    
    // fins
    translate([0,0,-(rail_thickness*2)]) {
        fins();
    } 
}

module cutpiece4frameupperright() {
    translate([-1,-1,-9]) {
        cube([base_x/2+1, base_y+2, 10]);
        cube([base_x+2, base_y/2+1, 10]);
    }
}
module cutpiece4framelowerright() {
    translate([-1,base_y/2,-9]) {
        cube([base_x+2, base_y/2+1, 10]);
    }
    translate([-1,-1,-9]) {
        cube([base_x/2+1, base_y+2, 10]);
    }
}
module cutpiece4frameupperleft() {
    translate([-1,-1,-9]) {
        cube([base_x+2, base_y/2+1, 10]);
    }
    translate([base_x/2,-1,-9]) {
        cube([base_x/2+1, base_y+2, 10]);
    }
}
module cutpiece4framelowerleft() {
    translate([-1,base_y/2,-9]) {
        cube([base_x+2, base_y/2+1, 10]);
    }
    translate([base_x/2,-1,-9]) {
        cube([base_x/2+1, base_y+2, 10]);
    }
}

//// upperright
//difference() {
//    frame();
//    cutpiece4frameupperright();
//}
//
//// upperleft
//difference() {
//    frame();
//    cutpiece4frameupperleft();
//}
//// lowerright
//difference() {
//    frame();
//    cutpiece4framelowerright();
//}
//// lowerleft
//difference() {
//    frame();
//    cutpiece4framelowerleft();
//}

bottomplatesize = [base_x, base_y, rail_thickness/2];
bottomplatesize_rot = [base_y, base_x, rail_thickness/2];
// bottom plate1
module bottom1() { 
    translate([0,0,-(rail_thickness*2+fin_thickness+rail_thickness/2)]) {   
        cube(size = bottomplatesize, center = false);
    }
}

// bottom plate2
module bottom2 () {
    translate([0,0,-(rail_thickness*2+fin_thickness+rail_thickness)]) {   
        cube(size = bottomplatesize_rot, center = false);
    }
}

use </home/walzer/Pictures/BaWue-puzzle/OpenSCAD_Dovetail-master/dovetail.scad>;
Teeth_count = 10; 
Teeth_height = 12; 
Teeth_clearance = 3;
teeth = [Teeth_count, Teeth_height, Teeth_clearance / 10];

module dovetail_bottom1() {
    intersection() {
        bottom1();
        cutter([base_x/2, base_y/2, -(rail_thickness*2+fin_thickness+rail_thickness/4)], bottomplatesize, teeth, true, Debug_flag);
    }

    intersection() {
        bottom1();
        cutter([base_x/2, base_y/2, -(rail_thickness*2+fin_thickness+rail_thickness/4)], bottomplatesize, teeth, false, Debug_flag);
    }
}

//bottom1();
//translate([base_x,0,0]) rotate([0,0,90]) bottom2();

module dovetail_bottom2() {
    translate([base_x,0,0]) rotate([0,0,90]){
        intersection() {
            bottom2();
            cutter([base_y/2, base_x/2, -(rail_thickness*2+fin_thickness+rail_thickness*3/4)], bottomplatesize_rot, teeth, true, Debug_flag);
        }

        intersection() {
            bottom2();
            cutter([base_y/2, base_x/2, -(rail_thickness*2+fin_thickness+rail_thickness*3/4)], bottomplatesize_rot, teeth, false, Debug_flag);
        }
    }
}


module cutpiece4bottom1upperright() {
    translate([-1,-1,-10]) {
        cube([base_x/2+1+8, base_y+2+8, 11]);
        cube([base_x+2, base_y/2+1, 11]);
    }
}
module cutpiece4bottom1lowerright() {
    translate([-1,base_y/2,-10]) {
        cube([base_x+2, base_y/2+1, 11]);
    }
    translate([-1,-1,-10]) {
        cube([base_x/2+1+8, base_y+2+8, 11]);
    }
}
module cutpiece4bottom1upperleft() {
    translate([-1,-1,-10]) {
        cube([base_x+2, base_y/2+1, 11]);
    }
    translate([base_x/2+8,-1,-10]) {
        cube([base_x/2+1+8, base_y+2+8, 11]);
    }
}
module cutpiece4bottom1lowerleft() {
    translate([-1,base_y/2,-10]) {
        cube([base_x+2, base_y/2+1, 11]);
    }
    translate([base_x/2+8,-1,-10]) {
        cube([base_x/2+1+8, base_y+2+8, 11]);
    }
}

// upperright
difference() {
    dovetail_bottom1();
    cutpiece4bottom1upperright();
}

//// upperleft
//difference() {
//    dovetail_bottom1();
//    cutpiece4bottom1upperleft();
//}

//// lowerright
//difference() {
//    dovetail_bottom1();
//    cutpiece4bottom1lowerright();
//}

//// lowerleft
//difference() {
//    dovetail_bottom1();
//    cutpiece4bottom1lowerleft();
//}

module cutpiece4bottom2upperright() {
    translate([-1,-1-8,-11]) {
        cube([base_x/2+1, base_y+2+8, 12]);
        cube([base_x+2+8, base_y/2+1+8, 12]);
    }
}
module cutpiece4bottom2lowerright() {
    translate([-1,base_y/2,-11]) {
        cube([base_x+2+8, base_y/2+1+8, 12]);
    }
    translate([-1,-1,-11]) {
        cube([base_x/2+1, base_y+2, 12]);
    }
}
module cutpiece4bottom2upperleft() {
    translate([-1,-1-8,-11]) {
        cube([base_x+2+8, base_y/2+1+8, 12]);
    }
    translate([base_x/2,-1,-11]) {
        cube([base_x/2+1, base_y+2, 12]);
    }
}
module cutpiece4bottom2lowerleft() {
    translate([-1,base_y/2,-11]) {
        cube([base_x+2+8, base_y/2+1+8, 12]);
    }
    translate([base_x/2,-1,-11]) {
        cube([base_x/2+1, base_y+2, 12]);
    }
}

// upperright
difference() {
    dovetail_bottom2();
    cutpiece4bottom2upperright();
    // - male
}

//// upperleft
//difference() {
//    dovetail_bottom2();
//    cutpiece4bottom2upperleft();
//}

//// lowerright
//difference() {
//    dovetail_bottom2();
//    cutpiece4bottom2lowerright();
//}

//// lowerleft
//difference() {
//    dovetail_bottom2();
//    cutpiece4bottom2lowerleft();
//}