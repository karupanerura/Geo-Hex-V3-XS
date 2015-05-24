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

# shortcut functions
sub encode_geohex { __PACKAGE__->_new_with_latlng(@_)->{code} }
sub decode_geohex { @{__PACKAGE__->_new_with_code(@_)}{qw/lat lng level/} }

1;
__END__

=encoding utf-8

=head1 NAME

Geo::Hex::V3::XS - c-geohex3 Perl5 binding.

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

Geo::Hex::V3::XS is 

=head1 FUNCTIONS

=over

=item my $geohex_code = encode_geohex($lat, $lng, $level);

=item my ($lat, $lng, $code) = decode_geohex($geohex_code);

=back

=head1 METHODS

=over

=item my $zone = Geo::Hex::V3::XS->new(...);

=item $zone->lat;

=item $zone->lng;

=item $zone->x;

=item $zone->y;

=item $zone->code;

=item $zone->level;

=item $zone->size;

=back

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

