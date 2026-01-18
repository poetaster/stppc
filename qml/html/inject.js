function action(topic) {
    command(topic);
   //var output = document.getElementById('output');
   // output.textContent = {"one": "1", "two": "2", "three": "3"}[topic]
}
function send(topic) {
    var customEvent = new CustomEvent("framescript:log",
        {detail: { topic: topic}});
    document.dispatchEvent(customEvent);
}
