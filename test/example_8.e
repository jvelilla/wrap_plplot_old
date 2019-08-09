note
	description: "Font demo."
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_8

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Displays the entire "plsym" symbol (font) set.
		local
			text: STRING
			x, y: REAL_64
			k: INTEGER
		do
			-- Parse and process command line arguments
			-- pl_merge_opts (options: POINTER, name: STRING_8, notes: POINTER)
			-- plparseopts (p_argc: POINTER, argv: ARRAY [STRING_8], mode: INTEGER_32)

			plptex_mode := 1

			-- Initialize PlPlot
			initialize
			plfontld( 0 )

			across 0 |..| 19 as l loop
				if  l.item = 2 then
            		plfontld ( 1 )
            	end
        		pladv ( 0 )

				-- Set up viewport and window

				plcol0 ( 2 )
				plvpor( 0.15, 0.95, 0.1, 0.9 )
				plwind( 0.0, 1.0, 0.0, 1.0 )

 					-- Draw the grid using plbox

				plbox( "bcg", 0.1, 0, "bcg", 0.1, 0 )

					-- Write the digits below the frame

 		       	plcol0( 15 )

 		       	across 0 |..| 9 as i loop
 		       		create text.make (1)
 		       		text.append (i.item.out)
 		       		plmtex( "b", 1.5, ( 0.1 * i.item + 0.05 ), 0.5, text );
 		       	end

 		       	k := 0

				across 0 |..| 9 as i loop
					-- Write the digits to the left of the frame
					create text.make (5)
					text.append ((base[l.item + 1] + 10 * i.item).out)
					plmtex( "lv", 1.0, ( 0.95 - 0.1 * i.item ), 1.0, text );
					across 0 |..| 9 as j loop
						x := 0.1 * j.item + 0.05;
						y := 0.95 - 0.1 * i.item;
							-- Display the symbols
						if plptex_mode = 1 then
							create text.make (10)
							text.append ("#(")
							text.append ((base[l.item + 1] + k).out)
							text.append (")")
							plptex( x, y, 1.0, 0.0, 0.5, text );
						else
							plsym( <<x>>, <<y>>, base[l.item + 1] + k );
						end
						k := k + 1
					end
				end
				if l.item < 2 then
					plmtex( "t", 1.5, 0.5, 0.5, "PLplot Example 7 - PLSYM symbols (compact)" );
				else
					plmtex( "t", 1.5, 0.5, 0.5, "PLplot Example 7 - PLSYM symbols (extended)" );
				end
			end
			finalize

		end


	base: ARRAY [INTEGER]
		do
			Result := <<0, 100, 0, 100, 200, 500, 600, 700, 800, 900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900 >>
		ensure
			is_class: class
		end


	plptex_mode: INTEGER





end
