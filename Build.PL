use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Simo::Constrain',
    license             => 'perl',
    dist_author         => 'Yuki <kimoto.yuki@gmail.com>',
    dist_version_from   => 'lib/Simo/Constrain.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Scalar::Util' => 0,
    },
    add_to_cleanup      => [ 'Simo-Constrain-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
