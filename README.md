# wat - a simple packet sniffer
wat is a very simple exploration of using the libpcap library on OSX via Swift through a command line interface.

## Goal
The main goal is the creation of a tool for debugging the network traffic of iOS apps, without having to use a proxy tool (such as Charles).  Other goals include:

* keep things simple: networks are hard enough
* keep things modern: most network code is OLD
* learn Swift: its new, I need to learn it

## Limitations
* SSL - no proxy means no reading SSL
* Eventually WPA/WPA2 traffic will be decrypted (given proper password), but I havn't figured out this code yet.

## Help & Links
If you want to help out, please fork and make some pull requests.  Here are some links I found useful:
* [tcpdump](http://www.tcpdump.org) - tcpdump source code &  docs
* [Programming with libpcap](http://recursos.aldabaknocking.com/libpcapHakin9LuisMartinGarcia.pdf) - PDF of article from Hackin9 magazine in 2008.  Very old, but nice to read some basics.
* [Radiotap docs](http://www.radiotap.org) - Explains the radiotap header - took me a while to figure this out.  Basically, you just need the (variable) length

## Contact

PJ Gray

- http://github.com/pj4533
- http://twitter.com/pj4533
- pj@pj4533.com

## License

wat is available under the MIT license. See the LICENSE file for more info.

