#!/bin/bash
#
# # The first input parameter indicates the KB_KEY, allowing for
# multiple KaBOB builds in the same Docker environment.
#
# The second input parameter should be an integer (1-5) indicating the
# number of docker containers to use to generate ICE RDF for NCBI
# taxonomy code 9606 (human).
#
#
# This script inspired by:
# http://kimh.github.io/blog/en/docker/using-docker-to-run-cucumber-tests-in-parallel/
#

KB_KEY=$1
TAX="-t 9606"
MAVEN="/usr/bin/mvn"

case $2 in
    1) DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES,IREFWEB_HUMAN_ONLY,REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ,UNIPROT_SWISSPROT,UNIPROT_IDMAPPING")
       ;;
    2) DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES,IREFWEB_HUMAN_ONLY,REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ" "UNIPROT_SWISSPROT,UNIPROT_IDMAPPING")
       ;;
    3) DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES,IREFWEB_HUMAN_ONLY,REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ" "UNIPROT_SWISSPROT" "UNIPROT_IDMAPPING")
       ;;
    4) DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES,IREFWEB_HUMAN_ONLY" "REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ" "UNIPROT_SWISSPROT" "UNIPROT_IDMAPPING")
       ;;
    5) DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES" "IREFWEB_HUMAN_ONLY" "REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ" "UNIPROT_SWISSPROT" "UNIPROT_IDMAPPING")
       ;;
    *) echo "Expected a number between 1-5 for the number of Docker containers to spin up to generate RDF. Observed $2 instead. By default, only a single container will be used for generating RDF."
       DATASOURCES=("PR_MAPPINGFILE,PHARMGKB_DRUG,PHARMGKB_DISEASE,PHARMGKB_GENE,PHARMGKB_RELATION,NCBIGENE_MIM2GENE,UNIPROT_TREMBL_SPARSE_HUMAN_ONLY,MIRBASE,DRUGBANK,HGNC,NCBIGENE_GENEINFO,NCBIGENE_REFSEQUNIPROTCOLLAB,GOA_HUMAN,HP_ANNOTATIONS_ALL_SOURCES,IREFWEB_HUMAN_ONLY,REFSEQ_RELEASECATALOG,NCBIGENE_GENE2REFSEQ,UNIPROT_SWISSPROT,UNIPROT_IDMAPPING")
       ;;
esac


DID=""
COUNTER=1
for ds in "${DATASOURCES[@]}"
do
    echo "Starting kabob-base container to process: $ds"
<<<<<<< HEAD
    DID=$DID" "`docker run -d --name "rdf_gen_$COUNTER" --volumes-from kabob_data-$KB_KEY callahantiff/kabob-base:0.3 ./ice-rdf-gen.sh "$TAX" "$ds" "$COUNTER"`
=======
    DID=$DID" "`docker run -d --name "rdf_gen_$COUNTER" --volumes-from kabob_data-$KB_KEY billbaumgartner/kabob-base:0.3 ./ice-rdf-gen.sh "$TAX" "$ds" "$MAVEN" "$COUNTER"`
>>>>>>> bill-baumgartner/master
    COUNTER=$((COUNTER + 1))
done
docker wait $DID
docker rm $DID
