#include "use_perl.h"
#include "geohex3.h"
#include "state.h"
#include "xsutil.h"

MODULE = Geo::Hex::V3::XS    PACKAGE = Geo::Hex::V3::XS

PROTOTYPES: DISABLE

void
_new_with_code(...)
PPCODE:
{
  if (items != 2) {
    croak("Invalid argument count: %d", items);
  }
  const char *class = SvPV_nolen(ST(0));
  const char *code  = SvPV_nolen(ST(1));

  const geohex_verify_result_t result = geohex_verify_code(code);
  switch (result) {
    case GEOHEX3_VERIFY_RESULT_SUCCESS:
      {
        geohex_t geohex = geohex_get_zone_by_code(code);
        HV* state = new_state(aTHX_ &geohex);
        SV* self  = bless_state(aTHX_ state, class);
        XPUSHs(self);
        XSRETURN(1);
      }
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_CODE:
      XPUSHs(&PL_sv_undef);
      XSRETURN(1);
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_LEVEL:
      XPUSHs(&PL_sv_undef);
      XSRETURN(1);
      break;
  }
}

void
_new_with_latlng(...)
PPCODE:
{
  if (items != 4) {
    croak("Invalid argument count: %d", items);
  }
  const char *class = SvPV_nolen(ST(0));
  const NV   lat    = SvNV(ST(1));
  const NV   lng    = SvNV(ST(2));
  const UV   level  = SvUV(ST(3));

  geohex_t geohex = geohex_get_zone_by_location(geohex_location((long double)lat, (long double)lng), (geohex_level_t)level);
  HV* state = new_state(aTHX_ &geohex);
  SV* self  = bless_state(aTHX_ state, class);
  XPUSHs(self);
  XSRETURN(1);
}
