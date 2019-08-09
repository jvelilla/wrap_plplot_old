note
	description: "Shade plot demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 16", "src=http://plplot.sourceforge.net/examples.php?demo=15&lbind=C", "protocol=uri"

class
	EXAMPLE_16

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does a variety of shade plots.
		local
			xx, yy: REAL_64
			t: TUPLE [fmax: REAL_64; fmin: REAL_64]
		do
			create zaux.make_filled (0.0, 1, XPTS)

				-- Set up color map 1

			create z.make (XPTS, YPTS)

			cmap1_init2

				-- Initialize plplot

			initialize

				-- Calculate z data array that is statically allocated above.

			across 0 |..|  (XPTS - 1) as i loop
				xx := ( i.item - ( XPTS / 2.0 ) ) / ( XPTS / 2.0 )
				across 0 |..| (YPTS - 1)  as j loop
					yy := ( j.item - ( YPTS / 2.0 ) ) / ( YPTS / 2.0 ) - 1.0
					z[i.item, j.item] := xx * xx - yy * yy + ( xx - yy ) / ( xx * xx + yy * yy + 0.1 );
				end
			end

			create ziliffe.make_by_pointer (z.pointer, z.rows, z.columns)
			t := ziliffe.min_max
			zmax := t.fmax
			zmin := t.fmin
			plot1
			plot2
			plot3

			finalize

		end

feature -- Access

		zmax, zmin: REAL_64

		XPTS: INTEGER =   35
			-- Data points in x
		YPTS: INTEGER =   46
			-- Data points in y

		z: PLPLOT_GRID2

		zaux: ARRAY [REAL_64]

		zIliffe: PLPLOT_GRID2



feature -- Initialization

	cmap1_init2
			--Initializes color map 1 in HLS space.
		local
			i, h, l, s: ARRAY [REAL_64]
		do
			create i.make_filled (0.0, 1, 4)
			create h.make_filled (0.0, 1, 4)
			create l.make_filled (0.0, 1, 4)
			create s.make_filled (0.0, 1, 4)

		    i[1] := 0           -- left boundary
		    i[2] := 0.45        -- just before center
		    i[3] := 0.55        -- just after center
		    i[4] := 1           -- right boundary

		    h[1] := 260;        -- hue -- low: blue-violet
		    h[2] := 260;        -- only change as we go over vertex
		    h[3] := 20;         -- hue -- high: red
		    h[4] := 20;         -- keep fixed

		    l[1] := 0.6;         -- lightness -- low
		    l[2] := 0.0;         -- lightness -- center
			l[3] := 0.0;         -- lightness -- center
			l[4] := 0.6;         -- lightness -- high

--			plscolbg( 255, 255, 255 );
--			l[1] := 0.5;         --// lightness -- low
--			l[2] := 1.0;         --// lightness -- center
--			l[3] := 1.0;         --// lightness -- center
--			l[4] := 0.5;         --// lightness -- high

		    s[1] := 1           -- saturation -- low
		    s[2] := 0.5         -- saturation -- center
		    s[3] := 0.5         -- saturation -- center
		    s[4] := 1           -- saturation -- high

		    plscmap1l( 0, 4, i, h, l, s, {ARRAY [BOOLEAN]}<<>> );
		end

