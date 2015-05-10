#include "use_perl.h"
#include "geohex3.h"

MODULE = Geo::Hex::V3::XS    PACKAGE = Geo::Hex::V3::XS

PROTOTYPES: DISABLE

void
_new_with_code(...)
PPCODE:
{
  if (items != 2) {
    croak("Invalid argument count: %d", items);
  }
  const char *klass = SvPV_nolen(ST(0));
  const char *code  = SvPV_nolen(ST(1));

  const geohex_verify_result_t result = geohex_verify_code(code);
  switch (result) {
    case GEOHEX3_VERIFY_RESULT_SUCCESS:
      {
        geohex_t *geohex; Newx(geohex, 1, geohex_t);
        *geohex = geohex_get_zone_by_code(code);

        SV* state = newSViv(PTR2IV(geohex));
        SV* self  = newRV_inc_mortal((SV*)state);
        sv_bless(self, gv_stashpv(klass, 1));
        SvREADONLY_on(self);
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
  const char *klass = SvPV_nolen(ST(0));
  const NV   lat    = SvNV(ST(1));
  const NV   lng    = SvNV(ST(2));
  const UV   level  = SvUV(ST(3));

  geohex_t *geohex; Newx(geohex, 1, geohex_t);
  *geohex = geohex_get_zone_by_location(geohex_location((long double)lat, (long double)lng), (geohex_level_t)level);

  SV* state = newSViv(PTR2IV(geohex));
  SV* self  = newRV_inc_mortal((SV*)state);
  sv_bless(self, gv_stashpv(klass, 1));
  SvREADONLY_on(self);
  XPUSHs(self);
  XSRETURN(1);
}

void
lat(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* lat = newSVnv((NV)geohex->location.lat);
  XPUSHs(lat);
  XSRETURN(1);
}

void
lng(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* lng = newSVnv((NV)geohex->location.lng);
  XPUSHs(lng);
  XSRETURN(1);
}

void
x(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* x = newSViv((IV)geohex->coordinate.x);
  XPUSHs(x);
  XSRETURN(1);
}

void
y(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* y = newSViv((IV)geohex->coordinate.y);
  XPUSHs(y);
  XSRETURN(1);
}

void
code(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* code = newSVpvn(geohex->code, geohex->level+2);
  XPUSHs(code);
  XSRETURN(1);
}

void
level(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* level = newSVuv((UV)geohex->level);
  XPUSHs(level);
  XSRETURN(1);
}

void
size(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  SV* size = newSVnv((NV)geohex->size);
  XPUSHs(size);
  XSRETURN(1);
}

void
DESTROY(...)
PPCODE:
{
  if (items != 1) {
    croak("Bad argument count: %d", items);
  }

  geohex_t *geohex = INT2PTR(geohex_t*, SvIV(SvRV(ST(0))));
  Safefree(geohex);
  XSRETURN(0);
}
