note
	description: "Mesh plot demo."
	date: "$Date$"
	revision: "$Revision$"
	eis:"name=Example 12", "src=http://plplot.sourceforge.net/examples.php?demo=11&lbind=C", "protocol=uri"

class
	EXAMPLE_12

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does a series of mesh plots for a given data set, with different
			-- viewing options in each plot.
		local
			x, y: ARRAY [REAL_64]
    		z: PLPLOT_GRID2
    		xx, yy: REAL_64
    		nlevel: INTEGER
    		clevel: ARRAY [REAL_64]
    		zmin, zmax, step: REAL_64
    		zmin_max: TUPLE [fmax: REAL_64; fmin: REAL_64]
 		do
 				-- Initialize plplot
 			initialize
 			create x.make_filled (0.0, 1, XPTS)
 			create y.make_filled (0.0, 1, YPTS)

 			create clevel.make_filled (0.0, 1, LEVELS)

			create z.make (XPTS, YPTS )

			across 0 |..| (XPTS-1)  as i  loop
				x [i.item + 1] := 3.0 * ( i.item - ( XPTS / 2.0 ) ) /  ( XPTS / 2.0 )
			end
			across 0 |..| (YPTS-1)  as i  loop
				y [i.item + 1] := 3.0 * ( i.item - ( YPTS / 2.0 ) ) /  ( YPTS / 2.0 )
			end

			across 0 |..| (XPTS - 1) as i loop
				xx := x [i.item + 1]
				across  0 |..| (YPTS - 1)  as j  loop
					yy := y[j.item + 1]
					z[i.item, j.item] := 3.0 * ( 1.0 - xx ) * ( 1.0 - xx ) * {DOUBLE_MATH}.exp( -( xx * xx ) - ( yy + 1.0 ) * ( yy + 1.0 ) ) -
                      10.0 * ( xx / 5.0 - xx.power (3.0)  - yy.power ( 5.0 ) ) * {DOUBLE_MATH}.exp( -xx * xx - yy * yy ) -
                      1.0 / 3.0 * {DOUBLE_MATH}.exp( -( xx + 1 ) * ( xx + 1 ) - ( yy * yy ) )

--					if True then
--						if z[i.item, j.item] < -1 then
--							z[i.item, j.item] := -1
--						end
--					end
				end
			end

			zmin_max := z.min_max
			zmax := zmin_max.fmax
			zmin := zmin_max.fmin
			step := ( zmax - zmin ) / ( nlevel + 1 );
			across 0 |..| (nlevel-1) as i loop
				clevel[i.item +1 ] := zmin + step + step * i.item
			end
			cmap1_init

			across 0 |..| 1 as k  loop
				across 0 |..| 3 as i loop
		            pladv( 0 )
        		    plcol0( 1 )
            		plvpor( 0.0, 1.0, 0.0, 0.9 )
            		plwind( -1.0, 1.0, -1.0, 1.5 )
           	 		plw3d( 1.0, 1.0, 1.2, -3.0, 3.0, -3.0, 3.0, zmin, zmax, alt[k.item + 1], az[k.item + 1] )
           			plbox3( "bnstu", "x axis", 0.0, 0, "bnstu", "y axis", 0.0, 0,"bcdmnstuv", "z axis", 0.0, 4 )

					plcol0( 2 )


					inspect i.item
					when 0 then
							-- wireframe plot
						plmesh( x, y, z, XPTS, YPTS, opt[k.item + 1] )
					when 1 then
							--  magnitude colored wireframe plot
						plmesh( x, y, z, XPTS, YPTS, opt[k.item + 1] | {PLPLOT_CONSTANTS}.MAG_COLOR );
					when 2 then
							-- magnitude colored wireframe plot with sides
						plot3d( x, y, z, XPTS, YPTS, opt[k.item + 1] | {PLPLOT_CONSTANTS}.MAG_COLOR, 1 );
					when 3 then
							--  magnitude colored wireframe plot with base contour
						plmeshc( x, y, z, XPTS, YPTS,( opt[k.item + 1] | {PLPLOT_CONSTANTS}.MAG_COLOR )| {PLPLOT_CONSTANTS}.BASE_CONT, clevel, nlevel );
					end
					plcol0( 3 );
            		plmtex( "t", 1.0, 0.5, 0.5, title[k.item + 1] )

				end
			end

		    z.clean
		    finalize
		    io.read_line
		end

	cmap1_init
		local
			i, h, l, s: ARRAY [REAL_64]
		do
			create i.make_filled (0.0, 1, 2)
			create h.make_filled (0.0, 1, 2)
			create l.make_filled (0.0, 1, 2)
			create s.make_filled (0.0, 1, 2)

		    i[1] := 0.0         -- left boundary
		    i[2] := 1.0         -- right boundary

		    h[1] := 240         -- blue -> green -> yellow ->
		    h[2] := 0           -- -> red

		    l[1] := 0.6
		    l[2] := 0.6

		    s[1] := 0.8
		    s[2] := 0.8

		    plscmap1n( 256 )
		    plscmap1l( 0, 2, i, h, l, s, {ARRAY [BOOLEAN]}<<False, False>> )
		end


feature -- Access

	XPTS: INTEGER = 35
			-- Data points in x.

	YPTS: INTEGER = 46
			--  Data points in y.

	LEVELS: INTEGER = 10


	opt: ARRAY [INTEGER]
		do
			Result := {ARRAY [INTEGER]} << {PLPLOT_CONSTANTS}.DRAW_LINEXY, {PLPLOT_CONSTANTS}.DRAW_LINEXY >>
		end

	alt: ARRAY [REAL_64]
		do
			Result := {ARRAY [REAL_64]} <<33.0, 17.0>>
		end

	az: ARRAY [REAL_64]
		do
			Result := {ARRAY [REAL_64]} <<24.0, 115.0>>
		end

	title: ARRAY [STRING]
		do
			Result := {ARRAY [STRING]} <<"#frPLplot Example 11 - Alt=33, Az=24, Opt=3", "#frPLplot Example 11 - Alt=17, Az=115, Opt=3">>
		end



end
