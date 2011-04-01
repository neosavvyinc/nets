#!/bin/bash

rm -rf /nets/storage
mkdir /nets/storage
scp -r root@nets.neosavvy.com:/nets/storage/* /nets/storage/