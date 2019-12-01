#!/bin/bash

mkdir -p gitbucket-data/plugins
pushd gitbucket-data/plugins

wget -N https://github.com/alexandremenif/gitbucket-mirror-plugin/releases/download/1.1.1/gitbucket-mirror-plugin-assembly-1.1.1.jar
wget -N https://github.com/takezoe/gitbucket-maven-repository-plugin/releases/download/1.5.0/gitbucket-maven-repository-plugin-assembly-1.5.0.jar
wget -N https://github.com/gitbucket-plugins/gitbucket-announce-plugin/releases/download/1.12.0/gitbucket-announce-plugin-assembly-1.12.0.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-desktopnotify-plugin/releases/download/4.32.0/gitbucket-desktopnotify-plugin_2.13-4.32.0.jar
wget -N https://github.com/gitbucket/gitbucket-gist-plugin/releases/download/4.18.0/gitbucket-gist-plugin-4.18.0.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-commitgraphs-plugin/releases/download/4.32.0/gitbucket-commitgraphs-plugin_2.13-4.32.0.jar
wget -N https://github.com/asciidoctor/gitbucket-asciidoctor-plugin/releases/download/1.1.0/gitbucket-4.32-asciidoctor-plugin-assembly-1.1.0.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-bugspots-plugin/releases/download/4.32.0/gitbucket-bugspots-plugin_2.13-4.32.0.jar
wget -N https://github.com/gitbucket/gitbucket-pages-plugin/releases/download/1.8.0/gitbucket-pages-plugin-1.8.0.jar
wget -N https://github.com/mrkm4ntr/gitbucket-network-plugin/releases/download/1.7.0/gitbucket-network-plugin_2.13-1.7.0.jar
wget -N https://github.com/gitbucket/gitbucket-emoji-plugin/releases/download/4.6.0/gitbucket-emoji-plugin-4.6.0.jar
wget -N https://github.com/amuramatsu/gitbucket-rst-plugin/releases/download/0.5.0/gitbucket-rst-plugin-assembly-0.5.0.jar
wget -N https://github.com/gitbucket-plugins/gitbucket-explorer-plugin/releases/download/7.0.0/gitbucket-explorer-plugin-7.0.0.jar
wget -N https://github.com/nus/gitbucket-plantuml-plugin/releases/download/v1.6.1/gitbucket-plantuml-plugin-assembly-1.6.1.jar
wget -N https://github.com/YoshinoriN/gitbucket-monitoring-plugin/releases/download/v4.0.1/gitbucket-monitorting-plugin-4.0.1.jar
wget -N https://github.com/kounoike/gitbucket-html5media-plugin/releases/download/1.1.0/gitbucket-html5media-plugin-assembly-1.1.0.jar
wget -N https://github.com/kounoike/gitbucket-ipynb-plugin/releases/download/0.3.2/gitbucket-ipynb-plugin-assembly_4.26.0-0.3.2.jar
wget -N https://github.com/takezoe/gitbucket-ci-plugin/releases/download/1.9.0/gitbucket-ci-plugin-assembly-1.9.0.jar
wget -N https://github.com/jyuch/gitbucket-backup-plugin/releases/download/1.2.2/gitbucket-backup-plugin-1.2.2.jar
wget -N https://github.com/YoshinoriN/gitbucket-application-logs-plugin/releases/download/v2.0.0/gitbucket-application-logs-plugin-2.0.0.jar
rm *.1 *.2

popd

