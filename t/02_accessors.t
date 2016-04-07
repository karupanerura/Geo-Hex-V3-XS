use strict;
use Test::More;
use Test::Number::Delta;

use Geo::Hex::V3::XS;

subtest code => sub {
    my $geohex = Geo::Hex::V3::XS->new(code => 'OL3371');
    is $geohex->level, 4;
    delta_ok $geohex->size, 9162.098006;
    is $geohex->code, 'OL3371';
    delta_ok $geohex->lat, -45.377703;
    delta_ok $geohex->lng, 49.382716;
    is $geohex->x, -79;
    is $geohex->y, -279;
};

subtest latlng => sub {
    my $geohex = Geo::Hex::V3::XS->new(lat => 40.5814792855475, lng => 134.296601127877, level => 7);
    is $geohex->level, 7;
    delta_ok $geohex->size, 339.336963;
    is $geohex->code, 'XU6312418';
    delta_ok $geohex->lat, 40.580142;
    delta_ok $geohex->lng, 134.293552;
    is $geohex->x, 11554;
    is $geohex->y, -3131;
};

done_testing;

