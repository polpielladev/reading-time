# Compile using a docker instance
docker run \
    --rm \
    --volume "$(pwd)/:/src" \
    --workdir "/src/" \
    swift:5.6-amazonlinux2 \
    swift build --product ReadingTimeLambda -c release -Xswiftc -static-stdlib

# Package into a `.zip` file for upload
# This script is available at:
# https://github.com/swift-server/swift-aws-lambda-runtime/blob/main/Examples/Deployment/scripts/package.sh
./package.sh
