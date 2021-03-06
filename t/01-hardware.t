#!/usr/bin/perl

use Modern::Perl;
use Test::More;
use Test::MockModule;

use t::Examples;

use SSAuthenticator;
use SSAuthenticator::Config;

my $defaultConfTempFile = t::Examples::writeDefaultConf();
SSAuthenticator::Config::setConfigFile($defaultConfTempFile->filename());

#$ENV{SSA_LOG_LEVEL} = -4; #Debug verbosity

subtest "Manually inspect LEDs", \&ledInspection;
sub ledInspection {
    my $ledDuration = 1;

    print "Turning red led on for $ledDuration seconds\n";
    ok(SSAuthenticator::ledOn('red'), "Red on");
    sleep($ledDuration);
    ok(SSAuthenticator::ledOff('red'), "Red off");

    print "Turning green led on for $ledDuration seconds\n";
    ok(SSAuthenticator::ledOn('green'), "Green on");
    sleep($ledDuration);
    ok(SSAuthenticator::ledOff('green'), "Green off");

    print "Turning blue led on for $ledDuration seconds\n";
    ok(SSAuthenticator::ledOn('blue'), "Blue on");
    sleep($ledDuration);
    ok(SSAuthenticator::ledOff('blue'), "Blue off");
}

subtest "Manually inspect door non-latching relay.", \&doorInspection;
sub doorInspection {
    print "You should hear two clicks from the relay with a 1 second delay\n";
    ok(SSAuthenticator::doorOn(), "Door opened");
    sleep 1;
    ok(SSAuthenticator::doorOff(), "Door closed");
}

subtest "Manually inspect beeper.", \&beeperInspection;
sub beeperInspection {
    print "You should hear the access granted sound\n";
    ok(SSAuthenticator::playRTTTL('toveri_access_granted'), "Access granted sound played");
}

subtest "Manually inspect OLED display.", \&OLEDInspection;
sub OLEDInspection {
    print "You should see the 'Display test' message\n";
    ok(SSAuthenticator::showAccessMsg( SSAuthenticator::OK, 1 ), "OLED display works");
}

t::Examples::rmConfig();

done_testing();
