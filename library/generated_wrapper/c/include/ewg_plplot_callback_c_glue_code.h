#ifndef EWG_CALLBACK_PLPLOT___
#define EWG_CALLBACK_PLPLOT___

#include <plplot.h>

typedef void (*pltransform_callback_eiffel_feature) (void *a_class, PLFLT x, PLFLT y, PLFLT_NC_SCALAR xp, PLFLT_NC_SCALAR yp, PLPointer data);

void* get_pltransform_callback_stub ();

struct pltransform_callback_entry_struct
{
	void* a_class;
	pltransform_callback_eiffel_feature feature;
};

void set_pltransform_callback_entry (void* a_class, void* a_feature);

void call_pltransform_callback (void *a_function, PLFLT x, PLFLT y, PLFLT_NC_SCALAR xp, PLFLT_NC_SCALAR yp, PLPointer data);


#include <plplot.h>

typedef void (*plmapform_callback_eiffel_feature) (void *a_class, PLINT n, PLFLT_NC_VECTOR x, PLFLT_NC_VECTOR y);

void* get_plmapform_callback_stub ();

struct plmapform_callback_entry_struct
{
	void* a_class;
	plmapform_callback_eiffel_feature feature;
};

void set_plmapform_callback_entry (void* a_class, void* a_feature);

void call_plmapform_callback (void *a_function, PLINT n, PLFLT_NC_VECTOR x, PLFLT_NC_VECTOR y);


#include <plplot.h>

typedef PLINT (*pldefined_callback_eiffel_feature) (void *a_class, PLFLT x, PLFLT y);

void* get_pldefined_callback_stub ();

struct pldefined_callback_entry_struct
{
	void* a_class;
	pldefined_callback_eiffel_feature feature;
};

void set_pldefined_callback_entry (void* a_class, void* a_feature);

PLINT call_pldefined_callback (void *a_function, PLFLT x, PLFLT y);


#include <plplot.h>

typedef void (*plfill_callback_eiffel_feature) (void *a_class, PLINT n, PLFLT_VECTOR x, PLFLT_VECTOR y);

void* get_plfill_callback_stub ();

struct plfill_callback_entry_struct
{
	void* a_class;
	plfill_callback_eiffel_feature feature;
};

void set_plfill_callback_entry (void* a_class, void* a_feature);

void call_plfill_callback (void *a_function, PLINT n, PLFLT_VECTOR x, PLFLT_VECTOR y);


#include <plplot.h>

typedef void (*pllabel_func_callback_eiffel_feature) (void *a_class, PLINT axis, PLFLT value, PLCHAR_NC_VECTOR label, PLINT length, PLPointer data);

void* get_pllabel_func_callback_stub ();

struct pllabel_func_callback_entry_struct
{
	void* a_class;
	pllabel_func_callback_eiffel_feature feature;
};

void set_pllabel_func_callback_entry (void* a_class, void* a_feature);

void call_pllabel_func_callback (void *a_function, PLINT axis, PLFLT value, PLCHAR_NC_VECTOR label, PLINT length, PLPointer data);


#include <plplot.h>

typedef PLFLT (*plf2eval_callback_eiffel_feature) (void *a_class, PLINT ix, PLINT iy, PLPointer data);

void* get_plf2eval_callback_stub ();

struct plf2eval_callback_entry_struct
{
	void* a_class;
	plf2eval_callback_eiffel_feature feature;
};

void set_plf2eval_callback_entry (void* a_class, void* a_feature);

PLFLT call_plf2eval_callback (void *a_function, PLINT ix, PLINT iy, PLPointer data);


#endif
