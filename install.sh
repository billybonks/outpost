#!/usr/bin/env bash
set -euo pipefail

handoff_work=
server_uninstaller_b64='IyEvYmluL3NoCnNldCAtZXUKWyAiJCMiIC1lcSAwIF0gfHwgZXhpdCAxCnJvb3Q9JHtPVVRQT1NUX1VOSU5TVEFMTF9ST09UOi19CnRlc3RfbW9kZT0ke09VVFBPU1RfVU5JTlNUQUxMX1RFU1Q6LTB9ClsgLXogIiRyb290IiBdIHx8IFsgIiR0ZXN0X21vZGUiID0gMSBdIHx8IGV4aXQgMQpjYXNlICIkcm9vdCIgaW4gJyd8LyopIDo7OyAqKSBleGl0IDE7OyBlc2FjClsgIiR0ZXN0X21vZGUiID0gMSBdIHx8IFsgIiQoaWQgLXUpIiA9IDAgXSB8fCBleGl0IDEKbG9nKCkgeyBbIC16ICIke09VVFBPU1RfVU5JTlNUQUxMX1RFU1RfTE9HOi19IiBdIHx8IHByaW50ZiAnJXNcbicgIiQxIiA+PiAiJE9VVFBPU1RfVU5JTlNUQUxMX1RFU1RfTE9HIjsgfQpyZW1vdmUoKSB7IGlmIFsgLWUgIiRyb290JDEiIF0gfHwgWyAtTCAiJHJvb3QkMSIgXTsgdGhlbiBybSAtcmYgLS0gIiRyb290JDEiOyBmaTsgfQppbmFjdGl2ZSgpIHsgWyAiJChzeXN0ZW1jdGwgc2hvdyAtcCBBY3RpdmVTdGF0ZSAtLXZhbHVlICIkMS5zZXJ2aWNlIikiID0gaW5hY3RpdmUgXTsgfQpzdG9wKCkgeyBzeXN0ZW1jdGwgc3RvcCAiJDEuc2VydmljZSIgfHwgWyAiJChzeXN0ZW1jdGwgc2hvdyAtcCBMb2FkU3RhdGUgLS12YWx1ZSAiJDEuc2VydmljZSIpIiA9IG5vdC1mb3VuZCBdOyBpbmFjdGl2ZSAiJDEiOyB9CnJlYWR5KCkgewogWyAiJHRlc3RfbW9kZSIgPSAxIF0gJiYgWyAiJHtPVVRQT1NUX1VOSU5TVEFMTF9URVNUX1JFQURZOi19IiA9IDEgXSAmJiByZXR1cm4KIHB5dGhvbjMgLSAiJHJvb3QvcnVuL291dHBvc3Qvdm0tbGF1bmNoZXIuc29jayIgIiR7T1VUUE9TVF9VTklOU1RBTExfUkVBRFlfVElNRU9VVDotMzB9IiA8PCdQWScKaW1wb3J0IHNvY2tldCxzeXMsdGltZQpwYXRoLHRpbWVvdXQ9c3lzLmFyZ3ZbMV0saW50KHN5cy5hcmd2WzJdKTsgZW5kPXRpbWUubW9ub3RvbmljKCkrdGltZW91dAp3aGlsZSB0aW1lLm1vbm90b25pYygpPGVuZDoKIHRyeToKICBzPXNvY2tldC5zb2NrZXQoc29ja2V0LkFGX1VOSVgpOyBzLnNldHRpbWVvdXQoLjIpOyBzLmNvbm5lY3QocGF0aCk7IHMuY2xvc2UoKTsgcmFpc2UgU3lzdGVtRXhpdCgwKQogZXhjZXB0IE9TRXJyb3I6IHRpbWUuc2xlZXAoLjEpCnJhaXNlIFN5c3RlbUV4aXQoMSkKUFkKfQpoYW5kb2ZmPScnOyBjcmVhdGVkX291dHBvc3RkX3VzZXI9Jyc7IGNyZWF0ZWRfb3V0cG9zdHZtX3VzZXI9Jyc7IGNyZWF0ZWRfb3V0cG9zdGRfZ3JvdXA9Jyc7IGNyZWF0ZWRfb3V0cG9zdHZtX2dyb3VwPScnOyBjcmVhdGVkX3N1YnVpZD0nJzsgY3JlYXRlZF9zdWJnaWQ9Jyc7IGlwX3ByZXZpb3VzPScnOyBjaGFuZ2VkX2lwPScnOyBjcmVhdGVkX3N5c2N0bD0nJwpmaWxlPSRyb290L2V0Yy9vdXRwb3N0ZC91bmluc3RhbGwuZW52CmlmIFsgLWYgIiRmaWxlIiBdICYmIFsgISAtTCAiJGZpbGUiIF07IHRoZW4KIFsgIiR0ZXN0X21vZGUiID0gMSBdIHx8IFsgIiQoc3RhdCAtYyAldTolYSAiJGZpbGUiKSIgPSAwOjYwMCBdIHx8IGV4aXQgMQogeyBJRlM9IHJlYWQgLXIgb25lOyBJRlM9IHJlYWQgLXIgdHdvOyBJRlM9IHJlYWQgLXIgdGhyZWU7IElGUz0gcmVhZCAtciBmb3VyOyBJRlM9IHJlYWQgLXIgZml2ZTsgSUZTPSByZWFkIC1yIHNpeDsgSUZTPSByZWFkIC1yIHNldmVuOyBJRlM9IHJlYWQgLXIgZWlnaHQ7IElGUz0gcmVhZCAtciBuaW5lOyBJRlM9IHJlYWQgLXIgdGVuOyBJRlM9IHJlYWQgLXIgZXh0cmEgfHwgOjsgfSA8ICIkZmlsZSIKIFsgLXogIiRleHRyYSIgXSB8fCBleGl0IDEKIHNldCAtLSAiJG9uZSIgIiR0d28iICIkdGhyZWUiICIkZm91ciIgIiRmaXZlIiAiJHNpeCIgIiRzZXZlbiIgIiRlaWdodCIgIiRuaW5lIiAiJHRlbiIKIGNhc2UgIiQxOiQyOiQzOiQ0OiQ1OiQ2OiQ3OiQ4OiQ5OiR7MTB9IiBpbgogIE9VVFBPU1RfSEFORE9GRj0qOk9VVFBPU1RfQ1JFQVRFRF9PVVRQT1NURF9VU0VSPVswMV06T1VUUE9TVF9DUkVBVEVEX09VVFBPU1RWTV9VU0VSPVswMV06T1VUUE9TVF9DUkVBVEVEX09VVFBPU1REX0dST1VQPVswMV06T1VUUE9TVF9DUkVBVEVEX09VVFBPU1RWTV9HUk9VUD1bMDFdOk9VVFBPU1RfQ1JFQVRFRF9PVVRQT1NURF9TVUJVSUQ9WzAxXTpPVVRQT1NUX0NSRUFURURfT1VUUE9TVERfU1VCR0lEPVswMV06T1VUUE9TVF9JUF9GT1JXQVJEX1BSRVZJT1VTPVswMV06T1VUUE9TVF9DSEFOR0VEX0lQX0ZPUldBUkQ9WzAxXTpPVVRQT1NUX0NSRUFURURfU1lTQ1RMPVswMV0pIDo7OyAqKSBleGl0IDE7OwogZXNhYwogaGFuZG9mZj0kezEjT1VUUE9TVF9IQU5ET0ZGPX0KIGlmIFsgIiR0ZXN0X21vZGUiID0gMSBdOyB0aGVuCiAgY2FzZSAiJGhhbmRvZmYiIGluIC8qLy5jb25maWcvb3V0cG9zdC9zZXJ2ZXIuZW52KSA6OzsgKikgZXhpdCAxOzsgZXNhYwogZWxzZQogIGNhc2UgIiRoYW5kb2ZmIiBpbgogICAvcm9vdC8uY29uZmlnL291dHBvc3Qvc2VydmVyLmVudikgOiA7OwogICAvaG9tZS8qLy5jb25maWcvb3V0cG9zdC9zZXJ2ZXIuZW52KQogICAgdXNlcj0ke2hhbmRvZmYjL2hvbWUvfTsgdXNlcj0ke3VzZXIlJS8qfQogICAgY2FzZSAiJHVzZXIiIGluICcnfCpbIUEtWmEtejAtOV8uLV0qKSBleGl0IDE7OyBlc2FjCiAgICBbICIkaGFuZG9mZiIgPSAiL2hvbWUvJHVzZXIvLmNvbmZpZy9vdXRwb3N0L3NlcnZlci5lbnYiIF0gfHwgZXhpdCAxCiAgICA7OwogICAqKSBleGl0IDEgOzsKICBlc2FjCiBmaQogY3JlYXRlZF9vdXRwb3N0ZF91c2VyPSR7MiMqPX07IGNyZWF0ZWRfb3V0cG9zdHZtX3VzZXI9JHszIyo9fTsgY3JlYXRlZF9vdXRwb3N0ZF9ncm91cD0kezQjKj19OyBjcmVhdGVkX291dHBvc3R2bV9ncm91cD0kezUjKj19OyBjcmVhdGVkX3N1YnVpZD0kezYjKj19OyBjcmVhdGVkX3N1YmdpZD0kezcjKj19OyBpcF9wcmV2aW91cz0kezgjKj19OyBjaGFuZ2VkX2lwPSR7OSMqPX07IGNyZWF0ZWRfc3lzY3RsPSR7MTAjKj19CmZpCiMgT25seSB0b3VjaCB0aGUgZGVkaWNhdGVkIE91dHBvc3QgdHVubmVsOyBsZWF2ZSB1bnJlbGF0ZWQgY2xvdWRmbGFyZWQgc2VydmljZXMgYWxvbmUuCmlmIFsgLWYgIiRyb290L2V0Yy9zeXN0ZW1kL3N5c3RlbS9vdXRwb3N0LWNsb3VkZmxhcmVkLnNlcnZpY2UiIF07IHRoZW4KIGxvZyBzdG9wLWNsb3VkZmxhcmU7IHN0b3Agb3V0cG9zdC1jbG91ZGZsYXJlZCB8fCBleGl0IDEKIHN5c3RlbWN0bCBkaXNhYmxlIG91dHBvc3QtY2xvdWRmbGFyZWQuc2VydmljZSB8fCBleGl0IDEKIHJlbW92ZSAvZXRjL3N5c3RlbWQvc3lzdGVtL291dHBvc3QtY2xvdWRmbGFyZWQuc2VydmljZQogcmVtb3ZlIC9ldGMvb3V0cG9zdC1jbG91ZGZsYXJlZApmaQpsYXVuY2hlcl9sb2FkPSQoc3lzdGVtY3RsIHNob3cgLXAgTG9hZFN0YXRlIC0tdmFsdWUgb3V0cG9zdC12bS1sYXVuY2hlci5zZXJ2aWNlKQpsb2cgc3RvcC1vdXRwb3N0ZDsgc3RvcCBvdXRwb3N0ZCB8fCBleGl0IDEKbG9nIHN0b3AtbGF1bmNoZXI7IHN0b3Agb3V0cG9zdC12bS1sYXVuY2hlciB8fCBleGl0IDEKaWYgWyAiJGxhdW5jaGVyX2xvYWQiICE9IG5vdC1mb3VuZCBdOyB0aGVuCiBsb2cgcmVjb25jaWxlLWxhdW5jaGVyOyBzeXN0ZW1jdGwgc3RhcnQgb3V0cG9zdC12bS1sYXVuY2hlci5zZXJ2aWNlICYmIHN5c3RlbWN0bCBpcy1hY3RpdmUgLS1xdWlldCBvdXRwb3N0LXZtLWxhdW5jaGVyLnNlcnZpY2UgJiYgcmVhZHkgfHwgZXhpdCAxCiBsb2cgc3RvcC1yZWNvbmNpbGVkLWxhdW5jaGVyOyBzdG9wIG91dHBvc3Qtdm0tbGF1bmNoZXIgfHwgZXhpdCAxCmZpCnN5c3RlbWN0bCBkaXNhYmxlIG91dHBvc3RkLnNlcnZpY2UgfHwgWyAiJChzeXN0ZW1jdGwgc2hvdyAtcCBMb2FkU3RhdGUgLS12YWx1ZSBvdXRwb3N0ZC5zZXJ2aWNlKSIgPSBub3QtZm91bmQgXSB8fCBleGl0IDEKc3lzdGVtY3RsIGRpc2FibGUgb3V0cG9zdC12bS1sYXVuY2hlci5zZXJ2aWNlIHx8IFsgIiRsYXVuY2hlcl9sb2FkIiA9IG5vdC1mb3VuZCBdIHx8IGV4aXQgMQpbIC16ICIkaGFuZG9mZiIgXSB8fCByZW1vdmUgIiRoYW5kb2ZmIgpbICIkY3JlYXRlZF9zeXNjdGwiICE9IDEgXSB8fCByZW1vdmUgL2V0Yy9zeXNjdGwuZC85OS1vdXRwb3N0LmNvbmYKcmVtb3ZlIC9ldGMvc3lzdGVtZC9zeXN0ZW0vb3V0cG9zdGQuc2VydmljZQpyZW1vdmUgL2V0Yy9zeXN0ZW1kL3N5c3RlbS9vdXRwb3N0LXZtLWxhdW5jaGVyLnNlcnZpY2UKcmVtb3ZlIC91c3IvbGliL3RtcGZpbGVzLmQvb3V0cG9zdC5jb25mCnJlbW92ZSAvdXNyL2xvY2FsL2Jpbi9vdXRwb3N0CnJlbW92ZSAvdXNyL2xvY2FsL2xpYi9vdXRwb3N0CnJlbW92ZSAvZXRjL291dHBvc3RkCnJlbW92ZSAvdmFyL2xpYi9vdXRwb3N0ZApyZW1vdmUgL3Nydi9vdXRwb3N0L3N0YXRlCnJlbW92ZSAvc3J2L291dHBvc3QvamFpbGVyCnJtZGlyIC0tICIkcm9vdC9zcnYvb3V0cG9zdCIgMj4vZGV2L251bGwgfHwgOgpyZW1vdmUgL3J1bi9vdXRwb3N0CmlmIFsgIiR0ZXN0X21vZGUiICE9IDEgXTsgdGhlbgogWyAiJGNyZWF0ZWRfc3VidWlkIiAhPSAxIF0gfHwgc2VkIC1pICcvXm91dHBvc3RkOi9kJyAvZXRjL3N1YnVpZAogWyAiJGNyZWF0ZWRfc3ViZ2lkIiAhPSAxIF0gfHwgc2VkIC1pICcvXm91dHBvc3RkOi9kJyAvZXRjL3N1YmdpZAogWyAiJGNyZWF0ZWRfb3V0cG9zdGRfdXNlciIgIT0gMSBdIHx8IHVzZXJkZWwgb3V0cG9zdGQKIFsgIiRjcmVhdGVkX291dHBvc3R2bV91c2VyIiAhPSAxIF0gfHwgdXNlcmRlbCBvdXRwb3N0dm0KIFsgIiRjcmVhdGVkX291dHBvc3RkX2dyb3VwIiAhPSAxIF0gfHwgZ3JvdXBkZWwgb3V0cG9zdGQKIFsgIiRjcmVhdGVkX291dHBvc3R2bV9ncm91cCIgIT0gMSBdIHx8IGdyb3VwZGVsIG91dHBvc3R2bQogaWYgWyAiJGNoYW5nZWRfaXAiID0gMSBdICYmICEgZ3JlcCAtUnFzICdeW1s6c3BhY2U6XV0qbmV0LmlwdjQuaXBfZm9yd2FyZFtbOnNwYWNlOl1dKj1bWzpzcGFjZTpdXSoxW1s6c3BhY2U6XV0qJCcgL2V0Yy9zeXNjdGwuY29uZiAvZXRjL3N5c2N0bC5kIDI+L2Rldi9udWxsOyB0aGVuIHN5c2N0bCAtdyAibmV0LmlwdjQuaXBfZm9yd2FyZD0kaXBfcHJldmlvdXMiID4vZGV2L251bGw7IGZpCmZpCnN5c3RlbWN0bCBkYWVtb24tcmVsb2FkCmxvZyBjb21wbGV0ZQo='
fail() { printf '%s\n' "$1" >&2; exit 1; }
usage() { printf '%s\n' 'Enter user@server for a remote server, local for this machine, or leave blank for client only.' >&2; }
https_url() { [[ $1 =~ ^https://[A-Za-z0-9.-]+(/[A-Za-z0-9._~/%+-]*)?$ ]]; }
ssh_target() { [[ $1 =~ ^[A-Za-z_][A-Za-z0-9_-]{0,31}@[A-Za-z0-9][A-Za-z0-9.-]{0,251}$ && $1 != *..* && $1 != *.-* && $1 != *-. ]]; }
valid_ipv4() {
 local IFS=. a b c d extra octet
 read -r a b c d extra <<< "$1"
 [[ -z ${extra:-} && -n ${a:-} && -n ${b:-} && -n ${c:-} && -n ${d:-} ]] || return 1
 for octet in "$a" "$b" "$c" "$d"; do [[ $octet =~ ^[0-9]{1,3}$ ]] && ((10#$octet <= 255)) || return 1; done
}
valid_hostname() {
 local label host=$1
 local -a labels
 [[ ${#host} -le 253 && $host == *.* && $host != *..* ]] || return 1
 local IFS=.
 read -ra labels <<< "$host"
 for label in "${labels[@]}"; do
  [[ ${#label} -le 63 && $label =~ ^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?$ ]] || return 1
 done
 [[ $host != *. && ! $host =~ ^[0-9.]+$ ]]
}
valid_server() {
 local address host port
 [[ $1 =~ ^https?://[A-Za-z0-9.:-]+$ ]] || return 1
 address=${1#*://}; host=$address; port=
 if [[ $address == *:* ]]; then
  host=${address%:*}; port=${address##*:}
  [[ $port =~ ^[1-9][0-9]{0,4}$ ]] && ((10#$port <= 65535)) || return 1
 fi
 if valid_ipv4 "$host"; then [[ -n $port ]]; else [[ $1 == https://* ]] && valid_hostname "$host"; fi
}
valid_token() { [[ $1 =~ ^[A-Za-z0-9+/=]{20,256}$ ]]; }
config_value() {
 local key=$1 file=$2 line name value found=
 while IFS= read -r line || [[ -n $line ]]; do
  [[ $line == *=* ]] || return 1
  name=${line%%=*}; value=${line#*=}
  [[ $name == "$key" ]] || continue
  [[ -z ${found:-} ]] || return 1
  found=$value
 done < "$file"
 [[ -n ${found:-} ]] || return 1
 printf '%s' "$found"
}
valid_config() {
 local file=$1 server token lines
 [[ -f $file && ! -L $file ]] || return 1
 lines=$(wc -l < "$file")
 [[ $lines -eq 2 ]] || return 1
 server=$(config_value OUTPOST_SERVER "$file") || return 1
 token=$(config_value OUTPOST_TOKEN "$file") || return 1
 valid_server "$server" && valid_token "$token"
}
release_metadata() {
 local work=$1 api tag
 if [[ -n ${OUTPOST_RELEASE_URL:-} || -n ${OUTPOST_RELEASE_VERSION:-} || -n ${OUTPOST_ASSETS_MANIFEST_SHA256:-} || -n ${OUTPOST_INSTALL_SERVER_SHA256:-} ]]; then
  [[ -n ${OUTPOST_RELEASE_URL:-} && -n ${OUTPOST_RELEASE_VERSION:-} && -n ${OUTPOST_ASSETS_MANIFEST_SHA256:-} && -n ${OUTPOST_INSTALL_SERVER_SHA256:-} ]] || fail 'release automation values must be complete'
  release=$OUTPOST_RELEASE_URL
  version=$OUTPOST_RELEASE_VERSION
  manifest_sha=$OUTPOST_ASSETS_MANIFEST_SHA256
  installer_sha=$OUTPOST_INSTALL_SERVER_SHA256
 else
  api=https://github.com/nishantdania/outpost/releases/latest
  tag=$(curl --fail --location --proto '=https' --tlsv1.2 --silent --show-error --output /dev/null --write-out '%{url_effective}' "$api") || fail 'unable to resolve latest release'
  [[ $tag =~ ^https://github\.com/nishantdania/outpost/releases/tag/(v[0-9]+\.[0-9]+\.[0-9]+)$ ]] || fail 'invalid latest release metadata'
  tag=${BASH_REMATCH[1]}
  version=${tag#v}
  release=https://github.com/nishantdania/outpost/releases/download/$tag
 fi
 https_url "$release" || fail 'release URL must use a safe HTTPS URL'
 [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail 'invalid release version'
 [[ ${manifest_sha:-} =~ ^[a-f0-9]{64}$ || -z ${manifest_sha:-} ]] || fail 'invalid manifest checksum'
 [[ ${installer_sha:-} =~ ^[a-f0-9]{64}$ || -z ${installer_sha:-} ]] || fail 'invalid installer checksum'
 curl --fail --location --proto '=https' --tlsv1.2 -o "$work/checksums.txt" "$release/checksums.txt"
 curl --fail --location --proto '=https' --tlsv1.2 -o "$work/assets.json" "$release/assets.json"
 curl --fail --location --proto '=https' --tlsv1.2 -o "$work/install-server" "$release/install-server"
 local listed_assets listed_installer actual
 listed_assets=$(awk '$2 == "assets.json" { print $1 }' "$work/checksums.txt")
 listed_installer=$(awk '$2 == "install-server" { print $1 }' "$work/checksums.txt")
 [[ $listed_assets =~ ^[a-f0-9]{64}$ && $listed_installer =~ ^[a-f0-9]{64}$ ]] || fail 'invalid release checksums'
 actual=$(sha256sum "$work/assets.json" | awk '{print $1}')
 [[ $actual == "$listed_assets" ]] || fail 'assets manifest checksum mismatch'
 actual=$(sha256sum "$work/install-server" | awk '{print $1}')
 [[ $actual == "$listed_installer" ]] || fail 'server installer checksum mismatch'
 [[ -z ${manifest_sha:-} || $manifest_sha == "$listed_assets" ]] || fail 'assets manifest checksum mismatch'
 [[ -z ${installer_sha:-} || $installer_sha == "$listed_installer" ]] || fail 'server installer checksum mismatch'
 manifest_sha=$listed_assets
 installer_sha=$listed_installer
}
client_install() (
 local home bin lib work actual client_sha uninstaller_sha
 home=${HOME:?HOME is required}
 bin=${OUTPOST_INSTALL_BIN_DIR:-$home/.local/bin}
 lib=${OUTPOST_INSTALL_LIB_DIR:-$home/.local/lib/outpost}
 [[ $bin == /* && $lib == /* ]] || fail 'install paths must be absolute'
 work=$(mktemp -d "${TMPDIR:-/tmp}/outpost-client-install.XXXXXX")
 trap 'rm -rf "$work"' EXIT HUP INT TERM
 release_metadata "$work"
 client_sha=$(awk '$2 == "outpost" { print $1 }' "$work/checksums.txt")
 [[ $client_sha =~ ^[a-f0-9]{64}$ ]] || fail 'invalid client release checksum'
 curl --fail --location --proto '=https' --tlsv1.2 -o "$work/outpost" "$release/outpost"
 actual=$(sha256sum "$work/outpost" | awk '{print $1}')
 [[ $actual == "$client_sha" ]] || fail 'client checksum mismatch'
 install -d -m 0755 "$bin" "$lib"
 install -m 0755 "$work/outpost" "$lib/outpost-$version"
 cat > "$work/outpost-uninstall" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
fail() { printf '%s\n' "$1" >&2; exit 1; }
[[ $# -ge 1 && $1 == uninstall ]] || fail 'usage: outpost uninstall [--yes] [--client-only]'
shift
yes=0; client_only=0
for option in "$@"; do
 case $option in
  --yes) [[ $yes == 0 ]] || fail 'usage: outpost uninstall [--yes] [--client-only]'; yes=1 ;;
  --client-only) [[ $client_only == 0 ]] || fail 'usage: outpost uninstall [--yes] [--client-only]'; client_only=1 ;;
  *) fail 'usage: outpost uninstall [--yes] [--client-only]' ;;
 esac
done
[[ ${OUTPOST_UNINSTALL_CONFIG:-} == "$HOME/.config/outpost/server.env" ]] || fail 'refusing to remove an unexpected Outpost configuration path'
if [[ $yes == 0 ]]; then
 [[ -r /dev/tty ]] || fail 'a terminal is required; use outpost uninstall --yes for noninteractive use'
 if [[ $client_only == 1 ]]; then prompt='remove only the local Outpost client'; else prompt='permanently remove Outpost and all VMs'; fi
 printf 'Type uninstall to %s: ' "$prompt" >/dev/tty
 IFS= read -r answer </dev/tty || fail 'unable to read confirmation'
 [[ $answer == uninstall ]] || fail 'uninstall cancelled'
fi
if [[ $client_only == 1 ]]; then
 printf '%s\n' 'Removing only the local Outpost client; the configured server and its VMs will not be removed.' >&2
elif [[ ${OUTPOST_UNINSTALL_LOCAL:-0} == 1 ]]; then
 sudo /usr/local/lib/outpost/outpost-uninstall-server || fail 'server uninstall failed; rerun with --client-only to remove only this client'
else
 ssh -tt -- "$OUTPOST_UNINSTALL_JUMP" 'sudo /usr/local/lib/outpost/outpost-uninstall-server' || fail 'server uninstall failed; rerun with --client-only to remove only this client'
fi
rm -f -- "$OUTPOST_UNINSTALL_CONFIG" "$OUTPOST_UNINSTALL_BIN" "$OUTPOST_UNINSTALL_SELF"
rm -f -- "$HOME/.config/outpost/known_hosts" "$HOME/.config/outpost/keys/id_ed25519" "$HOME/.config/outpost/keys/id_ed25519.pub"
for client in "$OUTPOST_UNINSTALL_LIB"/outpost-*; do
 [[ -f $client && ! -L $client && ${client##*/} =~ ^outpost-[0-9]+\.[0-9]+\.[0-9]+$ ]] && rm -f -- "$client"
done
rm -f -- "$OUTPOST_UNINSTALL_LIB/outpost-uninstall"
rmdir -- "$OUTPOST_UNINSTALL_LIB" "$HOME/.config/outpost/keys" "$HOME/.config/outpost" 2>/dev/null || :
EOF
 install -m 0700 "$work/outpost-uninstall" "$lib/outpost-uninstall"
 uninstaller_sha=$(sha256sum "$lib/outpost-uninstall" | awk '{print $1}')
 cat > "$work/outpost-wrapper" <<EOF
#!/usr/bin/env bash
set -euo pipefail
config=\${OUTPOST_CONFIG_FILE:-\$HOME/.config/outpost/server.env}
real=\${OUTPOST_REAL_BINARY:-$lib/outpost-$version}
uninstaller=$lib/outpost-uninstall
fail() { printf '%s\\n' "\$1" >&2; exit 1; }
uninstall_command=0
case "\$*" in
 uninstall|'uninstall --yes'|'uninstall --client-only'|'uninstall --yes --client-only'|'uninstall --client-only --yes') uninstall_command=1 ;;
esac
if [[ \$uninstall_command == 1 ]]; then
 [[ -e \$config ]] || fail 'invalid Outpost configuration'
fi
if [[ -e \$config ]]; then
 [[ -f \$config && ! -L \$config ]] || fail 'invalid Outpost configuration'
 mode=\$(stat -c %a "\$config")
 [[ \$mode =~ ^[0-7]00\$ ]] || fail 'Outpost configuration must not be accessible by group or others'
 [[ \$(stat -c %u "\$config") == \$(id -u) ]] || fail 'Outpost configuration must be owned by the current user'
 server= token= jump= count=0
 while IFS= read -r line || [[ -n \$line ]]; do
  [[ \$line == *=* ]] || fail 'invalid Outpost configuration'
  key=\${line%%=*}; value=\${line#*=}; count=\$((count + 1))
  case \$key in
   OUTPOST_SERVER) [[ -z \$server ]] || fail 'invalid Outpost configuration'; server=\$value ;;
   OUTPOST_TOKEN) [[ -z \$token ]] || fail 'invalid Outpost configuration'; token=\$value ;;
   OUTPOST_SSH_PROXY_JUMP) [[ -z \$jump ]] || fail 'invalid Outpost configuration'; jump=\$value ;;
   *) fail 'invalid Outpost configuration' ;;
  esac
 done < "\$config"
$(declare -f valid_ipv4 valid_hostname valid_server)
 local_config=0
 if [[ \$count -eq 2 && -z \$jump ]]; then local_config=1; elif [[ \$count -eq 3 && \$jump =~ ^[A-Za-z_][A-Za-z0-9_-]{0,31}@[A-Za-z0-9][A-Za-z0-9.-]{0,251}\$ && \$jump != *..* ]]; then :; else fail 'invalid Outpost configuration'; fi
 [[ \$token =~ ^[A-Za-z0-9+/=]{20,256}\$ ]] && valid_server "\$server" || fail 'invalid Outpost configuration'
 [[ -n \${OUTPOST_SERVER:-} ]] || export OUTPOST_SERVER=\$server
 [[ -n \${OUTPOST_TOKEN:-} ]] || export OUTPOST_TOKEN=\$token
 [[ \$local_config == 1 || -n \${OUTPOST_SSH_PROXY_JUMP:-} ]] || export OUTPOST_SSH_PROXY_JUMP=\$jump
 if [[ \$uninstall_command == 1 ]]; then
  [[ \$config == "\$HOME/.config/outpost/server.env" ]] || fail 'refusing to remove an unexpected Outpost configuration path'
  [[ -f \$uninstaller && ! -L \$uninstaller ]] || fail 'Outpost uninstaller is not installed'
  [[ \$(sha256sum "\$uninstaller" | awk '{print \$1}') == $uninstaller_sha ]] || fail 'Outpost uninstaller checksum mismatch'
  export OUTPOST_UNINSTALL_CONFIG=\$config OUTPOST_UNINSTALL_JUMP=\$jump OUTPOST_UNINSTALL_LOCAL=\$local_config OUTPOST_UNINSTALL_BIN=$bin/outpost OUTPOST_UNINSTALL_LIB=$lib OUTPOST_UNINSTALL_SELF=\$uninstaller
  exec "\$uninstaller" "\$@"
 fi
fi
[[ -f \$real && ! -L \$real ]] || fail 'Outpost client is not installed'
[[ \$(sha256sum "\$real" | awk '{print \$1}') == $client_sha ]] || fail 'Outpost client checksum mismatch'
exec "\$real" "\$@"
EOF
 install -m 0755 "$work/outpost-wrapper" "$bin/outpost"
 printf 'Installed Outpost %s\n' "$version"
)
install_server_packages() {
 local manager=${OUTPOST_INSTALL_PACKAGE_MANAGER:-} command missing=()
 if [[ -z $manager ]]; then
  if command -v apt-get >/dev/null 2>&1; then manager=apt; elif command -v pacman >/dev/null 2>&1; then manager=pacman; else fail 'apt-get or pacman is required'; fi
 fi
 case $manager in
  apt)
   sudo apt-get update
   sudo apt-get install -y curl zstd iproute2 nftables e2fsprogs openssh-client rsync podman uidmap fuse-overlayfs python3
   ;;
  pacman)
   for command in curl zstd ip nft mkfs.ext4 e2fsck resize2fs ssh ssh-keygen rsync podman newuidmap newgidmap fuse-overlayfs python3; do
    command -v "$command" >/dev/null 2>&1 || missing+=("$command")
   done
   if command -v python3 >/dev/null 2>&1 && ! python3 -c 'import hashlib, json' >/dev/null 2>&1; then missing+=(python3-unusable); fi
   ((${#missing[@]} == 0)) || fail "missing or unusable Arch dependencies: ${missing[*]}; install them during your normal system upgrade"
   ;;
  *) fail 'invalid package manager' ;;
 esac
}
validate_handoff() {
 local handoff=$1 account_home
 if [[ ${OUTPOST_INSTALL_TEST:-0} == 1 ]]; then
  [[ $handoff == "$HOME/.config/outpost/server.env" ]] || fail 'invalid client handoff path'
 else
  account_home=$(getent passwd "$(id -u)" | awk -F: 'NR == 1 && NF == 7 { print $6 }')
  [[ $account_home =~ ^(/home/[A-Za-z0-9_.-]+|/root)$ && $handoff == "$account_home/.config/outpost/server.env" ]] || fail 'invalid client handoff path'
 fi
}
load_uninstall_marker() {
 local marker
 if ! sudo test -e /etc/outpostd/uninstall.env; then return 1; fi
 [[ $(sudo stat -c '%F:%a:%u:%g' /etc/outpostd/uninstall.env) == 'regular file:600:0:0' ]] || fail 'invalid Outpost uninstall marker'
 marker=$(sudo cat /etc/outpostd/uninstall.env) || fail 'invalid Outpost uninstall marker'
 mapfile -t marker_lines <<< "$marker"
 [[ ${#marker_lines[@]} == 10 ]] || fail 'invalid Outpost uninstall marker'
 [[ ${marker_lines[0]} =~ ^OUTPOST_HANDOFF=(/home/[A-Za-z0-9_.-]+|/root)/\.config/outpost/server\.env$ && ${marker_lines[1]} =~ ^OUTPOST_CREATED_OUTPOSTD_USER=[01]$ && ${marker_lines[2]} =~ ^OUTPOST_CREATED_OUTPOSTVM_USER=[01]$ && ${marker_lines[3]} =~ ^OUTPOST_CREATED_OUTPOSTD_GROUP=[01]$ && ${marker_lines[4]} =~ ^OUTPOST_CREATED_OUTPOSTVM_GROUP=[01]$ && ${marker_lines[5]} =~ ^OUTPOST_CREATED_OUTPOSTD_SUBUID=[01]$ && ${marker_lines[6]} =~ ^OUTPOST_CREATED_OUTPOSTD_SUBGID=[01]$ && ${marker_lines[7]} =~ ^OUTPOST_IP_FORWARD_PREVIOUS=[01]$ && ${marker_lines[8]} =~ ^OUTPOST_CHANGED_IP_FORWARD=[01]$ && ${marker_lines[9]} =~ ^OUTPOST_CREATED_SYSCTL=[01]$ ]] || fail 'invalid Outpost uninstall marker'
 created_outpostd_user=${marker_lines[1]#*=}; created_outpostvm_user=${marker_lines[2]#*=}; created_outpostd_group=${marker_lines[3]#*=}; created_outpostvm_group=${marker_lines[4]#*=}; created_subuid=${marker_lines[5]#*=}; created_subgid=${marker_lines[6]#*=}; ip_previous=${marker_lines[7]#*=}; changed_ip=${marker_lines[8]#*=}; created_sysctl=${marker_lines[9]#*=}
 return 0
}
install_server_helper() {
 local handoff
 handoff=${OUTPOST_CLIENT_HANDOFF:-$HOME/.config/outpost/server.env}
 validate_handoff "$handoff"
 printf '%s' "$server_uninstaller_b64" | base64 -d | sudo install -o root -g root -m 0700 /dev/stdin /usr/local/lib/outpost/outpost-uninstall-server
 printf 'OUTPOST_HANDOFF=%s\nOUTPOST_CREATED_OUTPOSTD_USER=%s\nOUTPOST_CREATED_OUTPOSTVM_USER=%s\nOUTPOST_CREATED_OUTPOSTD_GROUP=%s\nOUTPOST_CREATED_OUTPOSTVM_GROUP=%s\nOUTPOST_CREATED_OUTPOSTD_SUBUID=%s\nOUTPOST_CREATED_OUTPOSTD_SUBGID=%s\nOUTPOST_IP_FORWARD_PREVIOUS=%s\nOUTPOST_CHANGED_IP_FORWARD=%s\nOUTPOST_CREATED_SYSCTL=%s\n' "$handoff" "$created_outpostd_user" "$created_outpostvm_user" "$created_outpostd_group" "$created_outpostvm_group" "$created_subuid" "$created_subgid" "$ip_previous" "$changed_ip" "$created_sysctl" | sudo tee /etc/outpostd/uninstall.env >/dev/null
 sudo chown root:root /etc/outpostd/uninstall.env
 sudo chmod 0600 /etc/outpostd/uninstall.env
}
prompt_value() {
 local prompt=$1 variable=$2 input=${OUTPOST_INSTALL_INPUT:-/dev/tty}
 [[ $input == /dev/tty || ${OUTPOST_INSTALL_TEST:-0} == 1 ]] || fail 'prompt input must be /dev/tty'
 printf '%s' "$prompt" >&2
 IFS= read -r "${variable?}" < "$input" || fail 'unable to read installer input'
}
select_network() {
 local answer
 network=${OUTPOST_INSTALL_NETWORK:-}
 if [[ -z $network ]]; then
  prompt_value 'Use Tailscale for private API and SSH connectivity? [Y/n]: ' answer
  case $answer in
   ''|y|Y|yes|YES) network=tailscale ;;
   n|N|no|NO)
    prompt_value 'Use Cloudflare Tunnel for HTTPS API access (SSH stays private)? [y/N]: ' answer
    case $answer in
     y|Y|yes|YES) network=cloudflare ;;
     ''|n|N|no|NO) network=local ;;
     *) fail 'answer yes or no' ;;
    esac ;;
   *) fail 'answer yes or no' ;;
  esac
 fi
 case $network in tailscale|cloudflare|local) ;; *) fail 'invalid OUTPOST_INSTALL_NETWORK (tailscale, cloudflare, or local)' ;; esac
 hostname=${OUTPOST_INSTALL_CLOUDFLARE_HOSTNAME:-}
 if [[ $network == cloudflare ]]; then
  if [[ -z $hostname ]]; then prompt_value 'Cloudflare API hostname (e.g. outpost.example.com): ' hostname; fi
  valid_hostname "$hostname" || fail 'invalid Cloudflare hostname'
 fi
}
install_cloudflare_tunnel() {
 local work=$1 token token_file=${OUTPOST_INSTALL_CLOUDFLARE_TOKEN_FILE:-} binary attempt ready=0
 binary=$(command -v cloudflared) || fail 'install cloudflared before choosing Cloudflare Tunnel'
 [[ $binary =~ ^/[A-Za-z0-9._/-]+$ ]] || fail 'invalid cloudflared executable path'
 printf 'Configure a Cloudflare dashboard tunnel with hostname %s and HTTP origin 127.0.0.1:17890.\n' "$hostname"
 printf '%s\n' 'Only the API is exposed. The Outpost bearer token is still required; SSH/copy/sync need a separate private route.'
 if [[ -n $token_file ]]; then
  [[ -f $token_file && ! -L $token_file && $(stat -c %u "$token_file") == "$(id -u)" && $(stat -c %a "$token_file") =~ ^[0-7]00$ ]] || fail 'tunnel token file must be private and owned by the current user'
  token=$(< "$token_file")
 else
  printf 'Paste the tunnel token (input hidden): ' >&2
  IFS= read -rs token </dev/tty || fail 'unable to read tunnel token'
  printf '\n' >&2
 fi
 [[ $token =~ ^[A-Za-z0-9_+/=-]{20,16384}$ ]] || fail 'invalid Cloudflare tunnel token'
 # Keep credentials out of command arguments, logs, and the local client config.
 (umask 077; printf 'TUNNEL_TOKEN=%s\n' "$token" > "$work/cloudflared.env")
 unset token
 cat > "$work/outpost-cloudflared.service" <<EOF
[Unit]
Description=Outpost Cloudflare API tunnel
After=network-online.target outpostd.service
Wants=network-online.target

[Service]
DynamicUser=yes
EnvironmentFile=/etc/outpost-cloudflared/cloudflared.env
ExecStart=$binary tunnel --no-autoupdate run
Restart=on-failure
RestartSec=5s
NoNewPrivileges=yes
ProtectSystem=strict
ProtectHome=yes
PrivateTmp=yes

[Install]
WantedBy=multi-user.target
EOF
 if sudo test -e /etc/systemd/system/outpost-cloudflared.service; then
  sudo cmp -s "$work/outpost-cloudflared.service" /etc/systemd/system/outpost-cloudflared.service || fail 'existing Outpost tunnel service has unexpected content; refusing to overwrite it'
 fi
 sudo install -d -o root -g root -m 0700 /etc/outpost-cloudflared
 sudo install -o root -g root -m 0600 "$work/cloudflared.env" /etc/outpost-cloudflared/cloudflared.env
 sudo install -o root -g root -m 0644 "$work/outpost-cloudflared.service" /etc/systemd/system/outpost-cloudflared.service
 sudo systemctl daemon-reload
 sudo systemctl enable outpost-cloudflared.service
 sudo systemctl restart outpost-cloudflared.service
 for ((attempt=0; attempt<60; attempt++)); do
  if OUTPOST_SERVER="https://$hostname" "$HOME/.local/bin/outpost" list >/dev/null 2>&1; then ready=1; break; fi
  sleep 1
 done
 [[ $ready == 1 ]] || fail 'Cloudflare API is not reachable; check the dashboard hostname/origin, DNS, and journalctl -u outpost-cloudflared'
 printf 'Cloudflare API URL: https://%s\n' "$hostname"
 printf '%s\n' 'Local CLI remains on localhost. Remove the dashboard tunnel/DNS record separately when uninstalling.'
}
server_install() (
 local work ip uplink actual handoff created_outpostd_user created_outpostvm_user created_outpostd_group created_outpostvm_group created_subuid created_subgid ip_previous changed_ip created_sysctl
 [[ $(uname -s) == Linux ]] || fail 'Linux is required'
 [[ $(uname -m) == x86_64 ]] || fail 'x86-64 is required'
 command -v sudo >/dev/null 2>&1 || fail 'sudo is required'
 if [[ $network != cloudflare ]] && sudo test -f /etc/systemd/system/outpost-cloudflared.service; then
  fail 'an Outpost Cloudflare tunnel is already installed; remove it before switching network modes'
 fi
 case $network in
  tailscale) command -v tailscale >/dev/null 2>&1 || fail 'install and sign in to Tailscale first, or choose local/Cloudflare' ;;
  cloudflare) command -v cloudflared >/dev/null 2>&1 || fail 'install cloudflared before choosing Cloudflare Tunnel' ;;
 esac
 handoff=${OUTPOST_CLIENT_HANDOFF:-$HOME/.config/outpost/server.env}
 validate_handoff "$handoff"
 load_uninstall_marker || true
 install_server_packages
 work=$(mktemp -d "${TMPDIR:-/tmp}/outpost-server-install.XXXXXX")
 trap 'rm -rf "$work"' EXIT HUP INT TERM
 release_metadata "$work"
 ip=127.0.0.1
 if [[ $network == tailscale ]]; then
  ip=$(tailscale ip -4 | awk 'NR == 1 { print }')
  valid_ipv4 "$ip" || fail 'a Tailscale IPv4 address is required; sign in to Tailscale first'
 fi
 uplink=$(ip route show default | awk 'NR == 1 { print $5 }')
 [[ $uplink =~ ^[A-Za-z0-9_.-]{1,15}$ ]] || fail 'a default network uplink is required'
 if [[ ${OUTPOST_INSTALL_TEST:-0} != 1 ]]; then
  [[ -r /dev/kvm && -c /dev/net/tun && -c /dev/userfaultfd && -f /sys/fs/cgroup/cgroup.controllers ]] || fail 'KVM, TUN, userfaultfd, and cgroup v2 are required'
 fi
 if [[ -z ${created_outpostd_user:-} ]]; then
  created_outpostd_user=0; created_outpostvm_user=0; created_outpostd_group=0; created_outpostvm_group=0; created_subuid=0; created_subgid=0
  id outpostd >/dev/null 2>&1 || created_outpostd_user=1
  id outpostvm >/dev/null 2>&1 || created_outpostvm_user=1
  getent group outpostd >/dev/null || created_outpostd_group=1
  getent group outpostvm >/dev/null || created_outpostvm_group=1
  grep -q '^outpostd:' /etc/subuid 2>/dev/null || created_subuid=1
  grep -q '^outpostd:' /etc/subgid 2>/dev/null || created_subgid=1
  ip_previous=$(sysctl -n net.ipv4.ip_forward); [[ $ip_previous =~ ^[01]$ ]] || fail 'invalid IPv4 forwarding state'
  changed_ip=0; [[ $ip_previous == 1 ]] || changed_ip=1; created_sysctl=1
 fi
 if [[ ${OUTPOST_INSTALL_TEST:-0} != 1 ]] && [[ -e /etc/sysctl.d/99-outpost.conf || -L /etc/sysctl.d/99-outpost.conf ]]; then
  [[ -f /etc/sysctl.d/99-outpost.conf && ! -L /etc/sysctl.d/99-outpost.conf && $(sudo cat /etc/sysctl.d/99-outpost.conf) == net.ipv4.ip_forward=1 ]] || fail 'Outpost sysctl path contains unexpected content'
 else
  printf '%s\n' 'net.ipv4.ip_forward=1' | sudo tee /etc/sysctl.d/99-outpost.conf >/dev/null
 fi
 sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null
 actual=$(sha256sum "$work/install-server" | awk '{print $1}')
 [[ $actual == "$installer_sha" ]] || fail 'server installer checksum mismatch'
 sudo env OUTPOST_VERSION="$version" OUTPOST_UPLINK="$uplink" OUTPOST_LISTEN="$ip:17890" OUTPOST_SERVER="http://$ip:17890" OUTPOST_CLIENT_HANDOFF="$handoff" OUTPOST_RELEASE_URL="$release" OUTPOST_ASSETS_MANIFEST_SHA256="$manifest_sha" sh "$work/install-server"
 install_server_helper
 local attempt ready=0
 for ((attempt=0; attempt<60; attempt++)); do
  if "$HOME/.local/bin/outpost" list >/dev/null 2>&1; then ready=1; break; fi
  sleep 1
 done
 [[ $ready == 1 ]] || fail 'Outpost API did not become ready within 60 seconds; check journalctl -u outpostd'
 if [[ $network == cloudflare ]]; then install_cloudflare_tunnel "$work"; fi
)
main() {
 local mode=${OUTPOST_INSTALL_MODE:-} target=${OUTPOST_INSTALL_TARGET:-} work server token config_dir config_tmp network hostname
 case $mode in ''|client|server) ;; *) fail 'invalid OUTPOST_INSTALL_MODE' ;; esac
 if [[ $mode == server ]]; then select_network; client_install; server_install; return; fi
 if [[ -z $target && $mode != client ]]; then
  [[ -r /dev/tty ]] || fail 'no terminal available; set OUTPOST_INSTALL_MODE=client, server, or OUTPOST_INSTALL_TARGET for automation'
  printf 'Outpost server (user@server, local, or blank for client only): ' >/dev/tty
  IFS= read -r target </dev/tty || fail 'unable to read server target'
 fi
 if [[ $target == local ]]; then select_network; client_install; server_install; return; fi
 if [[ -z $target ]]; then client_install; return; fi
 ssh_target "$target" || { usage; fail 'invalid SSH target'; }
 select_network
 [[ $network != local ]] || fail 'local-only networking requires installation on the server with target local'
 # A remote token file path refers to the server, never upload credentials in the SSH command.
 work=$(mktemp -d "${TMPDIR:-/tmp}/outpost-release-metadata.XXXXXX")
 trap 'rm -rf "$work"' EXIT HUP INT TERM
 release_metadata "$work"
 rm -rf "$work"
 trap - EXIT HUP INT TERM
 client_install
 work=$(mktemp -d "${TMPDIR:-/tmp}/outpost-handoff.XXXXXX")
 handoff_work=$work
 trap 'rm -rf "$handoff_work"' EXIT HUP INT TERM
 local remote_script remote_command ssh_stdin
 printf -v remote_script 'set -o pipefail; curl --fail --location --proto %q --tlsv1.2 %q | OUTPOST_INSTALL_MODE=server OUTPOST_RELEASE_URL=%q OUTPOST_RELEASE_VERSION=%q OUTPOST_ASSETS_MANIFEST_SHA256=%q OUTPOST_INSTALL_SERVER_SHA256=%q OUTPOST_INSTALL_NETWORK=%q OUTPOST_INSTALL_CLOUDFLARE_HOSTNAME=%q OUTPOST_INSTALL_CLOUDFLARE_TOKEN_FILE=%q bash' '=https' 'https://raw.githubusercontent.com/nishantdania/outpost/refs/heads/main/install.sh' "$release" "$version" "$manifest_sha" "$installer_sha" "$network" "$hostname" "${OUTPOST_INSTALL_CLOUDFLARE_TOKEN_FILE:-}"
 printf -v remote_command 'bash -c %q' "$remote_script"
 ssh_stdin=${OUTPOST_INSTALL_SSH_STDIN:-/dev/tty}
 [[ $ssh_stdin == /dev/tty || ${OUTPOST_INSTALL_TEST:-0} == 1 ]] || fail 'SSH input must be /dev/tty'
 ssh -tt "$target" "$remote_command" < "$ssh_stdin"
 scp "$target:~/.config/outpost/server.env" "$work/server.env"
 valid_config "$work/server.env" || fail 'server returned invalid configuration'
 server=$(config_value OUTPOST_SERVER "$work/server.env")
 if [[ $network == cloudflare ]]; then server=https://$hostname; fi
 token=$(config_value OUTPOST_TOKEN "$work/server.env")
 config_dir=${OUTPOST_CONFIG_DIR:-$HOME/.config/outpost}
 [[ $config_dir == /* ]] || fail 'OUTPOST_CONFIG_DIR must be absolute'
 mkdir -p "$config_dir"
 chmod 0700 "$config_dir"
 config_tmp=$(mktemp "$config_dir/.server.env.XXXXXX")
 printf 'OUTPOST_SERVER=%s\nOUTPOST_TOKEN=%s\nOUTPOST_SSH_PROXY_JUMP=%s\n' "$server" "$token" "$target" > "$config_tmp"
 chmod 0600 "$config_tmp"
 mv -f "$config_tmp" "$config_dir/server.env"
 printf 'Outpost is ready. Run outpost list.\n'
}
main
