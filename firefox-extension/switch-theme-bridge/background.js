/*
On startup, connect to the host app.
*/
var port = browser.runtime.connectNative("switch_theme_bridge_host");

/*
Listen for messages from the app.
*/
port.onMessage.addListener((theme) => {
  console.log("Received: \"" + theme + "\"");
  if (theme == "Dark\n") {
    console.log("Setting dark theme")
    browser.management.setEnabled("firefox-compact-dark@mozilla.org", true);
  } else if (theme == "Light\n") {
    console.log("Setting light theme")
    browser.management.setEnabled("firefox-compact-light@mozilla.org", true);
  }
});