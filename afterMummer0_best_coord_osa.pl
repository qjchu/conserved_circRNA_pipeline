# afterMummer0_best_coord_osa.pl
open IN1, $ARGV[0]."2osaj_coord.txt" or die "NO **2osaj_coord.txt FILE!\n";
@out = sort {$a->[7] cmp $b->[7] or $b->[4] <=> $a->[4] or $b->[6] <=> $a->[6]} map [(split/\t/,$_)],<IN1>;
open OUT1, ">".$ARGV[0]."2osaj_coord_best.txt" or die "NO sorted **2osaj_coord.txt FILE!\n";
foreach $out (@out) {
	$circ_name = @$out[7];
	if (!exists $ha{$circ_name}) {
		$ha{$circ_name} = 1;
		print OUT1 "@$out";
	}
}
close IN1;
