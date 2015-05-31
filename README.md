[![Build Status](https://travis-ci.org/karupanerura/Geo-Hex-V3-XS.svg?branch=master)](https://travis-ci.org/karupanerura/Geo-Hex-V3-XS)
# NAME

Geo::Hex::V3::XS - GeoHex implementation with XS. (c-geohex3 Perl5 binding.)

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

Geo::Hex::V3::XS is [GeoHex](http://geohex.net/) implementation.

# FUNCTIONS

- `my $geohex_code = encode_geohex($lat, $lng, $level)`

    Convert location,level to geohex's code.

- `my ($lat, $lng, $code) = decode_geohex($geohex_code)`

    Convert geohex's code to location,level.
    This location is center of geohex.

# METHODS

- `my $zone = Geo::Hex::V3::XS->new(...)`

    Create geohex zone object.

    Arguments can be:

    - `code`

        Create geohex zone object from geohex code.

            use Geo::Hex::V3::XS;

            my $zone = Geo::Hex::V3::XS->new(code => 'XM488548');

    - `lat/lng/level`

        Create geohex zone object from location with level.

            use Geo::Hex::V3::XS;

            my $zone = Geo::Hex::V3::XS->new(
                lat   => 40.5814792855475,
                lng   => 134.296601127877,
                level => 7,
            );

- `$zone->lat`

    Get geohex center location latitude.

- `$zone->lng`

    Get geohex center location longitude.

- `$zone->code`

    Get geohex code.

- `$zone->level`

    Get geohex level. (0-15)

- `$zone->size`

    Get geohex size.

- `my @locations = $zone->polygon()`

    Get vertex locations of a geohex polygon.

# LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

karupanerura <karupa@cpan.org>
