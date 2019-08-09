note
	description: "3-d line and point plot demo. "
	date: "$Date$"
	revision: "$Revision$"
	name: "example 19", "src=http://plplot.sourceforge.net/examples.php?demo=18&lbind=C", "protocol=uri"

class
	EXAMPLE_19

inherit

	PLPLOT_API

create
	make

feature {NONE} --Initialization

	make
			-- Does a series of 3-d plots for a given data set, with different
			-- viewing options in each plot.
		local
			x, y, z: ARRAY [REAL_64]
			r: REAL_64
			title: STRING
		do

				-- Initialize plplot
			initialize

			across 1 |..| 4 as k loop
				test_poly (k.item)
			end

			create x.make_filled (0.0, 1, NPTS)
			create y.make_filled (0.0, 1, NPTS)
			create z.make_filled (0.0, 1, NPTS)

				-- From the mind of a sick and twisted physicist...

			across 0 |..| (NPTS - 1) as i loop
				z [i.item + 1] :=  -1. + 2. * i.item / NPTS
					 -- Pick one ...

					 -- r    = 1. - ( (PLFLT) i / (PLFLT) NPTS );
				r := z[i.item + 1]

				x[i.item + 1] := r * {DOUBLE_MATH}.cosine( 2. * {DOUBLE_MATH}.pi * 6. * i.item / NPTS )
				y[i.item + 1] := r * {DOUBLE_MATH}.sine( 2. * {DOUBLE_MATH}.pi * 6. * i.item / NPTS )
			end

			across 0 |..| 3 as  k loop
		        pladv( 0 );
		        plvpor( 0.0, 1.0, 0.0, 0.9 );
		        plwind( -1.0, 1.0, -0.9, 1.1 );
		        plcol0( 1 );
		        plw3d( 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, alt[k.item + 1], az[k.item + 1] );
		        plbox3( "bnstu", "x axis", 0.0, 0,
		            "bnstu", "y axis", 0.0, 0,
		            "bcdmnstuv", "z axis", 0.0, 0 );

		        plcol0( 2 );

				if opt [k.item + 1] = 1 then
					plline3( x, y, z )
				else
					plstring3(x, y, z, "." )
				end
				plcol0( 3 )
				create title.make_from_string ("#frPLplot Example 18 - Alt=")
				title.append_double (alt [k.item + 1])
				title.append (",Az= ")
				title.append_double (az [k.item + 1])
				plmtex( "t", 1.0, 0.5, 0.5, title );
			end




			finalize

		end

feature -- ploting

	test_poly (a_k: INTEGER)
		local
			x, y , z: ARRAY [REAL_64]
			draw: ARRAY [ARRAY [INTEGER]]
		do
			draw :=<< << 1, 1, 1, 1 >>,
                        << 1, 0, 1, 0 >>,
                        << 0, 1, 0, 1 >>,
                        << 1, 1, 0, 0 >> >>

			create x.make_filled (0.0, 1, 5)
			create y.make_filled (0.0, 1, 5)
			create z.make_filled (0.0, 1, 5)

			pladv( 0 )
    		plvpor( 0.0, 1.0, 0.0, 0.9 )
    		plwind( -1.0, 1.0, -0.9, 1.1 )
    		plcol0( 1 )
    		plw3d( 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, alt[a_k], az[a_k] )
    		plbox3( "bnstu", "x axis", 0.0, 0,
		        "bnstu", "y axis", 0.0, 0,
		        "bcdmnstuv", "z axis", 0.0, 0 )

		    plcol0( 2 )

		    across 0 |..| 19 as i loop
		    	across 0 |..| 19 as j loop
		            x[1] := {DOUBLE_MATH}.sine ( phi( j.item  ) ) * {DOUBLE_MATH}.cosine ( theta( i.item ) )
		            y[1] := {DOUBLE_MATH}.sine( phi( j.item ) ) * {DOUBLE_MATH}.sine ( theta( i.item ) )
		            z[1] := {DOUBLE_MATH}.cosine( phi( j.item ) )

		            x[2] := {DOUBLE_MATH}.sine( phi( j.item + 1 ) ) * {DOUBLE_MATH}.cosine( theta( i.item ) )
		            y[2] := {DOUBLE_MATH}.sine( phi( j.item + 1 ) ) * {DOUBLE_MATH}.sine( theta( i.item ) )
		            z[2] := {DOUBLE_MATH}.cosine( PHI( j.item + 1 ) )


		            x[3] := {DOUBLE_MATH}.sine( phi( j.item + 1 ) ) * {DOUBLE_MATH}.cosine( theta( i.item + 1 ) )
		            y[3] := {DOUBLE_MATH}.sine( phi( j.item + 1 ) ) * {DOUBLE_MATH}.sine( theta( i.item + 1 ) )
		            z[3] := {DOUBLE_MATH}.cosine( phi( j.item + 1 ) )

		            x[4] := {DOUBLE_MATH}.sine( phi( j.item ) ) * {DOUBLE_MATH}.cosine( theta( i.item + 1 ) )
		            y[4] := {DOUBLE_MATH}.sine( phi( j.item ) ) * {DOUBLE_MATH}.sine( theta( i.item + 1 ) )
		            z[4] := {DOUBLE_MATH}.cosine( phi( j.item ) )

		            x[5] := {DOUBLE_MATH}.sine( phi( j.item ) ) * {DOUBLE_MATH}.cosine( theta( i.item ) )
		            y[5] := {DOUBLE_MATH}.sine( phi( j.item ) ) * {DOUBLE_MATH}.sine( theta( i.item ) )
		            z[5] := {DOUBLE_MATH}.cosine( phi( j.item ) );

		            plpoly3( x, y, z, draw[a_k], 1 )
		    	end
		    end

		    plcol0( 3 );
		    plmtex( "t", 1.0, 0.5, 0.5, "unit radius sphere" );

		end


feature -- Access

	opt: ARRAY [INTEGER]
		once
			Result := {ARRAY [INTEGER]} << 1, 0, 1, 0 >>
		end

	alt: ARRAY [REAL_64]
		once
			Result := {ARRAY [REAL_64]} <<20.0, 35.0, 50.0, 65.0>>
		end

	az: ARRAY [REAL_64]
		once
			Result := {ARRAY [REAL_64]} <<30.0, 40.0, 50.0, 60.0>>
		end

	NPTS: INTEGER =  1000

feature -- Helper


	theta (a: INTEGER): REAL_64
		do
			Result :=  ((2 *{DOUBLE_MATH}.pi) * ( a ) / 20.0 )
		end

	phi (a: INTEGER): REAL_64
		do
			Result := ( {DOUBLE_MATH}.pi * ( a ) / 20.1 )
		end

end
