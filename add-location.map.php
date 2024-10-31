function add_map_with_post_markers() {
    // Start building the output in a variable
    $output = '';
    $args = array(
        'post_type' => 'post',
        'meta_query' => array(
            array(
                'key' => 'lat',
                'compare' => 'EXISTS',
            ),
            array(
                'key' => 'lng',
                'compare' => 'EXISTS',
            )
        )
    );
    $query = new WP_Query($args);

    if ($query->have_posts()) {
        $output .= '<div id="map" style="height: 500px; width: 100%;"></div>';
        $output .= '<script type="text/javascript">
                document.addEventListener("DOMContentLoaded", function() {
                    var map = L.map("map").setView([0, 0], 2);
                    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
                        maxZoom: 19,
                        attribution: "© OpenStreetMap"
                    }).addTo(map);
        ';

        // Add each post marker
        while ($query->have_posts()) {
            $query->the_post();
            $lat = get_post_meta(get_the_ID(), 'lat', true);
            $lng = get_post_meta(get_the_ID(), 'lng', true);
            $title = get_the_title();
            $url = get_permalink();
            if ($lat && $lng) {
                $output .= "L.marker([$lat, $lng]).addTo(map)
                            .bindPopup('<a href=\"$url\">$title</a>');";
            }
        }

        $output .= '   });
            </script>';
        
        wp_reset_postdata();
    } else {
        $output .= 'No posts found with coordinates.';
    }

    // Return the output so it appears in the right place
    return $output;
}
add_shortcode('map_with_markers', 'add_map_with_post_markers');
