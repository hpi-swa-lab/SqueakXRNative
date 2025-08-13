#!/bin/bash

set -e
adb reverse tcp:8080 tcp:8080
