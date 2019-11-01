
# upload-github-release-asset.sh github_api_token=TOKEN owner=stefanbuck repo=playground tag=v0.1.0 filename=./build.zip
#

# Check dependencies.
set -e
xargs=$(which gxargs || which xargs)

# Validate settings.
[ "$TRACE" ] && set -x

CONFIG=$@

for line in $CONFIG; do
  eval "$line"
done

# Define variables.
GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/$owner/$repo"
GH_RELEASE="$GH_REPO/releases"
AUTH="Authorization: token $github_api_token"


# Validate token.
curl -o /dev/null -sH "$AUTH" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

#create the release
API_JSON=$(printf '{"tag_name": "%s","name": "%s","draft": false,"prerelease": false}' $tag $tag $tag)
curl --data "$API_JSON" -H "Authorization: token $github_api_token" $GH_RELEASE
