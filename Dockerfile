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
