note
	description: "Font demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=example 6", "src=http://plplot.sourceforge.net/examples.php?demo=06&lbind=", "protocol=uri"

class
	EXAMPLE_7

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Displays the entire "plpoin" symbol (font) set.
		local
			text: STRING
			k, maxfont: INTEGER
			x, y: REAL_64
		do
			-- Parse and process command line arguments
			--	plparseopts (p_argc: POINTER, argv: ARRAY [STRING_8], mode: INTEGER_32)

			-- Initialize plplot
			initialize

			across 0 |..| 1 as  ic loop
				plfont (ic.item)
				if ic.item = 0 then
					maxfont := 1
				else
					maxfont := 4
				end
				across 0 |..| (maxfont - 1) as f loop
					plfont (f.item + 1)
					pladv (0)

					-- Set up viewport and window
		            plcol0( 2 );
        		    plvpor( 0.1, 1.0, 0.1, 0.9 )
					plwind( 0.0, 1.0, 0.0, 1.3 )

					-- Draw the grid using plbox
			        plbox( "bcg", 0.1, 0, "bcg", 0.1, 0 )

					--	Write the digits below the frame
					plcol0 (15)
					across 0 |..| 9 as i loop
						create text.make (10)
						text.append (i.item.out)
						plmtex( "b", 1.5, ( 0.1 * i.item + 0.05 ), 0.5, text )
					end
					k := 0
					across 0 |..| 12 as i loop
						-- Write the digits to the left of the frame	
						create text.make (10)
						text.append ((10*i.item).out)
						plmtex( "lv", 1.0, ( 1.0 - ( 2 * i.item + 1 ) / 26.0 ), 1.0, text )
						across 0 |..| 9 as j loop
							x := 0.1 * j.item + 0.05;
							y := 1.25 - 0.1 * i.item;

						-- Display the symbols (plpoin expects that x and y are arrays so
                    	-- pass pointers)
                    		if k < 128 then
                    			plpoin( <<x>>, <<y>>, k )
                    		end
                    		k := k + 1
						end
					end

					if ic.item  = 0then
						plmtex( "t", 1.5, 0.5, 0.5, "PLplot Example 6 - plpoin symbols (compact)" )
					else
						plmtex( "t", 1.5, 0.5, 0.5, "PLplot Example 6 - plpoin symbols (extended)" )
					end
				end
			end
			finalize
		end

end
