#!/usr/bin/env perl

#  list-left.pl -- Get left edges of PET keyboard.
#  Copyright (C) Dieter Baron
#
#  This file is part of Anykey, a keyboard test program for C64.
#  The authors can be contacted at <anykey@tpau.group>.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. The names of the authors may not be used to endorse or promote
#     products derived from this software without specific prior
#     written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHORS "AS IS" AND ANY EXPRESS
#  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
#  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
#  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
#  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

use utf8;

use strict;

my ($source_file, $output_file) = @ARGV;

my @offsets = ();

open (my $fh, "<:encoding(UTF-8)", $source_file) or die "can't open '$source_file': $!";

my $row = 0;

my $name;

while (my $line = <$fh>) {
    if ($line =~ /name (.*)/) {
        $name = $1;
        $name =~ s/keyboard_pet_(.*)_screen/left_$1/;
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
