note
	description: "Summary description for {STRETCH_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRETCH_DATA

inherit

	MEMORY_STRUCTURE


create
	make, make_by_pointer


feature -- Access


  	xmin: REAL_64
  	xmax: REAL_64
  	ymin: REAL_64
    ymax: REAL_64
    stretch: REAL_64

feature -- Change element

	set_xmin (a_value: like xmin)
		do
			xmin := a_value
		ensure
			xmin_set: xmin = a_value
		end

	set_xmax (a_value: like xmax)
		do
			xmax := a_value
		ensure
			xmax_set: xmax = a_value
		end

	set_ymin (a_value: like ymin)
		do
			ymin := a_value
		ensure
			ymin_set: ymin = a_value
		end

	set_ymax (a_value: like ymax)
		do
			ymax := a_value
		ensure
			ymax_set: ymax = a_value
		end

	set_stretch (a_value: like stretch)
		do
			stretch := a_value
		ensure
			stretch_set: stretch = a_value
		end


feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes).
		do
			Result := {PLATFORM}.real_64_bytes * 5
		end


end
