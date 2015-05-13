[![Build Status](https://travis-ci.org/karupanerura/Geo-Hex-V3-XS.svg?branch=master)](https://travis-ci.org/karupanerura/Geo-Hex-V3-XS)
# NAME

Geo::Hex::V3::XS - c-geohex3 Perl5 binding.

# SYNOPSIS

    use Geo::Hex::V3::XS;

    my $zone = Geo::Hex::V3::XS->new(code => 'XM488276746');

    # or

    my $zone = Geo::Hex::V3::XS->new(lat => 35.579826, lng => 139.654524, level => 9);

    say 'geohex.code:  ', $zone->code;
    say 'geohex.lat:   ', $zone->lat;
    say 'geohex.lng:   ', $zone->lng;
    say 'geohex.level: ', $zone->level;

# DESCRIPTION

Geo::Hex::V3::XS is 

# FUNCTIONS

- my $geohex\_code = encode\_geohex($lat, $lng, $level);
- my ($lat, $lng, $code) = decode\_geohex($geohex\_code);

# METHODS

- my $zone = Geo::Hex::V3::XS->new(...);
- $zone->lat;
- $zone->lng;
- $zone->x;
- $zone->y;
- $zone->code;
- $zone->level;
- $zone->size;

# LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

karupanerura <karupa@cpan.org>
