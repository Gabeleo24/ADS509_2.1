#!/bin/bash

# Create a temporary container to copy data to volumes
docker run --rm -v ads509_notebooks:/notebooks -v ads509_m1_results:/m1_results -v $(pwd):/source busybox sh -c "
  cp -r /source/notebooks/* /notebooks/ && 
  cp -r '/source/notebooks/M1 Results'/* /m1_results/ && 
  cp '/source/Lyrics and Description EDA.ipynb' /notebooks/
"

echo "Data copied to Docker volumes"