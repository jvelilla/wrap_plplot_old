note
	description: "Eiffel class representing a matrix of type PLFLT_MATRIX (organized as an Iliffe column vector of pointers to row vectors)."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=Matrix", "src=http://plplot.sourceforge.net/doxygen/html/plmem_8c.html#a828b430c3e2ad50639241a6fb47712d1", "protocol=uri"

class
	PLPLOT_GRID2

create
	make, make_empty, make_by_pointer

feature {NONE} -- Initialization

	make_empty
		do
			rows := 0
			columns := 0
		ensure
			rows_set: rows = 0
			columns_set: columns = 0
			pointer_set: pointer = default_pointer
		end
		
	make (a_rows: INTEGER; a_columns: INTEGER)
		do
			{PLPLOT_FUNCTIONS_API}.c_pl_alloc2d_grid ($pointer, a_rows, a_columns)
			rows := a_rows
			columns := a_columns
		ensure
			rows_set: rows = a_rows
			columns_set: columns = a_columns
			pointer_set: pointer /= default_pointer
		end

	make_by_pointer (a_pointer: POINTER; a_rows: INTEGER; a_columns: INTEGER)
		do
			rows := a_rows
			columns := a_columns
			pointer := a_pointer
		ensure
			rows_set: rows = a_rows
			columns_set: columns = a_columns
			pointer_set: pointer /= default_pointer
		end
feature -- Access

	pointer: POINTER
			-- Location of the storage.

	rows: INTEGER
			-- Size of the grid in x.

	columns: INTEGER
			-- Size of the grid in y.

feature -- Change Element

	put ( a_element: REAL_64; x: INTEGER; y: INTEGER)
		require
			valid_x_index: x>= 0 and then x < rows
			valid_y_index: y>= 0 and then y < columns
			structure_not_void: pointer /= default_pointer
		do
			set_elements_2d_grid (pointer, x, y, a_element)
		end


feature -- Operations

	min_max: TUPLE [fmax: REAL_64; fmin: REAL_64]
			-- Find the maximum and minimum of a 2d matrix allocated.
		require
			structure_not_void: pointer /= default_pointer
		local
			l_min: REAL_64
			l_max: REAL_64
		do
			{PLPLOT_FUNCTIONS_API}.c_pl_min_max2d_grid (pointer, rows, columns,$l_max, $l_min)
			Result := [l_max, l_min]
		end


feature -- Clean

	clean
		do
			{PLPLOT_FUNCTIONS_API}.c_pl_free2d_grid (pointer, rows, columns)
		end

feature -- Access

	item alias "[]" (x: INTEGER; y: INTEGER): REAL_64 assign put
		require
			valid_x_index: x>= 0 and then x < rows
			valid_y_index: y>= 0 and then y < columns
			structure_not_void: pointer /= default_pointer
		do
			Result := access_2dgrid (pointer, x, y)
		end

	base_address: POINTER
		do
			Result := base_access_2dgrid (pointer, 0, 0)
		end

feature {NONE} -- Implementation

	set_elements_2d_grid (a_pointer: POINTER; x: INTEGER; y: INTEGER; element:REAL_64)
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLFLT **)$a_pointer) [$x][$y] = (PLFLT)$element;
		   ]"
		end

	access_2dgrid (a_pointer: POINTER; x: INTEGER; y: INTEGER): REAL_64
		external
			"C inline use <plplot.h>"
		alias
			"[
				return (EIF_REAL_64) ((PLFLT **)$a_pointer)[$x][$y];
			]"
		end

	base_access_2dgrid (a_pointer: POINTER; x: INTEGER; y: INTEGER): POINTER
		external
			"C inline use <plplot.h>"
		alias
			"[
				return  &((PLFLT **)$a_pointer)[$x][$y];
			]"
		end

	print_grid	(a_pointer: POINTER; x: INTEGER; y: INTEGER;)
		external
			"C inline use <plplot.h>"
		alias
			"[
				printf ("Value  [%i][%i]%f\n", $x, $y, ((PLFLT **)$a_pointer)[$x][$y] );
			]"
		end

end
