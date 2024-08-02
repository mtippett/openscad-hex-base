
hexHeight = 150;
hexDiameter = hexHeight /0.866;
hexSide = 1.1547*hexHeight/2;

height = 2;
shelfWidth = 2;

wallHeight = 9;
wallWidth = 2;

tileHeight = 4;

standGap = 6;
standHeight = standGap + wallHeight;
standDiameter = 4;

plugDiameter = 2;
plugHoleMultiplier = 1.1;
plugHoleDiameter = plugHoleMultiplier*plugDiameter;
plugLengthMultipler = 1.5;
plugLength = wallWidth*plugLengthMultipler;

cutX = 0;
cutY = 0;

//cutX = (688-2*hexHeight-2*hexSide)/2;
cutY = (488-1.5*hexHeight)/2;
//cutY = (488-2.5*hexHeight)/2;

cutFlipX = false;
cutFlipY = false;

echo ("cutX",cutX);
echo ("cutY",cutX);

epsilon = 0.01;


hexbase();

module hexbase() 
{
        x = (cutX > 0) ? cutX:hexDiameter;
        y = (cutY > 0) ? cutY:hexHeight + plugLength*2;
        z = standHeight + tileHeight + height;
        
        curShiftX = cutFlipX ? hexDiameter-x:0;
        curShiftY = cutFlipY ? (hexHeight + plugLength*2)-y:0;
        
        echo(curShiftX,curShiftY);


  

    intersection() {
        hexstand(diameter=hexDiameter,width=shelfWidth,height=2,wallWidth=wallWidth,wallHeight=wallHeight);    
              translate([-hexDiameter/2+curShiftX,-hexHeight/2-plugLength+curShiftY,-(tileHeight+epsilon)])
                    cube([x,y,z]);
    
    }
 
}
    

module hexstand(diameter,height,width, wallWidth,wallHeight) {

    hex(diameter,height,width);
    hex(diameter,wallHeight,wallWidth);
    
 
        
    for(angle = [0:60:300]) {
        echo (angle);
        rotate(angle)
            translate([hexDiameter/2-standDiameter*2/3,0,0])
                cylinder($fn=50,h=standHeight,d=standDiameter,center=false);
    }
}

module hex(diameter,height,width) 
{
    echo ("hex",diameter,height,width);
    difference() {
        union() {
            if ( tileHeight > 0) {
                translate([0,0,-tileHeight])
                    cylinder($fn=6,d=diameter, h=tileHeight);
            }
          for (side = [0:60:300]) {
                rotate(side)
                translate([hexHeight/10,hexHeight/2,wallHeight/2])
                    rotate([-90,0,0])
                        cylinder(h=plugLength,d=plugDiameter,$fn=50);
            }
            difference() {
                cylinder($fn=6,d=diameter,h=height,center=false);
                translate([0,0,-epsilon])
                    cylinder($fn=6,d=diameter-2*width, h=height + 2*epsilon,center=false);
            }
           
        }
        for (side = [0:60:300]) {
            rotate(side)
                translate([-hexHeight/10,hexHeight/2-2,wallHeight/2])
                    rotate([-90,0,0])
                        cylinder(h=wallWidth*2,d=plugHoleDiameter,$fn=50);
        }
    }
    
    
}