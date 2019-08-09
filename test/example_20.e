note
	description: "[
		Illustrates backdrop plotting of world, US maps.
	    Contributed by Wesley Ebisuzaki.
		Require build plplot with shapelib	
	]"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example_20", "src=http://plplot.sourceforge.net/examples.php?demo=19&lbind=C", "protocol=uri"

class
	EXAMPLE_20

inherit

	PLPLOT_API

create
	make

feature {NONE} --Initialization

	make
			-- Shows two views of the world map.
		local
			minx, maxx, miny, maxy: REAL_64
			x,y: ARRAY [REAL_64]
			nbeachareas: INTEGER
			beachareas: ARRAY [INTEGER]
			nwoodlandareas: INTEGER
			woodlandareas: ARRAY [INTEGER]
			nshingleareas: INTEGER
			shingleareas: ARRAY [INTEGER]
			ncragareas: INTEGER
			cragareas: ARRAY [INTEGER]
			majorroads: ARRAY [INTEGER]
			l_labeler: PLLABEL_FUNC_CALLBACK_DISPATCHER
			l_map: PLMAPFORM_CALLBACK_DISPATCHER
			l_transform: PLTRANSFORM_CALLBACK_DISPATCHER

		do

		  	  -- variables for the shapelib example
			nbeachareas	:= 2
			beachareas	:= {ARRAY [INTEGER]} << 23, 24 >>
    		nwoodlandareas := 94
    		create woodlandareas.make_filled (0, 1, 945)
    		nshingleareas	:= 22
    		shingleareas:= {ARRAY [INTEGER]} << 0, 1, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 217, 2424, 2425, 2426, 2427, 2428, 2491, 2577 >>
    		ncragareas	:= 2024;
    		create cragareas.make_filled (0, 1, 2024)
    		majorroads := {ARRAY [INTEGER]}<< 33, 48, 71, 83, 89, 90, 101, 102, 111 >>

 				-- Longitude (x) and latitude (y)

		    miny := -70
		    maxy := 80

		    	-- Cartesian plots
				-- Most of world

			initialize

		    minx := -170
		    maxx := minx + 36;

		    		-- Setup a custom latitude and longitude-based scaling function.
		    create l_labeler.make (agent geolocation_labeler)
		    plslabelfunc( l_labeler.c_dispatcher, default_pointer )

		    plcol0( 1 )
		    plenv( minx, maxx, miny, maxy, 1, 70 )
		    plmap( default_pointer, "usaglobe", minx, maxx, miny, maxy )

		     	-- The Americas

		    minx := 190
		    maxx := 340

		    plcol0( 1 )
		    plenv( minx, maxx, miny, maxy, 1, 70 )
		    plmap( default_pointer, "usaglobe", minx, maxx, miny, maxy )

		    	-- Clear the labeling function.
		    plslabelfunc( default_pointer, default_pointer )

				-- Polar, Northern hemisphere

		    minx := 0;
		    maxx := 360;

		    plenv( -75., 75., -75., 75., 1, -1 )
		   	create l_map.make (agent mapform19)
		    plmap( l_map.c_dispatcher, "globe", minx, maxx, miny, maxy )

		    pllsty( 2 )
		    plmeridians( l_map.c_dispatcher, 10.0, 10.0, 0.0, 360.0, -10.0, 80.0 )

				--// Polar, Northern hemisphere, this time with a PLplot-wide transform

		    minx := 0
		    maxx := 360

			create l_transform.make (agent map_transform)
		    plstransform( l_transform.c_dispatcher, default_pointer )

		    pllsty( 1 )
		    plenv( -75., 75., -75., 75., 1, -1 )
		    -- No need to set the map transform here as the global transform will be used.
		    plmap( default_pointer, "globe", minx, maxx, miny, maxy )

		    pllsty( 2 )
		    plmeridians( default_pointer, 10.0, 10.0, 0.0, 360.0, -10.0, 80.0 )

				--    // Show Baltimore, MD on the map
		    plcol0( 2 )
		    plssym( 0.0, 2.0 )
		    x := <<-76.6125>>
		    y := <<39.2902778>>
		    plpoin(x, y, 18 )
		    plssym( 0.0, 1.0 )
		    plptex( -76.6125, 43.0, 0.0, 0.0, 0.0, "Baltimore, MD" )

				-- For C, this is how the global transform is cleared
    		plstransform( default_pointer, default_pointer );

    		-- An example using shapefiles. The shapefiles used are from Ordnance Survey, UK.
			-- These were chosen because they provide shapefiles for small grid boxes which
			-- are easilly manageable for this demo.

		    pllsty( 1 )


		    minx := 240570;
		    maxx := 621109;
		    miny := 87822;
		    maxy := 722770;
		    plscol0( 0, 255, 255, 255 );
		    plscol0( 1, 0, 0, 0 );
		    plscol0( 2, 150, 150, 150 );
		    plscol0( 3, 0, 50, 200 );
		    plscol0( 4, 50, 50, 50 );
		    plscol0( 5, 150, 0, 0 );
		    plscol0( 6, 100, 100, 255 );


		    minx := 265000;
		    maxx := 270000;
		    miny := 145000;
		    maxy := 150000;
		    plscol0( 0, 255, 255, 255 );  --white
		    plscol0( 1, 0, 0, 0 );        --black
		    plscol0( 2, 255, 200, 0 );    --yelow for sand
		    plscol0( 3, 60, 230, 60 );    -- green for woodland
		    plscol0( 4, 210, 120, 60 );   --brown for contours
		    plscol0( 5, 150, 0, 0 );      --red for major roads
		    plscol0( 6, 180, 180, 255 );  --pale blue for water
		    plscol0( 7, 100, 100, 100 );  --pale grey for shingle or boulders
		    plscol0( 8, 100, 100, 100 );  --dark grey for custom polygons - generally crags


		    plcol0( 1 );
		    plenv( minx, maxx, miny, maxy, 1, -1 );
		    pllab( "", "", "Martinhoe CP, Exmoor National Park, UK (shapelib only)" );


		    	--Beach
		    plcol0( 2 );
		    plmapfill( default_pointer, "ss/ss64ne_Landform_Area", minx, maxx, miny, maxy, beachareas, nbeachareas );

		    	-- woodland
		    plcol0( 3 );
		    across 0 |..| nwoodlandareas as i loop
		    	woodlandareas[i.item + 1] := i.item + 218;
		    end
		    plmapfill( default_pointer, "ss/ss64ne_Landform_Area", minx, maxx, miny, maxy, woodlandareas, nwoodlandareas );

		    	--shingle or boulders
		    plcol0( 7 );
		    plmapfill( default_pointer, "ss/ss64ne_Landform_Area", minx, maxx, miny, maxy, shingleareas, nshingleareas );

		    	-- crags
		    plcol0( 8 );
		    across 1 |..| (ncragareas - 1) as i loop
		    	cragareas[i.item + 1] := i.item + 325;
		    end


		    plmapfill( default_pointer, "ss/ss64ne_Landform_Area", minx, maxx, miny, maxy, cragareas, ncragareas );

		    	-- draw contours, we need to separate contours from high/low coastline
		    	-- draw_contours(pls, "ss/SS64_line", 433, 20, 4, 3, minx, maxx, miny, maxy );
		    plcol0( 4 )
		    plmapline( default_pointer, "ss/ss64ne_Height_Contours", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]} <<>>, 0 );

		    -- draw the sea and surface water
		    plwidth( 0.0 )
		    plcol0( 6 )
		    plmapfill( default_pointer, "ss/ss64ne_Water_Area", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]}<<>>, 0 );
		    plwidth( 2.0 );
		    plmapline( default_pointer, "ss/ss64ne_Water_Line", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]} <<>>, 0 );

		     -- draw the roads, first with black and then thinner with colour to give an
		     -- an outlined appearance
		    plwidth( 5.0 );
		    plcol0( 1 );
		    plmapline( default_pointer, "ss/ss64ne_Road_Centreline", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]} <<>>, 0 );
		    plwidth( 3.0 );
		    plcol0( 0 );
		    plmapline( default_pointer, "ss/ss64ne_Road_Centreline", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]} <<>>, 0 );
		    plcol0( 5 );
		    plmapline( default_pointer, "ss/ss64ne_Road_Centreline", minx, maxx, miny, maxy, majorroads, 9 );

		     -- draw buildings
		    plwidth( 1.0 );
		    plcol0( 1 );
		    plmapfill( default_pointer, "ss/ss64ne_Building_Area", minx, maxx, miny, maxy, {ARRAY [INTEGER_32]}<<>>, 0 );

		     -- labels
		    plsfci( 0x80000100 );
		    plschr( 0, 0.8 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "MARTINHOE CP", minx, maxx, miny, maxy, 202 );
		    plschr( 0, 0.7 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Heale\nDown", minx, maxx, miny, maxy, 13 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "South\nDown", minx, maxx, miny, maxy, 34 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Martinhoe\nCommon", minx, maxx, miny, maxy, 42 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Woody Bay", minx, maxx, miny, maxy, 211 );
		    plschr( 0, 0.6 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Mill Wood", minx, maxx, miny, maxy, 16 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Heale Wood", minx, maxx, miny, maxy, 17 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 1.0, "Bodley", minx, maxx, miny, maxy, 31 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.0, "Martinhoe", minx, maxx, miny, maxy, 37 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Woolhanger\nCommon", minx, maxx, miny, maxy, 60 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "West Ilkerton\nCommon", minx, maxx, miny, maxy, 61 );
		    plmaptex( default_pointer, "ss/ss64ne_General_Text", 1.0, 0.0, 0.5, "Caffyns\nHeanton\nDown", minx, maxx, miny, maxy, 62 );



			finalize
  		end


feature -- Transform


	map_transform (x: REAL_64; y: REAL_64; xt: POINTER;  yt: POINTER; data: POINTER)
		local
			radius: REAL_64
			l_xt: REAL_64
			l_yt: REAL_64
		do
			radius := 90.0 - y
		    l_xt    := radius * {DOUBLE_MATH}.cosine( x * {DOUBLE_MATH}.pi / 180.0 )
		    l_yt    := radius * {DOUBLE_MATH}.sine( x * {DOUBLE_MATH}.pi / 180.0 )

			xt.memory_copy ($l_xt, {PLATFORM}.real_64_bytes)
			yt.memory_copy ($l_yt, {PLATFORM}.real_64_bytes)
		end


	mapform19 (n: INTEGER; x: POINTER; y: POINTER)
			-- Defines specific coordinate transformation for example 20.
			-- Not to be confused with mapform in src/plmap.c.
			--  x[], y[] are the coordinates to be plotted.
		local
			xp, yp: REAL_64
			my: MANAGED_POINTER
			mx: MANAGED_POINTER
		do
			create mx.share_from_pointer (x, n * {PLATFORM}.real_64_bytes)
			create my.share_from_pointer (y, n * {PLATFORM}.real_64_bytes)
			across 0 |..| (n-1) as i loop
				map_transform( mx.read_real_64 (i.item), my.read_real_64 (i.item), $xp, $yp, default_pointer )
				mx.put_real_64 (xp, i.item)
				my.put_real_64 (yp, i.item)
			end
			x.memory_copy (mx.item, n * {PLATFORM}.real_64_bytes)
			y.memory_copy (my.item, n * {PLATFORM}.real_64_bytes)
		end

	normalize_longitude (lon: REAL_64): REAL_64
			-- Normalize longitude values so that they always fall between -180.0 and 180.0
		local
			times: REAL_64
		do
		    if ( lon >= -180.0 and lon <= 180.0 ) then
		        Result := lon
		    else
		        times := ((lon.abs + 180.0 ) / 360.0 ).floor
		        if ( lon < 0.0 ) then
		            Result := ( lon + 360.0 * times )
		        else
		            Result := ( lon - 360.0 * times )
		        end
			end
		end


	geolocation_labeler ( axis: INTEGER; value: REAL_64; label: POINTER; length: INTEGER; data: POINTER)
			-- A custom axis labeling function for longitudes and latitudes.
		local
			direction_label: STRING
			label_val: REAL_64
			l_string: STRING
			c_string: C_STRING
		do
			if axis = {PLPLOT_CONSTANTS}.PL_Y_AXIS  then
				label_val := value
		        if ( label_val > 0.0 ) then
		            direction_label := " N"
		        elseif ( label_val < 0.0 ) then
		            direction_label := " S"
		        else
		            direction_label := "Eq"
		      	end
			elseif axis = {PLPLOT_CONSTANTS}.PL_X_AXIS then
		        label_val := normalize_longitude( value )
		        if ( label_val > 0.0 ) then
		            direction_label := " E"
		        elseif ( label_val < 0.0 ) then
		            direction_label := " W"
		        else
		            direction_label := ""
		        end
			end

		    if ( axis = {PLPLOT_CONSTANTS}.PL_Y_AXIS and value = 0.0 ) then
		        	-- A special case for the equator
		        create l_string.make (length)
					-- l_string.append (direction_label.substring (1, lenght)
		        	-- snprintf( label, (size_t) length, "%s", direction_label );
		    	l_string.append_string (direction_label)
		    else
		    	create l_string.make (length)
		    	l_string.append_double (label_val.abs)
		    	l_string.append_string (direction_label)
		   	end
		   	create c_string.make (l_string)
			label.memory_copy (c_string.item, {PLATFORM}.pointer_bytes)
		end

end
