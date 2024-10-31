# wp-post-maps

This repo contains an scenario to deploy a wordpress page with some customizations.

The idea is to add latitude and longitude fields in a custom post category called `piulada`.

Then, in a separate page, a map will display all those posts in a map with a marker in each latitude, longitude.

Usage:

```bash
make stop
make start
make install
```

## Configuration steps

This repo has automated some steps that can be done manually in any wp installation:

1. Create a new post category `piulada`.
2. Install advanced custom fields plugin.
3. Configure the plugin to include `lat` and `lng` fields in the category `piulada`.
4. Create posts that belong to that category and fill the `lat` and `lng` fields.
5. Add the code in `custom-functions/add-location.map.php` to theme's `function.php` file.
6. Create the page to display the posts in a map using the shortcode `[map_with_markers]`