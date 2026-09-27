# One-off, impure post-install setup steps that don't belong in the Nix store
# proper (they do things like clone a git repo into $HOME and run an
# installer against your actual browser profile). Run via:
#
#   nix run .#impure-setup
#   nix develop        # drops impure-setup onto $PATH instead
#
{
  lib,
  writers,
  coreutils,
  git,
  pywalfox-native,
}:
writers.writeFishBin "impure-setup" { }
  # fish
  ''
    set CP              '${lib.getExe' coreutils "cp"}'
    set GIT             '${lib.getExe git}'
    set MKDIR           '${lib.getExe' coreutils "mkdir"}'
    set MKTEMP          '${lib.getExe' coreutils "mktemp"}'
    set PYWALFOX_NATIVE '${lib.getExe pywalfox-native}'
    set RM              '${lib.getExe' coreutils "rm"}'
    set LN              '${lib.getExe' coreutils "ln"}'
    set ICON_DIR "$HOME/.local/share/icons"
    set REPO_URL 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git'
    set REPO_REV 'c5a48381fce7fda86fb9067fd7816f7de11c0aeb'
    set WAL_CACHE_DIR "$HOME/.cache/wal"
    set WAL_COLORS_LINK "$WAL_CACHE_DIR/colors.json"
    set WAL_COLORS_TARGET "$WAL_CACHE_DIR/dank-pywalfox.json"
    set FIREFOX_MANIFEST_DIR "$HOME/.mozilla/native-messaging-hosts"

    echo '[-*-] Setting up Papirus icon theme.'
    if test -d "$ICON_DIR/Papirus"
      echo "[?] Papirus icon theme already exists as: $ICON_DIR/Papirus"
      echo '    [1] Remove existing theme and re-install.'
      echo '    [2] Skip Papirus icon theme setup.'
      read -l -P 'Select an option [1/2*] : ' confirm
      switch "$confirm"
        case 1
          echo '[?] Removing existing Papirus installation.'
          "$RM" -rf "$ICON_DIR/Papirus"
        case 2
          echo '[?] Skipping Papirus icon theme setup.'
          set skip_papirus_installation true
        case '*'
          echo '[?] Defaulting to: Skip Papirus icon theme setup.'
          set skip_papirus_installation true
      end
    end
    if not set -q skip_papirus_installation
      echo '[-*-] Fetching Papirus icon theme.'
      "$MKDIR" -p "$ICON_DIR"
      set TMP_DIR ("$MKTEMP" -d)
      function cleanup --on-event fish_exit --inherit-variable TMP_DIR
          "$RM" -rf "$TMP_DIR"
      end
      "$GIT" -c advice.detachedHead=false clone \
        --revision=$REPO_REV \
        --depth=1 \
        --filter=blob:none \
        --sparse "$REPO_URL" "$TMP_DIR"
      "$GIT" -C "$TMP_DIR" sparse-checkout set Papirus
      echo "[-*-] Copying Papirus icon theme to: $ICON_DIR/Papirus"
      "$CP" -r "$TMP_DIR/Papirus" "$ICON_DIR/Papirus"
      echo "[+] Successfully installed Papirus icon theme to: $ICON_DIR/Papirus"
    end

    echo -e '\n[-*-] Setting up pywalfox for Firefox.'
    if test -e "$WAL_COLORS_LINK"
      echo "[?] pywalfox colors link already exists as: $WAL_COLORS_LINK"
      echo '    [1] Remove existing link and re-install.'
      echo '    [2] Skip pywalfox setup.'
      read -l -P 'Select an option [1/2*] : ' confirm
      switch "$confirm"
        case 1
          echo '[?] Removing existing pywalfox colors link.'
          "$RM" -f "$WAL_COLORS_LINK"
        case 2
          echo '[?] Skipping pywalfox setup.'
          set skip_pywalfox_installation true
        case '*'
          echo '[?] Defaulting to: Skip pywalfox setup.'
          set skip_pywalfox_installation true
      end
    end
    if not set -q skip_pywalfox_installation
      "$MKDIR" -p "$FIREFOX_MANIFEST_DIR"
      "$PYWALFOX_NATIVE" install --manifest-path "$FIREFOX_MANIFEST_DIR"
      "$MKDIR" -p "$WAL_CACHE_DIR"
      "$LN" -sf "$WAL_COLORS_TARGET" "$WAL_COLORS_LINK"
      echo "[+] Successfully setup pywalfox for Firefox."
    end
  ''
