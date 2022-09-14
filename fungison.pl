use strict;
#use warnings;
use Getopt::Long qw(GetOptions);


print "USAGE: perl fungison.pl <OPTIONS>\n\n";
print "OPTIONS:\n\n";
print "-q FILE.query   	|QUERY FILE, a file with .query extension\n";
print "-r 1234			|REFERENCE GENOME ID FROM RAST.IDs INDEX, a number\n";
print "-e 0.0000001		|E-VALUE CUTOFF, a number\n";
print "-s 200	        	|BIT-SCORE CUTOFF a number\n";
print "-d full  OR -db 1,2,3	|IDs OF THE GENOMES INCLUDED IN THE ANALYSIS, full= ENTIRE DATABASE, selected genomes separated by ',' \n";
print "-f 10			|NUMBER OF FLAKING GENES INCLUDED IN THE ANALYSIS, a number\n\n";

my $query;
my $reference;
my $evalue;
my $score;
my $database;
my $flanks;
my $refname;
my $databasesize;
my $dbstatement;
my $filenames;

GetOptions(

'q=s' => \$query,
'r=s' => \$reference,
'e=s' => \$evalue,
's=s' => \$score,
'd=s' => \$database,
'f=s' => \$flanks,


) or die "missing parameters\n";

#printing the globals.pm file	
open OUT, ">./bin/globals.pm";
#printign defaults
print OUT "use lib \'\.\/\'\;\n";
print OUT "use Cwd\;\n";
print OUT "\$eCluster=\"0.1\"\;\n"; 		
print OUT "\$eCore=\"0.1\"\;\n"; 		
print OUT "\$RAST_IDs=\"RAST.IDs\"\;\n";
print OUT "\$BLAST_CALL=\"\"\;\n";
print OUT "\$FORMAT_DB=\"0\"\;\n"; 
print OUT "\$currWorkDir = &Cwd::cwd();\n";
print OUT "\$dir=\$currWorkDir\;\n";		
print OUT "\$NAME= pop \@\{\[split m|/|, \$currWorkDir]}\;\n";					
print OUT "\$BLAST=\"\$NAME.blast\";\n";
print OUT "\$NUM = `wc -l < \$RAST_IDs`;\n";
print OUT "chomp \$NUM;\n";
print OUT "\$NUM=int(\$NUM);\n";
#edit this to zoom in or out inthe SVG canvas
print OUT "\$RESCALE=195000;\n";	

#printing user input parameters
	if ($query=~/.+query/) {
	print OUT "\$QUERIES=\"$query\"\;\n";
	system "cp $query ./bin/$query";
	}
	else {
	die "missing argument -q FILE.query [QUERY FILE, a file with .query extension]\n"; 
	}
	if ($reference) {
	$refname=`awk  '(\$4==$reference){print \$3}' ./bin/RAST.IDs`;
	chomp $refname;
	print OUT "\$SPECIAL_ORG=\"$reference\";\n";
	}
	else {
	die "missing argument -r 1234 [REFERENCE GENOME ID FROM RAST.IDs INDEX, a number]\n"; 
	}
	if ($evalue) {
	print OUT "\$e=\"$evalue\"\;\n";
	}
	else {
	die "missing argument -e 0.0000001 [E-VALUE CUTOFF, a number]\n"; 
	}
	if ($score) {
	print OUT "\$BITSCORE=\"$score\"\;\n";
	}
	else {
	die "missing argument -s 200 [BIT-SCORE CUTOFF a number]\n";
	}
	if ($database=~/full/) {
	$databasesize=`grep "." ./bin/RAST.IDs  -c`;
	chomp $databasesize;
	$dbstatement="You are searching in the full database with $databasesize entries";
	print OUT "\$LIST=\"\";\n";
	}
	elsif ($database=~/,/) {
	print OUT "\$LIST=\"$database\";\n";
	$dbstatement="You are searching in entries $database";
	}
	else {
	die "missing argument -d full  OR -db 1,2,3 [IDs OF THE GENOMES INCLUDED IN THE ANALYSIS, full= ENTIRE DATABASE, selected genomes separated by ',']\n";
	}
	if ($flanks) {
	print OUT "\$ClusterRadio=\"$flanks\"\;\n"; 
	}
	else {
	die "missing argument -f 10 [NUMBER OF FLAKING GENES INCLUDED IN THE ANALYSIS, a number]\n";
	}
close OUT;
print "All arguments were provided\n";
print "Running CORASON2 with query $query and reference gene context from entry ID:$reference, $refname\n";
print "The e-value cutoff is $evalue and  the bitscore cut-off is $score\n";
print "$dbstatement, the search will be done for $flanks genes flanking the query hits\n\n";

system "cd bin; perl corason2.pl";
system "mv ./bin/*.contree ./bin/Report.report ./bin/concatenated_matrix.aln ./bin/GENE_CONTEXT.svg ./bin/QUERY_HITS.aln ./bin/*.BLAST .";

$query=~/(.+).(query)/;
$filenames="$1";
system "mkdir $filenames\_results";
system "mv concatenated_matrix.aln ./$filenames\_results/$filenames.core.aln";
system "mv GENE_CONTEXT.svg ./$filenames\_results/$filenames.gene_context.svg";
system "mv QUERY_HITS.aln ./$filenames\_results/$filenames.hits.aln";
system "mv QUERY_HITS.aln.contree ./$filenames\_results/$filenames.hits.contree";
system "mv concatenated_matrix.aln.contree ./$filenames\_results/$filenames.core.contree";
system "mv Report.report ./$filenames\_results/$filenames.report";
system "mv *.BLAST ./$filenames\_results/";



system "rm ./bin/$query";

