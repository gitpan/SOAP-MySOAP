package SOAP::MySOAP;

use warnings;
use strict;
use LWP 5.64;

=head1 NAME

SOAP::MySOAP - An extremely basic SOAP client module

=head1 VERSION

Version 0.023

=cut

our $VERSION = '0.023';

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
	my $params = shift || {};

	my $ua = LWP::UserAgent->new;
	$ua->agent("MySOAP/0.1 ");

	my $self = {
					endpoint => $endpoint,
					ua => $ua,
					%$params,
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
	if ($self->{'debug'}) {
		print $req->as_string;
	}

	$self->{'request'} = $req;
	my $res = $self->{'ua'}->request($req);
	$self->{'response'} = $res;
	if ($self->{'debug'}) {
		print $res->as_string;
	}
	return $res->content;
}

1;
