# deepVariant-docker02

# create input output directory
mkdir -p input output


# create a docker file
nano Dockerfile

# write the docker
## Use the official DeepVariant Docker image
FROM google/deepvariant:latest

## Set environment variables for input and output directories
ENV INPUT_DIR=/input
ENV OUTPUT_DIR=/output
ENV REF_GENOME=/input/reference.fasta

## Create input and output directories in the container
RUN mkdir -p /input /output

## Set the default command to run DeepVariant
ENTRYPOINT ["/opt/deepvariant/bin/run_deepvariant"]

## Provide default arguments for DeepVariant
CMD ["--model_type=WGS", \
     "--ref=/input/reference.fasta", \
     "--reads=/input/sample.bam", \
     "--output_vcf=/output/sample.vcf", \
     "--output_gvcf=/output/sample.g.vcf", \
     "--num_shards=2"]

# import your data
wget -O input/sample.bam https://storage.googleapis.com/deepvariant/quickstart-testdata/NA12878_S1.chr20.10_10p1mb.bam
wget -O input/sample.bam.bai https://storage.googleapis.com/deepvariant/quickstart-testdata/NA12878_S1.chr20.10_10p1mb.bam.bai
wget -O input/reference.fasta https://storage.googleapis.com/deepvariant/quickstart-testdata/ucsc.hg19.chr20.unittest.fasta

# create indexing for fasta
## updating and installing file
sudo apt-get update
sudo apt-get install -y samtools

## creating index
samtools faidx input/reference.fasta

# Build the docker image
docker build -t deepvariant_image .

# rerun building 
docker run -v $(pwd)/input:/input -v $(pwd)/output:/output deepvariant_image

