import mapboxgl from 'mapbox-gl';
// build the map
const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: 'map',    
    // style: 'mapbox://styles/mapbox/streets-v10'
    style: 'mapbox://styles/pettersyvertsen/ckg7sxmkr0crv19obpwtqhe1j'   
    });
  return map
};
// add markers to map
const addMarkersToMap = (map, markers) => { 
  markers.forEach((marker) => {
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
  });
}
// fit markers 
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();  
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 2 });
};
// This function called first!
const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // only build a map if there's a div#map to inject into
   const map = buildMap(mapElement);  
   const markers = JSON.parse(mapElement.dataset.markers)
   addMarkersToMap(map, markers);
   fitMapToMarkers(map, markers);
  }
};
export { initMapbox };