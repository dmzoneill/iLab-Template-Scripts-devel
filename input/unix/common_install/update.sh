#!/bin/sh

rsync -vazHP irvdsm001.ir.intel.com::dist/euec/vas/ ./vasclnts/ --delete --delete-excluded --stats

