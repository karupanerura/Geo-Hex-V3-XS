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
        const geohex_t geohex = geohex_get_zone_by_code(code);
        const HV* state = new_state(aTHX_ &geohex);
        SV* self = bless_state(aTHX_ state, class);
        PUSHs(self);
        XSRETURN(1);
      }
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_CODE:
      XSRETURN(0);
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_LEVEL:
      XSRETURN(0);
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

  const geohex_t geohex = geohex_get_zone_by_location(geohex_location((long double)lat, (long double)lng), (geohex_level_t)level);
  const HV* state = new_state(aTHX_ &geohex);
  SV* self = bless_state(aTHX_ state, class);
  PUSHs(self);
  XSRETURN(1);
}

void
encode_geohex(...)
PPCODE:
{
  if (items != 3) {
    croak("Invalid argument count: %d", items);
  }
  const NV lat   = SvNV(ST(0));
  const NV lng   = SvNV(ST(1));
  const UV level = SvUV(ST(2));

  const geohex_t geohex = geohex_get_zone_by_location(geohex_location((long double)lat, (long double)lng), (geohex_level_t)level);
  mPUSHp(geohex.code, geohex.level+2);
  XSRETURN(1);
}

void
decode_geohex(...)
PPCODE:
{
  if (items != 1) {
    croak("Invalid argument count: %d", items);
  }
  const char *code = SvPV_nolen(ST(0));

  const geohex_verify_result_t result = geohex_verify_code(code);
  switch (result) {
    case GEOHEX3_VERIFY_RESULT_SUCCESS:
      {
        const geohex_t geohex = geohex_get_zone_by_code(code);
        EXTEND(SP, 3);
        mPUSHn((NV)geohex.location.lat);
        mPUSHn((NV)geohex.location.lng);
        mPUSHu((UV)geohex.level);
        XSRETURN(3);
      }
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_CODE:
      XSRETURN(0);
      break;
    case GEOHEX3_VERIFY_RESULT_INVALID_LEVEL:
      XSRETURN(0);
      break;
  }
}

void
lat(...)
ALIAS:
  Geo::Hex::V3::XS::lat   = 0
  Geo::Hex::V3::XS::lng   = 1
  Geo::Hex::V3::XS::x     = 2
  Geo::Hex::V3::XS::y     = 3
  Geo::Hex::V3::XS::code  = 4
  Geo::Hex::V3::XS::level = 5
  Geo::Hex::V3::XS::size  = 6
PREINIT:
  static const char *key[7] = {"lat", "lng", "x", "y", "code", "level", "size"};
PPCODE:
{
  if (items != 1) {
    croak("Invalid argument count: %d", items);
  }
  HV* state = (HV*)SvRV(ST(0));

  SV** val = XSUTIL_HV_FETCH(state, key[ix]);
  PUSHs(*val);
  XSRETURN(1);
}
