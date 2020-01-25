# usearch-docker-onbuild
Docker image for using usearch

The docker image contains a basic setup of Ubuntu 16.04 with onbuild instructions to setup [usearch](https://www.drive5.com/usearch/). I used it with the free 32-bit version. Find the image on [Dockerhub](https://hub.docker.com/repository/docker/chrishah/usearch-docker-onbuild/general).

To set it up you need to:
 - Download your own version of usearch and rename the binary to `usearch`
 - Pull this image from dockerhub (or build it locally with the Dockerfile in the repo)
 - Build your own image locally

If you have not cloned this repo you need to prepare a Dockerfile first. If you have cloned it you can use the existing file `Dockerfile_usearch`.
Build your image locally (this will first pull the image `chrishah/usearch-docker-onbuild` from dockerhub):
```bash
#prepare the Dockerfile, if you don't have it
echo -e "FROM chrishah/usearch-docker-onbuild:v012020" > Dockerfile_usearch

#build the image (remember that a binary called usearch needs to be in your working directory)
docker build --file ./Dockerfile_usearch -t usearch .
```


Once you've setup your image, you can use usearch like so:
```bash
docker run -v $(pwd):/in/ -w /in/ --rm usearch usearch
```

The image also contains a bash script that automatically merges paired-end fastq data with the `-fastq_mergepairs` functionality of usearch. Since the 32-bit version of usearch has an upper memory limit, the script first splits up the fastq data into batches of n reads (per default n=4,000,000, which seems to be fine with respect to memory from my experience), then merges the individual batches and finally concatenates and compresses all output.
```bash
docker run -v $(pwd):/in/ -w /in/ --rm usearch usearch_mergepairs.sh forw.fastq.gz reve.fastq.gz outputprefix 5 4000000
```