feature -- Plotting

	plot1
			-- llustrates a single shaded region.
		local
			shade_min, shade_max, sh_color: REAL_64
			sh_cmap: INTEGER
			min_color, max_color: INTEGER
			sh_width, min_width, max_width: REAL_64
		do
			sh_cmap := 0
			min_color := 0
			max_color := 0

			min_width := 0.0
			max_width := 0.0

		    pladv( 0 )
		    plvpor( 0.1, 0.9, 0.1, 0.9 )
		    plwind( -1.0, 1.0, -1.0, 1.0 )

				-- Plot using identity transform

		    shade_min := zmin + ( zmax - zmin ) * 0.4;
		    shade_max := zmin + ( zmax - zmin ) * 0.6;
		    sh_color  := 7;
		    sh_width  := 2.;
		    min_color := 9;
		    max_color := 2;
		    min_width := 2.;
		    max_width := 2.;

		    plpsty( 8 )
		    plshade(zIliffe, XPTS, YPTS, default_pointer, -1., 1., -1., 1.,
		        shade_min, shade_max,
		        sh_cmap, sh_color, sh_width,
		        min_color, min_width, max_color, max_width,
		        plfill_address, 1, default_pointer, default_pointer)

		    plcol0( 1 )
		    plbox( "bcnst", 0.0, 0, "bcnstv", 0.0, 0 )
		    plcol0( 2 )
		    pllab( "distance", "altitude", "Bogon flux" )
		end


	plot2
			-- Illustrates multiple adjacent shaded regions, using different fill
			-- patterns for each region.
		local
			shade_min, shade_max, sh_color: REAL_64
			sh_cmap: INTEGER
			min_color, max_color: INTEGER
			sh_width, min_width, max_width: REAL_64
			nlin: ARRAY [INTEGER]
			inc: ARRAY [ARRAY [INTEGER]]
			del: ARRAY [ARRAY [INTEGER]]
		do
			sh_cmap  := 0
			min_color := 0
			max_color := 0
			min_width := 0.0
			max_width := 0.0

			nlin := << 1, 1, 1, 1, 1, 2, 2, 2, 2, 2 >>
			inc := << << 450,    0 >>, << -450,    0 >>, << 0,   0 >>, << 900,   0 >>,
					                                << 300,    0 >>, <<  450, -450 >>, << 0, 900 >>, <<   0, 450 >>,
					                                << 450, -450 >>, <<    0,  900 >> >>

			del := << << 2000, 2000 >>, << 2000, 2000 >>, << 2000, 2000 >>,
					                                << 2000, 2000 >>, << 2000, 2000 >>, << 2000, 2000 >>,
					                                << 2000, 2000 >>, << 2000, 2000 >>, << 4000, 4000 >>,
					                                << 4000, 2000 >> >>

			sh_width := 2.0
			pladv( 0 )
			plvpor( 0.1, 0.9, 0.1, 0.9 )
			plwind( -1.0, 1.0, -1.0, 1.0 )

				-- plot using identity transform
			across 0 |..| 9 as i loop
				shade_min := zmin + ( zmax - zmin ) * i.item / 10.0;
				shade_max := zmin + ( zmax - zmin ) * ( i.item + 1 ) / 10.0;
				sh_color  := i.item + 6;
				plpat( nlin[i.item + 1], inc[i.item + 1], del[i.item + 1] );

				plshade( zIliffe, XPTS, YPTS, default_pointer, -1., 1., -1., 1.,
						shade_min, shade_max,
			            sh_cmap, sh_color, sh_width,
			            min_color, min_width, max_color, max_width,
			            plfill_address, 1, default_pointer, default_pointer )
			end
			plcol0( 1 )
			plbox( "bcnst", 0.0, 0, "bcnstv", 0.0, 0 )
			plcol0( 2 )
			pllab( "distance", "altitude", "Bogon flux" )
		end


	plot3
			-- Illustrates shaded regions in 3d, using a different fill pattern for
			-- each region.
		local
			xx: ARRAY [ARRAY [REAL_64]]
			yy: ARRAY [ARRAY [REAL_64]]
			zz: ARRAY [ARRAY [REAL_64]]
		do

			xx := << << -1.0, 1.0, 1.0, -1.0, -1.0 >>,
                              << -1.0, 1.0, 1.0, -1.0, -1.0 >> >>
			yy := << <<  1.0,  1.0, 0.0, 0.0,  1.0 >>,
                              << -1.0, -1.0, 0.0, 0.0, -1.0 >> >>
    	 	zz := << << 0.0, 0.0, 1.0, 1.0, 0.0 >>,
                              << 0.0, 0.0, 1.0, 1.0, 0.0 >> >>

			pladv( 0 )
			plvpor( 0.1, 0.9, 0.1, 0.9 );
			plwind( -1.0, 1.0, -1.0, 1.0 );
			plw3d( 1., 1., 1., -1.0, 1.0, -1.0, 1.0, 0.0, 1.5, 30, -40 )

				-- Plot using identity transform

		    plcol0( 1 );
		    plbox3( "bntu", "X", 0.0, 0, "bntu", "Y", 0.0, 0, "bcdfntu", "Z", 0.5, 0 )
		    plcol0( 2 )
		    pllab( "", "", "3-d polygon filling" )

		    plcol0( 3 )
		    plpsty( 1 )
		    plline3( xx[1], yy[1], zz[1] )
		    plfill3(xx[1], yy[1], zz[1] )
		    plpsty( 2 );
		    plline3( xx[2], yy[2], zz[2] )
		    plfill3( xx[2], yy[2], zz[2] )
		end



end
