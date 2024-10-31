# wp-post-maps

This repo contains an scenario to deploy a wordpress page with some customizations.

The idea is to add latitude and longitude fields in a custom post category called `piulada`.

Then, in a separate page, a map will display all those posts in a map with a marker in each latitude, longitude.

Usage:

```bash
make clean
make start
make install
```