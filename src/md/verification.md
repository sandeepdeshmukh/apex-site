# How to verify Apache Apex (incubating) release candidate builds

## Prerequisites
1. *gpg* program should be installed on your system.
2. Download the KEYS file and import it. This is one time activity.
```bash
wget https://dist.apache.org/repos/dist/release/incubator/apex/KEYS
gpg --import KEYS
```
3. You can also created your own key which is required if you would like to sign the build. This step is optional and can be skipped.
```bash
gpg --gen-key
```
Please provide 4096 as keysize while generating the key.

## File integrity check
Download all files present in staging directory of the RC build. Staging directory link is shared in VOTE thread of the release candidate.

```bash
wget -r -np -nd <staging-area-link>/
```
Note the link should end with "/".

Define the apex release candidate variable. We will set it up *apex-3.3.0-incubating* as an example.
```bash
APEX_RELEASE_CANDIDATE=apex-3.3.0-incubating
```

Verify integrity of tar.gz file:
```bash
gpg --verify $APEX_RELEASE_CANDIDATE-source-release.tar.gz.asc
md5sum --check $APEX_RELEASE_CANDIDATE-source-release.tar.gz.md5
sha512sum --check $APEX_RELEASE_CANDIDATE-source-release.tar.gz.sha
```

Verify integrity of .zip file:
```bash
gpg --verify $APEX_RELEASE_CANDIDATE-source-release.zip.asc
md5sum --check $APEX_RELEASE_CANDIDATE-source-release.zip.md5
sha512sum --check $APEX_RELEASE_CANDIDATE-source-release.zip.sha
```
## Source code verification
You can extract source either using .tar.gz file or .zip file.

### Using .tar.gz source
Extract source using .tar.gz:
```bash
tar -zxvf $APEX_RELEASE_CANDIDATE-source-release.tar.gz
```
### Using .tar.gz source
```bash
unzip $APEX_RELEASE_CANDIDATE-source-release.zip
```

Either of the two commands above will create a directory named *build candidate*.

### Check for compilation, license headers, etc.

The last step is optional and needs prerequisite 3 given above. 
```bash
cd $APEX_RELEASE_CANDIDATE
mvn clean package
mvn apache-rat:check verify -Dlicense.skip=false -Pall-modules -DskipTests
mvn verify -Papache-release -DskipTests
```

## Launch demos
Launch few demos to make sure everything is working fine using dtcli utitlity. The dtcli script is present at <apex-core-folder>/engine/src/main/scripts/dtcli . If apex-core is being verified, then simply use engine/src/main/scripts/dtcli to launch the script. Otherwise, prefix it with apex-core folder path.

```bash
engine/src/main/scripts/dtcli 
```
You will get dtcli prompt, where demos can be launched.
```bash
dt> launch <demo-apk-file>
```
Demo apk files are typically in incubating-apex-malhar/demos directory.

## Additional checks
1. Existence of DISCLAIMER, LICENSE, NOTICE, and CHANGELOG.md files.
2. No unexpected binary files in the sources.
3. Presensence of word incubating in the artifact name.
