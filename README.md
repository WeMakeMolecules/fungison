# Fungison
This is a clean version of CORASON integrated with the FUNGIT repository. It is tailored for fungal genomes. It wont drop large jobs on thousands of PKSs and NRPSs and in general for long sequences

# Download the precompiled package
	wget https://github.com/WeMakeMolecules/fungison/raw/main/FUNGISON.tar.gz
# Decompress the file
    tar -xvf FUNGISON.tar.gz
# make the nw_distance file executable
	cd FUNGISON/bin
	chmod +x nw_distance
    
# Install the dependencies
    sudo apt install blast+
    sudo apt install iqtree
    sudo apt install mafft

# Install the SVG module for perl, Method 1
        perl -MCPAN -e shell
        install SVG

# Install the SVG module for perl, Method 2
	sudo apt install cpanminus
        cpanm SVG
# Loading the example dataset
    cd FUNGISON/
    tar -xvf EXAMPLE_DATASET.tar.gz
    mv EXAMPLE_DATASET/GENOMES bin/
    mv EXAMPLE_DATASET/GENOMES.IDs bin/
    mv EXAMPLE_DATASET/G3P1.query .
    rm -r EXAMPLE_DATASET*

# Test run fungison
    perl fungison.pl -d full -x FORMATDB -q 1  -r 1 -e 0.000001 -s 400 -f 5 -q G3P1.query 

# expected outputi STDIN:
	USAGE: perl fungison.pl <OPTIONS>
	
	OPTIONS:
	
	-q FILE.query   	|QUERY FILE, [a file with .query extension}
	-r 1234			|REFERENCE GENOME ID FROM GENOMES.IDs, WHEN NOT USING -d full MAKE SURE THE ENTRY IS LISTED IN -d [a number]
	-e 0.0000001		|E-VALUE CUTOFF, [a number]
	-s 200	        	|BIT-SCORE CUTOFF [a number]
	-f 10			|NUMBER OF FLAKING GENES INCLUDED IN THE ANALYSIS, [a number]
	-d full  OR -db 1,2,3	|IDs OF THE GENOMES INCLUDED IN THE ANALYSIS, ][full= entire database OR selected genomes separated by ',' ]
	-x n or -F FORMATDB	|FORMAT THE DATABASE SELECTED WITH THE -d OPTION, ['no' is the recommeded option or 'FORMATDB']
	
	The database will be created with full entries
	All arguments were provided
	Running CORASON2 with query G3P1.query and reference gene context from entry ID:1, Agaricus_bisporus_AB58GCA_008271545.1
	The e-value cutoff is 0.000001 and  the bitscore cut-off is 400
	You are searching in the full database with 3 entries, the search will be done for 5 genes flanking the query hits
	
	
	
	##########################################################################
	CORASON: CORE ANALYSIS OF SYNTENIC ORTHOLOGOUS NATURAL PRODUCT BGCs
	this is version 2.1 uses iqtree, no trimming, phylo sort with nw_distances
	Smartmatch silenced, order files exist if trees fail, aligning with mafft
	Adapted to run with wrapper fungison.pl
	latest version modified by Pablo Cruz-Morales september 2022
	##########################################################################
	
	Your working directory is /home/ynp/Desktop/FUNGISON/bin
	Program lists have been created
	An organism identifier has been added to each sequence
	Formatting the database...
	the database has been formatted
		
	Searching for homologs of the query...
	Sequences found
	Searching for clusters related to the query...
	Clusters found
	There are 5 organisms with similar clusters
	Aligning the sequences...
	Creating a tree of query homologs (single marker)...
	Calculating the BGC core...
	The core has been calculated
	core line number 4 Core!
	core line number ¡4!
	Best cluster 1_5356
	Aligning...
	Sequences were aligned
	Creating matrix...
	renaming...
	
	Formating matrix for BGC tree..
	constructing the BGC tree using IQTREE with  1000 bootstraps replicates...
	Drawing the genome contexts with the order of the BGC tree...
	BGC_TREE.orderDrawing the BGCs with files 1_5356.input,2_524.input,2_525.input,3_6762.input,3_6763.input : 
	rm: cannot remove 'Cluster*.BLAST': No such file or directory
	rm: cannot remove 'QUERY_HITS.aln.uniqueseq.phy': No such file or directory
	BGCs found in the following genome IDs:
	
	1,2,3,
	There are 5 organisms with similar clusters
	There is a core composed by 4 orhtolog(s) in this BGC
	The core is annotated in the reference organism as follows:
	fig|666666.797168.peg.5354	unknown function
	fig|666666.797168.peg.5358	unknown function
	fig|666666.797168.peg.5359	Amino acid permease
	fig|666666.797168.peg.5360	unknown function
	Done
	Have a great day
	


# Cheking results located in a folder called G3P1_results:
	cd G3P1_results/
	ls
	G3P1.BLAST  G3P1.core.aln  G3P1.core.contree  G3P1.gene_context.svg  G3P1.hits.aln  G3P1.hits.contree  G3P1.report
	
# Cheking the  G3P1.gene_context.svg file ( you can open it in  a web browser)
![G3P1 gene_context](https://user-images.githubusercontent.com/68575424/190658936-74af60b8-c9b1-48e0-825b-c3ab34d0966e.svg)

# Cheking the  G3P1.core.contree ( you can open it in  a web browser) made with 4synthenic orthologs found in 5 genomes
here i opened the file with figtree (http://tree.bio.ed.ac.uk/software/figtree/)

![G3P1 core contree](https://user-images.githubusercontent.com/68575424/190661230-d5c70214-fdf7-4444-a3d5-10845acfb93c.jpg)



