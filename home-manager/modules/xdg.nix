{ lib, config, ... }:

let
  mkDefaultAppEntry = name: mimeTypes: {
    application = config.defaultApplications."${name}";
    inherit mimeTypes;
  };

  defaultApplications = {
    video = mkDefaultAppEntry "video" [
      "video/mp4"
      "video/avi"
      "video/webm"
      "video/mpeg2"
      "video/mpeg"
      "video/x-avi"
      "video/x-flv"
      "video/flv"
      "video/ogg"
      "video/quicktime"
    ];
    audio = mkDefaultAppEntry "audio" [
      "audio/aac"
      "audio/x-flac"
      "audio/mp3"
      "audio/mp4"
      "audio/mpeg"
      "audio/ogg"
      "audio/vorbis"
      "audio/x-wav"
      "audio/x-vorbis"
      "audio/x-vorbis+ogg"
      "audio/x-oggflac"
      "audio/x-mp3"
      "audio/x-mpegurl"
    ];
    image = mkDefaultAppEntry "image" [
      "image/jpeg"
      "image/png"
      "image/gif"
      "image/bmp"
      "image/webp"
      "image/avif"
      "image/heif"
      "image/x-icns"
    ];
    archive = mkDefaultAppEntry "archive" [
      "application/zip"
      "application/vnd.rar"
      "application/x-compressed-tar"
    ];
    text = mkDefaultAppEntry "text" [
      "text/plain"
      "application/x-osu-beatmap"
      "application/json"
      "text/x-csharp"
      "text/x-python"
      "application/yaml"
      "application/x-desktop"
    ];
    browser = mkDefaultAppEntry "browser" [
      "x-scheme-handler/https"
      "x-scheme-handler/http"
      "text/html"
    ];
    file-explorer = mkDefaultAppEntry "file-explorer" [ "inode/directory" ];
    pdf = mkDefaultAppEntry "pdf" [ "application/pdf" ];
  };

  defaultApplications' =
    defaultApplications
    |> lib.mapAttrsToList (
      _: value:
      builtins.map (mimeType: {
        name = mimeType;
        value = value.application;
      }) value.mimeTypes
    )
    |> builtins.concatLists
    |> builtins.listToAttrs;
in
{
  options.defaultApplications =
    defaultApplications
    |> builtins.mapAttrs (
      name: _:
      lib.mkOption {
        type = lib.types.str;
      }
    );

  config = {
    xdg.configFile."mimeapps.list".force = true;
    xdg.mimeApps = {
      enable = true;
      defaultApplications = defaultApplications' // {
        "application/pdf" = [ "brave-browser.desktop" ];
      };
    };
  };
}
