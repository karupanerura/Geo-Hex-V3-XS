use strict;
use warnings;
use utf8;

use Test::More tests => 16;
use Benchmark qw/cmpthese timethese/;
use Geo::Hex::V3;
use Geo::Hex::V3::XS;

my @geohexes = qw/
    XM
    XM4
    XM48
    XM488
    XM4882
    XM48827
    XM488276
    XM4882767
    XM48827674
    XM488276746
    XM4882767460
    XM48827674605
    XM488276746051
    XM4882767460512
    XM48827674605123
    XM488276746051234
/;
my (@latlngs) = map { [Geo::Hex::V3::XS::decode_geohex($_)] } @geohexes;

for my $geohex (@geohexes) {
    my $zone_pp = Geo::Hex::V3::geohex2zone($geohex);
    my $zone_xs = Geo::Hex::V3::XS->new(code => $geohex);
    subtest $geohex => sub {
        is $zone_xs->lat,   $zone_pp->lat,      'lat';
        is $zone_xs->lng,   $zone_pp->lng,      'lng';
        is $zone_xs->x,     $zone_pp->x,        'x';
        is $zone_xs->y,     $zone_pp->y,        'y';
        is $zone_xs->code,  $zone_pp->code,     'code';
        is $zone_xs->level, $zone_pp->level,    'level';
        is $zone_xs->size,  $zone_pp->hex_size, 'size';
    };
}

print '-' x 60, "\n";
print 'Creates zone object from geohex:', "\n";
cmpthese timethese 20000 => {
    pp => sub {
        Geo::Hex::V3::geohex2zone($_) for @geohexes;
    },
    xs => sub {
        Geo::Hex::V3::XS->new(code => $_) for @geohexes;
    },
};
print '-' x 60, "\n";

print '-' x 60, "\n";
print 'Creates zone object from latlng:', "\n";
cmpthese timethese 20000 => {
    pp => sub {
        Geo::Hex::V3::latlng2zone(@$_) for @latlngs;
    },
    xs => sub {
        Geo::Hex::V3::XS->new(lat => $_->[0], lng => $_->[1], level => $_->[2]) for @latlngs;
    },
};
print '-' x 60, "\n";

print '-' x 60, "\n";
print 'Converts latlng to geohex:', "\n";
cmpthese timethese 20000 => {
    pp => sub {
        Geo::Hex::V3::latlng2geohex(@$_) for @latlngs;
    },
    xs => sub {
        Geo::Hex::V3::XS::encode_geohex(@$_) for @latlngs;
    },
};
print '-' x 60, "\n";

print '-' x 60, "\n";
print 'Converts geohex to latlng:', "\n";
cmpthese timethese 20000 => {
    pp => sub {
        Geo::Hex::V3::geohex2latlng($_) for @geohexes;
    },
    xs => sub {
        Geo::Hex::V3::XS::decode_geohex($_) for @geohexes;
    },
};
print '-' x 60, "\n";

__END__
1..16
    # Subtest: XM
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 1 - XM
    # Subtest: XM4
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 2 - XM4
    # Subtest: XM48
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 3 - XM48
    # Subtest: XM488
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 4 - XM488
    # Subtest: XM4882
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 5 - XM4882
    # Subtest: XM48827
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 6 - XM48827
    # Subtest: XM488276
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 7 - XM488276
    # Subtest: XM4882767
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 8 - XM4882767
    # Subtest: XM48827674
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 9 - XM48827674
    # Subtest: XM488276746
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 10 - XM488276746
    # Subtest: XM4882767460
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 11 - XM4882767460
    # Subtest: XM48827674605
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 12 - XM48827674605
    # Subtest: XM488276746051
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 13 - XM488276746051
    # Subtest: XM4882767460512
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 14 - XM4882767460512
    # Subtest: XM48827674605123
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 15 - XM48827674605123
    # Subtest: XM488276746051234
    ok 1 - lat
    ok 2 - lng
    ok 3 - x
    ok 4 - y
    ok 5 - code
    ok 6 - level
    ok 7 - size
    1..7
ok 16 - XM488276746051234
------------------------------------------------------------
Creates zone object from geohex:
Benchmark: timing 20000 iterations of pp, xs...
        pp: 14 wallclock secs (13.77 usr +  0.14 sys = 13.91 CPU) @ 1437.81/s (n=20000)
        xs:  1 wallclock secs ( 1.21 usr +  0.01 sys =  1.22 CPU) @ 16393.44/s (n=20000)
      Rate    pp    xs
pp  1438/s    --  -91%
xs 16393/s 1040%    --
------------------------------------------------------------
------------------------------------------------------------
Creates zone object from latlng:
Benchmark: timing 20000 iterations of pp, xs...
        pp: 15 wallclock secs (14.43 usr +  0.15 sys = 14.58 CPU) @ 1371.74/s (n=20000)
        xs:  1 wallclock secs ( 1.26 usr +  0.01 sys =  1.27 CPU) @ 15748.03/s (n=20000)
      Rate    pp    xs
pp  1372/s    --  -91%
xs 15748/s 1048%    --
------------------------------------------------------------
------------------------------------------------------------
Converts latlng to geohex:
Benchmark: timing 20000 iterations of pp, xs...
        pp: 15 wallclock secs (14.34 usr +  0.15 sys = 14.49 CPU) @ 1380.26/s (n=20000)
        xs:  1 wallclock secs ( 0.92 usr +  0.01 sys =  0.93 CPU) @ 21505.38/s (n=20000)
      Rate    pp    xs
pp  1380/s    --  -94%
xs 21505/s 1458%    --
------------------------------------------------------------
------------------------------------------------------------
Converts geohex to latlng:
Benchmark: timing 20000 iterations of pp, xs...
        pp: 15 wallclock secs (14.24 usr +  0.15 sys = 14.39 CPU) @ 1389.85/s (n=20000)
        xs:  1 wallclock secs ( 1.04 usr +  0.01 sys =  1.05 CPU) @ 19047.62/s (n=20000)
      Rate    pp    xs
pp  1390/s    --  -93%
xs 19048/s 1270%    --
------------------------------------------------------------
