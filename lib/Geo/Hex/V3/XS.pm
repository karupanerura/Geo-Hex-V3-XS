package Geo::Hex::V3::XS;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";
use Exporter 5.57 qw/import/;
our @EXPORT_OK = qw/encode_geohex decode_geohex/;

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

sub new {
    my ($class, %args) = @_;
    if (exists $args{code}) {
        return $class->_new_with_code($args{code}) || die "invalid code: $args{code}";
    }
    elsif (exists $args{lat} and exists $args{lng} and exists $args{level}) {
        return $class->_new_with_latlng(@args{qw/lat lng level/});
    }
    else {
        die "Usage: $class->new(code => \$geohex_code) or $class->new(lat => \$lat, lng => \$lng, lng => \$level)";
    }
}

1;
__END__

=for stopwords c-geohex3

=encoding utf-8

=head1 NAME

Geo::Hex::V3::XS - GeoHex implementation with XS. (c-geohex3 Perl5 binding.)

=head1 SYNOPSIS

    use Geo::Hex::V3::XS;

    my $zone = Geo::Hex::V3::XS->new(code => 'XM488276746');

    # or

    my $zone = Geo::Hex::V3::XS->new(lat => 35.579826, lng => 139.654524, level => 9);

    say 'geohex.code:  ', $zone->code;
    say 'geohex.lat:   ', $zone->lat;
    say 'geohex.lng:   ', $zone->lng;
    say 'geohex.level: ', $zone->level;

=head1 DESCRIPTION

Geo::Hex::V3::XS is L<GeoHex|http://geohex.net/> implementation.

=head1 FUNCTIONS

=over

=item C<my $geohex_code = encode_geohex($lat, $lng, $level)>

Convert location,level to geohex's code.

=item C<my ($lat, $lng, $code) = decode_geohex($geohex_code)>

Convert geohex's code to location,level.
This location is center of geohex.

=back

=head1 METHODS

=over

=item C<my $zone = Geo::Hex::V3::XS-E<gt>new(...)>

Create geohex zone object.

Arguments can be:

=over

=item * C<code>

Create geohex zone object from geohex code.

    use Geo::Hex::V3::XS;

    my $zone = Geo::Hex::V3::XS->new(code => 'XM488548');

=item * C<lat/lng/level>

Create geohex zone object from location with level.

    use Geo::Hex::V3::XS;

    my $zone = Geo::Hex::V3::XS->new(
        lat   => 40.5814792855475,
        lng   => 134.296601127877,
        level => 7,
    );

=back

=item C<$zone-E<gt>lat>

Get geohex center location latitude.

=item C<$zone-E<gt>lng>

Get geohex center location longitude.

=item C<$zone-E<gt>code>

Get geohex code.

=item C<$zone-E<gt>level>

Get geohex level. (0-15)

=item C<$zone-E<gt>size>

Get geohex size.

=item C<my @locations = $zone-E<gt>polygon()>

Get vertex locations of a geohex polygon.

=back

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

