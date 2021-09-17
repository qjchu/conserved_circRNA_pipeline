# ount_reads_from_bowtie.pl
open IN, $ARGV[0] or die "NO 137_osaj_genomic_seq_2fold.txt FILE!\n";
while (<IN>) {
	chomp;
	if (/>(.*)/) {
		$seq_name = $1;
	}
	else{
		$seq_len = length($_) / 2;
		$ha{$seq_name} = $seq_len;
	}
}
close IN;

open B, $ARGV[1] or die;
while (<B>) {
	chomp;
	@aa = split/\t/, $_;
	if ($aa[3] < $ha{$aa[2]} -10 && $aa[3] > $ha{$aa[2]} +10 -length($aa[4]) ) {
		$count{$aa[2]} ++;
		$reads{$aa[2]} .= $aa[0].",";
	}
	# if ($aa[3] < $ha{$aa[2]} -5 && $aa[3] > $ha{$aa[2]} +5 -length($aa[4]) ) {
	# 	$count2{$aa[2]} ++;
	# 	$reads2{$aa[2]} .= $aa[0].",";
	# }
}
close OUT;

open OUT, ">$ARGV[1]\_count.txt";
foreach	$key(sort keys %ha){
	# print OUT "$key\t$ha{$key}\t$count{$key}\t$reads{$key}\t$count2{$key}\t$reads2{$key}\n";
	print OUT "$key\t$ha{$key}\t$count{$key}\t$reads{$key}\n";
}
