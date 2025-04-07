{...}:
let
    height = "35px";
    roundness = "15px";
    topMargin = "4px";
    islandColor = "rgba(253, 183, 234, 0.7)";
in
''
* {
    border: none;
    font-family: "JetBrainsMono Nerd Font, JetBrainsMono NF";
    font-size: 14px;
    color: white;
}

window#waybar {
    background: transparent;
    /* margin: 5px; */
}

tooltip {
  border-radius: 15px;
  background: rgba(0, 0, 0, 0.9);
}

.modules-left, .modules-center, .modules-right {
    min-height: ${height};
    margin-top: ${topMargin};
    background: ${islandColor};
}

.modules-left {
    border-radius: 0 ${roundness} ${roundness} 0;
}

.modules-center {
    border-radius: ${roundness} ${roundness} ${roundness} ${roundness};
}

.modules-right {
    border-radius: ${roundness} 0 0 ${roundness};
}

#battery, 
#window, 
#clock {
    padding: 0 5px;
}

#workspaces button {
    border-radius: 2px;
}

#workspaces button.active {
    border-bottom: solid 2px @active;
}

#custom-logo {
    background-image: url("${./nix-logo.svg}");
    background-size: 20px 20px;
    background-repeat: no-repeat;
    background-position: center; 
    padding-left: 20px; 
}

#battery.charging {
    color: #77DD77;
}

#battery.warning:not(.charging) {
    background-color: #ffbe61;
    color: black;
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}
''