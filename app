#!/bin/sh -e

docker_image=$IMAGE
if [ -z $docker_image ]; then
  echo "No IMAGE specified to update" >&2
  exit 1
fi

babl_server_path=$(mktemp -t "babl-server.XXXXXXXXXX")
cat > $babl_server_path
chmod +x $babl_server_path

tmp_docker_image=${docker_image}.tmp$$

cpath=$(docker run --rm --entrypoint=/bin/sh $docker_image -c "which babl-server")
cid=$(docker create $docker_image)
docker cp "$babl_server_path" $cid:$cpath
rm -rf $babl_server_path
docker commit $cid $tmp_docker_image > /dev/null
bsv=$(docker run --rm --entrypoint=/bin/sh $tmp_docker_image -c "babl-server -plainversion")
new_docker_image=${docker_image}.bs-${bsv}
docker tag $tmp_docker_image $new_docker_image
docker rmi $tmp_docker_image > /dev/null
docker push $new_docker_image
echo $new_docker_image
