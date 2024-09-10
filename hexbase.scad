
frameX = 688;
frameY = 488;

hexHeight = 150;
hexDiameter = hexHeight / 0.866;
hexangle = 1.1547 * hexHeight / 2;

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
plugHoleDiameter = plugHoleMultiplier * plugDiameter;
plugLengthMultipler = 1.5;
plugLength = wallWidth * plugLengthMultipler;

baseHeight = 2;
baseWireHoleDiameter = 6;
baseStandDiameter = 5;
baseWireGap = 4;
baseStandInsetDepth = 0.5;

lightCount = 62;

cutX = 0;
cutY = 0;

// cutX = (frameX-2*hexHeight-2*hexangle)/2;
// cutY = (frameY-1.5*hexHeight)/2;
// cutY = (frameY - 2.5 * hexHeight) / 2;

cutFlipX = false;
cutFlipY = false;

echo("cutX", cutX);
echo("cutY", cutY);

epsilon = 0.01;

//hexbase();
//hexstand();
 hexEdge();

module hexEdge()
{
	x = (cutX > 0) ? cutX : hexDiameter;
	y = (cutY > 0) ? cutY : hexHeight + plugLength * 2;
	z = standHeight + tileHeight + height;

	curShiftX = cutFlipX ? hexDiameter - x : 0;
	curShiftY = cutFlipY ? (hexHeight + plugLength * 2) - y : 0;

	echo(curShiftX, curShiftY);
	echo("bounds", x, y, z)

	    echo(tileHeight);

	intersection()
	{
		hexstand(hexTileHeight = tileHeight);
		translate([ -hexDiameter / 2 + curShiftX, -hexHeight / 2 - plugLength + curShiftY, -(tileHeight + epsilon) ])
		cube([ x, y, z ]);
	}
}

module hexbase()
{
	difference()
	{
		union()
		{
			hex(diameter = hexDiameter, width = hexDiameter, height = baseHeight);

		//	cylinder(h = plugLength, d = standDiameter, $fn = 50);

			for (angle = [0:60:300])
			{
				rotate(angle)
				{

					translate([ hexDiameter / 2 * 0.5, 0, 0 ])
					cylinder(h = baseWireGap + baseHeight, d = standDiameter, $fn = 50);
					translate([ hexDiameter / 2 -baseStandDiameter* 2 / 3 , 0, 0 ])
					cylinder(h = baseWireGap+ baseHeight, d = baseStandDiameter, $fn = 50);
				}
			}
		}

            lightXCount = 3;
			lightYCount = (lightXCount %2 ? lightXCount:lightXCount+1)/2;
			deltaX = (hexDiameter) / lightXCount;
			deltaY = deltaX/1.73;
			rowOffset = deltaX/1.73;
        
    
            rings = 4;

            
	translate([ 0 , 0, -epsilon ])
		{

    
            cylinder(h = plugLength, d = baseWireHoleDiameter, $fn = 50);
            ringOffset = (hexHeight/2-baseWireHoleDiameter)/rings;
            echo (ringOffset);

            for (ring = [1:rings]) {
                circumeference = 2*ringOffset*ring*3.142;
                ringLightCount = floor(circumeference/ringOffset*1.1);
                arcLength = 360/ringLightCount;
                echo(arcLength,ringLightCount,ringOffset,circumeference);
        
            for (angle = [0:arcLength:360-arcLength]) {
                    rotate(angle)
                    translate([ringOffset*ring,0,0])
                        cylinder(h = plugLength, d = baseWireHoleDiameter, $fn = 50);

            
            }
}
/*
}

			for (row = [0:lightYCount])
			{
				for (column = [0:lightXCount-1])
				{
					translate([column * deltaX + row * rowOffset, row * deltaY, 0 ])
                        cylinder(h = plugLength, d = baseWireHoleDiameter, $fn = 50);
					translate([ column * deltaX + row * rowOffset, -row * deltaY, 0 ])
                        cylinder(h = plugLength, d = baseWireHoleDiameter, $fn = 50);
				}
			}

                  */  }
                  
                  
        for (angle = [0:60:300])
			{
				rotate(angle)
				{

					translate([ hexDiameter/2 -standDiameter* 2 / 3, 0, -epsilon ])
					cylinder(h = baseStandInsetDepth, d = standDiameter, $fn = 50);
                    		translate([ hexDiameter/2, 0, -epsilon ])
					cylinder(h = 0.5, d = standDiameter*1.3, $fn = 50);
				}
			}
		


	}
}

module hexstand(hexTileHeight = 0)
{

	diameter = hexDiameter;
	width = shelfWidth;
	height = 2;
	wallWidth = wallWidth;
	wallHeight = wallHeight;

	hex(diameter, height, width);

	echo(hexTileHeight);

	difference()
	{
		union()
		{
			hex(diameter, wallHeight, wallWidth);
			if (hexTileHeight > 0)
			{
				translate([ 0, 0, -hexTileHeight ])
				cylinder($fn = 6, d = diameter, h = hexTileHeight);
			}
			for (angle = [0:60:300])
			{
				rotate(angle)
				translate([ hexHeight / 10, hexHeight / 2, wallHeight / 2 ])
				rotate([ -90, 0, 0 ])
				cylinder(h = plugLength, d = plugDiameter, $fn = 50);
			}
		}
		for (angle = [0:60:300])
		{
			rotate(angle)
			translate([ -hexHeight / 10, hexHeight / 2 - 2, wallHeight / 2 ])
			rotate([ -90, 0, 0 ])
			cylinder(h = wallWidth * 2, d = plugHoleDiameter, $fn = 50);
		}
	}

	for (angle = [0:60:300])
	{
		echo(angle);
		rotate(angle)
		translate([ hexDiameter / 2 - standDiameter * 2 / 3, 0, 0 ])
		cylinder($fn = 50, h = standHeight, d = standDiameter, center = false);
	}
}

module hex(diameter, height, width)
{
	echo("hex", diameter, height, width);

	difference()
	{
		cylinder($fn = 6, d = diameter, h = height, center = false);
		translate([ 0, 0, -epsilon ])
		cylinder($fn = 6, d = diameter - 2 * width, h = height + 2 * epsilon, center = false);
	}
}
