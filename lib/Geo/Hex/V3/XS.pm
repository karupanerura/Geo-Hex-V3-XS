package Geo::Hex::V3::XS;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

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

BEGIN {
    my $src = '';
    for my $name (qw/lat lng x y code level size/) {
        $src .= "sub $name { shift->{$name} }\n";
    }
    eval $src;
    die $@ if $@;
}

1;
__END__

=encoding utf-8

=head1 NAME

Geo::Hex::V3::XS - It's new $module

=head1 SYNOPSIS

    use Geo::Hex::V3::XS;

=head1 DESCRIPTION

Geo::Hex::V3::XS is ...

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

