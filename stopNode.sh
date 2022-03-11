#!/bin/bash

pid=`ps aux | grep "geth"|grep "networkid"|awk '{print $2}'`
kill -9 $pid

