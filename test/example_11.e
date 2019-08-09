note
	description: "Window positioning demo."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name= Example 11", "src=http://plplot.sourceforge.net/examples.php?demo=10&lbind=C", "protocol=uri"

class
	EXAMPLE_11

inherit

	PLPLOT_API

create
	make

feature -- Initialization

	make
			-- Demonstrates absolute positioning of graphs on a page.
		do
				-- Initialize plplot

		    initialize

		    pladv( 0 )
			plvpor( 0.0, 1.0, 0.0, 1.0 )
		    plwind( 0.0, 1.0, 0.0, 1.0 )
		    plbox( "bc", 0.0, 0, "bc", 0.0, 0 )

		    plsvpa( 50.0, 150.0, 50.0, 100.0 )
		    plwind( 0.0, 1.0, 0.0, 1.0 )
		    plbox( "bc", 0.0, 0, "bc", 0.0, 0 )
		    plptex( 0.5, 0.5, 1.0, 0.0, 0.5, "BOX at (50,150,50,100)" )
		    finalize
		end

end
