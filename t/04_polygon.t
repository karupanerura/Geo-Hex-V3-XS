use strict;
use Test::More tests => 12;
use Test::Number::Delta;

use Geo::Hex::V3::XS;

my $geohex = Geo::Hex::V3::XS->new(code => 'OL3371');
my @locations = $geohex->polygon();
delta_ok $locations[0]{lat}, -45.47775038345;
delta_ok $locations[0]{lng}, 49.46502057613;
delta_ok $locations[1]{lat}, -45.47775038345;
delta_ok $locations[1]{lng}, 49.30041152263;
delta_ok $locations[2]{lat}, -45.37770368915;
delta_ok $locations[2]{lng}, 49.54732510288;
delta_ok $locations[3]{lat}, -45.37770368915;
delta_ok $locations[3]{lng}, 49.21810699588;
delta_ok $locations[4]{lat}, -45.27747966662;
delta_ok $locations[4]{lng}, 49.46502057613;
delta_ok $locations[5]{lat}, -45.27747966662;
delta_ok $locations[5]{lng}, 49.30041152263;
