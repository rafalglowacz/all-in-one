## Developer channel
If you want to switch to the develop channel, you simply stop and delete the mastercontainer and create a new one with a changed tag to develop:
```shell
sudo docker run \
--init \
--sig-proxy=false \
--name nextcloud-aio-mastercontainer \
--restart always \
--publish 80:80 \
--publish 8080:8080 \
--publish 8443:8443 \
--volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
--volume /var/run/docker.sock:/var/run/docker.sock:ro \
nextcloud/all-in-one:develop
```
And you are done :)
It will now also select the developer channel for all other containers automatically.

## How to publish new releases?
Simply use https://github.com/nextcloud/all-in-one/issues/180 as template.

## How to build new containers
Go to https://github.com/nextcloud-releases/all-in-one/actions/workflows/repo-sync.yml and run the workflow that will first sync the repo and then build new container that automatically get published to `develop` and `develop-arm64`.

## How to test things correctly?
Before testing, make sure that at least the amd64 containers are built successfully by checking the last workflow here: https://github.com/nextcloud-releases/all-in-one/actions/workflows/build_images.yml. 

There is a testing-VM available for the maintainer of AIO that allows for some final testing before releasing new version. See [this](https://cloud.nextcloud.com/apps/collectives/Nextcloud%20Handbook/Technical/AIO%20testing%20VM?fileId=6350152) for details.

## How to promote builds from develop to beta
1. Verify that no job is running here: https://github.com/nextcloud-releases/all-in-one/actions/workflows/build_images.yml
2. Go to https://github.com/nextcloud-releases/all-in-one/actions/workflows/promote-to-beta.yml, click on `Run workflow`.

## Where to find the VPS and other builds?
This is documented here: https://github.com/nextcloud-releases/all-in-one/tree/main/.build

## How to promote builds from beta to latest

1. Verify that no job is running here: https://github.com/nextcloud-releases/all-in-one/actions/workflows/promote-to-beta.yml
2. Go to https://github.com/nextcloud-releases/all-in-one/actions/workflows/promote-to-latest.yml, click on `Run workflow`.

## How to connect to the database?
Simply run `sudo docker exec -it nextcloud-aio-database psql -U oc_nextcloud nextcloud_database` and you should be in.
