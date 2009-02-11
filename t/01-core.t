use Test::More 'no_plan';

BEGIN {
	use_ok( 'Simo::Constrain', qw( is_undef is_defined is_bool is_value is_value is_ref is_str
                                   is_num is_int is_scalar_ref is_array_ref is_hash_ref
                                   is_code_ref is_regexp_ref is_glob_ref is_file_handle
                                   is_object is_class_name is_method_name blessed isa )
    );
}

{
    {
        local $_ = undef;
        ok( is_undef, 'is_undef $_ true' );
    }
    
    ok( is_undef( undef ), 'is_undef true' );
    
    ok( !is_undef( 1 ), 'is_undef false' );
    like( $@, qr/must be undef\.\( 1 is bad \)/, 'is_undef err msg' );
}

{
    {
        local $_ = 1;
        ok( is_defined, 'is_defined $_ true' );
    }
    
    ok( is_defined( 1 ), 'is_defined true' );
    
    ok( !is_defined( undef ) , 'is_defined false' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_defined err msg' );
}

{
    {
        local $_ = 1;
        ok( is_bool, 'is_bool $_ true' );
    }
    
    ok( is_bool( 0 ), 'is_bool true 1' );
    ok( is_bool( undef ), 'is_bool true 2' );
    ok( is_bool( 1 ), 'is_bool true 3' );
    ok( is_bool( "" ), 'is_bool true 4' );
    
    ok( !is_bool( 2), 'is_bool false' );
    like( $@, qr/must be boolean\.\( 2 is bad \)/, 'is_bool err msg' );
}

{
    {
        local $_ = 'a';
        ok( is_value, 'is_value $_ true' );
    }
    
    ok( is_value( 'a' ), 'is_value true' );
    
    ok( !is_value( undef ), 'is_value false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_value err msg 1' );
    
    ok( !is_value( [] ), 'is_value false 2' );
    like( $@, qr/must be value\.\( .+ is bad \)/, 'is_value err msg 2' );
}

{
    {
        local $_ = 'a';
        ok( is_str, 'is_str $_ true' );
    }
    
    ok( is_str( 'a' ), 'is_str true' );
    
    ok( !is_str( undef ), 'is_str false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_str err msg 1' );

    ok( !is_str( [] ), 'is_str false 2' );
    like( $@, qr/must be string\.\( .+ is bad \)/, 'is_str err msg 2' );
}

{
    {
        local $_ = 1.654;
        ok( is_num, 'is_num $_ true' );
    }
    
    ok( is_num( 1.654 ), 'is_num true' );
    
    ok( !is_num( undef ), 'is_num false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_num err msg 1' );
    
    ok( !is_num( 'a' ), 'is_num false 2' );
    like( $@, qr/must be number\.\( a is bad \)/, 'is_num err msg 2' );
}

{
    {
        local $_ = 255;
        ok( is_int, 'is_int $_ true' );
    }
    
    ok( is_int( 255 ), 'is_int true' );
    
    ok( !is_int( undef ), 'is_int false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_int err msg 1' );
    
    ok( !is_int( 1.2 ), 'is_int false 2' );
    like( $@, qr/must be integer\.\( 1\.2 is bad \)/, 'is_int err msg 2' );
}

{
    {
        local $_ = [];
        ok( is_ref, 'is_ref $_ true' );
    }
    
    ok( is_ref( [] ), 'is_ref true' );
    
    ok( !is_ref( undef ), 'is_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_ref err msg 1' );
    
    ok( !is_ref( 1 ), 'is_ref false 2' );
    like( $@, qr/must be reference\.\( 1 is bad \)/, 'is_ref err msg 2' );
}

{
    {
        local $_ = \do{ 1 };
        ok( is_scalar_ref, 'is_scalar_ref $_ true' );
    }
    
    ok( is_scalar_ref( \do{ 1 } ), 'is_scalar_ref true' );
    
    ok( !is_scalar_ref( undef ), 'is_scalar_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_scalar_ref err msg 1' );
    
    ok( !is_scalar_ref( [] ), 'is_scalar_ref false 2' );
    like( $@, qr/must be scalar reference\.\( .+ is bad \)/, 'is_scalar_ref err msg 2' );
}

{
    {
        local $_ = [];
        ok( is_array_ref, 'is_array_ref $_ true' );
    }
    
    ok( is_array_ref( [] ), 'is_array_ref true' );
    
    ok( !is_array_ref( undef ), 'is_array_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_array_ref err msg 1' );
    
    ok( !is_array_ref( {} ), 'is_array_ref false 2' );
    like( $@, qr/must be array reference\.\( .+ is bad \)/, 'is_array_ref err msg 2' );
}

{
    {
        local $_ = {};
        ok( is_hash_ref, 'is_hash_ref $_ true' );
    }
    
    ok( is_hash_ref( {} ), 'is_hash_ref true' );
    
    ok( !is_hash_ref( undef ), 'is_hash_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_hash_ref err msg 1' );
    
    ok( !is_hash_ref( [] ), 'is_hash_ref false 2' );
    like( $@, qr/must be hash reference\.\( .+ is bad \)/, 'is_hash_ref err msg 2' );
}

{
    {
        local $_ = sub{};
        ok( is_code_ref, 'is_code_ref $_ true' );
    }
    
    ok( is_code_ref( sub{} ), 'is_code_ref true' );
    
    ok( !is_code_ref( undef ), 'is_code_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_code_ref err msg 1' );
    
    ok( !is_code_ref( [] ), 'is_code_ref false 2' );
    like( $@, qr/must be code reference\.\( .+ is bad \)/, 'is_code_ref err msg 2' );
}

{
    {
        local $_ = qr//;
        ok( is_regexp_ref, 'is_regexp_ref $_ true' );
    }
    
    ok( is_regexp_ref( qr// ), 'is_regexp_ref true' );
    
    ok( !is_regexp_ref( undef ), 'is_regexp_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_regexp_ref err msg 1' );
    
    ok( !is_regexp_ref( [] ), 'is_regexp_ref false 2' );
    like( $@, qr/must be regexp reference\.\( .+ is bad \)/, 'is_regexp_ref err msg 2' );
}

{
    {
        local $_ = \*a;
        ok( is_glob_ref, 'is_glob_ref $_ true' );
    }
    
    ok( is_glob_ref( \*a ), 'is_glob_ref true' );
    
    ok( !is_glob_ref( undef ), 'is_glob_ref false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_glob_ref err msg 1' );
    
    ok( !is_glob_ref( [] ), 'is_glob_ref false 2' );
    like( $@, qr/must be glob reference\.\( .+ is bad \)/, 'is_glob_ref err msg 2' );
}

{
    require File::Temp;
    my $fh = File::Temp::tempfile();
    
    {
        local $_ = $fh;
        ok( is_file_handle, 'is_file_handle $_ true' );
    }
    
    ok( is_file_handle( $fh ), 'is_file_handle true' );
    
    ok( !is_file_handle( undef ), 'is_file_handle false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_file_handle err msg 1' );
    
    ok( !is_file_handle( \*a ), 'is_file_handle false 2' );
    like( $@, qr/must be file handle\.\( .+ is bad \)/, 'is_file_handle err msg 2' );
    
    close $fh;
}

{
    my $obj = bless {}, 'A';
    
    {
        local $_ = $obj;
        ok( is_object, 'is_object $_ true' );
    }
    
    ok( is_object( $obj ), 'is_object true' );
    
    ok( !is_object( undef ), 'is_object false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_object err msg 1' );
    
    ok( !is_object( [] ), 'is_object false 2' );
    like( $@, qr/must be object\.\( .+ is bad \)/, 'is_object err msg 2' );
    
    ok( !is_object( qr// ), 'is_object false 3' );
    like( $@, qr/must be object\.\( .+ is bad \)/, 'is_object err msg 3' );
}

{
    {
        local $_ = 'A';
        ok( is_class_name, 'is_class_name $_ true' );
    }
    
    ok( is_class_name( 'A' ), 'is_class_name true 1' );
    ok( is_class_name( 'A::B' ), 'is_class_name true 2' );
    
    ok( !is_class_name( undef ), 'is_class_name false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'is_class_name err msg 1' );
    
    ok( !is_class_name( 'A::' ), 'is_class_name false 2' );
    like( $@, qr/must be class name\.\( .+ is bad \)/, 'is_class_name err msg 2' );
    
    ok( !is_class_name( '::B' ), 'is_class_name false 2' );
    like( $@, qr/must be class name\.\( .+ is bad \)/, 'is_class_name err msg 2' );
    
    ok( !is_class_name( '-' ), 'is_class_name false 3' );
    like( $@, qr/must be class name\.\( .+ is bad \)/, 'is_class_name err msg 3' );
}

{
    {
        local $_ = bless {}, 'A';
        ok( blessed, 'blessed $_ true' );
    }
    
    ok( blessed( bless {}, 'A' ), 'blessed true 1' );
    ok( blessed( qr// ), 'blessed true 2' );
    
    ok( !blessed( undef ), 'blessed false 1' );
    like( $@, qr/must be defined\.\( undef is bad \)/, 'blessed err msg 1' );
    
    ok( !blessed( 1 ), 'blessed false 2' );
    like( $@, qr/must be blessed\.\( 1 is bad \)/, 'blessed err msg 2' );
}

{
    my $obj = bless {}, 'A';
    {
        local $_ = $obj;
        my $isa_ok = isa 'A';
        ok( $isa_ok, 'isa $_ true' );
    }
    
    ok( isa( $obj, 'A' ), 'isa true 1' );
    
    eval{ isa( $obj, undef ) };
    like( $@, qr/class name of isa must be defined/, 'isa $_ false 1' );
    
    eval{ isa( $obj, '-' ) };
    like( $@, qr/class name of isa is invalid/ , 'ias $_ false 2' );
    
    ok( !isa( $obj, 'B' ), 'isa false 1' );
    like( $@, qr/must inherit B\.\( .+ is bad \)/, 'isa err msg 1' );
    
}

