note
	description: "Plots a simple stripchart with four pens."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 18", "src=http://plplot.sourceforge.net/examples.php?demo=17&lbind=C", "protocol=uri"

class
	EXAMPLE_18

inherit

	PLPLOT_API

	EXCEPTIONS

create

	make

feature -- Initialization

	make
		local
			id1, n, autoy, acc, nsteps: INTEGER
			y1, y2, y3, y4, ymin, ymax, xlab, ylab: REAL_64
			t, tmin, tmax, tjump, dt, noise: REAL_64
			colbox, collab: INTEGER
			colline, styline: ARRAY [INTEGER]
			legline: ARRAY [STRING]
		do
			nsteps := 1000

				--// If db is used the plot is much more smooth. However, because of the
				--// async X behaviour, one does not have a real-time scripcharter.
				--// This is now disabled since it does not significantly improve the
				--// performance on new machines and makes it difficult to use this
				--// example non-interactively since it requires an extra pleop call after
				--// each call to plstripa.
				--//
				--    //plsetopt("db", "");
				--    //plsetopt("np", "");

				--// User sets up plot completely except for window and data
				--// Eventually settings in place when strip chart is created will be
				--// remembered so that multiple strip charts can be used simultaneously.
				--//

				--// Specify some reasonable defaults for ymin and ymax
				--// The plot will grow automatically if needed (but not shrink)

			ymin := -0.1
    		ymax := 0.1

				-- Specify initial tmin and tmax -- this determines length of window.
				-- Also specify maximum jump in t
				-- This can accomodate adaptive timesteps

		    tmin  := 0.0
		    tmax  := 10.0
		    tjump := 0.3        -- percentage of plot to jump

				-- Axes options same as plbox.
				-- Only automatic tick generation and label placement allowed
				-- Eventually I'll make this fancier

		    colbox     := 1
		    collab     := 3

		    create styline.make_filled (0, 1, 4)
		    create colline.make_filled (0, 1, 4)

		    		-- pens color and line style
		    styline[1] := 2
		    styline[2] := 3
		    styline[3] := 4
		    styline[4] := 5

		    colline[1] := 2
		    colline[2] := 3
		    colline[3] := 4
		    colline[4] := 5


					-- pens legend
		    create legline.make_filled ("", 1, 4)
		    legline[1] := "sum"
		    legline[2] := "sin"
		    legline[3] := "sin*noi"
		    legline[4] := "sin+noi"

					-- legend position
			xlab := 0.0
			ylab := 0.25

		    autoy := 1                  -- autoscale y
    		acc   := 1                  -- don't scrip, accumulate

				-- Initialize plplot

    		initialize

		    pladv( 0 )
		    plvsta

				-- Register our error variables with PLplot
				-- From here on, we're handling all errors here

			create errmsg.make (160)
    		plsError( $pl_errcode, errmsg );

		    plstripc( $id1, "bcnst", "bcnstv",
		        tmin, tmax, tjump, ymin, ymax,
		        xlab, ylab,
		        autoy, acc,
		        colbox, collab,
		        colline, styline, legline,
		        "t", "", "Strip chart demo" )

		    if ( pl_errcode /= 0 ) then
				finalize
				raise (errmsg)
		    end

				-- Let plplot handle errors from here on

			plsError( default_pointer, Void )

		    autoy := 0  -- autoscale y
		    acc   := 1  -- accumulate

				-- This is to represent a loop over time
				-- Let's try a random walk process

  			-- y1 = y2 = y3 = y4 = 0.0;
    		dt := 0.1


			across 0 |..| (nsteps - 1) as nc loop

				{EXECUTION_ENVIRONMENT}.sleep (1000000)

	        	t     := (nc.item * dt)
				noise := plrandd - 0.5
	 			y1    := y1 + noise
				y2    := {DOUBLE_MATH}.sine( t * {DOUBLE_MATH}.pi / 18. )
	        	y3    := y2 * noise
	        	y4    := y2 + noise / 3.0

	        		-- There is no need for all pens to have the same number of
	        		-- points or beeing equally time spaced.

		        if ( nc.item \\ 2) /= 0  then
		            plstripa( id1, 0, t, y1 )
		        end
		        if ( nc.item \\ 3) /= 0  then
		            plstripa( id1, 1, t, y2 )
		        end
		        if ( nc.item \\ 4) /= 0  then
		            plstripa( id1, 2, t, y3 )
		        end
		        if ( nc.item \\ 5) /= 0  then
		            plstripa( id1, 3, t, y4 );
				end
			end
			-- needed if using double buffering (-db on command line)
			-- pleop();

   			plstripd( id1 )
			finalize

		end

feature -- Error report

	pl_errcode: INTEGER
			-- Error code.

	errmsg: STRING
			-- Error msg.


end
