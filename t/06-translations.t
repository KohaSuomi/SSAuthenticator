#!/usr/bin/perl

# Copyright (C) 2016 Koha-Suomi
#
# This file is part of Authenticator.

use Test::More;
use Test::MockModule;

use t::Examples;

use SSAuthenticator;
use SSAuthenticator::Config;

my $defaultConfTempFile = t::Examples::writeDefaultConf();
SSAuthenticator::Config::setConfigFile($defaultConfTempFile->filename());


=head2 Trouble?

Try running
    bash -x translate.sh
to create the translations and update them after modifying the .po-files afterwards.

=cut


subtest "Translations fi_FI", \&translationsFi_FI;
sub translationsFi_FI {
    #Set the locale to fi_FI to test the expected Finnish language translations
    SSAuthenticator::changeLanguage('fi_FI', 'UTF-8');
    my $arr;

    $arr = SSAuthenticator::_getAccessMsg( SSAuthenticator::OK, 0 );
    is($arr->[0],
       '   Paasy sallittu   ');

    $arr = SSAuthenticator::_getAccessMsg( SSAuthenticator::ERR_REVOKED, 0 );
    is($arr->[0],
       '    Paasy evatty    ');
    is($arr->[1],
       ' Omatoimikirjaston  ');
    is($arr->[2],
       '   kaytto estetty   ');
}

subtest "Translations en_GB", \&translationsEn_GB;
sub translationsEn_GB {
    #Set the locale to english
    SSAuthenticator::changeLanguage('en_GB', 'UTF-8');
    my $arr;

    $arr = SSAuthenticator::_getAccessMsg( SSAuthenticator::OK, 0 );
    is($arr->[0],
       '   Access granted   ');

    $arr = SSAuthenticator::_getAccessMsg( SSAuthenticator::ERR_REVOKED, 0 );
    is($arr->[0],
       '   Access denied    ');
    is($arr->[1],
       ' Self-service usage ');
    is($arr->[2],
       ' permission revoked ');
}

t::Examples::rmConfig();

done_testing();
