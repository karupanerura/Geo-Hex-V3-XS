use strict;
use Test::More;

use Geo::Hex::V3::XS;

my $geohex = Geo::Hex::V3::XS->new(code => 'OL3371');
is_deeply [$geohex->polygon], [
    {
        lat => -45.4777503834569,
        lng => 49.4650205761317
    },
    {
        lat => -45.4777503834569,
        lng => 49.3004115226337
    },
    {
        lat => -45.3777036891565,
        lng => 49.5473251028807
    },
    {
        lat => -45.3777036891565,
        lng => 49.2181069958848
    },
    {
        lat => -45.2774796666239,
        lng => 49.4650205761317
    },
    {
        lat => -45.2774796666239,
        lng => 49.3004115226337
   },
];

done_testing;

