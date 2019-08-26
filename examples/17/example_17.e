note
	description: " plshade demo, using color fill."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=Example 17", "src=http://plplot.sourceforge.net/examples.php?demo=16&lbind=C", "protocol=uri"
class
	EXAMPLE_17

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does several shade plots using different coordinate mappings.
		local
			x, y, argx, argy, distort, r, t: REAL_64
			px, py: ARRAY [REAL_64]
			zmin, zmax: REAL_64
			z, w: PLPLOT_GRID2
			clevel, shedge, xg1, yg1: ARRAY [REAL_64]
			cgrid1: PLC_GRID
			cgrid2: PLC_GRID2
			fill_width, cont_width: REAL_64
			cont_color: INTEGER
			n_axis_opts: INTEGER
			axis_opts: ARRAY [STRING]
			num_values: ARRAY [INTEGER]
			values: ARRAY [POINTER]
			axis_ticks: ARRAY [REAL_64]
			axis_subticks: ARRAY [INTEGER]
			n_labels: INTEGER
			label_opts: ARRAY [INTEGER]
			labels: ARRAY [STRING]
			tuple: TUPLE [fmin: REAL_64; fmax: REAL_64]
			colorbar_width, colorbar_height: REAL_64
			l_pldefined: PLDEFINED_CALLBACK_DISPATCHER
		do
			fill_width := 2.0
			cont_width := 0
			cont_color := 0
			n_axis_opts := NUM_AXES
			axis_opts := <<"bcvtm">>
			axis_ticks := <<0.0>>
			axis_subticks := <<0>>
			n_labels := NUM_LABELS
			label_opts := << {PLPLOT_CONSTANTS}.PL_COLORBAR_LABEL_BOTTOM>>
			labels := <<"Magnitude">>

				-- Load colour palettes
    		plspal0( "cmap0_black_on_white.pal" )
    		plspal1( "cmap1_gray.pal", 1 )

				-- Reduce colors in cmap 0 so that cmap 1 is useful on a 16-color display
    		plscmap0n( 3 );

				-- Initialize plplot

    		initialize

				-- Set up transformation function
			create tr.make_filled (0.0, 1, 6)

		    tr[1] := 2. / ( nx - 1 )
		    tr[2] := 0.0
		    tr[3] := -1.0
		    tr[4] := 0.0
		    tr[5] := 2.0 / ( ny - 1 )
		    tr[6] := -1.0

				-- Initialize data structures
			create clevel.make_filled (0.0, 1, ns)
			create shedge.make_filled (0.0, 1, ns + 1)
			create xg1.make_filled (0.0, 1, nx)
			create yg1.make_filled (0.0, 1, ny)

			create z.make (nx, ny)
			create w.make (nx, ny)


				-- Set up data array

			across 0 |..| (nx - 1) as i loop
				x := ( i.item - ( nx / 2.0 ) ) / ( nx / 2.0 )
				across 0 |..| (ny - 1) as j  loop
					y := ( j.item - ( ny / 2.0 ) ) / ( ny / 2 ) - 1.0
					z[i.item, j.item] := - {DOUBLE_MATH}.sine( 7.0 * x ) *  {DOUBLE_MATH}.cosine( 7.0 * y ) + x * x - y * y
					w[i.item, j.item] := - {DOUBLE_MATH}.cosine( 7.0 * x ) * {DOUBLE_MATH}.sine( 7.0 * y ) + 2 * x * y;
				end
			end


		    tuple := f2mnmx( z)
		    zmin := tuple.fmin
		    zmax := tuple.fmax

		    across 0 |..| (ns - 1) as i loop
		    	clevel[i.item + 1] := zmin + ( zmax - zmin ) * ( i.item + 0.5 ) / ns
		    end

		    across 0 |..| ns as i loop
		    	shedge[i.item +1 ] := zmin + ( zmax - zmin ) *  i.item /  ns
		    end


			create cgrid1.make
			cgrid1.set_xg (xg1)
			cgrid1.set_yg (yg1)

			create cgrid2.make (nx, ny)
			cgrid2.set_xg (create {PLPLOT_GRID2}.make (nx, ny))
			cgrid2.set_yg (create {PLPLOT_GRID2}.make (nx, ny))

			across 0 |..| (nx - 1) as i loop
				across 0 |..| (ny - 1)  as j loop
					mypltr( i.item, j.item, $x, $y, default_pointer )
					argx    := x * {DOUBLE_MATH}.pi / 2
		            argy    := y * {DOUBLE_MATH}.pi / 2
		            distort := 0.4

		            cgrid1.xg[i.item + 1] := x + distort * {DOUBLE_MATH}.cosine ( argx )
		            cgrid1.yg[j.item + 1] := y - distort * {DOUBLE_MATH}.cosine ( argy )

		            cgrid2.xg[i.item, j.item] := x + distort * {DOUBLE_MATH}.cosine( argx ) * {DOUBLE_MATH}.cosine( argy );
		            cgrid2.yg[i.item, j.item] := y - distort * {DOUBLE_MATH}.cosine( argx ) * {DOUBLE_MATH}.cosine( argy );
				end
			end
			-- Plot using identity transform

		    pladv( 0 )
		    plvpor( 0.1, 0.9, 0.1, 0.9 )
		    plwind( -1.0, 1.0, -1.0, 1.0 )

		    plpsty( 0 )

		    plshades( z, nx, ny, default_pointer, -1., 1., -1., 1.,
        		shedge, ns + 1, fill_width,
        		cont_color, cont_width,
        		plfill_address, 1, default_pointer, Void );

			create num_values.make_filled (0, 1, 1)
			create values.make_filled (default_pointer, 1, 1)
			if  colorbar = 1 then
					-- Smaller text
				plschr( 0.0, 0.75 )
					-- Small ticks on the vertical axis
				plsmaj( 0.0, 0.5 )
				plsmin( 0.0, 0.5 )

				num_values[1] := ns + 1;
				values[1]     := shedge.area.base_address
				plcolorbar( $colorbar_width, $colorbar_height, {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE | {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE_LABEL, 0,
            			0.005, 0.0, 0.0375, 0.875, 0, 1, 1, 0.0, 0.0,
            			cont_color, cont_width,
            			n_labels, label_opts.area.base_address, labels,
            			n_axis_opts, axis_opts,
           				axis_ticks, axis_subticks,
            			num_values, values.area.base_address )

 		       		-- Reset text and tick sizes
       			plschr( 0.0, 1.0 )
       			plsmaj( 0.0, 1.0 )
        		plsmin( 0.0, 1.0 )
       		end

			plcol0( 1 )
			plbox( "bcnst", 0.0, 0, "bcnstv", 0.0, 0 );
			plcol0( 2 );
			plcont( w, nx, ny, 1, nx, 1, ny, clevel, ns, pltr2_address, cgrid2.pointer )

		    pllab( "distance", "altitude", "Bogon density, with streamlines" )

				-- Plot using 2d coordinate transform

				-- Load colour palettes
		    plspal0( "" );
    		plspal1( "", 1 );
				-- Reduce colors in cmap 0 so that cmap 1 is useful on a 16-color display
    		plscmap0n( 3 );

		    pladv( 0 );
		    plvpor( 0.1, 0.9, 0.1, 0.9 );
		    plwind( -1.0, 1.0, -1.0, 1.0 );

		    plpsty( 0 );

		    plshades( z, nx, ny, default_pointer, -1., 1., -1., 1.,
		        shedge, ns + 1, fill_width,
		        2, 3.,
		        plfill_address, 0, pltr2_address, cgrid2 )

			if  colorbar = 1 then
		        	-- Smaller text
		        plschr( 0.0, 0.75 )
					-- Small ticks on the vertical axis
		        plsmaj( 0.0, 0.5 )
		        plsmin( 0.0, 0.5 )

		        num_values[1] := ns + 1;
		        values[1]     := shedge.area.base_address
		        plcolorbar( $colorbar_width, $colorbar_height,
		            {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE | {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE_LABEL, 0,
		            0.005, 0.0, 0.0375, 0.875, 0, 1, 1, 0.0, 0.0,
		            2, 3.,
		            n_labels, label_opts.area.base_address, labels,
		            n_axis_opts, axis_opts,
		            axis_ticks, axis_subticks,
		            num_values, values.area.base_address )

		        	-- Reset text and tick sizes
		        plschr( 0.0, 1.0 )
		        plsmaj( 0.0, 1.0 )
		        plsmin( 0.0, 1.0 )
			end

  			plcol0( 1 )
    		plbox( "bcnst", 0.0, 0, "bcnstv", 0.0, 0 )
   			plcol0( 2 )
				--plcont((const PLFLT **) w, nx, ny, 1, nx, 1, ny, clevel, ns, pltr2, (void *) &cgrid2)

			pllab( "distance", "altitude", "Bogon density" )

				-- Note this exclusion API will probably change.

				-- Plot using 2d coordinate transform and exclusion

			if ( exclude = 1 ) then
--				set_callback
				create l_pldefined.make (agent zdefined)
					 -- Load colour palettes
        		plspal0( "cmap0_black_on_white.pal" );
        		plspal1( "cmap1_gray.pal", 1 );
					 -- Reduce colors in cmap 0 so that cmap 1 is useful on a 16-color display
      		  	plscmap0n( 3 )

  				pladv( 0 )
				plvpor( 0.1, 0.9, 0.1, 0.9 )
				plwind( -1.0, 1.0, -1.0, 1.0 )

				plpsty( 0 )

--		        plshades(z, nx, ny, l_pldefined.c_dispatcher, -1., 1., -1., 1.,
--		            shedge, ns + 1, fill_width,
--		            cont_color, cont_width,
--		            plfill_address, 0, pltr2_address, cgrid2)
		        plshades(z, nx, ny, l_pldefined.c_dispatcher, -1., 1., -1., 1.,
		            shedge, ns + 1, fill_width,
		            cont_color, cont_width,
		            plfill_address, 0, pltr2_address, cgrid2)

				plcol0( 1 )
				plbox( "bcnst", 0.0, 0, "bcnstv", 0.0, 0 )

				pllab( "distance", "altitude", "Bogon density with exclusion" )
			end

				-- Example with polar coordinates.

				-- Load colour palettes
    		plspal0( "cmap0_black_on_white.pal" );
    		plspal1( "cmap1_gray.pal", 1 );
				--Reduce colors in cmap 0 so that cmap 1 is useful on a 16-color display
		    plscmap0n( 3 )

		    pladv( 0 )
		    plvpor( .1, .9, .1, .9 )
		    plwind( -1., 1., -1., 1. )


		    plpsty( 0 );

				--Build new coordinate matrices.

			across 0 |..| (nx-1) as i loop
				r := (i.item.to_double / (nx - 1))
				across 0 |..| (ny - 1) as j loop
					t := ( 2. * {DOUBLE_MATH}.pi / ( ny - 1. ) ) * j.item
					cgrid2.xg[i.item ,j.item ] := r * {DOUBLE_MATH}.cosine( t )
					cgrid2.yg[i.item, j.item ] := r * {DOUBLE_MATH}.sine( t );
            		z[i.item, j.item] := {DOUBLE_MATH}.exp( -r * r ) * {DOUBLE_MATH}.cosine( 5. * {DOUBLE_MATH}.PI * r ) * {DOUBLE_MATH}.cosine( 5. * t )
				end
			end

 				-- Need a new shedge to go along with the new data set.
			tuple := f2mnmx (z)
			zmax := tuple.fmax
			zmin := tuple.fmin

			across 0 |..| ns as i loop
				shedge[i.item + 1] := zmin + ( zmax - zmin ) *  i.item.to_double / ns
			end


				-- Now we can shade the interior region.
		    plshades( z, nx, ny, default_pointer, -1., 1., -1., 1.,
		        shedge, ns + 1, fill_width,
		        cont_color, cont_width,
		        plfill_address, 0, pltr2_address, cgrid2 );

		    if ( colorbar = 1) then
		        	-- Smaller text
		        plschr( 0.0, 0.75 )
		        	-- Small ticks on the vertical axis
		        plsmaj( 0.0, 0.5 )
		        plsmin( 0.0, 0.5 )

		        num_values[1] := ns + 1;
		        values[1]     := shedge.area.base_address
		        plcolorbar( $colorbar_width, $colorbar_height,
		            {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE | {PLPLOT_CONSTANTS}.PL_COLORBAR_SHADE_LABEL, 0,
		            0.005, 0.0, 0.0375, 0.875, 0, 1, 1, 0.0, 0.0,
		            cont_color, cont_width,
		            n_labels, label_opts.area.base_address, labels,
		            n_axis_opts, axis_opts,
		            axis_ticks, axis_subticks,
		            num_values, values.area.base_address );

		        	-- Reset text and tick sizes
		        plschr( 0.0, 1.0 )
		        plsmaj( 0.0, 1.0 )
		        plsmin( 0.0, 1.0 )
		    end


			create px.make_filled (0.0, 1, PERIMETERPTS)
			create py.make_filled (0.0, 1, PERIMETERPTS)
				-- Now we can draw the perimeter.  (If do before, shade stuff may overlap.
			across 0 |..| (PERIMETERPTS - 1) as i  loop
				t     := ( 2. * {DOUBLE_MATH}.pi/ ( PERIMETERPTS - 1 ) ) * i.item
        		px[i.item + 1] := {DOUBLE_MATH}.cosine( t )
        		py[i.item + 1] := {DOUBLE_MATH}.sine( t )

			end
		    plcol0( 1 )
		    plline( px, py )

			--  And label the plot.

		    plcol0( 2 )
		    pllab( "", "", "Tokamak Bogon Instability" )

			z.clean
			w.clean
			cgrid2.xg.clean
			cgrid2.yg.clean

			finalize
 		end



feature -- Fundamental settings.  See notes[] for more info.

	ns: INTEGER  = 20
		-- Default number of shade levels
	nx: INTEGER = 35
		-- Default number of data points in x

	ny: INTEGER = 46
		-- Default number of data points in y

	exclude: INTEGER = 1  -- 0 by default.
		-- By default do not plot a page illustrating
		-- exclusion.  API is probably going to change
		-- anyway, and cannot be reproduced by any
		-- front end other than the C one.


	colorbar: INTEGER = 1
		-- For now, don't show the colorbars while we are working out the API.		

	NUM_AXES: INTEGER = 1

	NUM_LABELS: INTEGER = 1

feature -- Transformation function

	tr: ARRAY [REAL_64]
		-- Transformation function

	mypltr (x: REAL_64; y: REAL_64; tx: POINTER; ty: POINTER; a_data: POINTER)
		local
			l_tx: REAL_64
			l_ty: REAL_64
		do
			l_tx := tr[1] * x + tr[2] * y + tr[3]
			l_ty := tr[4] * x + tr[5] * y + tr[6]
			tx.memory_copy ($l_tx, {PLATFORM}.real_64_bytes)
			ty.memory_copy ($l_ty, {PLATFORM}.real_64_bytes)
		end

feature -- polar plot data

	PERIMETERPTS: INTEGER = 100

feature -- Helper

	f2mnmx (f: PLPLOT_GRID2): TUPLE [fmin: REAL_64; fmax: REAL_64]
			--  Compute min and max value of a 2-d array.
		local
			l_max, l_min: REAL_64
		do
			l_max := f [0,0]
			l_min := l_max
			across 0 |..| (f.rows - 1) as i loop
				across 0 |..| (f.columns - 1) as j loop
					if ( f[i.item, j.item ] < l_min ) then
						l_min := f[i.item, j.item]
					end
					if ( f[i.item, j.item] > l_max ) then
						l_max := f[i.item, j.item];
					end
				end
			end
			Result := [l_min, l_max]
		end

	zdefined (x: REAL_64; y: REAL_64): INTEGER
		local
			z: REAL_64
			b: BOOLEAN
		do
			z := {DOUBLE_MATH}.sqrt (x * x + y * y )
			b := z < 0.4 or z > 0.6
			Result := b.to_integer
		end


end
