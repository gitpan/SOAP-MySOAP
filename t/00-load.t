#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'SOAP::MySOAP' );
}

diag( "Testing SOAP::MySOAP $SOAP::MySOAP::VERSION, Perl $], $^X" );
