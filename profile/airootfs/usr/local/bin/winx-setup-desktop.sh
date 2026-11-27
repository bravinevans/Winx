#!/usr/bin/env bash

MARKER="$HOME/.config/.winx-initialized"
[ -f "$MARKER" ] && exit 0

# 1. Dark Mode Global Theme, Windows double-click behavior & clean fonts
lookandfeeltool -a org.kde.breezedark.desktop 2>/dev/null || true
kwriteconfig6 --file kdeglobals --group General --key ColorScheme "BreezeDark"
kwriteconfig6 --file kdeglobals --group KDE --key SingleClick false
kwriteconfig6 --file kdeglobals --group General --key font "Liberation Sans,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
kwriteconfig6 --file kdeglobals --group General --key fixed "Noto Sans Mono,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

# 2. Desktop shortcuts: Installer, WinX Store, Steam, WinX Word, WinX Excel, WinX PowerPoint
mkdir -p "$HOME/Desktop"
cp -f /usr/share/applications/calamares.desktop "$HOME/Desktop/Install-WinX.desktop" 2>/dev/null || true
cp -f /usr/local/share/applications/winx-store.desktop "$HOME/Desktop/WinX-Store.desktop" 2>/dev/null || true
cp -f /usr/share/applications/steam.desktop "$HOME/Desktop/" 2>/dev/null || true
cp -f /usr/local/share/applications/libreoffice-writer.desktop "$HOME/Desktop/WinX-Word.desktop" 2>/dev/null || true
cp -f /usr/local/share/applications/libreoffice-calc.desktop "$HOME/Desktop/WinX-Excel.desktop" 2>/dev/null || true
cp -f /usr/local/share/applications/libreoffice-impress.desktop "$HOME/Desktop/WinX-PowerPoint.desktop" 2>/dev/null || true
chmod +x "$HOME/Desktop/"*.desktop 2>/dev/null || true

# 3. Wait for plasmashell DBus service, then apply 44px taskbar, WinX Start icon, pinned apps & wallpaper
for _ in $(seq 1 30); do
    qdbus6 org.kde.plasmashell /PlasmaShell >/dev/null 2>&1 && break
    sleep 0.5
done

qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '
var allDesktops = desktops();
for (var d = 0; d < allDesktops.length; d++) {
    allDesktops[d].wallpaperPlugin = "org.kde.image";
    allDesktops[d].currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    allDesktops[d].writeConfig("Image", "file:///usr/share/pixmaps/winx-wallpaper.svg");
}

var panels = panels();
for (var i = 0; i < panels.length; i++) {
    panels[i].location = "bottom";
    panels[i].height = 44;
    var widgets = panels[i].widgets();
    for (var j = 0; j < widgets.length; j++) {
        if (widgets[j].type == "org.kde.plasma.kickoff") {
            widgets[j].currentConfigGroup = ["General"];
            widgets[j].writeConfig("icon", "/usr/share/pixmaps/winx-logo.svg");
        }
        if (widgets[j].type == "org.kde.plasma.icontasks") {
            widgets[j].currentConfigGroup = ["General"];
            widgets[j].writeConfig("launchers", [
                "applications:org.kde.dolphin.desktop",
                "file:///usr/local/share/applications/winx-store.desktop",
                "applications:steam.desktop",
                "file:///usr/local/share/applications/libreoffice-writer.desktop",
                "file:///usr/local/share/applications/libreoffice-calc.desktop",
                "file:///usr/local/share/applications/libreoffice-impress.desktop"
            ]);
        }
    }
}
'

# 4. Office suite Tabbed Ribbon UI by default
mkdir -p "$HOME/.config/libreoffice/4/user"
cat << 'EOF' > "$HOME/.config/libreoffice/4/user/registrymodifications.xcu"
<?xml version="1.0" encoding="UTF-8"?>
<oor:items xmlns:oor="http://openoffice.org/2001/registry" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Writer']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar_groupedbar_compact.ui</value></prop></item>
  <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Calc']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar_groupedbar_compact.ui</value></prop></item>
  <item oor:path="/org.openoffice.Office.UI.ToolbarMode/Applications/org.openoffice.Office.UI.ToolbarMode:Application['Impress']"><prop oor:name="Active" oor:op="fuse"><value>notebookbar_groupedbar_compact.ui</value></prop></item>
</oor:items>
EOF

touch "$MARKER"
