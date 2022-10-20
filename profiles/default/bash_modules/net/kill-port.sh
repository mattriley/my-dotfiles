#!/bin/bash

function net.kill_port { 

    lsof -i TCP:"$1" | grep LISTEN | awk '{print $2}' | xargs kill -9 

}
