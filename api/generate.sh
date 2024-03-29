#!/usr/bin/env bash

export JAVA_OPTS="${JAVA_OPTS} -Xmx1024M -DloggerPath=conf/log4j.properties"

WORKDIR=.

rm -R ${WORKDIR}/lib/src
rm -R ${WORKDIR}/doc

executable="./openapi-generator-cli.jar"
# Generate client
ags="$@ generate -i api.yml -g dart-dio-next --skip-validate-spec -o ${WORKDIR} --additional-properties pubName=heal_happy_sdk,hideGenerationTimestamp=true,nullableFields=false"
java ${JAVA_OPTS} -jar ${executable} ${ags}

cd ${WORKDIR}
dart pub get
dart run build_runner build --delete-conflicting-outputs
rm -R ${WORKDIR}/test/
