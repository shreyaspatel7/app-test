#!/bin/sh

setp_install_depenadacies() {
   pip install -r requirements.txt --user
}

step_run_service(){
    python ./app.py
}

main (){
    setp_install_depenadacies
    step_run_service
}

main