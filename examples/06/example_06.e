note
	description: "Histogram demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 6", "src=http://plplot.sourceforge.net/examples.php?demo=05&lbind=C", "protocol=uri"
class
	EXAMPLE_06

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Draws a histogram from sample data.
		local
			data: ARRAY [REAL_64]
			delta: REAL_64
		do
			-- Parse and process command line arguments
			--plparseopts (p_argc: POINTER, argv: ARRAY [STRING_8], mode: INTEGER_32)

			-- Initialize plplot
			initialize

			-- Fill up data points
			create data.make_filled (0.0, 1, NPTS)
			delta := 2.0 * {DOUBLE_MATH}.pi / NPTS
			across 0 |..| (NPTS - 1) as i loop
				data[i.item + 1] := {DOUBLE_MATH}.sine( i.item * delta )
			end

		    plcol0( 1 )
    		plhist(data, -1.1, 1.1, 44, 0 )
    		plcol0( 2 )
    		pllab( "#frValue", "#frFrequency",  "#frPLplot Example 5 - Probability function of Oscillator" )
			finalize
		end

	NPTS: INTEGER = 2047
end
