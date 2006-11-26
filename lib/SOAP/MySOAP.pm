package SOAP::MySOAP;

use warnings;
use strict;
use LWP 5.64;

=head1 NAME

SOAP::MySOAP - An extremely basic SOAP client module

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use SOAP::MySOAP;

    my $client = SOAP::MySOAP->new("http://www.server.com/soap.jsp");
    my $reply = $soap->request($rawxml);
    print $reply;

=head1 METHODS

=head2 SOAP::MySOAP->new($url)

Creates a SOAP::MySOAP object, a SOAP client that can issue SOAP requests to the $url URL.

=cut


sub new {
	my $class = shift;
	my $endpoint = shift;

	my $ua = LWP::UserAgent->new;
	$ua->agent("MySOAP/0.1 ");

	my $self = {
					endpoint => $endpoint,
					ua => $ua,
				};
	
	bless $self, $class;
}

=head2 $client->request($rawxml)

Sends $rawxml to the SOAP server and returns the XML that it receives.

=cut

sub request {
	my $self = shift;
	my $xml = shift;

	my $req = HTTP::Request->new(POST => $self->{'endpoint'});
	$req->header( SOAPAction => '""' );
	$req->content_type('text/xml; charset=UTF-8');
	$req->content($xml);
	$req->content_length(length($xml));

	$self->{'request'} = $req;
	my $res = $self->{'ua'}->request($req);
	$self->{'response'} = $res;
	return $res->content;
}

1;
