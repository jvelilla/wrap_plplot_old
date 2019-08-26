note
	description: "Bar chart demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name= Example 13", "src=http://plplot.sourceforge.net/examples.php?demo=12&lbind=C", "protocol=uri"

class
	EXAMPLE_13

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does a simple bar chart, using color fill.  If color fill is
			-- unavailable, pattern fill is used instead (automatic).
		local
			pos: ARRAY [REAL_64]
			red: ARRAY [REAL_64]
			green: ARRAY [REAL_64]
			blue: ARRAY [REAL_64]
			string: STRING
			y0: ARRAY [REAL_64]
		do

			create y0.make_filled (0.0, 1, 10)

			pos := <<0.0, 0.25, 0.5, 0.75, 1.0 >>
    		red := <<0.0, 0.25, 0.5, 1.0, 1.0>>
			green := << 1.0, 0.5, 0.5, 0.5, 1.0 >>
    		blue := << 1.0, 1.0, 0.5, 0.25, 0.0 >>

				-- Initialize plplot
			initialize

		    pladv( 0 )
		    plvsta
		    plwind( 1980.0, 1990.0, 0.0, 35.0 )
		    plbox( "bc", 1.0, 0, "bcnv", 10.0, 0 )
		    plcol0( 2 )
		    pllab( "Year", "Widget Sales (millions)", "#frPLplot Example 12" )

		    y0[1] := 5
		    y0[2] := 15
		    y0[3] := 12
		    y0[4] := 24
		    y0[5] := 28
		    y0[6] := 30
		    y0[7] := 20
		    y0[8] := 8
		    y0[9] := 12
		    y0[10] := 3

		    plscmap1l( 1, 5, pos, red, green, blue, {ARRAY [BOOLEAN]}<<>> )

		    across 0 |..| 9 as i loop
		        plcol1( i.item / 9.0 )
		        plpsty( 0 )
		        plfbox( ( 1980. + i.item ), y0[i.item + 1] )
		        create string.make_from_string ( (y0[i.item + 1]).out)
		        plptex( ( 1980. + i.item + .5 ), ( y0[i.item + 1] + 1. ), 1.0, 0.0, .5, string )
		       	create string.make_from_string ((1990 + i.item).out)
		        plmtex( "b", 1.0, ( ( i.item + 1 ) * .1 - .05 ), 0.5, string )
		    end
			finalize
		end


feature -- Access

	plfbox (x0: REAL_64; y0: REAL_64)
		local
			x, y: ARRAY [REAL_64]
		do
			create x.make_filled (0.0, 1, 4)
			create y.make_filled (0.0, 1, 4)

		    x[1] := x0
		    y[1] := 0.0
		    x[2] := x0
		    y[2] := y0
		    x[3] := x0 + 1.0
		    y[3] := y0
		    x[4] := x0 + 1.0
		    y[4] := 0.0
		    plfill( x, y )
		    plcol0( 1 )
		    pllsty( 1 )
		    plline( x, y )
		end
end
