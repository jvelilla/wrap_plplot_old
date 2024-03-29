note

	description: "This file has been generated by EWG. Do not edit. Changes will be lost!"

	generator: "Eiffel Wrapper Generator"

class PLTRANSFORM_CALLBACK_DISPATCHER

inherit

	EWG_PLPLOT_CALLBACK_C_GLUE_CODE_FUNCTIONS_API
		export {NONE} all end
create
	make

feature -- Initialization

	make (a_routine: like routine) 
				-- Dispatcher initialization
		do
			routine := a_routine
			set_pltransform_callback_entry (Current, $on_callback)
		end

feature --Access: Routine 

	routine: PROCEDURE [TUPLE [a_x: REAL_64; a_y: REAL_64; a_xp: POINTER; a_yp: POINTER; a_data: POINTER]]  
			--Eiffel routine to be call on callback.

feature --Access: Dispatcher

	c_dispatcher: POINTER 
		do
			Result := get_pltransform_callback_stub
		end

feature --Access: Callback

	on_callback (a_x: REAL_64; a_y: REAL_64; a_xp: POINTER; a_yp: POINTER; a_data: POINTER)  
		do
			routine (a_x, a_y, a_xp, a_yp, a_data)
		end

end
