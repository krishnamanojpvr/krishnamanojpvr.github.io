#!/usr/bin/env fish

set subdomain manojliveme 

function buildRepo
    set repo_url "https://github.com/krishnamanojpvr/manojliveme.git"
    set repo_dir manojliveme

    if test ! -e site
        mkdir site
    else if test -e ./site/$subdomain
        rm -rf ./site/$subdomain
    end

    if test ! -e buildfiles
        mkdir buildfiles
    else
        rm -rf ./buildfiles/*
    end

    echo "Cloning $repo_url"
    set auth_repo_url (string replace "https://" "https://$PA_TOKEN:@" $repo_url)
    git clone "$auth_repo_url" "$repo_dir"

    cd $repo_dir
    bun i
    bun run build
    cd -

    mkdir -p "./site/$subdomain"
    cp -r $repo_dir/out/* ./site/$subdomain

    rm -rf $repo_dir
end

buildRepo
