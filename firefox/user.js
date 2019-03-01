/*
 * Resources:
 * http://kb.mozillazine.org/About:config_entries
 */

/*
 * Open blank page in new tabs.
 */
user_pref("browser.newtabpage.enabled", false);

/*
 * Hide one-click search engines.
 */
user_pref("browser.search.hiddenOneOffs", "Google,Bing,Amazon.com,DuckDuckGo,Twitter,Wikipedia (en)");

/*
 * Set the homepage to about:blank.
 */
user_pref("browser.startup.homepage", "about:blank");

/*
 * Open tabs from the previous session when Firefox starts.
 */
user_pref("browser.startup.page", 3);

/*
 * Customize the toolbar so that it is less cluttered.
 */
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"PersonalToolbar\":[\"personal-bookmarks\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"urlbar-container\",\"downloads-button\",\"add-ons-button\",\"preferences-button\",\"sidebar-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[\"PersonalToolbar\",\"nav-bar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":14,\"newElementCount\":4}");

/*
 * Set UI density to "compact".
 */
user_pref("browser.uidensity", 1);

/*
 * Set the default search engine to DuckDuckGo.
 */
user_pref("browser.urlbar.placeholderName", "DuckDuckGo");

/*
 * Use the light theme.
 */
user_pref("lightweightThemes.selectedThemeID", "firefox-compact-light@mozilla.org");

/*
 * Disable the smooth transition animation hiding tabs and bars when
 * switching to full screen.
 */
user_pref("toolkit.cosmeticAnimations.enabled", false);

/*
 * Bring back Ctrl-Tab and Ctrl-Shift-Tab old behavior. The new one that
 * switches to first to the recently used tab is frustrating.
 */
user_pref("browser.ctrlTab.recentlyUsedOrder", false);
