# The native 'palm rejection' feature in KDE does not work well with the
# framework 13 laptop. This is due to libinput not recognizing both the
# keyboard+touchpad as "internal" devices. This is a fix that is currently
# working well.
# https://community.frame.work/t/palm-suppression-settings-insufficient-on-linux/18224
{
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal

    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=FRMW0004:00 32AC:0006 Consumer Control
    AttrKeyboardIntegration=internal

    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=AT Translated Set 2 keyboard
    AttrKeyboardIntegration=internal
  '';
}
