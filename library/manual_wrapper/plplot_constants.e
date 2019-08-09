note
	description: "{PLPLOT_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	PLPLOT_CONSTANTS


feature -- Access: Global mode settings These override per-option settings

	PL_PARSE_PARTIAL: INTEGER
			-- For backward compatibility.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_PARTIAL"
		end

	PL_PARSE_FULL: INTEGER
			-- Process fully & exit if error.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_FULL"
		end

	PL_PARSE_QUIET: INTEGER
			-- Don't issue messages.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_QUIET"
		end

	PL_PARSE_NODELETE: INTEGER
			-- Don't delete options after processing.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_NODELETE"
		end

	PL_PARSE_SHOWALL: INTEGER
			-- Show invisible options.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_SHOWALL"
		end

	PL_PARSE_NOPROGRAM: INTEGER
			-- Program name NOT in *argv[0].
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_NOPROGRAM"
		end

	PL_PARSE_NODASH: INTEGER
			-- Set if leading dash NOT required.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_NODASH"
		end

	PL_PARSE_SKIP: INTEGER
			-- Skip over unrecognized args.
		external
			"C inline use <plplot.h>"
		alias
			"PL_PARSE_SKIP"
		end


feature -- Access: Option table & support constants

	PL_OPT_ARG: INTEGER
			-- Option has an argument.
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_ARG"
		end

	PL_OPT_NODELETE: INTEGER
			-- Don't delete after processing.
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_NODELETE"
		end

	PL_OPT_INVISIBLE: INTEGER
			-- Make invisible.
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_INVISIBLE"
		end


	PL_OPT_DISABLED: INTEGER
			-- Processing is disabled.
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_INVISIBLE"
		end


feature -- Access :Option-processing settings -- mutually exclusive

	PL_OPT_FUNC: INTEGER
			-- Call handler function
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_FUNC"
		end

	PL_OPT_BOOL: INTEGER
			-- Set *var = atoi(optarg)
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_BOOL"
		end

	PL_OPT_INT: INTEGER
			-- Set *var = 1
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_INT"
		end

	PL_OPT_FLOAT: INTEGER
			-- Set *var = atof(optarg)
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_FLOAT"
		end

	PL_OPT_STRING: INTEGER
			-- Set var = optarg
		external
			"C inline use <plplot.h>"
		alias
			"PL_OPT_STRING"
		end

feature -- Access: Flags for pllegend.

	PL_LEGEND_NULL: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_NULL"
		end

	PL_LEGEND_NONE: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_NONE"
		end

	PL_LEGEND_COLOR_BOX: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_COLOR_BOX"
		end

	PL_LEGEND_LINE: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_LINE"
		end

	PL_LEGEND_SYMBOL: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_SYMBOL"
		end

	PL_LEGEND_TEXT_LEFT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_TEXT_LEFT"
		end

	PL_LEGEND_BACKGROUND: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_BACKGROUND"
		end

	PL_LEGEND_BOUNDING_BOX: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_BOUNDING_BOX"
		end

	PL_LEGEND_ROW_MAJOR: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_LEGEND_ROW_MAJOR"
		end

feature -- opt argument in plot3dc() and plsurf3d()		

	MAG_COLOR: INTEGER
			-- draw the mesh with a color dependent of the magnitude
		external
			"C inline use <plplot.h>"
		alias
			"MAG_COLOR"
		end

	DRAW_LINEX: INTEGER
			-- draw lines parallel to the X axis
		external
			"C inline use <plplot.h>"
		alias
			"DRAW_LINEX"
		end

	DRAW_LINEY: INTEGER
			-- draw lines parallel to the Y axis
		external
			"C inline use <plplot.h>"
		alias
			"DRAW_LINEY"
		end

	DRAW_LINEXY: INTEGER
			-- draw lines parallel to both the X and Y axis.
		external
			"C inline use <plplot.h>"
		alias
			"DRAW_LINEXY"
		end

	BASE_CONT: INTEGER
			-- draw contour plot at bottom xy plane.
		external
			"C inline use <plplot.h>"
		alias
			"BASE_CONT"
		end

	TOP_CONT: INTEGER
			-- draw contour plot at top xy plane.
		external
			"C inline use <plplot.h>"
		alias
			"TOP_CONT"
		end

	SURF_CONT: INTEGER
			-- draw contour plot at surface.
		external
			"C inline use <plplot.h>"
		alias
			"SURF_CONT"
		end

	DRAW_SIDES: INTEGER
			-- draw sides.
		external
			"C inline use <plplot.h>"
		alias
			"DRAW_SIDES"
		end

	FACETED: INTEGER
			-- draw outline for each square that makes up the surface.
		external
			"C inline use <plplot.h>"
		alias
			"FACETED"
		end

	MESH: INTEGER
			-- draw mes.
		external
			"C inline use <plplot.h>"
		alias
			"MESH"
		end

feature -- Flags for plcolorbar

	PL_COLORBAR_NULL: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_NULL"
		end

	PL_COLORBAR_LABEL_LEFT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_LABEL_LEFT"
		end

	PL_COLORBAR_LABEL_RIGHT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_LABEL_RIGHT"
		end

	PL_COLORBAR_LABEL_TOP: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_LABEL_TOP"
		end

	PL_COLORBAR_LABEL_BOTTOM: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_LABEL_BOTTOM"
		end

	PL_COLORBAR_IMAGE: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_IMAGE"
		end

	PL_COLORBAR_SHADE: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_SHADE"
		end

	PL_COLORBAR_GRADIENT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_GRADIENT"
		end

	PL_COLORBAR_CAP_NONE: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_CAP_NONE"
		end

	PL_COLORBAR_CAP_LOW: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_CAP_LOW"
		end

	PL_COLORBAR_CAP_HIGH: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_CAP_HIGH"
		end

	PL_COLORBAR_SHADE_LABEL: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_SHADE_LABEL"
		end

	PL_COLORBAR_ORIENT_RIGHT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_ORIENT_RIGHT"
		end

	PL_COLORBAR_ORIENT_TOP: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_ORIENT_TOP"
		end

	PL_COLORBAR_ORIENT_LEFT: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_ORIENT_LEFT"
		end

	PL_COLORBAR_ORIENT_BOTTOM: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_ORIENT_BOTTOM"
		end

	PL_COLORBAR_BACKGROUND: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_BACKGROUND"
		end

	PL_COLORBAR_BOUNDING_BOX: INTEGER
		external
			"C inline use <plplot.h>"
		alias
			"PL_COLORBAR_BOUNDING_BOX"
		end



feature -- Axis label tags

	PL_X_AXIS: INTEGER
			-- The x-axis.
		external
			"C inline use <plplot.h>"
		alias
			"PL_X_AXIS"
		end

	PL_Y_AXIS: INTEGER
			-- The y-axis.
		external
			"C inline use <plplot.h>"
		alias
			"PL_Y_AXIS"
		end

	PL_Z_AXIS: INTEGER
			-- The z-axis.
		external
			"C inline use <plplot.h>"
		alias
			"PL_Z_AXIS"
		end

end
