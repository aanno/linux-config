#!/bin/bash

mkdir -p gitbucket-data/plugins
pushd gitbucket-data/plugins

wget -N https://github.com/alexandremenif/gitbucket-mirror-plugin/releases/download/1.0.2/gitbucket-mirror-plugin-assembly-1.0.2.jar
wget -N https://github.com/takezoe/gitbucket-maven-repository-plugin/releases/download/1.3.1/gitbucket-maven-repository-plugin-assembly-1.3.1.jar
wget -N https://github.com/gitbucket-plugins/gitbucket-announce-plugin/releases/download/1.10.0/gitbucket-announce-plugin-assembly-1.10.0.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-desktopnotify-plugin/releases/download/4.10.0/gitbucket-desktopnotify-plugin_2.12-4.10.0.jar
wget -N https://github.com/gitbucket/gitbucket-gist-plugin/releases/download/4.15.0/gitbucket-gist-plugin-gitbucket_4.25.0-4.15.0.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-commitgraphs-plugin/releases/download/4.23.1/gitbucket-commitgraphs-plugin_2.12-4.23.1.jar
wget -N https://github.com/asciidoctor/gitbucket-asciidoctor-plugin/releases/download/1.0.2/gitbucket-4.10-asciidoctor-plugin-assembly-1.0.2.jar
wget -N https://github.com/yoshiyoshifujii/gitbucket-bugspots-plugin/releases/download/4.11.0/gitbucket-bugspots-plugin_2.12-4.11.0.jar
wget -N https://github.com/gitbucket/gitbucket-pages-plugin/releases/download/v1.7.1/gitbucket-pages-plugin_2.12-1.7.1.jar
wget -N https://github.com/mrkm4ntr/gitbucket-network-plugin/releases/download/1.6.1/gitbucket-network-plugin_2.12-1.6.1.jar
wget -N https://github.com/gitbucket/gitbucket-emoji-plugin/releases/download/4.5.0/gitbucket-emoji-plugin_2.12-4.5.0.jar
wget -N https://github.com/amuramatsu/gitbucket-rst-plugin/releases/download/0.4.0/gitbucket-rst-plugin-assembly-0.4.0.jar
wget -N https://github.com/gitbucket-plugins/gitbucket-explorer-plugin/releases/download/6.0.0/gitbucket-explorer-plugin_2.12-6.0.0.jar
wget -N https://github.com/nus/gitbucket-plantuml-plugin/releases/download/v1.4.0/gitbucket-plantuml-plugin-assembly-1.4.0.jar
wget -N https://github.com/YoshinoriN/gitbucket-monitoring-plugin/releases/download/v3.1.0/gitbucket-monitorting-plugin_2.12-3.1.0.jar
wget -N https://github.com/kounoike/gitbucket-html5media-plugin/releases/download/1.1.0/gitbucket-html5media-plugin-assembly-1.1.0.jar
wget -N https://github.com/kounoike/gitbucket-ipynb-plugin/releases/download/0.3.2/gitbucket-ipynb-plugin-assembly_4.26.0-0.3.2.jar
wget -N https://github.com/takezoe/gitbucket-ci-plugin/releases/download/1.6.0/gitbucket-ci-plugin-assembly-1.6.0.jar
wget -N https://github.com/jyuch/gitbucket-backup-plugin/releases/download/1.2.1/gitbucket-backup-plugin-gitbucket_4.29.0-1.2.1.jar
wget -N https://github.com/YoshinoriN/gitbucket-application-logs-plugin/releases/download/v1.0.0/gitbucket-application-logs-plugin_2.12-1.0.0.jar
rm *.1 *.2

popd

