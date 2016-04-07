use strict;
use Test::More tests => 6;
use Test::Number::Delta;

use Geo::Hex::V3::XS qw/encode_geohex decode_geohex geohex_hexsize/;

my $code = encode_geohex(35.579826, 139.654524, 9);
is $code, 'XM488276746';

my ($lat, $lng, $level) = decode_geohex('XM488276746');
delta_ok $lat, 35.579825;
delta_ok $lng, 139.654524;
is $level, 9;

delta_ok geohex_hexsize(7), 339.336963;
delta_ok geohex_hexsize(9), 37.704107;

