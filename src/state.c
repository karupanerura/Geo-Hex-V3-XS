#include "state.h"
#include "geohex3.h"
#include "xsutil.h"

HV* new_state (pTHX_ const geohex_t *geohex) {
  return init_state(aTHX_ newHV_mortal(), geohex);
}

HV* init_state (pTHX_ HV* state, const geohex_t *geohex) {
  XSUTIL_HV_STORE(state, "lat",   XSUTIL_NEW_SVNV_MORTAL((NV)geohex->location.lat));
  XSUTIL_HV_STORE(state, "lng",   XSUTIL_NEW_SVNV_MORTAL((NV)geohex->location.lng));
  XSUTIL_HV_STORE(state, "x",     XSUTIL_NEW_SVIV_MORTAL((IV)geohex->coordinate.x));
  XSUTIL_HV_STORE(state, "y",     XSUTIL_NEW_SVIV_MORTAL((IV)geohex->coordinate.y));
  XSUTIL_HV_STORE(state, "code",  sv_2mortal(newSVpvn(geohex->code, geohex->level+2)));
  XSUTIL_HV_STORE(state, "level", XSUTIL_NEW_SVUV_MORTAL((UV)geohex->level));
  XSUTIL_HV_STORE(state, "size",  XSUTIL_NEW_SVNV_MORTAL((NV)geohex->size));
  return state;
}

SV* bless_state (pTHX_ const HV* state, const char *class) {
  SV* self = newRV_inc_mortal((SV*)state);
  sv_bless(self, gv_stashpv(class, 1));
  SvREADONLY_on(self);
  return self;
}
