/*
    The getLoc function calls back to the WebView

    var latitude
    var longitude

    function lat(latitude) {
        var output = document.getElementById('output');
        output.textcontent = latitude
        var latitude = latitude;
    }
    function lon(longitude) {
        var output = document.getElementById('output');
        output.textcontent = longitude
        longitude = longitude;
    }
    function getLoc() {
        var customEvent = new CustomEvent("framescript:action",
            { detail: { topic: longitude, also: latitude } } );
        document.dispatchEvent(customEvent);
    }

    function latlon(lat,lon) {
        var output = document.getElementById('output');
        //output.textContent = lat + " " + lon;
        latitude = lat;
        longitude = lon;
        //map.panTo([lat, lon]);
        map.panTo([latitude, longitude]);
        getLoc();
    }
    */

addEventListener("DOMContentLoaded", function (aEvent) {
    aEvent.originalTarget.addEventListener("framescript:action",
        function (aEvent) {
            sendAsyncMessage("webview:action", aEvent.detail)
    });
});
