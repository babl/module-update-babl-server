## Usage Example

`cat babl-server_linux_amd64 | babl babl/update-babl-server -e IMAGE=registry.babl.sh/larskluge/string-upcase:v46`

If the pushed babl-server version is 0.5.7 the result is a pushed image to the registry labeled:

`registry.babl.sh/larskluge/string-upcase:v46.bs-0.5.7`

check via

`curl https://registry.babl.sh/v2/larskluge/string-upcase/tags/list`
