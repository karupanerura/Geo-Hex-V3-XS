use strict;
use Test::More;

use Geo::Hex::V3::XS;

isa_ok(Geo::Hex::V3::XS->new(code => "XE1234"), 'Geo::Hex::V3::XS');
isa_ok(Geo::Hex::V3::XS->new(lat => 40.5814792855475, lng => 134.296601127877, level => 7), 'Geo::Hex::V3::XS');

done_testing;
