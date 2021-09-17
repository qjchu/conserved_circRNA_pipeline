# afterMummer2_extract_genome_seq_osa40311circs.pl
@genomes = ("/data2/chuqj/genomes/ensembl_genomes_v38/fasta/aegilops_tauschii/dna/Aegilops_tauschii.ASM34733v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/amborella_trichopoda/dna/Amborella_trichopoda.AMTR1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/arabidopsis_lyrata/dna/Arabidopsis_lyrata.v.1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/beta_vulgaris/dna/Beta_vulgaris.RefBeet-1.2.2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/brachypodium_distachyon/dna/Brachypodium_distachyon.v1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/brassica_napus/dna/Brassica_napus.AST_PRJEB5043_v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/brassica_oleracea/dna/Brassica_oleracea.v2.1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/brassica_rapa/dna/Brassica_rapa.IVFCAASv1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/chlamydomonas_reinhardtii/dna/Chlamydomonas_reinhardtii.v3.1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/chondrus_crispus/dna/Chondrus_crispus.ASM35022v2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/corchorus_capsularis/dna/Corchorus_capsularis.CCACVL1_1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/cucumis_sativus/dna/Cucumis_sativus.ASM407v2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/cyanidioschyzon_merolae/dna/Cyanidioschyzon_merolae.ASM9120v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/dioscorea_rotundata/dna/Dioscorea_rotundata.TDr96_F1_Pseudo_Chromosome_v1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/galdieria_sulphuraria/dna/Galdieria_sulphuraria.ASM34128v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/glycine_max/dna/Glycine_max.Glycine_max_v2.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/gossypium_raimondii/dna/Gossypium_raimondii.Graimondii2_0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/helianthus_annuus/dna/Helianthus_annuus.HanXRQr1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/hordeum_vulgare/dna/Hordeum_vulgare.Hv_IBSC_PGSB_v2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/leersia_perrieri/dna/Leersia_perrieri.Lperr_V1.4.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/lupinus_angustifolius/dna/Lupinus_angustifolius.LupAngTanjil_v1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/manihot_esculenta/dna/Manihot_esculenta.Manihot_esculenta_v6.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/medicago_truncatula/dna/Medicago_truncatula.MedtrA17_4.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/musa_acuminata/dna/Musa_acuminata.MA1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/nicotiana_attenuata/dna/Nicotiana_attenuata.NIATTr2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_barthii/dna/Oryza_barthii.O.barthii_v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_brachyantha/dna/Oryza_brachyantha.Oryza_brachyantha.v1.4b.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_glaberrima/dna/Oryza_glaberrima.AGI1.1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_glumaepatula/dna/Oryza_glumaepatula.ALNU02000000.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_indica/dna/Oryza_indica.ASM465v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_longistaminata/dna/Oryza_longistaminata.O_longistaminata_v1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_meridionalis/dna/Oryza_meridionalis.Oryza_meridionalis_v1.3.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_nivara/dna/Oryza_nivara.AWHD00000000.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_punctata/dna/Oryza_punctata.AVCL00000000.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_rufipogon/dna/Oryza_rufipogon.OR_W1943.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/oryza_sativa/dna/Oryza_sativa.IRGSP-1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/ostreococcus_lucimarinus/dna/Ostreococcus_lucimarinus.ASM9206v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/phaseolus_vulgaris/dna/Phaseolus_vulgaris.PhaVulg1_0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/physcomitrella_patens/dna/Physcomitrella_patens.ASM242v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/populus_trichocarpa/dna/Populus_trichocarpa.JGI2.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/prunus_persica/dna/Prunus_persica.Prunus_persica_NCBIv2.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/selaginella_moellendorffii/dna/Selaginella_moellendorffii.v1.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/setaria_italica/dna/Setaria_italica.JGIv2.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/solanum_lycopersicum/dna/Solanum_lycopersicum.SL2.50.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/solanum_tuberosum/dna/Solanum_tuberosum.SolTub_3.0.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/sorghum_bicolor/dna/Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/theobroma_cacao/dna/Theobroma_cacao.Theobroma_cacao_20110822.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/trifolium_pratense/dna/Trifolium_pratense.Trpr.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/triticum_aestivum/dna/Triticum_aestivum.TGACv1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/triticum_urartu/dna/Triticum_urartu.ASM34745v1.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/vitis_vinifera/dna/Vitis_vinifera.IGGP_12x.dna.toplevel.fa",
"/data2/chuqj/genomes/ensembl_genomes_v38/fasta/zea_mays/dna/Zea_mays.AGPv4.dna.toplevel.fa");

foreach $file(@genomes){
	$specie = (split/\//,$file)[6];
	open OSA, $file or die "NO $file\n";
	while (<OSA>) {
		chomp;
		if (/>(.+?) /) {
			$chr = $1;
		}
		else{
			$seq{$specie}{$chr} .= $_;
		}
	}
	close OSA;
}

open IN, "arranged_posi_osaj.txt" or die "NO arranged_posi_osaj.txt FILE!\n";
# 47 plants
@rice = ("chondrus_crispus", "galdieria_sulphuraria", "cyanidioschyzon_merolae", "ostreococcus_lucimarinus", "chlamydomonas_reinhardtii", "physcomitrella_patens", "selaginella_moellendorffii", "musa_acuminata", "oryza_brachyantha", "oryza_glaberrima", "oryza_rufipogon", "oryza_sativa", "oryza_glumaepatula", "oryza_barthii", "oryza_longistaminata", "oryza_meridionalis", "oryza_punctata", "leersia_perrieri", "hordeum_vulgare", "triticum_urartu", "triticum_aestivum", "aegilops_tauschii", "brachypodium_distachyon", "sorghum_bicolor", "zea_mays", "vitis_vinifera", "gossypium_raimondii", "theobroma_cacao", "arabidopsis_thaliana", "arabidopsis_lyrata", "brassica_rapa", "brassica_oleracea", "brassica_napus", "cucumis_sativus", "lupinus_angustifolius", "glycine_max", "phaseolus_vulgaris", "medicago_truncatula", "trifolium_pratense", "prunus_persica", "manihot_esculenta", "populus_trichocarpa", "beta_vulgaris", "helianthus_annuus", "solanum_tuberosum", "solanum_lycopersicum", "amborella_trichopoda");

while (<IN>) {
	if (!/^circ_name/) {
		@aa = split/\t/, $_;
		$seq_name = $aa[0];
		open OUT, ">$seq_name\.fasta";
		for (my $var = 1; $var <= 47; $var++) {
			if ($aa[$var] =~ /\|/) {
				@posi = split/\|/, $aa[$var];
				$length = $posi[2] - $posi[1] + 1;
				$start = $posi[1] - 1;
				$circseq = substr($seq{$rice[$var-1]}{$posi[0]}, $start, $length);
				print OUT ">$rice[$var-1]\n$circseq\n";
				$genome{$rice[$var-1]} .= $circseq;
			}
			else{
				print OUT ">$rice[$var-1]\n\n";
			}
		}
		close OUT;
	}
}
close IN;

foreach $r(@rice){
	open S, ">$r\_pseudo_genome_seq.txt";
	print S ">1\n$genome{$r}\n";
	close S;
}
