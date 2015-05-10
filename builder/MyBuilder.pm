package builder::MyBuilder;
use strict;
use warnings;
use parent qw/Module::Build/;

use Cwd::Guard ();
use File::Spec;

sub new {
    my ($self, %args) = @_;

    if ( $^O =~ m!(?:MSWin32|cygwin)! ) {
        print "This module does not support Windows.\n";
        exit 0;
    }

    $args{extra_linker_flags}   = ['-L' . File::Spec->rel2abs(File::Spec->catdir('deps', 'c-geohex3', 'local', 'lib')), '-lgeohex3'];
    $args{extra_compiler_flags} = ['-fPIC', '-I' . File::Spec->rel2abs(File::Spec->catdir('deps', 'c-geohex3', 'local', 'include'))];

    return $self->SUPER::new(%args);
}

sub ACTION_code {
    my $self = shift;

    {
        my $guard = Cwd::Guard::cwd_guard(File::Spec->catdir('deps', 'c-geohex3'));
        system('cmake', '-DCMAKE_INSTALL_PREFIX=local', '.') == 0 or die;
        system('make') == 0 or die;
        system('make', 'test') == 0 or die;
        system('make', 'install') == 0 or die;
    }

    return $self->SUPER::ACTION_code(@_);
}

1;
