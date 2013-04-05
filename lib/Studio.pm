package Studio;

use strict;
use warnings;
use utf8;

use URI;
use Web::Query;
use Encode;
use Data::Dumper;
use Time::Piece;

binmode STDIN,":encoding(UTF-8)";
binmode STDOUT,":utf8";
binmode STDERR,":utf8";

sub getAkijikan{
    my $place = shift;
    my $now = localtime;
    my $nowstr = $now->ymd('/');
    my %datah;

    if($nowstr =~ /\A(\d+\/)0?(\d+\/)0?(\d+)\z/){
        $nowstr = $1.$2.$3;
    };
    my $urlString = 'http://yoyaku.bassontop.jp/'.$place.'/index.cgi?date='.$nowstr.'&target=table';
    wq($urlString)->find('tr')
    ->each(sub { 
        my ($i,$elem)= @_;
        my $timestr = $elem->find('th')->text;
        $elem->find('td')
        ->each(sub{
            my ($j,$elem2) = @_;
            if(!exists($datah{$timestr})||$datah{$timestr} ne encode_utf8("○")){
                $datah{$timestr} = encode_utf8($elem2->text);
            };
        });
    });

    foreach my $key(keys(%datah)){
        if($key =~ /\A(\d+):(\d+)\z/){
            if($1 < $now->hour){
                delete $datah{$key};
            }elsif($datah{$key} ne encode_utf8("○")){
                delete $datah{$key};
            };
        };
    };
    push(my @array,$place);
    foreach my $key(sort keys(%datah)){
        push(@array,$key);
    };
return \@array;
}

return 1;
