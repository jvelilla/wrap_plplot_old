note
	description: "Demo of multiple stream/window capability (requires Tk or Tcl-DP)."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=Example 15", "src=http://plplot.sourceforge.net/examples.php?demo=14&lbind=C", "protocol=uri"

-- TODO be completed later, since it require TK or TCL-DP driver.
class
	EXAMPLE_15

inherit

	PLPLOT_API

create
	make

feature
	make
		local
			driver: STRING
		do
			initialize
			create driver.make_empty
			plgdev (driver)
		end
end
