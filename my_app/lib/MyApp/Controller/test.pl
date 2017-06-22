#!/usr/env/perl perl
use strict;
use warnings;
use LWP::Protocol::https;

use WWW::Mechanize;
my $mech = new WWW::Mechanize( autocheck => 1 );

$mech->get("https://www.google.com/intl/us/gmail/about/");
$mech->submit_form(
	button => 'SIGN IN',
	button => 'Use another account',
	fields => { id => 'e145759@ie.u-ryukyu.ac.jp'},
	button => 'NEXT',
	fields => { password => 'vtFg2P#J' },
	button => 'NEXT',
	button => 'COMPOSE',
	fields => {To => 'e145759\@gmail.com', Subject => 'Mechanize'},
	button => 'Send',
);

