# Fungison
This is a clean version of CORASON integrated with the FUNGIT repository. It is tailored for fungal genomes. It wont drop large jobs on thousands of PKSs and NRPSs and in general for long sequences

# Download the precompile package
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

# Install the SVG module for perl, Method 1
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

# expected output:



RESULTS:
in a folder called G3P1_results:
