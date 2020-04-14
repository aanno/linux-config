#!/bin/bash -x

export JAVA_HOME=/usr/lib/jvm/java-11
for i in $JAVA_HOME/bin/*; do
  ln -sf $i /home/tpasch/bin/
done

which java
which javac
java -version
javac -version
