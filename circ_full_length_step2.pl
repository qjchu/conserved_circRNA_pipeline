open IN, "$ARGV[0]" or die "NO combined circ full length FILE!\n";
# format
# #chr_start_end	genomic_length	PlantcircBase_ID	circseqcup_res (length;exons;seq)	CIRI-full_res (length;exons;seq)	CIRCexplorer_res (length;exons;seq)
# 10_14330781_14330896	116	osa_circ_006791	116;14330781-14330896;CAGCCATGGGTCGCGTGCGGACCAAGACGGTGAAGAAGACCTCGAGGCAGGTGATCGAGAAGTACTACTCGCGGATGACGCTCGACTTCCACACCAACAAGAAGGTGCTCGAGGAG	;;	;;
while (<IN>) {
	chomp;
	@aa = split/\t/, $_;
	if ($aa[3] ne ";;") { # circseqcup_res
		$seq{$aa[3]} = $aa[0]."|".$aa[2];
	}
	if ($aa[4] ne ";;") { # CIRI-full_res
		$seq{$aa[4]} = $aa[0]."|".$aa[2];
	}
	if ($aa[5] ne ";;") { # CIRCexplorer_res
		$seq{$aa[5]} = $aa[0]."|".$aa[2];
	}
}
close IN;

foreach $key (keys %seq) {
	$id{$seq{$key}} .= $key."	";
	$count{$seq{$key}} ++;
}

open OUT, ">$ARGV[1]" or die "NO output FILE!\n";
foreach $k (sort keys %count) {
	$posi = (split/\|/, $k)[0];
	$id = (split/\|/, $k)[1];
	$genomic_length = (split/_/, $posi)[2] - (split/_/, $posi)[1] + 1;
	print OUT "$posi	$genomic_length	$id	$count{$k}	$id{$k}\n";
}
close OUT;
