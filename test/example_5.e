note
	description: "Log plot demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 5", "src=http://plplot.sourceforge.net/examples.php?demo=04&lbind=C","protocol=uri"
class
	EXAMPLE_5

inherit

	PLPLOT_API

create
	make

feature --Initialization

	make
			-- Illustration of logarithmic axes, and redefinition of window.
		do
			-- Parse and process command line arguments
			-- Initialize plplot

		    initialize
    		plfont( 2 )

			-- Make log plots using two different styles.

		    plot1( 0 )
    		plot1( 1 )
    		finalize
		end

feature -- Plotting

	plot1 (a_type: INTEGER)
			-- Log-linear plot.
		local
			freq1: ARRAY [REAL_64]
			ampl: ARRAY [REAL_64]
			phase: ARRAY [REAL_64]
			i: INTEGER
			f0, freq: REAL_64
			nlegend: INTEGER
			text: ARRAY [STRING]
			symbols: ARRAY [STRING]
			opt_array: ARRAY [INTEGER]
			text_colors: ARRAY [INTEGER]
			line_colors: ARRAY [INTEGER]
			line_styles: ARRAY [INTEGER]
			line_widths: ARRAY [REAL_64]
			symbol_numbers, symbol_colors: ARRAY [INTEGER]
			symbol_scales: ARRAY [REAL_64]
			legend_width, legend_height: REAL_64

		do
			create freq1.make_filled (0.0, 1, 101)
			create ampl.make_filled (0.0, 1, 101)
			create phase.make_filled (0.0, 1, 101)

			pladv( 0 );

				-- Set up data for log plot
			f0 := 1.0
			across 0 |..| 100 as ic  loop
				freq1 [ic.item + 1] := -2.0 + ic.item / 20.0
				freq := (10.0^ freq1[ic.item + 1] )
				ampl[ic.item + 1]  := 20.0 * {DOUBLE_MATH}.log10( 1.0 / {DOUBLE_MATH}.sqrt( 1.0 + ( freq / f0 )^ 2.0 ) )
				phase[ic.item + 1] := -( 180.0 / {DOUBLE_MATH}.pi ) * {DOUBLE_MATH}.arc_tangent( freq / f0 )
			end

			plvpor( 0.15, 0.85, 0.1, 0.9 );
			plwind( -2.0, 3.0, -80.0, 0.0 );

				-- Try different axis and labelling styles.

    		plcol0( 1 )
    		inspect a_type
    		when 0 then
    			plbox( "bclnst", 0.0, 0, "bnstv", 0.0, 0 )
    		when 1 then
    			plbox( "bcfghlnst", 0.0, 0, "bcghnstv", 0.0, 0 )
    		end

				-- Plot ampl vs freq

    		plcol0( 2 )
    		plline(freq1, ampl )
    		plcol0( 2 )
    		plptex( 1.6, -30.0, 1.0, -20.0, 0.5, "-20 dB/decade" )

				-- Put labels on
		    plcol0( 1 )
		    plmtex( "b", 3.2, 0.5, 0.5, "Frequency" )
		    plmtex( "t", 2.0, 0.5, 0.5, "Single Pole Low-Pass Filter" )
		    plcol0( 2 )
		    plmtex( "l", 5.0, 0.5, 0.5, "Amplitude (dB)" )
		    nlegend := 1

				-- For the gridless case, put phase vs freq on same plot

		    if  a_type = 0 then
				plcol0( 1 )
		        plwind( -2.0, 3.0, -100.0, 0.0 )
		        plbox( "", 0.0, 0, "cmstv", 30.0, 3 )
		        plcol0( 3 )
		        plline( freq1, phase );
		        plstring(freq1, phase, "#(728)" )
		        plcol0( 3 )
		        plmtex( "r", 5.0, 0.5, 0.5, "Phase shift (degrees)" )
		        nlegend := 2
		    end

			create opt_array.make_filled (0, 1, 2)
			create text_colors.make_filled (0, 1, 2)
			create text.make_filled ("", 1, 2)
			create line_styles.make_filled (0, 1, 2)
			create line_widths.make_filled (0.0, 1, 2)
			create line_colors.make_filled (0, 1, 2)
			create symbols.make_filled ("", 1, 2)
			create symbol_colors.make_filled (0, 1, 2)
			create symbol_numbers.make_filled (0, 1, 2)
			create symbol_scales.make_filled (0, 1, 2)

				-- Draw a legend
				-- First legend entry.

			opt_array [1] := {PLPLOT_CONSTANTS}.PL_LEGEND_LINE
			text_colors [1] := 2
			text [1] := "Amplitude"
			line_colors [1] := 2
			line_styles [1] := 1
			line_widths [1] := 1.0

				-- note from the above opt_array the first symbol (and box) indices
				-- do not have to be specified, at least in C. For Fortran we need
				-- to set the symbols to be something, since the string is always
				-- copied as part of the bindings.

				--    Second legend entry.
			opt_array[2] := {PLPLOT_CONSTANTS}.PL_LEGEND_LINE | {PLPLOT_CONSTANTS}.PL_LEGEND_SYMBOL
			text_colors[2] := 3
			text[2] := "Phase shift"
			line_colors[2] := 3
			line_styles[2] := 1
			line_widths[2] := 1.0
			symbol_colors[2] := 3
			symbol_scales[2]  := 1.0
			symbol_numbers[2] := 4
			symbols[2] := "#(728)"

				-- from the above opt_arrays we can completely ignore everything
				-- to do with boxes.

			plscol0a( 15, 32, 32, 32, 0.70 )
		    pllegend (  $legend_width,
		    			$legend_height,
		    			{PLPLOT_CONSTANTS}.PL_LEGEND_BACKGROUND | {PLPLOT_CONSTANTS}.PL_LEGEND_BOUNDING_BOX,
		    			0,
		    			0.0,
		    			0.0,
		    			0.1,
		    			15,
		    			1,
		    			1,
		    			0,
		    			0,
		    			nlegend,
		    			opt_array,
		    			1.0,
		    			1.0,
		    			2.0,
		    			1.0,
		    			text_colors,
		    			text,
		    			default_pointer,
		    			default_pointer,
		    			default_pointer,
		    			default_pointer,
		    			line_colors,
		    			line_styles,
		    			line_widths,
		        		symbol_colors,
		        		symbol_scales,
		        		symbol_numbers,
		        		symbols )

		end
end
