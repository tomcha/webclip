#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Mojolicious::Lite;
use FindBin;
use lib "$FindBin::Bin/./lib";
use Studio;
use Data::Dumper;
# Documentation browser under "/perldoc"

get '/' => sub {
  my $self = shift;
  my $tenroku = Studio::getAkijikan('tenroku');
  my $kandai = Studio::getAkijikan('kandai');
  my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime;
  $self->stash(daystr   => ($year+1900)."年".($mon+1)."月".$mday."日");
  $self->stash(tenroku  => $tenroku);
  $self->stash(kandai   => $kandai);
  $self->render('index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<%= $daystr %></br>
<table border=4>
% my $title1 = shift(@$tenroku);
<tr><th><%= $title1 %></th></tr>
% for my $element (@$tenroku){
   <tr><td><%= $element %></td></tr>
%};
</table>
</br>
<table border=4>
% my $title2 = shift(@$kandai);
<tr><th><%= $title2 %></th></tr>
% for my $element (@$kandai){
   <tr><td><%= $element %></td></tr> 
%};
</table>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
