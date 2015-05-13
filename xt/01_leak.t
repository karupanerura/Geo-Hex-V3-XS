use strict;
use warnings;
use utf8;

use Test::More tests => 1;
use Test::LeakTrace;
use Geo::Hex::V3::XS;

no_leaks_ok { Geo::Hex::V3::XS->new(code => "XM0123") } 'new with code';
