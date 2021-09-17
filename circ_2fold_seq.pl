open IN, "$ARGV[0]" or die "NO genomic seq FILE!\n";
while (<IN>) {
	chomp;
	if (/>(.*)/) {
		$name = $1;
	}else{
		$seq{$name} = $_.$_;
	}
}
close IN;

open OUT, ">$ARGV[1]" or die "NO output 2-fold  genomic seq FILE!\n";
foreach $p(sort keys %seq){
	print OUT ">$p\n$seq{$p}\n";
}
close OUT;
