use strict;
use warnings;
use utf8;

use Test::More tests => 5;
use Test::LeakTrace;
use Geo::Hex::V3::XS qw/encode_geohex decode_geohex/;

no_leaks_ok { Geo::Hex::V3::XS->new(code => "XM0123") } 'new with code';
no_leaks_ok { Geo::Hex::V3::XS->new(lat => 40.5814792855475, lng => 134.296601127877, level => 7) } 'new with latlng';
no_leaks_ok { encode_geohex(40.5814792855475, 134.296601127877, 7) } 'encode geohex';
no_leaks_ok { decode_geohex("XM0123") } 'decode geohex';

no_leaks_ok {
    my $zone = Geo::Hex::V3::XS->new(code => "XM0123");
    for my $accessor (qw/level size code lat lng x y/) {
        $zone->$accessor;
    }
} 'accessors';
