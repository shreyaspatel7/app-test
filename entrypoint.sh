#!/bin/sh

step_run_service(){
    python ./app.py
}

main (){
    step_run_service
}

main