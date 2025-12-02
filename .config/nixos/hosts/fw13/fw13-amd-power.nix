# https://community.frame.work/t/tracking-ppd-v-tlp-for-amd-ryzen-7040/39423/137
{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (
      final: prev: {
        power-profiles-daemon = prev.power-profiles-daemon.overrideAttrs (
          old: {
            version = "0.13-1";
            # src = prev.fetchFromGitLab {
            #   domain = "gitlab.freedesktop.org";
            #   owner = "upower";
            #   repo = "power-profiles-daemon";
            #   rev = "0c301fe93f7237c04e28ff98a68337373c3b8766";
            #   sha256 = "sha256-L2e8EIt8V4tS8/hURHxqKMODmyxSbJ1JIpWm90aHEic=";
            # };

            patches =
              (old.patches or [])
              ++ [
                (prev.fetchpatch {
                  url = "https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/merge_requests/127.patch";
                  sha256 = "sha256-CneqixlpZx9iZ0PM5MFIutsvnqKrLlM7FHOHUA/MK6g=";
                })
                # (prev.fetchpatch {
                #    url = "https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/merge_requests/128.patch";
                #    sha256 = "sha256-1QrrSqsbtiQ9skZBsGfOV2qnhnUC2fhIR9BOGch4Cg8=";
                # })
                (prev.fetchpatch {
                  url = "https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/merge_requests/129.patch";
                  sha256 = "sha256-h806OQTYbxlUB44NunbPm8MOOVjlg9eB3TWx3TzEE6M=";
                })
              ];

            # explicitly fetching the source to make sure we're patching over 0.13 (this isn't strictly needed):
            src = prev.fetchFromGitLab {
              domain = "gitlab.freedesktop.org";
              owner = "hadess";
              repo = "power-profiles-daemon";
              rev = "0.13";
              sha256 = "sha256-ErHy+shxZQ/aCryGhovmJ6KmAMt9OZeQGDbHIkC0vUE=";
            };
          }
        );
      }
    )
  ];
}
