package common::header v0.3.2;

# NOTE !!!WARNING!!! don't use indirect with strawberry perl
# https://rt.cpan.org/Public/Bug/Display.html?id=102321

use utf8;
use strict qw[subs vars];
no strict qw[refs];    ## no critic qw[TestingAndDebugging::ProhibitProlongedStrictureOverride]

no warnings;           ## no critic qw[TestingAndDebugging::ProhibitNoWarnings]
use warnings (
    'all',
    FATAL => qw[
      closed
      closure
      debugging
      digit
      glob
      inplace
      internal
      io
      layer
      malloc
      pack
      pipe
      portable
      printf
      prototype
      reserved
      semicolon
      taint
      threads
      unpack
      utf8
      ],
    NONFATAL => qw[
      exec
      newline
      unopened
      ]
);

no if $^V ge 'v5.18', warnings => 'experimental';
use if $^V lt 'v5.23', warnings => 'experimental::autoderef', FATAL => 'experimental::autoderef';

use if $^V ge 'v5.10', feature => ':all';
no  if $^V ge 'v5.16', feature => 'array_base';

use if $^V ge 'v5.22', re => 'strict';    # NOTE https://rt.perl.org/Public/Bug/Display.html?id=128313

# TODO mro caller
BEGIN {
    eval <<"PERL";                        ## no critic qw[BuiltinFunctions::ProhibitStringyEval ErrorHandling::RequireCheckingReturnValueOfEval]
        sub import {
            local \$^W;

            \${^WARNING_BITS} = "@{[ join( q[], map "\\x$_", unpack '(H2)*', ${^WARNING_BITS}) ]}";

            \$^H |= $^H;

            @^H{ qw[@{[ join q[ ], keys %^H ]}] } = (@{[ join q[, ], values %^H ]});

            return;
        }

        1;
PERL

    # TODO re-export mro
    # my $caller = $args{-caller} // caller;
    # mro::set_mro( $caller, 'c3' ) if $^V ge 'v5.10';
    # use if $^V ge 'v5.10', mro => 'c3';
}

1;
__END__
=pod

=encoding utf8

=head1 NAME

common::header - re-exporting the set of standard perl pragmas

=head1 SYNOPSIS

    use common::header;

    # or re-export

    common::header->import;

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head1 SEE ALSO

common::sense

=cut
