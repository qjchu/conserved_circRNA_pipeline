# extract_circ_full_length_osa.pl
open IN, "$ARGV[0]" or die "NO all_circ_full_length_osa.txt FIlE!\n";

open OUT, ">$ARGV[1]" or die "NO output FILE!\n";
$count_id = 0; # 6519
while (<IN>) {
	chomp;
	if (!/^#/) {
		@aa = split/\t/, $_;
		if ($aa[2] ne '') {
			$count_id ++;
			$lmax = 0;
			for ($var = 4; $var <= $#aa; $var++) {
				@bb = split/\;/, $aa[$var];
				$l = $bb[0];
				if ($lmax <= $l) {
					$lmax = $l;
					$posi = $aa[$var];
				}
			}

			# extract longeast sequence
			@cc = split/\;/, $posi;
			@dd = split/\,/, $cc[1];
			if ($#dd == 0) {
				print OUT ">$aa[0]|$aa[2]|1_1\n$cc[2]\n";
			}else{
				$total_seq_parts = $#dd + 1;
				for ($i = 0; $i <= $#dd; $i++) {
					$num = $i + 1;
					print OUT ">$aa[0]|$aa[2]|$total_seq_parts\_$num\_$dd[$i]\n";
					$seq = substr($cc[2], 0, (split/\-/, $dd[$i])[1] - (split/\-/, $dd[$i])[0] + 1);
					print OUT "$seq\n";
					$cc[2] =~ s/^$seq//;
					}
				}
		}
	}
}
close IN;

print "Number of circRNAs in PlantcircBase: $count_id\n";
