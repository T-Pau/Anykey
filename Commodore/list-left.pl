#!/usr/bin/env perl

use strict;

my ($source_file, $output_file, $name) = @ARGV;

my @offsets = ();

open (my $fh, "<", $source_file) or die "can't open '$source_file': $!";

my $row = 0;

# ignore title and empty line
<$fh>;
<$fh>;

while (my $line = <$fh>) {
    chomp $line;

    my $column;
    for my $char (split('', $line)) {
        if ($char eq "B") {
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

.export $name

.section data

$name:
EOF

print $fh "    .byte ";

my $last_offset = 0;
for my $offset (@offsets) {
    print $fh ($offset - $last_offset) . ", ";
    $last_offset = $offset;
}
print $fh "0\n";

close($fh);
