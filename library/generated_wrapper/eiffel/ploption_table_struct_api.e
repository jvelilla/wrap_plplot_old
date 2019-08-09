note

	description: "This file has been generated by EWG. Do not edit. Changes will be lost!"

	generator: "Eiffel Wrapper Generator"

class PLOPTION_TABLE_STRUCT_API

inherit

	MEMORY_STRUCTURE

	
create

	make,
	make_by_pointer

feature -- Measurement

	structure_size: INTEGER 
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	opt: STRING
			-- Access member `opt`
		require
			exists: exists
		do
			Result := (create {C_STRING}.make_by_pointer (c_opt (item))).string
		ensure
			result_correct: Result.same_string ((create {C_STRING}.make_by_pointer (c_opt (item))).string)
		end

	set_opt (a_value: STRING) 
			-- Change the value of member `opt` to `a_value`.
		require
			exists: exists
		do
			set_c_opt (item, (create {C_STRING}.make (a_value)).item )
		end

	handler: detachable FUNCTION [TUPLE [STRING, STRING, POINTER], INTEGER]
			-- Access member `handler`
		require
			exists: exists
		do
			if attached dispatcher_table_handler as l_op then
				if c_handler (item).is_equal (l_op.ptr) then
					Result :=l_op.callback
				end
			end
		end

	set_handler (a_value: FUNCTION [TUPLE [STRING, STRING, POINTER], INTEGER]) 
			-- Change the value of member `handler` to `a_value`.
		require
			exists: exists
		do
			dispatcher_table_handler := [a_value, $a_value]
			set_c_handler (item, $a_value)
		end

	dispatcher_table_handler: detachable TUPLE [callback:FUNCTION [TUPLE [STRING, STRING, POINTER], INTEGER]; ptr: TYPED_POINTER [FUNCTION [TUPLE [STRING, STRING, POINTER], INTEGER]]]
		 -- callback register table for member `handler`

	client_data: POINTER
			-- Access member `client_data`
		require
			exists: exists
		do
			Result := c_client_data (item)
		ensure
			result_correct: Result = c_client_data (item)
		end

	set_client_data (a_value: POINTER) 
			-- Change the value of member `client_data` to `a_value`.
		require
			exists: exists
		do
			set_c_client_data (item, a_value)
		ensure
			client_data_set: a_value = client_data
		end

	var: POINTER
			-- Access member `var`
		require
			exists: exists
		do
			Result := c_var (item)
		ensure
			result_correct: Result = c_var (item)
		end

	set_var (a_value: POINTER) 
			-- Change the value of member `var` to `a_value`.
		require
			exists: exists
		do
			set_c_var (item, a_value)
		ensure
			var_set: a_value = var
		end

	mode: INTEGER
			-- Access member `mode`
		require
			exists: exists
		do
			Result := c_mode (item)
		ensure
			result_correct: Result = c_mode (item)
		end

	set_mode (a_value: INTEGER) 
			-- Change the value of member `mode` to `a_value`.
		require
			exists: exists
		do
			set_c_mode (item, a_value)
		ensure
			mode_set: a_value = mode
		end

	syntax: STRING
			-- Access member `syntax`
		require
			exists: exists
		do
			Result := (create {C_STRING}.make_by_pointer (c_syntax (item))).string
		ensure
			result_correct: Result.same_string ((create {C_STRING}.make_by_pointer (c_syntax (item))).string)
		end

	set_syntax (a_value: STRING) 
			-- Change the value of member `syntax` to `a_value`.
		require
			exists: exists
		do
			set_c_syntax (item, (create {C_STRING}.make (a_value)).item )
		end

	desc: STRING
			-- Access member `desc`
		require
			exists: exists
		do
			Result := (create {C_STRING}.make_by_pointer (c_desc (item))).string
		ensure
			result_correct: Result.same_string ((create {C_STRING}.make_by_pointer (c_desc (item))).string)
		end

	set_desc (a_value: STRING) 
			-- Change the value of member `desc` to `a_value`.
		require
			exists: exists
		do
			set_c_desc (item, (create {C_STRING}.make (a_value)).item )
		end

feature {NONE} -- Implementation wrapper for struct PLOptionTable

	sizeof_external: INTEGER 
		external
			"C inline use <plplot.h>"
		alias
			"sizeof(PLOptionTable)"
		end

	c_opt (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->opt
			]"
		end

	set_c_opt (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->opt =  (PLCHAR_VECTOR)$a_value
			]"
		ensure
			opt_set: a_value = c_opt (an_item)
		end

	c_handler (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->handler
			]"
		end

	set_c_handler (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->handler =  (int (*) (PLCHAR_VECTOR anonymous_1, PLCHAR_VECTOR anonymous_2, PLPointer anonymous_3))$a_value
			]"
		ensure
			handler_set: a_value = c_handler (an_item)
		end

	c_client_data (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->client_data
			]"
		end

	set_c_client_data (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->client_data =  (PLPointer)$a_value
			]"
		ensure
			client_data_set: a_value = c_client_data (an_item)
		end

	c_var (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->var
			]"
		end

	set_c_var (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->var =  (PLPointer)$a_value
			]"
		ensure
			var_set: a_value = c_var (an_item)
		end

	c_mode (an_item: POINTER): INTEGER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->mode
			]"
		end

	set_c_mode (an_item: POINTER; a_value: INTEGER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->mode =  (long)$a_value
			]"
		ensure
			mode_set: a_value = c_mode (an_item)
		end

	c_syntax (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->syntax
			]"
		end

	set_c_syntax (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->syntax =  (PLCHAR_VECTOR)$a_value
			]"
		ensure
			syntax_set: a_value = c_syntax (an_item)
		end

	c_desc (an_item: POINTER): POINTER
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->desc
			]"
		end

	set_c_desc (an_item: POINTER; a_value: POINTER) 
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C inline use <plplot.h>"
		alias
			"[
				((PLOptionTable*)$an_item)->desc =  (PLCHAR_VECTOR)$a_value
			]"
		ensure
			desc_set: a_value = c_desc (an_item)
		end

end
