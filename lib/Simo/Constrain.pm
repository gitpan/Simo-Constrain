package Simo::Constrain;

use warnings;
use strict;
use Exporter;
use Carp;

our $VERSION = '0.0201';

our @ISA = 'Exporter';
our @EXPORT_OK = qw( is_undef is_defined is_bool is_value is_value is_ref is_str
                     is_num is_int is_scalar_ref is_array_ref is_hash_ref
                     is_code_ref is_regexp_ref is_glob_ref is_file_handle
                     is_object is_class_name is_method_name blessed isa );

sub is_undef(;$){
    my $val = shift || $_;
    !defined($val) or $@ = "must be undef.( $val is bad )", return 0;
    return 1;
}

sub is_defined(;$){
    my $val = shift || $_;
    defined($val) or $@ = "must be defined.( undef is bad )", return 0;
    return 1;
}

sub is_bool(;$){
    my $val = shift || $_;
    !defined($val) || $val eq "" || "$val" eq '1' || "$val" eq '0'
        or $@ = "must be boolean.( $val is bad )", return 0;
    return 1;
}

sub is_value(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    !ref($val) or $@ = "must be value.( $val is bad )", return 0;
    return 1;
}

sub is_str(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    !ref($val) or $@ = "must be string.( $val is bad )", return 0;
    return 1;
}

sub is_num(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;

    require Scalar::Util;
    is_value( $val ) && Scalar::Util::looks_like_number( $val )
        or $@ = "must be number.( $val is bad )", return 0;
    return 1;
}

sub is_int(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_num( $val ) && "$val" =~ /^-?[0-9]+$/
        or $@ = "must be integer.( $val is bad )", return 0;
    return 1;
}

sub is_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    ref($val) or $@ = "must be reference.( $val is bad )", return 0;
    return 1;
}

sub is_scalar_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'SCALAR'
        or $@ = "must be scalar reference.( $val is bad )", return 0;
    return 1;
}

sub is_array_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'ARRAY'
        or $@ = "must be array reference.( $val is bad )", return 0;
    return 1;
}

sub is_hash_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'HASH'
        or $@ = "must be hash reference.( $val is bad )", return 0;
    return 1;
    
}

sub is_code_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'CODE'
        or $@ = "must be code reference.( $val is bad )", return 0;
    return 1;
}

sub is_regexp_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'Regexp'
        or $@ = "must be regexp reference.( $val is bad )", return 0;
    return 1;
}

sub is_glob_ref(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_ref( $val ) && ref($val) eq 'GLOB'
        or $@ = "must be glob reference.( $val is bad )", return 0;
    return 1;
}

sub is_file_handle(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_glob_ref( $val ) && Scalar::Util::openhandle($val)
        or $@ = "must be file handle.( $val is bad )", return 0;
    return 1;
}

sub is_object(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    require Scalar::Util;
    is_ref( $val ) && Scalar::Util::blessed($val) && Scalar::Util::blessed($val) ne 'Regexp'
        or $@ = "must be object.( $val is bad )", return 0;
    return 1;
}

sub is_class_name(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    is_str( $val ) && $val =~ /^(\w+::)*\w+$/ or $@ = "must be class name.( $val is bad )", return 0;
    return 1;
}

sub blessed(;$){
    my $val = shift || $_;
    is_defined( $val ) or return 0;
    require Scalar::Util;
    Scalar::Util::blessed( $val ) or $@ = "must be blessed.( $val is bad )", return 0;
    return 1;
}

sub isa($;$){
    my $val = @_ eq 2 ? shift : $_;
    my $class = shift;
    croak "class name of isa must be defined" unless defined $class;
    croak "class name of isa is invalid" unless is_class_name( $class ); 
    
    is_defined( $val ) or return 0;
    eval{ $val->isa( $class ) } or $@ = "must inherit $class.( $val is bad )", return 0;
    return 1;
}



=head1 NAME

Simo::Constrain - Constrain functions for Simo;

=head1 VERSION

Version 0.0201

Simo::Constrain is experimental stage. some function will be change.

=cut

=head1 SYNOPSIS
    
    This class provede many functions intended to use with constrain option.
    
    package Book;
    use Simo;
    use Simo::Constrain qw( is_str isa is_int );
    
    sub title{ ac constrain => sub{ is_str } };
    sub author{ ac constrain => sub{ isa 'Person' } }
    sub price{ ac constrain => sub{ is_int } }

=head1 EXPORT

No function is exported.

All function can be exported.

    use Simo::Constrain qw( isa is_object is_int is_str );

=head1 FUNCTIONS

The following is constrain functions.

If function return false, error message is set to $@.

If first argument is omitted, all functions receive $_ as first argument.

=head2 is_undef
    
If it is undef, return true.

=cut

=head2 is_defined

If it is defined, return true.
    
=cut

=head2 is_bool

If it is boolean, return true.

( undef, "", 0, and 1 ) are boolean.
    
=cut

=head2 is_value

If it is value, return true.

Not reference value is value.

=cut

=head2 is_str

If it is string, return true.

Not reference value is string. This is same as value.

=cut

=head2 is_num

If it is number, return true.

If Scalar::Util::looks_like_number return true, it is number.

=cut

=head2 is_int

If it is integer, return true.

If regexp /^-?[0-9]+$/ is matched. it is integer.

=cut

=head2 is_ref

If it is reference, return true.

=cut

=head2 is_scalar_ref

If it is scalar reference, return true.

=cut

=head2 is_array_ref

If it is array reference, return true.

=cut

=head2 is_hash_ref

If it is hash reference, return true.

=cut

=head2 is_code_ref

If it is code reference, return true.

=cut

=head2 is_regexp_ref

If it is regular expression reference, return true.

=cut

=head2 is_glob_ref

If it is glob reference, return true.

=cut

=head2 is_file_handle

If it is file handle, return true.

If Scalar::Util::openhandle is true, it is file handle.

=cut

=head2 is_object

If it is objcet, return true.

Blessed value is object, except qr//.

=cut

=head2 is_class_name

If it is class name, return true.

If /^(\w+::)*\w+$/ is matched, it is class name.

=cut

=head2 blessed

If it is blessed, return true.

=cut

=head2 isa

If it inherit a Class, return true.

    sub author{ ac constrain => sub{ isa 'Person' }, }

=cut

=head1 AUTHOR

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-simo-constrain at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Simo-Constrain>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Simo::Constrain


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Simo-Constrain>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Simo-Constrain>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Simo-Constrain>

=item * Search CPAN

L<http://search.cpan.org/dist/Simo-Constrain/>

=back


=head1 See also

I study from Moose::Util::TypeConstraints and
Most of Simo::Constrain functions is compatible of Moose::Util::TypeConstraints

L<Moose>,L<Moose::Util::TypeConstraints>

Scalar::Util is used in Simo::Constrain

L<Scalar::Util>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Yuki, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Simo::Constrain
