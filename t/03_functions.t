use strict;
use Test::More tests => 4;

use Geo::Hex::V3::XS qw/encode_geohex decode_geohex/;

my $code = encode_geohex(35.579826, 139.654524, 9);
is $code, 'XM488276746';

my ($lat, $lng, $level) = decode_geohex('XM488276746');
like $lat, qr/^35\.579825/;
like $lng, qr/^139\.654524/;
is $level, 9;

