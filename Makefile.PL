use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'SOAP::MySOAP',
    AUTHOR              => 'Alexander Karelas <karjala@karjala.org>',
    VERSION_FROM        => 'lib/SOAP/MySOAP.pm',
    ABSTRACT_FROM       => 'lib/SOAP/MySOAP.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SOAP-MySOAP-*' },
);
