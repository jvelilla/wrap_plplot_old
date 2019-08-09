note
	description: "Simple demo of a 2D line plot."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=Example 1", "src=http://plplot.sourceforge.net/examples.php?demo=00&lbind=C", "protocol=uri"

class
	EXAMPLE_1

inherit

	PLPLOT_API

create
	make

feature {NONE} -- Initialization

	make
		local
			l_array: LIST [STRING]
			size: INTEGER
			x: ARRAY [REAL_64]
			y: ARRAY [REAL_64]
			xmin, xmax, ymin, ymax: REAL_64
			l_x: REAL_64
			l_y: REAL_64
		do
			size := 101
			xmin := 0.0
			xmax := 1.0
			ymin := 0.0
			ymax := 100.0

			create x.make_filled (0.0, 1, size)
			create y.make_filled (0.0, 1, size)

				-- prepare data to be plotted.

			across 0|..| (size-1)   as ic loop
			   x[ic.item + 1] := (ic.item.to_real)  / ( size - 1 ).to_real
     	  	   y[ic.item + 1] := (ymax * x[ic.item + 1] * x[ic.item + 1]);
			end

			create {ARRAYED_LIST [STRING]} l_array.make (1)
			l_array.force ("test")
				-- parse and process command line arguments.
--			plparseopts (l_array, PL_PARSE_FULL)

				-- initialize Plplot
			initialize

				-- Create a labelled box to hold the plot.
			plenv (xmin, xmax, ymin, ymax, 0, 0)
			pllab ("x", "y=100 x#u2#d", "Simple PLplot demo of a 2D line plot")

			plline (x, y)

			finalize
			io.read_line
		end

end
