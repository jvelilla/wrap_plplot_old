note
	description: "Simple line plot and multiple windows demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example2", "src=http://plplot.sourceforge.net/examples.php?demo=01&lbind=C", "protocol=uri"

class
	EXAMPLE_02

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Generates several simple line plots.  Demonstrates:
			--   - subwindow capability
			--   - setting up the window, drawing plot, and labelling
			--   - changing the color
			--   - automatic axis rescaling to exponential notation
			--   - placing the axes in the middle of the box
			--   - gridded coordinate axes
		local
			 digmax, cur_strm, new_strm: INTEGER
			 ver: STRING
			 i: INTEGER
			 l_res: INTEGER
		do

			create x.make_filled (0.0, 1, size)
			create y.make_filled (0.0, 1, size)

			create xs.make_filled (0.0, 1, 6)
			create ys.make_filled (0.0, 1, 6)

			fontset := 1

			--  plplot initialization
			--  Parse and process command line arguments

		    -- l_res := pl_merge_opts( options.to_array, "x01c options", notes )
		    -- l_res := plparseopts (create {ARRAY [STRING]}.make_empty, {PLPLOT_CONSTANTS}.PL_PARSE_FULL | {PLPLOT_CONSTANTS}.PL_PARSE_NOPROGRAM)

			-- Version number
		   create ver.make (80)
		   plgver (ver)
		   print ("PLplot library version: " + ver + "%N")

		   	-- Initialize plplot
			-- Divide page into 2x2 plots
			-- Note: calling plstar replaces separate calls to plssub and plinit
    		plstar( 2, 2 );

    		--  Select font set as per input flag (1,0)
    		--  it should be a BOOL
			if fontset = 1 then
				plfontld (1)
			else
				plfontld (0)
			end


			-- Set up the data
			-- Original case

		    xscale := 6.0
		    yscale := 1.0
		    xoff   := 0.0
		    yoff   := 0.0

			-- Do a plot

		    plot1( 0 )

			-- Set up the data

	    	xscale := 1.0
    		yscale := 0.0014
   			yoff   := 0.0185

   			-- Do a plot
   			digmax := 5
   			plsyax (digmax, 0)
			plot1 (1)

			plot2

			plot3
			finalize

		end


feature --Access

	size: INTEGER = 101
	xscale: REAL_64

	yscale: REAL_64

	xoff: REAL_64

	yoff: REAL_64

	x: ARRAY [REAL_64]
	y: ARRAY [REAL_64]

	xs: ARRAY [REAL_64]
	ys: ARRAY [REAL_64]


feature -- Plotting

	plot1 (a: INTEGER)
		local
				l_array: LIST [STRING]
						xmin, xmax, ymin, ymax: REAL_64
				l_x: REAL_64
				l_y: REAL_64
				l_size: INTEGER
			do
				l_size := 60

				create x.make_filled (0.0, 1, l_size)
				create y.make_filled (0.0, 1, l_size)


					-- prepare data to be plotted.
				across 0|..| (l_size-1)   as ic loop
				   x[ic.item + 1] :=   xoff + xscale * ( ic.item + 1 ) / 60.0
	     	  	   y[ic.item + 1] :=   yoff + yscale * ( x[ic.item + 1].power (2.0))
				end

				xmin := x[1];
			    xmax := x[60];
    			ymin := y[1];
    			ymax := y[60];

				create xs.make_filled (0.0, 1, 6)
				create ys.make_filled (0.0, 1, 6)

				across 0|..| 5   as ic loop
					xs[ic.item + 1] :=   x [ic.item * 10 + 3]
				 	ys[ic.item + 1] :=   y [ic.item * 10 + 3]
				end

				-- Set up the viewport and window using PLENV. The range in X is
				-- 0.0 to 6.0, and the range in Y is 0.0 to 30.0. The axes are
				-- scaled separately (just = 0), and we just draw a labelled
				-- box (axis = 0).

				plcol0 (1)
				plenv (xmin, xmax, ymin, ymax, 0, 0)
				plcol0 (2)
				pllab( "(x)", "(y)", "#frPLplot Example 1 - y=x#u2" )


				-- Plot the data points
				plcol0 (4)
				plpoin (xs, ys, 9)

				-- Draw the line through the data
				plcol0 (3)
				plline( x, y )

				if a = 1 and test_xor = 1 then

				end
			end


	plot2
		local
			i: INTEGER
		do
			create x.make_filled (0.0, 1, size)
			create y.make_filled (0.0, 1, size)

			-- Set up the viewport and window using PLENV. The range in X is -2.0 to
			-- 10.0, and the range in Y is -0.4 to 2.0. The axes are scaled separately
			-- (just = 0), and we draw a box with axes (axis = 1).
			plcol0( 1 );
			plenv( -2.0, 10.0, -0.4, 1.2, 0, 1 );
			plcol0( 2 );
			pllab( "(x)", "sin(x)/x", "#frPLplot Example 1 - Sinc Function" );

			-- Fill up the arrays
			across 0 |..| (size-1) as ic  loop
				x[ic.item + 1] := ( ic.item - 19.0 ) / 6.0;
				y[ic.item + 1] := 1.0
				if x[ic.item + 1] /= 0.0  then
					y[ic.item + 1] := {DOUBLE_MATH}.sine (x[ic.item + 1])/x[ic.item + 1]
				end
			end
			-- Draw the line
			plcol0 (3)
			plwidth (2)
			plline (x, y)
			plwidth (1)
		end


	plot3
		local
			space0: INTEGER
			mark0: INTEGER
			space1: INTEGER
			mark1: INTEGER
		do
			space0 := 0
			mark0 := 0
			space1 := 1500
			mark1 := 1500
			-- For the final graph we wish to override the default tick intervals, and
			-- so do not use plenv().
			pladv (0)

			-- Use standard viewport, and define X range from 0 to 360 degrees, Y range
			-- from -1.2 to 1.2.

		    plvsta;
			plwind( 0.0, 360.0, -1.2, 1.2 );

			-- Draw a box with ticks spaced 60 degrees apart in X, and 0.2 in Y.

		    plcol0( 1 );
		    plbox( "bcnst", 60.0, 2, "bcnstv", 0.2, 2 );

			-- Superimpose a dashed line grid, with 1.5 mm marks and spaces.
			-- plstyl expects a pointer!

		    plstyl( 1, $mark1, $space1 )
		    plcol0( 2 );
		    plbox( "g", 30.0, 0, "g", 0.2, 0 );
		    plstyl( 0, $mark0, $space0 );

		    plcol0( 3 );
		    pllab( "Angle (degrees)", "sine", "#frPLplot Example 1 - Sine function" );

			create x.make_filled (0.0, 1, size)
			create y.make_filled (0.0, 1, size)

			-- prepare data to be plotted.
			across 0|..| (size-1)   as ic loop
			   x[ic.item + 1] :=   3.6 * ic.item
     	  	   y[ic.item + 1] :=  {DOUBLE_MATH}.sine (x[ic.item+1]* {MATH_CONST}.pi / 180.0)
			end

		    plcol0( 4 );
		    plline(x, y );
		end

