note

	description: "This file has been generated by EWG. Do not edit. Changes will be lost!"

	generator: "Eiffel Wrapper Generator"
-- functions wrapper
class EWG_PLPLOT_CALLBACK_C_GLUE_CODE_FUNCTIONS_API


feature -- Access

	get_pltransform_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_pltransform_callback_stub ();
			]"
		end

	set_pltransform_callback_entry (a_class: PLTRANSFORM_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_pltransform_callback_entry (a_class, a_feature)
		end

	call_pltransform_callback (a_function: POINTER; x: REAL_64; y: REAL_64; xp: POINTER; yp: POINTER; data: POINTER) 
		do
			c_call_pltransform_callback (a_function, x, y, xp, yp, data)
		end

	get_plmapform_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_plmapform_callback_stub ();
			]"
		end

	set_plmapform_callback_entry (a_class: PLMAPFORM_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_plmapform_callback_entry (a_class, a_feature)
		end

	call_plmapform_callback (a_function: POINTER; n: INTEGER; x: POINTER; y: POINTER) 
		do
			c_call_plmapform_callback (a_function, n, x, y)
		end

	get_pldefined_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_pldefined_callback_stub ();
			]"
		end

	set_pldefined_callback_entry (a_class: PLDEFINED_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_pldefined_callback_entry (a_class, a_feature)
		end

	call_pldefined_callback (a_function: POINTER; x: REAL_64; y: REAL_64): INTEGER 
		do
			Result := c_call_pldefined_callback (a_function, x, y)
		end

	get_plfill_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_plfill_callback_stub ();
			]"
		end

	set_plfill_callback_entry (a_class: PLFILL_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_plfill_callback_entry (a_class, a_feature)
		end

	call_plfill_callback (a_function: POINTER; n: INTEGER; x: POINTER; y: POINTER) 
		do
			c_call_plfill_callback (a_function, n, x, y)
		end

	get_pllabel_func_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_pllabel_func_callback_stub ();
			]"
		end

	set_pllabel_func_callback_entry (a_class: PLLABEL_FUNC_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_pllabel_func_callback_entry (a_class, a_feature)
		end

	call_pllabel_func_callback (a_function: POINTER; axis: INTEGER; value: REAL_64; label: STRING; length: INTEGER; data: POINTER) 
		do
			c_call_pllabel_func_callback (a_function, axis, value,  (create {C_STRING}.make (label)).item, length, data)
		end

	get_plf2eval_callback_stub: POINTER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return get_plf2eval_callback_stub ();
			]"
		end

	set_plf2eval_callback_entry (a_class: PLF2EVAL_CALLBACK_DISPATCHER; a_feature: POINTER) 
		do
			c_set_plf2eval_callback_entry (a_class, a_feature)
		end

	call_plf2eval_callback (a_function: POINTER; ix: INTEGER; iy: INTEGER; data: POINTER): REAL_64 
		do
			Result := c_call_plf2eval_callback (a_function, ix, iy, data)
		end

feature -- Externals

	c_set_pltransform_callback_entry (a_class: PLTRANSFORM_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_pltransform_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_pltransform_callback (a_function: POINTER; x: REAL_64; y: REAL_64; xp: POINTER; yp: POINTER; data: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				call_pltransform_callback ((void*)$a_function, (PLFLT)$x, (PLFLT)$y, (PLFLT_NC_SCALAR)$xp, (PLFLT_NC_SCALAR)$yp, (PLPointer)$data);
			]"
		end

	c_set_plmapform_callback_entry (a_class: PLMAPFORM_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_plmapform_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_plmapform_callback (a_function: POINTER; n: INTEGER; x: POINTER; y: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				call_plmapform_callback ((void*)$a_function, (PLINT)$n, (PLFLT_NC_VECTOR)$x, (PLFLT_NC_VECTOR)$y);
			]"
		end

	c_set_pldefined_callback_entry (a_class: PLDEFINED_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_pldefined_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_pldefined_callback (a_function: POINTER; x: REAL_64; y: REAL_64): INTEGER
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return call_pldefined_callback ((void*)$a_function, (PLFLT)$x, (PLFLT)$y);
			]"
		end

	c_set_plfill_callback_entry (a_class: PLFILL_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_plfill_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_plfill_callback (a_function: POINTER; n: INTEGER; x: POINTER; y: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				call_plfill_callback ((void*)$a_function, (PLINT)$n, (PLFLT_VECTOR)$x, (PLFLT_VECTOR)$y);
			]"
		end

	c_set_pllabel_func_callback_entry (a_class: PLLABEL_FUNC_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_pllabel_func_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_pllabel_func_callback (a_function: POINTER; axis: INTEGER; value: REAL_64; label: POINTER; length: INTEGER; data: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				call_pllabel_func_callback ((void*)$a_function, (PLINT)$axis, (PLFLT)$value, (PLCHAR_NC_VECTOR)$label, (PLINT)$length, (PLPointer)$data);
			]"
		end

	c_set_plf2eval_callback_entry (a_class: PLF2EVAL_CALLBACK_DISPATCHER; a_feature: POINTER)
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				set_plf2eval_callback_entry ((void*)$a_class, (void*)$a_feature);
			]"
		end

	c_call_plf2eval_callback (a_function: POINTER; ix: INTEGER; iy: INTEGER; data: POINTER): REAL_64
		external
			"C inline use <ewg_plplot_callback_c_glue_code.h>"
		alias
			"[
				return call_plf2eval_callback ((void*)$a_function, (PLINT)$ix, (PLINT)$iy, (PLPointer)$data);
			]"
		end

feature -- Externals Address

end
