# circ_full_length.pl
open CUP, "$ARGV[0]" or die "NO circseqcup result FILE!\n";
# format of circseqcup
# 1_6463646_6463760	25	0	exon	114	2	AG GT	0	0
# GCAGTGGCTGTTTGCTCTTTGATCTGCATGTCCTTTGGCCTTCACCGACGACGAGATGGGCTCTGCTCCGTTCGGTGACGCCGTCGCCGGCGGTGGGCTCTATGAGTACCAGGG

while (<CUP>) {
	chomp;
	@aa = split/\t/, $_;
	if ($#aa > 2) {
		@bb = split/\_/, $aa[0];
		$start = $bb[1] + 1;
		$name = $bb[0]."_".$start."_".$bb[2];

		$circ_name{$name} = 1;
	}
	else{
		$circseqcup{$name} = $_;
	}
}
close CUP;

open G, "$ARGV[1]" or die "NO genome sequences FILE!\n";
# circseqcup_res/Oryza_sativa.IRGSP-1.0.dna.toplevel.chrname.fa
while (<G>) {
	chomp;
	if (/>(.+)/) {
		$name = $1;
	}
	else{
		$seq{$name} .= $_;
	}
}
close G;

open CIRI, "$ARGV[2]" or die "NO CIRI-full result FILE!\n";
# format of CIRI-full
# BSJ	Chr	Start	End	GTF-annotated_exon	Cirexon	Coveage	BSJ_reads_information RO_reads_information Original_gene	strain

while (<CIRI>) {
	chomp;
	@aa = split/\t/, $_;
	$name = $aa[1]."_".$aa[2]."_".$aa[3];
	$circ_name{$name} = 1;

	$start = $aa[2] -1;

	@seq_num = ();
	@bb = split/\,/, $aa[6];
	for ($var = 0; $var <=$#bb; $var++) {
		if ($bb[$var] ne '') {
			if ($bb[$var] > 0) {
				$seq_num = $start + $var;
				push @seq_num, $seq_num;
			}
		}
	}
	foreach $k (@seq_num) {
		$cirifull{$name} .= substr($seq{$aa[1]},$k,1);
	}
}
close CIRI;

open CIRC, "$ARGV[3]" or die "NO CIRCexplorer result FILE!\n";
# format of CIRCexplorer
# 1	34720023	34720517	circular_RNA/6	1	-	34720023	34720023	0,0,0	3	65,178,80	0,161,414	6	circRNA	Os01t0816400-02	Os01t0816400-02	6,5,4	1:34718911-34720023|1:34720517-34721666

while (<CIRC>) {
	chomp;
	@aa = split/\t/, $_;
	$start = $aa[1] + 1;
	$name = $aa[0]."_".$start."_".$aa[2];
	$circ_name{$name} = 1;

	@exon_length = split/\,/, $aa[10];
	@exon_start = split/\,/, $aa[11];
	for ($var = 0; $var <=$#exon_length; $var++) {
		$circexplorer{$name} .= substr($seq{$aa[0]}, $aa[1] + $exon_start[$var], $exon_length[$var]);
	}
}
close CIRC;

open OUT, ">$ARGV[4]\_full_length.txt" or die "NO output FILE!\n";
foreach $key (sort keys %circ_name) {
	$if_circseqcup = "";
	$if_cirifull = "";
	$if_circexplorer = "";
	if (exists $circseqcup{$key}) { $if_circseqcup = "circseq_cup,"; }
	if (exists $cirifull{$key}) { $if_cirifull = "CIRI-full,"; }
	if (exists $circexplorer{$key}) { $if_circexplorer = "CIRCexplorer,"; }
	print OUT "$key	$if_circseqcup$if_cirifull$if_circexplorer	$circseqcup{$key}	$cirifull{$key}	$circexplorer{$key}\n";
}
close OUT;
