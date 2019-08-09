#include <ewg_eiffel.h>
#include <ewg_plplot_callback_c_glue_code.h>

#ifdef _MSC_VER
#pragma warning (disable:4715) // Not all control paths return a value
#endif
struct pltransform_callback_entry_struct pltransform_callback_entry = {NULL, NULL};

void pltransform_callback_stub (PLFLT x, PLFLT y, PLFLT_NC_SCALAR xp, PLFLT_NC_SCALAR yp, PLPointer data)
{
	if (pltransform_callback_entry.a_class != NULL && pltransform_callback_entry.feature != NULL)
	{
		pltransform_callback_entry.feature (eif_access(pltransform_callback_entry.a_class), x, y, xp, yp, data);
	}
}

void set_pltransform_callback_entry (void* a_class, void* a_feature)
{
	pltransform_callback_entry.a_class = eif_adopt(a_class);
	pltransform_callback_entry.feature = (pltransform_callback_eiffel_feature) a_feature;
}

void* get_pltransform_callback_stub ()
{
	return (void*) pltransform_callback_stub;
}

void call_pltransform_callback (void *a_function, PLFLT x, PLFLT y, PLFLT_NC_SCALAR xp, PLFLT_NC_SCALAR yp, PLPointer data)
{
	((void (*) (PLFLT x, PLFLT y, PLFLT_NC_SCALAR xp, PLFLT_NC_SCALAR yp, PLPointer data))a_function) (x, y, xp, yp, data);
}

struct plmapform_callback_entry_struct plmapform_callback_entry = {NULL, NULL};

void plmapform_callback_stub (PLINT n, PLFLT_NC_VECTOR x, PLFLT_NC_VECTOR y)
{
	if (plmapform_callback_entry.a_class != NULL && plmapform_callback_entry.feature != NULL)
	{
		plmapform_callback_entry.feature (eif_access(plmapform_callback_entry.a_class), n, x, y);
	}
}

void set_plmapform_callback_entry (void* a_class, void* a_feature)
{
	plmapform_callback_entry.a_class = eif_adopt(a_class);
	plmapform_callback_entry.feature = (plmapform_callback_eiffel_feature) a_feature;
}

void* get_plmapform_callback_stub ()
{
	return (void*) plmapform_callback_stub;
}

void call_plmapform_callback (void *a_function, PLINT n, PLFLT_NC_VECTOR x, PLFLT_NC_VECTOR y)
{
	((void (*) (PLINT n, PLFLT_NC_VECTOR x, PLFLT_NC_VECTOR y))a_function) (n, x, y);
}

struct pldefined_callback_entry_struct pldefined_callback_entry = {NULL, NULL};

PLINT pldefined_callback_stub (PLFLT x, PLFLT y)
{
	if (pldefined_callback_entry.a_class != NULL && pldefined_callback_entry.feature != NULL)
	{
		return pldefined_callback_entry.feature (eif_access(pldefined_callback_entry.a_class), x, y);
	}
}

void set_pldefined_callback_entry (void* a_class, void* a_feature)
{
	pldefined_callback_entry.a_class = eif_adopt(a_class);
	pldefined_callback_entry.feature = (pldefined_callback_eiffel_feature) a_feature;
}

void* get_pldefined_callback_stub ()
{
	return (void*) pldefined_callback_stub;
}

PLINT call_pldefined_callback (void *a_function, PLFLT x, PLFLT y)
{
	return ((PLINT (*) (PLFLT x, PLFLT y))a_function) (x, y);
}

struct plfill_callback_entry_struct plfill_callback_entry = {NULL, NULL};

void plfill_callback_stub (PLINT n, PLFLT_VECTOR x, PLFLT_VECTOR y)
{
	if (plfill_callback_entry.a_class != NULL && plfill_callback_entry.feature != NULL)
	{
		plfill_callback_entry.feature (eif_access(plfill_callback_entry.a_class), n, x, y);
	}
}

void set_plfill_callback_entry (void* a_class, void* a_feature)
{
	plfill_callback_entry.a_class = eif_adopt(a_class);
	plfill_callback_entry.feature = (plfill_callback_eiffel_feature) a_feature;
}

void* get_plfill_callback_stub ()
{
	return (void*) plfill_callback_stub;
}

void call_plfill_callback (void *a_function, PLINT n, PLFLT_VECTOR x, PLFLT_VECTOR y)
{
	((void (*) (PLINT n, PLFLT_VECTOR x, PLFLT_VECTOR y))a_function) (n, x, y);
}

struct pllabel_func_callback_entry_struct pllabel_func_callback_entry = {NULL, NULL};

void pllabel_func_callback_stub (PLINT axis, PLFLT value, PLCHAR_NC_VECTOR label, PLINT length, PLPointer data)
{
	if (pllabel_func_callback_entry.a_class != NULL && pllabel_func_callback_entry.feature != NULL)
	{
		pllabel_func_callback_entry.feature (eif_access(pllabel_func_callback_entry.a_class), axis, value, label, length, data);
	}
}

void set_pllabel_func_callback_entry (void* a_class, void* a_feature)
{
	pllabel_func_callback_entry.a_class = eif_adopt(a_class);
	pllabel_func_callback_entry.feature = (pllabel_func_callback_eiffel_feature) a_feature;
}

void* get_pllabel_func_callback_stub ()
{
	return (void*) pllabel_func_callback_stub;
}

void call_pllabel_func_callback (void *a_function, PLINT axis, PLFLT value, PLCHAR_NC_VECTOR label, PLINT length, PLPointer data)
{
	((void (*) (PLINT axis, PLFLT value, PLCHAR_NC_VECTOR label, PLINT length, PLPointer data))a_function) (axis, value, label, length, data);
}

struct plf2eval_callback_entry_struct plf2eval_callback_entry = {NULL, NULL};

PLFLT plf2eval_callback_stub (PLINT ix, PLINT iy, PLPointer data)
{
	if (plf2eval_callback_entry.a_class != NULL && plf2eval_callback_entry.feature != NULL)
	{
		return plf2eval_callback_entry.feature (eif_access(plf2eval_callback_entry.a_class), ix, iy, data);
	}
}

void set_plf2eval_callback_entry (void* a_class, void* a_feature)
{
	plf2eval_callback_entry.a_class = eif_adopt(a_class);
	plf2eval_callback_entry.feature = (plf2eval_callback_eiffel_feature) a_feature;
}

void* get_plf2eval_callback_stub ()
{
	return (void*) plf2eval_callback_stub;
}

PLFLT call_plf2eval_callback (void *a_function, PLINT ix, PLINT iy, PLPointer data)
{
	return ((PLFLT (*) (PLINT ix, PLINT iy, PLPointer data))a_function) (ix, iy, data);
}

