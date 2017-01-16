#!/bin/sh

OPTIONS=${@:-.}

exec grip "$OPTIONS" 0.0.0.0
