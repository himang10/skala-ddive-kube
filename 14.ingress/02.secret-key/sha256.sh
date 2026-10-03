#!/bin/bash

DATA="hello"
FILE="tls-process.sh"

echo "sha256 $DATA"
echo  $DATA | sha256

echo "sha256 $FILE"
cat tls-process.sh | sha256
