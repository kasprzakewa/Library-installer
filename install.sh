#!/bin/bash

repository_path=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -n "$repository_path" ]; then
    cd "$repository_path"

    if [ -e ".gitmodules" ]; then
        superproject_path=$(git rev-parse --show-superproject-working-tree)
        submodule_name=$(cat .gitmodules | grep "path" | awk '{print $3}')

        if [ -d "./$submodule_name/build" ]; then
            if [ ! -d "./$submodule_name/build/install" ]; then
                cd "./$submodule_name/build"
                cmake -DCMAKE_INSTALL_PREFIX:PATH=./install .
                make 
                sudo make install
            fi
        else
            cd "$submodule_name"
            ./build.sh
            cd build
            cmake -DCMAKE_INSTALL_PREFIX:PATH=./install .
            make 
            sudo make install
        fi
    else
        echo -e -n "\nSubmodule not found, but can be installed with git submodule add https://github.com/yksz/c-logger.git. Do you want to install it? [Y/N]"
        read -r choice

        if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
            git submodule add https://github.com/yksz/c-logger.git
            git submodule update --init --recursive
            cd c-logger
            ./build.sh
            cd build
            cmake -DCMAKE_INSTALL_PREFIX:PATH=./install .
            make 
            sudo make install
        elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
            echo "You chose not to install. Exiting..."
            exit 1
        else
            echo "Invalid choice. Exiting..."
            exit 1
        fi
    fi
else
    wget https://github.com/yksz/c-logger/archive/refs/heads/master.zip
    unzip master.zip
    rm master.zip
    mv c-logger-master c-logger
    cd c-logger
    ./build.sh
    cd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH=./install .
    make 
    sudo make install
fi