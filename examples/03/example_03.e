note
	description: "Demonstrates multiple windows and color map 0 palette, both default and"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=Example 03", "src=http://plplot.sourceforge.net/examples.php?demo=02&lbind=C", "protocol=uri"

class
	EXAMPLE_03

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
		do
				-- Parse and process command line arguments
 		    -- plparseopts( &argc, argv, PL_PARSE_FULL );

				-- Initialize plplot
   			initialize

				-- Run demos
		    demo1
		    demo2

		    finalize
		end


feature -- Demos

	demo1
			-- Demonstrates multiple windows and default color map 0 palette.
		do
			plbop
				-- Divide screen into 16 regions
   			plssub( 4, 4 )

			draw_windows( 16, 0 )

			pleop

		end

	demo2
			-- Demonstrates multiple windows, user-modified color map 0 palette, and
			-- HLS -> RGB translation.
		local
			r,g, b: ARRAY [INTEGER]
				-- Use 100 custom colors in addition to base 16
			lmin, lmax: REAL_64
			i: INTEGER
			h,l,s: REAL_64
			r1, g1, b1: REAL_64
			r2, g2, b2: INTEGER
		do
			create r.make_filled (0, 1, 116)
			create g.make_filled (0, 1, 116)
			create b.make_filled (0, 1, 116)

				-- Min & max lightness values
			lmin := 0.15
			lmax := 0.85

			plbop

				-- Divide screen  into 100 regions
			plssub (10, 10)

			across 0 |..| 99 as  ic loop
				-- Bounds on HLS, from plhlsrgb() commentary --
				--  hue     [0., 360.]  degrees
				--  lightness   [0., 1.]    magnitude
				--  saturation  [0., 1.]    magnitude

				-- Vary hue uniformly from left to right			
				h := ( 360.0 / 10.0 ) * ( ic.item \\ 10 )
				-- Vary lightness uniformly from top to bottom, between min & max
        		l := lmin + ( lmax - lmin ) * ( ic.item / 10 ) / 9.0
        		-- Use max saturation
				s := 1.0
				plhlsrgb( h, l, s, $r1, $g1, $b1 );
				-- Use 255.001 to avoid close truncation decisions in this example.
				r[(ic.item + 1) + 16] :=( r1 * 255.001 ).truncated_to_integer
				g[(ic.item + 1) + 16] := ( g1 * 255.001 ).truncated_to_integer
				b[(ic.item + 1) + 16] := ( b1 * 255.001 ).truncated_to_integer
			end

				-- Load default cmap0 colors into our custom set
			across 0 |..| 15 as ic  loop
				plgcol0( ic.item + 1, $r2, $g2, $b2 );
				r[ic.item  + 1] := r2
				g[ic.item  + 1] := g2
				b[ic.item  + 1] := b2
 			end
			-- Now set cmap0 all at once (faster, since fewer driver calls)
  	  		plscmap0( r, g, b, 116 )

    		draw_windows( 100, 16 )

    		pleop
		end


	draw_windows (nw, cmap0_offset: INTEGER)
			-- Draws a set of numbered boxes with colors according to cmap0 entry.
		local
			vmin, vmax: REAL_64
			text: STRING
		do
			plschr( 0.0, 3.5 )
			plfont( 4 )
			across 0 |..| (nw-1)  as ic
			loop
				create text.make_from_string (ic.item.out)
				plcol0( ic.item + cmap0_offset )
				pladv( 0 )
				vmin := 0.1
				vmax := 0.9
				across 0 |..| 2  as jc
				loop
					plwidth( jc.item + 1 )
					plvpor( vmin, vmax, vmin, vmax )
					plwind( 0.0, 1.0, 0.0, 1.0 );
					plbox( "bc", 0.0, 0, "bc", 0.0, 0 );
					vmin := vmin + 0.1
					vmax := vmax - 0.1
				end
				plwidth( 1 )
				plptex( 0.5, 0.5, 1.0, 0.0, 0.5, text )
			end
		end
end
