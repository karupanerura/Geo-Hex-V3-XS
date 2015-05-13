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

cmpthese timethese 10000 => {
    pp => sub {
        Geo::Hex::V3::geohex2zone($_) for @geohexes;
    },
    xs => sub {
        Geo::Hex::V3::XS->new(code => $_) for @geohexes;
    },
};

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
Benchmark: timing 10000 iterations of pp, xs...
        pp: 10 wallclock secs (10.18 usr +  0.04 sys = 10.22 CPU) @ 978.47/s (n=10000)
        xs:  1 wallclock secs ( 0.78 usr +  0.01 sys =  0.79 CPU) @ 12658.23/s (n=10000)
      Rate    pp    xs
pp   978/s    --  -92%
xs 12658/s 1194%    --
