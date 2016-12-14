#!/bin/bash

docker run -it --rm -v $PWD:/data:ro -p 6419:6419 menski/grip
