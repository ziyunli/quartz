---
source: https://web.archive.org/web/20210426203102/https://mullvad.net/en/help/bittorrent/
tags:
  - Clippings
---

From [web archive](https://web.archive.org/web/20210426203102/https://mullvad.net/en/help/bittorrent/)

---

Use the BitTorrent protocol more securely by following these steps.

We only provide instructions for the qBittorrent client. Others like µTorrent, Vuze, and BitComet are not open source, contain adware or junkware, or aren't equipped with good privacy settings.

## Binding qBittorrent to an interface

The first step is to bind qBittorrent to the Mullvad network interface to prevent it from leaking your IP in some situations.

### Windows

1. Start the Mullvad app and connect to a location.
2. Open qBittorrent.
3. Click on Tools > Options... > Advanced.
4. Change Network interface to **Mullvad**.
5. Click on OK.
6. Click on File > Exit and then start qBittorrent again.
7. Continue with the steps in the next section.

### Linux

1. Start the Mullvad app and connect to a location.
2. Open qBittorrent.
3. Click on Tools > Preferences > Advanced
4. Change Network interface to one of the following depending on the app and protocol you are using:
   - Mullvad app using OpenVPN: **tun0**
   - Mullvad app using WireGuard kernel: **wg-mullvad**
   - Mullvad app using WireGuard userspace: **tun0**
   - WireGuard standalone: **mlvd-xx**
   - OpenVPN standalone: **tun0**
5. Click on OK.
6. Click on File > Exit and then start qBittorrent again.
7. Continue with the steps in the next section.

### macOS

1. Start the Mullvad app and connect to a location.
2. Open the Terminal app.
3. Run the command `ifconfig | grep -A 2 utun`
4. Check which utun interface Mullvad is using by looking for the internal IP "inet 10.x.x.x".
5. Open qBittorrent.
6. Click on the Preferences button on the toolbar.
7. Click on Advanced.
8. Change Network interface to the utun interface you found above.
9. Click on OK.
10. Click on the qbittorrent main menu > Quit qbittorrent and then start qBittorrent again.
11. Continue with the steps in the next section.

## Recommended qBittorrent settings

1. Click on Tools.
2. Click on Options (in Windows) or Preferences (in Linux and macOS)
3. Click on BitTorrent.
4. Check Enable anonymous mode.
5. Uncheck (disable) Enable DHT.
6. Uncheck (disable) Enable PeX.
7. Uncheck (disable) Enable Local peer discovery.
8. Click on Connection.
9. For Peer connection protocol, use the drop-down menu to select TCP.

## Mullvad app settings

If you use the Mullvad desktop app then go to Settings > Advanced and enable "Always require VPN". This will block your Internet if you disconnect it by mistake.

## Check for leaks

Go to the [Mullvad Connection check](https://web.archive.org/web/20210426203102/https://mullvad.net/check/) page and click on the Torrent check tab. Click on the UDP and HTTP buttons to launch the tests. Note that this test does not work if you use SOCKS5 in the Bittorrent client.

## Port forwarding

Read our [Port forwarding guide](https://web.archive.org/web/20210426203102/https://mullvad.net/help/port-forwarding-and-mullvad/) if you want to set up a port forward to the Bittorrent client. This should improve your seeding. Add the port in qBittorrent > Connection > "Port used for incoming connections". Note that this does not work with SOCKS5 enabled.

## Troubleshooting

#### When I have enabled the SOCKS5 proxy with qBittorrent, why is the torrent shown as offline?

The SOCKS5 protocol does not support port forwarding, so if you use trackerless torrents, you might need to have DHT enabled. Otherwise, you might need to disable the SOCKS5 proxy.

#### qBittorrent shows the status as Stalled

If you use our SOCKS5 proxy then you will need to change the IP-address depending on if you use WireGuard or OpenVPN, and restart qBittorrent.

#### qBittorrent for Linux shows the status as Stalled

If you switch between WireGuard and OpenVPN you will need to re-bind the network interface and restart qBittorrent.
