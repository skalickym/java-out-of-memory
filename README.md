~~~~
jar cmvf META-INF/MANIFEST.MF CrunchifyGenerateOOM.jar com/crunchify/tutorials/CrunchifyGenerateOOM.class

export _JAVA_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./dump.bin -XX:+ExitOnOutOfMemoryError -Xmx128m"
java -jar CrunchifyGenerateOOM.jar```
~~~~


~~~~
docker build .
docker run -v $PWD/dump:/dump --rm -ti <container_hash>
~~~~
