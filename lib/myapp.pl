#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Mojolicious::Lite;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Studio;
use Data::Dumper;
# Documentation browser under "/perldoc"

get '/' => sub {
  my $self = shift;
  my $tenroku = Studio::getAkijikan('tenroku');
  my $kandai = Studio::getAkijikan('kandai');
  $self->stash(tenroku  => Dumper \$tenroku);
  $self->stash(kandai   => Dumper \$kandai);
  $self->render('index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<%= $tenroku %>;
<%= $kandai%>;

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