feature -- Options table

	pl_parse_skip_mode: INTEGER

	locate_mode: INTEGER

	test_xor: INTEGER

	fontset: INTEGER

	font: BOOLEAN

	f_name: detachable STRING


	options: ARRAYED_LIST [PLOPTION_TABLE_API]
		local
			l_opt: PLOPTION_TABLE_API
		once
			create Result.make (6)
			create l_opt.make
			l_opt.set_opt ("pl_parse_skip")
			l_opt.set_var ($pl_parse_skip_mode)
			l_opt.set_mode ({PLPLOT_CONSTANTS}.PL_OPT_BOOL)
			l_opt.set_syntax ("-pl_parse_skip")
			l_opt.set_desc ("Test using PL_PARSE_SKIP mode for plparseopts (this option must precede non-PLplot options)")
			Result.force (l_opt)
				-- Turns on test of API locate function
			create l_opt.make
			l_opt.set_opt ("locate")
			l_opt.set_var ($locate_mode)
			l_opt.set_mode ({PLPLOT_CONSTANTS}.PL_OPT_BOOL)
			l_opt.set_syntax ("-locate")
			l_opt.set_desc ("Turns on test of API locate function")
			Result.force (l_opt)
				-- Turns on test of xor function
			create l_opt.make
			l_opt.set_opt ("xor")
			l_opt.set_var ($test_xor)
			l_opt.set_mode ({PLPLOT_CONSTANTS}.PL_OPT_BOOL)
			l_opt.set_syntax ("-xor")
			l_opt.set_desc ("Turns on test of XOR")
			Result.force (l_opt)
				-- For switching between font set 1 & 2
			create l_opt.make
			l_opt.set_opt ("font")
			l_opt.set_var ($fontset)
			l_opt.set_mode ({PLPLOT_CONSTANTS}.PL_OPT_INT)
			l_opt.set_syntax ("-font number")
			l_opt.set_desc ("Selects stroke font set (0 or 1, def:1)")
			Result.force (l_opt)
				-- For saving in postscript
			create l_opt.make
			l_opt.set_opt ("save")
			l_opt.set_var ($f_name)
			l_opt.set_mode ({PLPLOT_CONSTANTS}.PL_OPT_STRING)
			l_opt.set_syntax ("-save filename")
			l_opt.set_desc ("Save plot in color postscript `file'")
			Result.force (l_opt)

			create l_opt.make
			l_opt.set_mode (0)
			Result.force (l_opt)
		end

	  notes: ARRAY [detachable STRING]
	  	once
	  		create Result.make_filled ({STRING}, 1, 2)
	  		Result.put ("Make sure you get it right!", 1)
	  		Result.put (Void, 2)
	  	end


end
