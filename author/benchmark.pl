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
cmpthese timethese 30000 => {
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
cmpthese timethese 30000 => {
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
cmpthese timethese 30000 => {
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
cmpthese timethese 30000 => {
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
Benchmark: timing 30000 iterations of pp, xs...
        pp: 21 wallclock secs (20.84 usr +  0.10 sys = 20.94 CPU) @ 1432.66/s (n=30000)
        xs:  2 wallclock secs ( 1.84 usr +  0.01 sys =  1.85 CPU) @ 16216.22/s (n=30000)
      Rate    pp    xs
pp  1433/s    --  -91%
xs 16216/s 1032%    --
------------------------------------------------------------
------------------------------------------------------------
Creates zone object from latlng:
Benchmark: timing 30000 iterations of pp, xs...
        pp: 22 wallclock secs (21.64 usr +  0.10 sys = 21.74 CPU) @ 1379.94/s (n=30000)
        xs:  2 wallclock secs ( 1.90 usr +  0.00 sys =  1.90 CPU) @ 15789.47/s (n=30000)
      Rate    pp    xs
pp  1380/s    --  -91%
xs 15789/s 1044%    --
------------------------------------------------------------
------------------------------------------------------------
Converts latlng to geohex:
Benchmark: timing 30000 iterations of pp, xs...
        pp: 21 wallclock secs (21.49 usr +  0.10 sys = 21.59 CPU) @ 1389.53/s (n=30000)
        xs:  1 wallclock secs ( 0.59 usr +  0.00 sys =  0.59 CPU) @ 50847.46/s (n=30000)
      Rate    pp    xs
pp  1390/s    --  -97%
xs 50847/s 3559%    --
------------------------------------------------------------
------------------------------------------------------------
Converts geohex to latlng:
Benchmark: timing 30000 iterations of pp, xs...
        pp: 21 wallclock secs (21.22 usr +  0.09 sys = 21.31 CPU) @ 1407.79/s (n=30000)
        xs:  1 wallclock secs ( 0.70 usr +  0.01 sys =  0.71 CPU) @ 42253.52/s (n=30000)
      Rate    pp    xs
pp  1408/s    --  -97%
xs 42254/s 2901%    --
------------------------------------------------------------
