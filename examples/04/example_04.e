note
	description: "Polar plot demo"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 4", "src=http://plplot.sourceforge.net/examples.php?demo=03&lbind=C", "protocol=uri"

class
	EXAMPLE_04

inherit

	PLPLOT_API

create
		make

feature -- Initialization

	make
			-- Generates polar plot, with 1-1 scaling.
		local
			dtr, theta, dx, dy, r, offset: REAL_64
			text: STRING
			x0, y0: ARRAY [REAL_64]
    		x, y:  ARRAY [REAL_64]
		do
			create x0.make_filled (0.0, 1, 361)
			create y0.make_filled (0.0, 1, 361)
			create x.make_filled (0.0, 1, 361)
			create y.make_filled (0.0, 1, 361)

			dtr := {MATH_CONST}.pi / 180

			across 0 |..| 360 as ic  loop
				x0[ic.item + 1] := {DOUBLE_MATH}.cosine( dtr * ic.item )
				y0[ic.item + 1] := {DOUBLE_MATH}.sine( dtr * ic.item )
			end

			-- Parse and process command line arguments


			-- Set orientation to portrait - note not all device drivers
			-- support this, in particular most interactive drivers do not
    		plsori( 1 )

			-- Initialize plplot

			initialize
			-- Set up viewport and window, but do not draw box			
			plenv( -1.3, 1.3, -1.3, 1.3, 1, -2 );
			-- Draw circles for polar grid
			across 1 |..| 10 as  ic loop
				plarc( 0.0, 0.0, 0.1 * ic.item, 0.1 * ic.item, 0.0, 360.0, 0.0, 0 );
    		end

    		plcol0 (2)
    		across 0 |..| 11 as ic loop
				theta := 30.0 * ic.item
				dx := {DOUBLE_MATH}.cosine( dtr * theta )
				dy := {DOUBLE_MATH}.sine( dtr * theta )

				-- Draw radial spokes for polar grid
				 pljoin( 0.0, 0.0, dx, dy );
				create text.make_from_string (theta.rounded.out)
				-- Write labels for angle

				if  theta < 9.99  then
		            offset := 0.45
				elseif  theta < 99.9 then
					offset := 0.30
		        else
    		        offset := 0.15
       			end
				-- Slightly off zero to avoid floating point logic flips at 90 and 270 deg.
        		if ( dx >= -0.00001 ) then
					plptex( dx, dy, dx, dy, -offset, text )
        		else
					plptex( dx, dy, -dx, -dy, 1. + offset, text )
            	end
    		end
			--Draw the graph

			across 0 |..| 360 as ic  loop
				r := {DOUBLE_MATH}.sine( dtr * ( 5 * ic.item ) )
				x[ic.item + 1] := x0[ic.item + 1] * r
				y[ic.item + 1] := y0[ic.item + 1] * r;
			end
			plcol0( 3 )
			plline( x, y )

			plcol0( 4 );
			plmtex( "t", 2.0, 0.5, 0.5, "#frPLplot Example 3 - r(#gh)=sin 5#gh" );


			-- Close the plot at end

			finalize

		end
end
