note
	description: "Pie chart demo"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example14", "src=http://plplot.sourceforge.net/examples.php?demo=13&lbind=C", "protocol=uri"

class
	EXAMPLE_14

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Does a simple pie chart.
		local
			dthet, theta0, theta1, theta: INTEGER
			just, dx, dy: REAL_64
			x, y, per: ARRAY [REAL_64]
			j: INTEGER
		do
				-- TODO double check the code
				-- issues
			create x.make_filled (0.0, 1, 500)
			create y.make_filled (0.0, 1, 500)
			per := <<10.0, 32.0, 12.0, 30.0, 16.0>>

				-- Initialize plplot
			initialize

		    pladv( 0 )
		    	-- Ensure window has aspect ratio of one so circle is
		    	-- plotted as a circle.
		    plvasp( 1.0 )
		    plwind( 0.0, 10.0, 0.0, 10.0 )
		    	-- plenv(0., 10., 0., 10., 1, -2)
		    plcol0( 2 )

		    	-- n.b. all theta quantities scaled by 2*M_PI/500 to be integers to avoid
		    	--  floating point logic problems.
		    theta0 := 0
		    dthet  := 1

		    across 0 |..| 4 as  i loop
		    	j := 0
		    	x [j + 1] := 5.0
		    	y [j + 1] := 5.0
		    	j := j + 1
			    	-- n.b. the theta quantities multiplied by 2*M_PI/500 afterward so
					-- in fact per is interpreted as a percentage.
       			theta1 := ( theta0 + 5 * per[i.item + 1] ).truncated_to_integer
       			if i.item = 4 then
       			 	theta1 := 500
				end

				from
					theta := theta0
				until
					theta > theta1
				loop
					x[j + 1] := 5 + 3 * {DOUBLE_MATH}.cosine( ( 2.0 * {DOUBLE_MATH}.pi / 500.0 ) * theta )
					y[j + 1] := 5 + 3 * {DOUBLE_MATH}.sine( ( 2.0 * {DOUBLE_MATH}.pi / 500. ) * theta )
					j := j + 1
					theta := theta + dthet
				end
		        plcol0( i.item + 1 )
		        plpsty( ( i.item + 3 ) \\ 8 + 1 )
		        plfill( x.subarray (1, j+1), y.subarray (1, j + 1) )
		        plcol0( 1 )
		        plline( x.subarray (1, j + 1), y.subarray (1, j + 1) )
		        just := ( 2.0 * {DOUBLE_MATH}.pi / 500.0 ) * ( theta0 + theta1 ) / 2.0
		        dx   := 0.25 * {DOUBLE_MATH}.cosine( just )
		        dy   := 0.25 * {DOUBLE_MATH}.sine( just );
		        if ( ( theta0 + theta1 ) < 250 or ( theta0 + theta1 ) > 750 ) then
		            just := 0.0
		        else
		            just := 1.0
		        end

		        plptex( ( x[ ((j+1) // 2) + 1] + dx ), ( y[((j+1) // 2) + 1] + dy ), 1.0, 0.0, just, text[i.item + 1] );
		        theta0 := theta - dthet;
		    end
		    plfont( 2 );
		    plschr( 0., 1.3 );
		    plptex( 5.0, 9.0, 1.0, 0.0, 0.5, "Percentage of Sales" );

			finalize
		end


	text: ARRAY [STRING]
		do
			Result := {ARRAY [STRING]} <<   "Maurice", "Geoffrey",  "Alan", "Rafael", "Vince" >>
		end
end
