#!/usr/bin/env perl

use strict;

my ($source_file, $output_file) = @ARGV;

my @offsets = ();

open (my $fh, "<", $source_file) or die "can't open '$source_file': $!";

my $row = 0;

my $name;

while (my $line = <$fh>) {
    if ($line =~ /name (.*)/) {
        $name = $1;
        $name =~ s/keyboard_pet_(.*)_screen/$1/;
    }
    if ($line =~ /^---/) {
        last;
    }
}

while (my $line = <$fh>) {
    chomp $line;

    my $column;
    for my $char (split('', $line)) {
        if ($char eq "│") {
            push @offsets, $row * 40 + $column;
        }
        $column++;
    }
    $row++;
}

close ($fh);

open ($fh, ">", $output_file) or die "can't create '$output_file': $!";

print $fh <<EOF;
; Automatically created from $source_file by $0.
; Don't edit manually.

.section data

$name {
EOF

print $fh "    .data ";

my $last_offset = 0;
for my $offset (@offsets) {
    print $fh ($offset - $last_offset) . ", ";
    $last_offset = $offset;
}
print $fh "0\n}\n";

close($fh);
