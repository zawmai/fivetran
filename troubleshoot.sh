#!/bin/bash

# extract all IP Addresses into a single column
awk '{print $4}' log.txt

# count unique IP addresses
awk '{print $4}' log.txt | uniq -u | wc -l